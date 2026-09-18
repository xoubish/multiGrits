- `diagrams/fan-out.mmd` — 5 nodes: orchestrator fans a target list out to three isolated archive agents (IRSA, NED, Exoplanet Archive), each returning a summary merged into one table.
- `diagrams/pipeline.mmd` — 5 nodes: script → planner → implementer → tester → result, each stage a fresh context, hand-off is a plan file then a diff then a test report.
- `diagrams/writer-critic.mmd` — 6 nodes: script owns the loop between writer and a tool-equipped critic (tests/schema/data), critique goes back to the script which issues the revise, pass yields the approved artifact.
- `diagrams/parallel-workers.mmd` — 5 nodes: script assigns tasks to three workers each in its own git worktree, diffs merge and get verified — the fix for two-agents-one-file.
- `diagrams/meta-pipeline.mmd` — 5 nodes: `pipeline/run.sh` as orchestrator driving this repo's stages — evidence/example/chronicle, three-worktree write, critique↔revise loop, fact-check/notes/Q&A — to a verified deck.

Notes written to `runs/018-write/diagrams/notes.md`.
