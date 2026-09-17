## 5. Numbers

**Total cost so far:** $29.22 logged for runs 002–014 (attempt one; run 001 was interactive and its cost is
recorded by hand, not in this total) [runs/cost-report.md; runs/README.md], plus $0.7286 (run 015) and $0.3209
(run 016) for attempt two so far [runs/015-evidence/cost-row.tsv; runs/016-example/cost-row.tsv]. Running total
across both attempts as of run 016: **$30.27**. Run 017 (this chronicle pass) is in progress and its cost is not
yet known.

**Per attempt:**
- Attempt one (runs 002–014, headless stages only): $29.22, 1,222 turns, 578,569 output tokens, 6,169 seconds
  [runs/cost-report.md]. Run 001 (interactive research fan-out) is additional and not logged in dollars here
  [runs/README.md].
- Attempt two (runs 015–016 so far): $1.0495, 65 turns, 171 s + 207 s wall time
  [runs/015-evidence/cost-row.tsv; runs/016-example/cost-row.tsv]. Remaining stages (write, loop, chronicle,
  revise, factcheck, notes, qa, cost) not yet run; not recorded.

**Agents count:**
- Then (attempt one): 11 — four `researcher`s, `outliner`, `slide-writer`, `diagrammer`, `critic`, `design-critic`,
  `teaching-critic`, `fact-checker`, `notes-writer`, `qa-skeptic`, `demo-editor` [README.md]. (Note: this lists more
  than 11 named roles across the README's retirement list and run 012's three-critic addition; the README's
  "Retired" line names exactly these roles as having existed in attempt one.)
- Now (attempt two): 10 — `evidence-finder`, `example-builder`, `chronicler`, `slide-writer`, `diagrammer`,
  `illustrator`, `reviewer`, `fact-checker`, `notes-writer`, `qa-skeptic` [README.md; .claude/agents/*.md].

**Slides count:**
- Then (attempt one, final): 25 slides (21 presented + 4 sources), stated as the ceiling in run 006's revise notes
  [runs/006-revise/return.md]. Run 011's demo rework split 5 slides into 10 and added a 10-slide appendix, and the
  spec afterward allowed up to 30 presented slides [runs/011-shots/README.md].
- Now (attempt two): not recorded — `slides/deck.md` has not been written yet; the `write` stage has not run as of
  run 016. The outline (`slides/outline.md`) specifies 27 numbered entries (1–27) across segments A–E plus Q&A and
  Sources, several of which may become more than one slide each per the outline's own instruction to "split rather
  than shrink" [slides/outline.md; talk-context.md].
