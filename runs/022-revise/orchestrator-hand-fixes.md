# Orchestrator hand-fixes during run 022 (2026-09-17)

Applied by the orchestrating session, not by an agent, because the files belong to agents that were not running:

- `diagrams/meta-pipeline.mmd`, `diagrams/writer-critic.mmd`: shortened node and edge labels so the LR chains render
  near full size (review 021, finding 5). Diagrammer's files; slide-writer may not touch them. SVGs re-rendered.
- `research/evidence.md`: added the Tran and Kiela (2026) title, fetched from the arXiv abstract page (review 019
  finding 4, review 021 finding 2). Evidence-finder's file.
