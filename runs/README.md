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

`cost.tsv` gets one row per stage. `pipeline/cost_report.py` turns it, plus the JSON, into `cost-report.md`.

`001-research-fanout/` was run interactively inside a Claude Code session (the orchestrator spawned
four researcher subagents with the Agent tool), so it has `prompts/` and `returns/` instead of
`result.json`. Its cost is recorded by hand in its README from the session's `/cost` output.

These logs are the demo. Show the audience a prompt, the return, and the diff the stage produced.
