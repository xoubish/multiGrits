# Multi-agent workflows — handout

Shooby Hemmati, IPAC · GRITS AI workshop, Day 2. This deck was built by the pipeline it describes,
in the repo below. Full citations are on the deck's Sources slides (27–30 of 30) and in
`research/brief.md`.

## The four patterns

1. **Fan-out and merge** — shape: independent pieces. Send each piece to its own subagent in
   parallel; one orchestrator merges the returns in a single place.
2. **Pipeline** — shape: sequential steps. Planner, implementer, tester run in order, each stage
   starting with a fresh context and a file hand-off. Do not fan out a sequential job.
3. **Writer and critic** — shape: needs verifying. One agent produces; a second reviews
   adversarially with tools in hand (tests, schema, data) and sends findings back for a round or two.
4. **Parallel isolated workers** — shape: shared repo. Each agent works in its own git worktree on
   its own branch; a single merge step reconciles them at the end.

## Try this on your own repo — a three-line recipe

**1. Frontmatter skeleton** for a subagent file (e.g. `.claude/agents/my-agent.md`):
```
---
name: my-agent
description: one sentence — what it does and when to launch it
tools: Read, Grep, Glob, Write
model: sonnet
---
Plain-English instructions: the goal, the input files, the output path, and what to return.
```

**2. Headless call with a budget cap** (copied from the deck's "A subagent is a markdown file"
slide):
```
claude -p --agent critic --allowedTools Read,Glob,Grep,Write --max-budget-usd 5 "$(cat prompt.md)"
```

**3. One check on the return:** read the text the call prints back and confirm it is a short
summary — roughly 200 to 2,000 tokens — not a dump of every file the agent read.

## First step to try

From the deck's closing slide: put one bounded, read-only subtask in its own agent file. Run it
once. Check summary length.

## This repo's pipeline

| Agent | Model | Role |
|---|---|---|
| researcher | sonnet | One assigned topic, web search/fetch, writes a cited brief; run several in parallel for a fan-out |
| outliner | sonnet | Turns the merged research brief + `talk-context.md` into a timed, slide-by-slide outline |
| slide-writer | inherit | Writes or revises the Marp deck; also the critic loop's revise half; runs in its own worktree |
| diagrammer | sonnet | Produces the Mermaid diagrams for the four patterns and the pipeline itself |
| critic | inherit | Adversarial content reviewer against a fixed rubric; PASS/REVISE; never edits the deck |
| fact-checker | sonnet | Verifies every citation/number by fetching the source; never edits the deck |
| notes-writer | sonnet | Writes the speaker script and this handout; never touches slide content |
| qa-skeptic | sonnet | Drafts the ten hardest likely audience questions with grounded answers |
| demo-editor | sonnet | Converts the live demo into a recorded one built from pre-captured screenshots |
| design-critic | sonnet | Reviews rendered slide PNGs for readability and layout; never edits the deck |
| teaching-critic | sonnet | Scores the deck against the learning objectives; never edits the deck |

**Two commands to run the pipeline:**
```
pipeline/run.sh all     # outline -> write (2 worktrees) -> critic/revise loop
                         # -> fact-check -> notes+QA (parallel) -> cost report
pipeline/run.sh shots   # captures terminal screenshots and rewrites the 10 demo slides around them
```
Any single stage can also be run on its own: `pipeline/run.sh <stage>` (see the header comment in
`pipeline/run.sh` for the full stage list and the `--commit`/`--budget`/`--rounds` flags).

**Where the logs and cost report live:** every stage writes one directory under
`runs/NNN-<stage>/` — `prompt.md` (exact prompt sent), `result.json` (full headless output: text,
tokens, cost, turns), `return.md` (what the agent returned), `exit-code`, and the stage's own output
file (`runs/README.md` has the layout; the parallel `write` and `critique` stages nest one
subdirectory per worker or critic). `runs/cost-report.md` and `runs/cost.tsv` are rebuilt from every
`result.json` by `pipeline/cost_report.py`; no stage appends to a shared file, so parallel runs
cannot collide on the log. As verified today: 16 logged stages, $27.94 total.

**Repository:** https://github.com/xoubish/multiGrits

## Links

1. Repo above.
2. Claude Code, subagents — https://code.claude.com/docs/en/sub-agents
3. Claude Code, worktrees — https://code.claude.com/docs/en/worktrees
