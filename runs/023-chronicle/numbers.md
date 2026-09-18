## 5. Numbers

**Total cost so far:** $29.22 for attempt one (runs 002–014; run 001 was interactive and its cost is recorded by
hand, not in this total) [runs/cost-report.md; runs/README.md], plus $14.7838 for attempt two so far (runs
015–022, summed from each run's own `cost-row.tsv` since `runs/cost-report.md` has not been regenerated past run
014) [runs/015-evidence/cost-row.tsv; runs/016-example/cost-row.tsv; runs/017-chronicle/cost-row.tsv;
runs/018-write/slides/cost-row.tsv; runs/018-write/diagrams/cost-row.tsv; runs/018-write/illustrations/cost-row.tsv;
runs/019-critique/cost-row.tsv; runs/020-revise/cost-row.tsv; runs/021-critique/cost-row.tsv;
runs/022-revise/cost-row.tsv]. Running total across both attempts as of run 022: **≈$44.00** ($29.22 + $14.7838 =
$44.0038). This chronicle pass (run 023) and every stage after it (a further chronicle-placing revise, factcheck,
notes, qa, cost) are not yet run and their cost is not included.

**Per attempt:**
- Attempt one (runs 002–014, headless stages only): $29.22, 1,222 turns, 578,569 output tokens, 6,169 seconds
  [runs/cost-report.md]. Run 001 (interactive research fan-out) is additional and not logged in dollars here
  [runs/README.md].
- Attempt two (runs 015–022 so far): $14.7838, 328 turns, 1,593 s wall time summed across the ten cost-rows listed
  above (evidence 37t/$0.7286/171s; example 28t/$0.3209/207s; chronicle-1 38t/$0.4361/128s; write/slides
  16t/$3.0735/359s; write/diagrams 16t/$0.1811/60s; write/illustrations 10t/$0.9379/115s; critique-1
  64t/$2.9727/150s; revise-1 27t/$1.6625/132s; critique-2 63t/$2.9859/171s; revise-2 29t/$1.4847/100s)
  [cost-row.tsv files cited individually above]. Remaining stages (a second chronicle, a placing revise,
  factcheck, notes, qa, cost) not yet run; not recorded.

**Agents count:**
- Then (attempt one): 11 named roles per the README's retirement line — four `researcher`s, `outliner`,
  `slide-writer`, `diagrammer`, `critic`, `design-critic`, `teaching-critic`, `fact-checker`, `notes-writer`,
  `qa-skeptic`, `demo-editor` — fourteen distinct role names in that list against the README's stated count of
  eleven; run 021's reviewer flagged this same discrepancy on slide 22 as a "for the speaker" item, unresolved as
  of this writing [README.md; runs/021-critique/review.md].
- Now (attempt two): 10 — `evidence-finder`, `example-builder`, `chronicler`, `slide-writer`, `diagrammer`,
  `illustrator`, `reviewer`, `fact-checker`, `notes-writer`, `qa-skeptic` [README.md; .claude/agents/*.md].

**Slides count:**
- Then (attempt one, final): 25 slides (21 presented + 4 sources), stated as the ceiling in run 006's revise notes
  [runs/006-revise/return.md]. Run 011's demo rework split 5 slides into 10 and added a 10-slide appendix, and the
  spec afterward allowed up to 30 presented slides [runs/011-shots/README.md].
- Now (attempt two): the deck went through three drafts. Run 018 (`write`) produced 53 slides (51 presented + 2
  Sources) [runs/018-write/slides/return.md]. Run 019's reviewer counted 54 rendered PNGs, one more than run 018
  reported — a discrepancy this file does not resolve, since no run explains the difference; run 020 (`revise`)
  reported the count as "unchanged (54)" relative to what the reviewer saw [runs/019-critique/review.md;
  runs/020-revise/return.md]. Run 022 (`revise`), after splitting one dense code slide into two, reported "55
  slides plus two Sources" [runs/022-revise/return.md]. Counting heading markers (`^#`/`^##`) directly in the
  current `slides/deck.md` gives 55 [slides/deck.md], consistent with run 022's own count; the exact total
  including the two Sources slides is therefore about 57, but this file reports the components as each run stated
  them rather than reconciling them by inference.
