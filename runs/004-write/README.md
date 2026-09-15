# Run 004 — write stage (pattern 4: parallel isolated workers), and the merge conflict it produced

`pipeline/run.sh write`. Two worktrees created from the same commit, two agents run at the same time:

| Worktree | Agent | Model | Turns | Output tokens | USD | Wall time |
|---|---|---|---|---|---|---|
| `.worktrees/slides` | slide-writer | session model (Fable 5.1) | 13 | 26k | $2.37 | 5.2 min |
| `.worktrees/diagrams` | diagrammer | Sonnet | 16 | 9k | $0.22 | 1.4 min |

Both agents finished cleanly and committed on their branches. The slides branch merged first as a fast-forward.
The diagrams branch **conflicted on `runs/cost.tsv`**: `log_result.py` appended one row to a single shared cost
log from inside each worktree, so both branches changed the same lines of the same file. The script stopped at
the failed merge and left git mid-merge with the diagrams worktree still on disk. Later stages (005 to 010)
kept running in that state and appended more rows below the conflict markers.

## Why this is the best slide in the deck

It is the exact failure the talk warns about: two agents, one file. The agents never touched each other's
outputs, `slides/` and `diagrams/` were perfectly isolated, and the collision came from the orchestration's
own bookkeeping, a shared log nobody thought of as "the agents' file". Git turned the silent overwrite into a
visible conflict, which is the promise of pattern 4.

## Fix

- Resolved by keeping both rows, completed the merge (commit "pipeline: merge diagrams worktree (resolved
  runs/cost.tsv conflict...)"), removed the worktree and branch.
- Root cause: `log_result.py` now writes `<run_dir>/cost-row.tsv` instead of appending to a shared file, and
  `pipeline/cost_report.py` regenerates `runs/cost.tsv` from every `result.json`. Parallel workers no longer
  write to any common path.
- `stage_write` now prints resolution instructions and exits when a merge fails instead of dying on `set -e`.

## Related: run 006 hit the budget cap

The first revise pass (`runs/006-revise`) exhausted the $3 default `--max-budget-usd` after 34 turns: the
slide-writer on the session model re-reads the whole deck and brief each time. `result.json` shows
`terminal_reason: budget_exhausted` and `subtype: error_max_budget_usd`, but the process exit code was 1, not
the 2 the docs describe. The stage had already written most of its changes (`changes.md` lists 24 items);
run 007 critiqued the result and run 008 finished the revision. Default budget raised to $5 and the script
now detects budget exhaustion from `result.json` rather than the exit code.
