# Orchestrator hand-fixes during run 022 (2026-09-17)

Applied by the orchestrating session, not by an agent, because the files belong to agents that were not running:

- `diagrams/meta-pipeline.mmd`, `diagrams/writer-critic.mmd`: shortened node and edge labels so the LR chains render
  near full size (review 021, finding 5). Diagrammer's files; slide-writer may not touch them. SVGs re-rendered.
- `research/evidence.md`: added the Tran and Kiela (2026) title, fetched from the arXiv abstract page (review 019
  finding 4, review 021 finding 2). Evidence-finder's file.
- `slides/deck.md` (after run 022 finished, before run 024 started): inserted the Tran and Kiela title on the
  citation slide and the Sources slide, and replaced the TODO note. The slide-writer had declined twice, correctly,
  because it could not verify the title itself.

## Loop outcome (from runs/pipeline-all.log)

Review round 1 (run 019): REVISE, 4 must-fix. Revise 020 applied 3, declined the paper title (unverifiable).
Review round 2 (run 021): REVISE, 5 must-fix. Revise 022 applied 3, declined the title and the diagram labels
(diagrammer's files). Both declined items were then applied by the orchestrator, above. The script stopped at its
2-round limit with the verdict REVISE and printed "Human review needed"; that human review is this file.
- `slides/shots/first-deck-*-crop.png`: cropped copies of the old-deck screenshots (review 021 finding 8), for the
  slide-writer or the speaker to swap in on the "What came out" slides. Originals kept.
- `slides/deck.md`: pointed the "What came out" slides at the cropped screenshots (during run 025, fact-checker
  running; it reads the deck and writes only its own file).
