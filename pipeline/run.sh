#!/usr/bin/env bash
# pipeline/run.sh — deterministic orchestration of the talk-building pipeline.
#
# A shell script decides the order, the loop, and the isolation. Agents only do the work inside
# each stage. That split is the reproducibility story of the talk.
#
# Usage:
#   pipeline/run.sh <stage> [--commit] [--budget USD] [--rounds N]
#   stages: evidence | example | chronicle | write | critique | revise | loop | factcheck | notes | qa | cost | all
#
#   The outline (slides/outline.md) is written by the speaker, by hand. No stage generates it. The last pipeline
#   that did produced a rubric-compliant deck nobody wanted to present; that lesson is in the talk.
#
#   evidence   evidence-finder reads the outline, finds one source per claim -> research/evidence.md
#   example    example-builder builds and RUNS the take-home example under examples/ (the only agent with Bash)
#   chronicle  chronicler writes research/build-log.md: how this deck was built, step by step, from runs/ and git.
#              Runs before write and again after the loop, so the deck can describe its own build honestly
#   write      slide-writer, diagrammer and illustrator run IN PARALLEL in three git worktrees, then merge
#   critique   renders PNGs, then ONE reviewer reads the deck and looks at the images -> runs/NNN-critique/review.md
#   revise     slide-writer applies the latest review
#   loop       critique -> revise until PASS or --rounds exhausted (default 2)
#   factcheck  fact-checker fetches every source in the notes, writes runs/NNN-factcheck/factcheck.md
#   notes      notes-writer writes slides/speaker-script.md and handout/handout.md
#   qa         qa-skeptic writes handout/qa.md          (notes and qa run in parallel under 'all')
#   cost       python3 pipeline/cost_report.py -> runs/cost-report.md   (no LLM needed)
#   all        evidence, example, chronicle, write, loop, chronicle, revise, factcheck, notes+qa, cost
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
[[ -z "$STAGE" ]] && { sed -n '2,32p' "$SELF" | sed 's/^# \{0,1\}//'; exit 2; }

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

stage_evidence() {
  [[ -s slides/outline.md ]] || { echo "slides/outline.md missing: write the outline first" >&2; exit 1; }
  run_agent evidence-finder "$(next_run_dir evidence)" pipeline/prompts/evidence.md "WebSearch,WebFetch,Read,Write,Glob,Grep"
}

stage_chronicle() {
  run_agent chronicler "$(next_run_dir chronicle)" pipeline/prompts/chronicle.md "Read,Glob,Grep,Write"
}

# The take-home example. This agent runs `claude -p` itself, so it needs Bash; keep its budget small.
stage_example() {
  run_agent example-builder "$(next_run_dir example)" pipeline/prompts/example.md "Read,Write,Edit,Bash,Glob,Grep"
}

# Pattern 4: parallel isolated workers. Three agents, three worktrees, three merges, disjoint files.
stage_write() {
  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "working tree has uncommitted changes; commit first (the write stage merges branches)" >&2; exit 1
  fi
  local run_dir; run_dir=$(next_run_dir write)
  mkdir -p .worktrees
  local w agent tools
  for w in slides diagrams illustrations; do
    case $w in
      slides)        agent=slide-writer; tools="Read,Write,Edit,Glob,Grep" ;;
      diagrams)      agent=diagrammer;   tools="Read,Write,Glob,Grep" ;;
      illustrations) agent=illustrator;  tools="Read,Write,Glob,Grep" ;;
    esac
    git worktree add -q -B "wt/$w" ".worktrees/$w" HEAD
    log "worktree .worktrees/$w on branch wt/$w for $agent"
    (
      cd ".worktrees/$w"
      COMMIT=0 run_agent "$agent" "$run_dir/$w" "$ROOT/pipeline/prompts/$w.md" "$tools"
      git add -A && git commit -qm "pipeline: $agent in worktree $w" || true
    ) &
  done
  wait
  for w in slides diagrams illustrations; do
    log "merging wt/$w"
    if ! git merge -q --no-edit -m "pipeline: merge $w worktree" "wt/$w"; then
      log "MERGE CONFLICT on wt/$w. Fix the files git lists, then run:"
      log "  git add -A && git commit --no-edit && git worktree remove --force .worktrees/$w && git branch -D wt/$w"
      exit 1
    fi
    git worktree remove --force ".worktrees/$w"
    git branch -qD "wt/$w"
  done
  log "write stage merged; logs in $run_dir/{slides,diagrams,illustrations}"
}

# One reviewer, sitting in the audience. It looks at rendered PNGs, so render first.
stage_critique() {
  local run_dir; run_dir=$(next_run_dir critique); mkdir -p "$run_dir"
  pipeline/render.sh --png >/dev/null 2>&1 || log "WARNING: PNG render failed; the reviewer will have no images"
  COMMIT=0 run_agent reviewer "$run_dir" pipeline/prompts/critique.md "Read,Glob,Grep,Write"
  if [[ -f "$run_dir/review.md" ]] && grep -qiE '^\s*\**verdict\**:?\s*\**PASS' "$run_dir/review.md"; then VERDICT=PASS; else VERDICT=REVISE; fi
  LAST_CRITIQUE="$run_dir"
  log "reviewer: $VERDICT ($run_dir)"
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
    log "review loop round $i of $ROUNDS"
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

case "$STAGE" in
  evidence)  stage_evidence ;;
  example)   stage_example ;;
  chronicle) stage_chronicle ;;
  write)     stage_write ;;
  critique)  stage_critique ;;
  revise)    stage_revise ;;
  loop)      stage_loop ;;
  factcheck) stage_factcheck ;;
  notes)     stage_notes ;;
  qa)        stage_qa ;;
  cost)      stage_cost ;;
  all)
    stage_evidence
    stage_example
    stage_chronicle
    [[ $COMMIT -eq 1 ]] || { git add -A && git commit -qm "pipeline: evidence, example, chronicle" || true; }
    stage_write
    stage_loop
    # The deck describes its own build, so record the runs above and let the writer place the update.
    stage_chronicle
    stage_revise
    stage_factcheck
    # notes and qa write different files and only read the deck: safe to run side by side without worktrees
    stage_notes & stage_qa & wait
    stage_cost
    ;;
  *) echo "unknown stage: $STAGE" >&2; exit 2 ;;
esac
