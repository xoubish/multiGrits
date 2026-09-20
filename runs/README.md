# Run logs

Every pipeline stage writes one directory here, numbered in execution order:

```
runs/NNN-<stage>/
  prompt.md      the exact prompt the agent received (templates live in pipeline/prompts/)
  result.json    full `claude -p --output-format json` output: result text, usage, cost, turns
  return.md      the text the agent returned to the orchestrator
  exit-code
  <stage output> e.g. critique.md, factcheck.md, changes.md, notes.md
```

The parallel `write` stage nests two subdirectories, `slides/` and `diagrams/`, one per worktree.

Each run directory gets its own `cost-row.tsv`. `pipeline/cost_report.py` regenerates `cost.tsv` and `cost-report.md`
from every `result.json`; nothing appends to a shared file, because run 004 showed why (see its README).

`001-research-fanout/` was run interactively inside a Claude Code session (the orchestrator spawned
four researcher subagents with the Agent tool), so it has `prompts/` and `returns/` instead of
`result.json`. Its cost is recorded by hand in its README from the session's `/cost` output.

## Two generations, one numbering

The numbering runs straight through both versions of the pipeline on purpose, because the talk tells
the story of the change. Do not renumber them.

| Runs | Pipeline | What it was |
|---|---|---|
| `000`–`014` | **Attempt one**, retired 2026-09-17 | Eleven agent roles, and the agents wrote the outline as well as the slides: four `researcher`s, an `outliner`, three critics with counting rubrics, a `demo-editor`. About $29.22. It met every constraint and produced a deck that was unpresentable. Three of its failures are teaching material in the talk: the spec contradiction the outliner logged rather than silently resolving (`002`), the worktree merge conflict on a shared cost log (`004`), and the budget cap that exited 1 instead of the documented 2 (`006`). |
| `015`–`030` | **Attempt two**, current | Ten agents, the outline written by hand and off limits to every agent, three critics replaced by one `reviewer` that looks at the rendered slide images. About $25.09. |

`runs/cost-report.md` totals both: **$54.31**.

These logs are the demo. Show the audience a prompt, the return, and the diff a stage produced.
(The first pipeline had a `pipeline/capture.py` that screenshotted them for a recorded-demo slide;
both the script and those slides were retired with `demo-editor`.)
