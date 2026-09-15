# Multi-agent workflows — handout

Shooby Hemmati, IPAC · GRITS AI workshop, Day 2 · repo: this deck was built by the pipeline it
describes. Full citations are on the deck's Sources slides (22–25) and in `research/brief.md`.

## The four patterns

1. **Fan-out and merge** — independent subtasks run in parallel on separate subagents; one
   orchestrator merges the returns in a single place.
2. **Pipeline** — planner, implementer, tester run in sequence; each stage starts with a fresh,
   clean context and a file handoff. Do not fan out a sequential job.
3. **Writer and critic** — one agent produces, a second reviews adversarially with tools in hand
   (tests, schema, data) and sends findings back for one or two revision rounds.
4. **Parallel isolated workers** — each agent works in its own git worktree on its own branch;
   a single merge step reconciles them at the end.

## Agents in `.claude/agents/`

- **researcher.md** — one assigned topic, web search/fetch, writes a cited brief to
  `research/briefs/`, returns a ≤200-word summary. Run several in parallel for a fan-out.
- **outliner.md** — reads `research/brief.md` and `talk-context.md`, writes the timed,
  slide-by-slide `slides/outline.md`.
- **slide-writer.md** — writes or revises `slides/deck.md` (Marp) from the outline and brief;
  runs in its own worktree during the parallel write stage and during revisions.
- **diagrammer.md** — writes the five Mermaid diagrams in `diagrams/*.mmd`; runs in its own
  worktree in parallel with slide-writer.
- **critic.md** — adversarial reviewer; scores the deck against a fixed rubric, writes
  `critique.md` with a PASS/REVISE verdict, never edits the deck.
- **fact-checker.md** — fetches every citation in the deck, writes `factcheck.md`: a status table
  (CONFIRMED / PARTIAL / NOT FOUND / CONTRADICTED) plus required edits. Never edits the deck.
- **notes-writer.md** — reads the finished deck, writes `slides/speaker-script.md` and this
  handout. Never changes slide content.
- **qa-skeptic.md** — plays a skeptical IPAC astronomer, writes the ten hardest likely audience
  questions with draft answers to `handout/qa.md`.

## Two commands to run the pipeline

```
pipeline/run.sh all       # outline -> write (parallel worktrees) -> critic/revise loop
                          # -> fact-check -> notes+QA (parallel) -> cost report
pipeline/render.sh        # inline the diagrams and render slides/deck.md to
                          # slides/build/deck.html (add --pdf for a PDF)
```

Individual stages (`outline`, `write`, `critique`, `revise`, `loop`, `factcheck`, `notes`, `qa`,
`cost`) can each be run on their own via `pipeline/run.sh <stage>`; see the header comment in
`pipeline/run.sh` for flags (`--commit`, `--budget`, `--rounds`).

## Where the logs and cost report live

- `runs/NNN-<stage>/` — one numbered directory per stage, in execution order. Each holds
  `prompt.md` (exact prompt sent), `result.json` (full headless output: text, tokens, cost,
  turns), `return.md` (what the agent returned), `exit-code`, and the stage's own output file
  (e.g. `critique.md`, `factcheck.md`). The parallel `write` stage nests `slides/` and
  `diagrams/` subdirectories, one per worktree. See `runs/README.md`.
- `runs/cost-report.md` — built from `runs/cost.tsv` by `pipeline/run.sh cost`
  (`pipeline/cost_report.py`); totals and per-stage rows of tokens and USD. As of this run it
  only reflects stages through `003-outline` — later stages (004–010) haven't had `cost` rerun
  against them, and `runs/cost.tsv` currently has an unresolved git merge-conflict marker
  (`<<<<<<<` / `=======` / `>>>>>>>`) sitting in it from the parallel write stage, which will need
  fixing before the report can be rebuilt correctly.

## Five links

1. Anthropic, "How we built our multi-agent research system" —
   https://www.anthropic.com/engineering/built-multi-agent-research-system
2. Claude Code docs, subagents —
   https://code.claude.com/docs/en/sub-agents
3. Claude Code docs, worktrees —
   https://code.claude.com/docs/en/worktrees
4. Kim et al., "Towards a science of scaling agent systems" (arXiv) —
   https://arxiv.org/abs/2512.08296
5. Cemri et al., "Why do multi-agent LLM systems fail?" (MAST, arXiv) —
   https://arxiv.org/abs/2503.13657
