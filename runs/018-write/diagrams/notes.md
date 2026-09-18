# Diagrams — notes

One line per diagram: filename, node count, what it shows.

- `diagrams/fan-out.mmd` — 5 nodes. Orchestrator sends the same target list to three archive
  agents (IRSA, NED, Exoplanet Archive), each isolated, each returns a summary merged into one
  table. Illustrates entry 7 (Pattern 1, fan-out and merge).
- `diagrams/pipeline.mmd` — 5 nodes. A script hands a task to a planner, whose plan file passes
  to an implementer, whose diff passes to a tester, ending in a result; each stage gets a fresh
  context. Illustrates entry 8 (Pattern 2, pipeline).
- `diagrams/writer-critic.mmd` — 6 nodes. A script owns the loop: writer drafts, a critic reviews
  with tests/schema/data in hand and returns a critique to the script, which sends a revise
  instruction back to the writer; a pass produces the approved artifact. Illustrates entry 9
  (Pattern 3, writer and critic).
- `diagrams/parallel-workers.mmd` — 5 nodes. A script assigns the same kind of task to three
  workers, each in its own git worktree; each returns a diff to a merge-and-verify step.
  Illustrates entry 10 (Pattern 4, parallel isolated workers) and the two-agents-one-file failure
  it avoids.
- `diagrams/meta-pipeline.mmd` — 5 nodes. `pipeline/run.sh` (the script, the orchestrator) drives
  this repo's own build: evidence/example/chronicle stages, then a three-worktree write stage,
  a critique-revise loop, fact-check/notes/Q&A, ending in the verified deck. Illustrates entry 13
  (this deck was built by the pipeline in this repo) and matches the stage order in `run.sh`.
