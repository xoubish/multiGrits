#!/usr/bin/env bash
# pipeline/run.sh — deterministic orchestration of the talk-building pipeline.
#
# A shell script decides the order, the loop, and the isolation. Agents only do the work inside
# each stage. That split is the reproducibility story of the talk.
#
# Usage:
#   pipeline/run.sh <stage> [--commit] [--budget USD] [--rounds N]
#   stages: outline | write | critique | revise | loop | factcheck | notes | qa | cost | shots | all
#
#   outline    outliner reads research/brief.md, writes slides/outline.md
#   write      slide-writer and diagrammer run IN PARALLEL in two git worktrees, then merge
#   critique   three critics in parallel (content, design, teaching) -> runs/NNN-critique/<critic>/critique.md;
#              verdict is PASS only if all three pass. Renders PNGs first so the design critic can look at slides
#   revise     slide-writer applies every critique from the latest critique run
#   loop       critique -> revise until PASS or --rounds exhausted (default 2)
#   factcheck  fact-checker fetches every citation, writes runs/NNN-factcheck/factcheck.md
#   notes      notes-writer writes slides/speaker-script.md and handout/handout.md
#   qa         qa-skeptic writes handout/qa.md          (notes and qa run in parallel under 'all')
#   cost       python3 pipeline/cost_report.py -> runs/cost-report.md   (no LLM needed)
#   shots      recorded demo: capture.py renders terminal screenshots of real runs, demo-editor rewrites
#              the five demo slides around them so nothing runs live on stage
#   all        outline, write, loop, factcheck, notes+qa, cost
#
# Every stage logs to runs/NNN-<stage>/: prompt.md (exact prompt sent), result.json (full
# headless output), return.md (what the agent returned). The logs ARE the demo material.
#
# --commit    git commit after each sequential stage (the 'write' stage always commits: worktrees need it)
# --budget    per-stage cap passed to claude --max-budget-usd (default 5; a slide-writer revise on the session model
#             exhausted a $3 cap in run 006, which surfaced as exit 1 with terminal_reason budget_exhausted)
set -euo pipefail

SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ROOT="$(dirname "$(dirname "$SELF")")"
cd "$ROOT"

STAGE="${1:-}"; shift || true
COMMIT=0; BUDGET="${BUDGET_USD:-5}"; ROUNDS=2
while [[ $# -gt 0 ]]; do
  case "$1" in
    --commit) COMMIT=1 ;;
    --budget) BUDGET="$2"; shift ;;
    --rounds) ROUNDS="$2"; shift ;;
    *) echo "unknown option $1" >&2; exit 2 ;;
  esac; shift
done
[[ -z "$STAGE" ]] && { sed -n '2,25p' "$SELF" | sed 's/^# \{0,1\}//'; exit 2; }

log() { printf '\033[1;34m[pipeline]\033[0m %s\n' "$*" >&2; }

next_run_dir() {  # next_run_dir <stage-name> -> runs/NNN-<stage-name>
  local last
  last=$(ls -d runs/[0-9][0-9][0-9]-* 2>/dev/null | sed -E 's#runs/([0-9]+)-.*#\1#' | sort -n | tail -1)
  printf 'runs/%03d-%s' "$((10#${last:-0} + 1))" "$1"
}

# run_agent <agent> <run_dir> <prompt-template> <allowed-tools> [KEY=VALUE ...]
# Substitutes {{RUN_DIR}} and any KEY=VALUE pairs as {{KEY}} in the template, then runs headless.
run_agent() {
  local agent="$1" run_dir="$2" template="$3" tools="$4"; shift 4
  mkdir -p "$run_dir"
  sed "s#{{RUN_DIR}}#$run_dir#g" "$template" > "$run_dir/prompt.md"
  for kv in "$@"; do sed -i '' "s#{{${kv%%=*}}}#${kv#*=}#g" "$run_dir/prompt.md"; done
  log "$agent -> $run_dir (budget \$$BUDGET)"
  local start; start=$(date +%s)
  set +e
  # env -u CLAUDECODE lets the stage run even when this script is launched from inside a Claude Code session
  env -u CLAUDECODE claude -p --agent "$agent" \
    --output-format json \
    --permission-mode acceptEdits \
    --allowedTools "$tools" \
    --max-budget-usd "$BUDGET" \
    --no-session-persistence \
    "$(cat "$run_dir/prompt.md")" > "$run_dir/result.json"
  local rc=$?
  set -e
  echo "$rc" > "$run_dir/exit-code"
  python3 "$ROOT/pipeline/log_result.py" "$run_dir" "$agent" "$(( $(date +%s) - start ))"
  if grep -qE '"terminal_reason": *"budget_exhausted"|"subtype": *"error_max_budget_usd"' "$run_dir/result.json" 2>/dev/null; then
    log "WARNING: $agent hit the --max-budget-usd ceiling (\$$BUDGET); output may be partial. Re-run with --budget N"
  elif [[ $rc -ne 0 ]]; then
    log "WARNING: claude exited $rc for $agent; see $run_dir/result.json"
  fi
  if [[ $COMMIT -eq 1 ]]; then git add -A && git commit -qm "pipeline: $agent ($run_dir)" && log "committed"; fi
  return 0
}

stage_outline() {
  [[ -s research/brief.md ]] || { echo "research/brief.md missing: merge the research fan-out first" >&2; exit 1; }
  run_agent outliner "$(next_run_dir outline)" pipeline/prompts/outline.md "Read,Write,Glob,Grep"
}

# Pattern 4: parallel isolated workers. Two agents, two worktrees, one merge.
stage_write() {
  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "working tree has uncommitted changes; commit first (the write stage merges branches)" >&2; exit 1
  fi
  local run_dir; run_dir=$(next_run_dir write)
  mkdir -p .worktrees
  local w agent tools
  for w in slides diagrams; do
    if [[ $w == slides ]]; then agent=slide-writer; tools="Read,Write,Edit,Glob,Grep"; else agent=diagrammer; tools="Read,Write,Glob,Grep"; fi
    git worktree add -q -B "wt/$w" ".worktrees/$w" HEAD
    log "worktree .worktrees/$w on branch wt/$w for $agent"
    (
      cd ".worktrees/$w"
      COMMIT=0 run_agent "$agent" "$run_dir/$w" "$ROOT/pipeline/prompts/$w.md" "$tools"
      git add -A && git commit -qm "pipeline: $agent in worktree $w" || true
    ) &
  done
  wait
  for w in slides diagrams; do
    log "merging wt/$w"
    if ! git merge -q --no-edit -m "pipeline: merge $w worktree" "wt/$w"; then
      log "MERGE CONFLICT on wt/$w. Fix the files git lists, then run:"
      log "  git add -A && git commit --no-edit && git worktree remove --force .worktrees/$w && git branch -D wt/$w"
      exit 1
    fi
    git worktree remove --force ".worktrees/$w"
    git branch -qD "wt/$w"
  done
  log "write stage merged; logs in $run_dir/{slides,diagrams}"
}

# Three critics in parallel (pattern 1 applied to pattern 3): content, visual design, teaching. Each writes its own
# critique.md in its own subdirectory, so no shared file. The design critic looks at rendered PNGs, so render first.
stage_critique() {
  local run_dir; run_dir=$(next_run_dir critique); mkdir -p "$run_dir"
  pipeline/render.sh --png >/dev/null 2>&1 || log "WARNING: PNG render failed; the design critic will have no images"
  COMMIT=0 run_agent critic          "$run_dir/content"  pipeline/prompts/critique.md          "Read,Glob,Grep,Write" &
  COMMIT=0 run_agent design-critic   "$run_dir/design"   pipeline/prompts/critique-design.md   "Read,Glob,Grep,Write" &
  COMMIT=0 run_agent teaching-critic "$run_dir/teaching" pipeline/prompts/critique-teaching.md "Read,Glob,Grep,Write" &
  wait
  VERDICT=PASS; local c v summary=""
  for c in content design teaching; do
    if [[ -f "$run_dir/$c/critique.md" ]] && grep -qiE '^\s*\**verdict\**:?\s*\**PASS' "$run_dir/$c/critique.md"; then v=PASS; else v=REVISE; VERDICT=REVISE; fi
    summary+="$c=$v "
  done
  LAST_CRITIQUE="$run_dir"
  log "critics: $summary-> $VERDICT ($run_dir)"
  if [[ $COMMIT -eq 1 ]]; then git add -A && git commit -qm "pipeline: critique ($run_dir)" || true; fi
}

stage_revise() {
  local critique="${LAST_CRITIQUE:-$(ls -d runs/*-critique 2>/dev/null | tail -1)}"
  [[ -d "$critique" ]] || { echo "no critique run found; run critique first" >&2; exit 1; }
  run_agent slide-writer "$(next_run_dir revise)" pipeline/prompts/revise.md "Read,Write,Edit,Glob,Grep" "CRITIQUE=$critique"
}

# Pattern 3: writer and critic. The SCRIPT owns the loop, not the agents.
stage_loop() {
  local i
  for ((i = 1; i <= ROUNDS; i++)); do
    log "critic loop round $i of $ROUNDS"
    stage_critique
    [[ $VERDICT == PASS ]] && { log "PASS after $((i - 1)) revision(s)"; return; }
    stage_revise
  done
  log "rounds exhausted; final verdict was $VERDICT. Human review needed."
}

stage_factcheck() { run_agent fact-checker "$(next_run_dir factcheck)" pipeline/prompts/factcheck.md "WebFetch,WebSearch,Read,Glob,Grep,Write"; }
stage_notes()     { run_agent notes-writer "$(next_run_dir notes)" pipeline/prompts/notes.md "Read,Glob,Grep,Write"; }
stage_qa()        { run_agent qa-skeptic   "$(next_run_dir qa)"    pipeline/prompts/qa.md    "Read,Glob,Grep,Write"; }
stage_cost()      { python3 pipeline/cost_report.py; log "runs/cost-report.md written"; }

# Recorded demo. Deterministic capture first, one agent edits the demo slides, capture again in case the agent
# added shots to pipeline/captures.json. The script owns the loop; the agent never runs commands.
stage_shots() {
  local run_dir; run_dir=$(next_run_dir shots); mkdir -p "$run_dir"
  python3 pipeline/capture.py
  cp slides/deck.md "$run_dir/deck-before.md"
  run_agent demo-editor "$run_dir" pipeline/prompts/shots.md "Read,Write,Edit,Glob,Grep"
  python3 pipeline/capture.py
  log "recorded demo written; render with pipeline/render.sh --pdf"
}

case "$STAGE" in
  outline)   stage_outline ;;
  write)     stage_write ;;
  critique)  stage_critique ;;
  revise)    stage_revise ;;
  loop)      stage_loop ;;
  factcheck) stage_factcheck ;;
  notes)     stage_notes ;;
  qa)        stage_qa ;;
  cost)      stage_cost ;;
  shots)     stage_shots ;;
  all)
    stage_outline
    [[ $COMMIT -eq 1 ]] || { git add -A && git commit -qm "pipeline: outline" || true; }
    stage_write
    stage_loop
    stage_factcheck
    # notes and qa write different files and only read the deck: safe to run side by side without worktrees
    stage_notes & stage_qa & wait
    stage_cost
    ;;
  *) echo "unknown stage: $STAGE" >&2; exit 2 ;;
esac
