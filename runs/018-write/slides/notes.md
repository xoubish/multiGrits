# Slide-writer notes — run 018-write/slides

Output: `slides/deck.md`, 53 slides (51 presented + 2 Sources). No `slides/illustrations/README.md` existed at
write time, so no illustrations are placed; that is a revise-stage job.

## Slides per outline entry

| Entry | Slides | Entry | Slides |
|---|---|---|---|
| 1 Title | 1 | 15 What came out | 2 (both screenshots) |
| 2 Yesterday | 1 | 16 Reset | 2 |
| 3 Why not more | 1 | 17 Recipe 1 (agent file) | 2 |
| 4 Teams | 2 | 18 Recipe 2 (command, stages) | 2 |
| 5 Thesis | 3 | 19 Attempt two step by step | 2 |
| 6 Workflows / axes | 2 | 20 Cost and receipts | 2 |
| 7 Fan-out | 1 | 21 Kim et al. | 2 |
| 8 Pipeline | 1 | 22 Rest of evidence | 3 |
| 9 Writer-critic | 1 | 23 How it fails | 2 |
| 10 Parallel workers | 2 | 24 Simple example | 4 |
| 11 How many | 3 | 25 Difficult example | 1 |
| 12 You already do this | 1 | 26 Cost / worth it | 2 |
| 13 Built by pipeline | 2 | 27 Close | 1 |
| 14 Attempt one | 4 | Sources | 2 |

## TODO evidence

- Entry 11, slide "How many agents?": outline says Codex and Cursor also default to one agent with an occasional
  subagent; `research/evidence.md` confirms this only for Claude Code. Slide says so aloud; TODO in notes.
- Entry 21, slide "(2): task shape decides": "diminishing returns once the single agent is already strong" has no
  number or quote in `research/evidence.md`.
- Entry 22, Tran & Kiela (2026): `research/evidence.md` gives no paper title, so the slide citation has authors,
  year, and arXiv id only.
- Entry 24 (not a TODO, a discrepancy to flag): outline says "under 2,000 tokens"; the built agent file caps the
  reply at 600 tokens. Slide follows the real file.

## Least sure of

1. **"Attempt two, step by step (2)"** (entry 19): the build log has run 017 "in progress" and later stages "not
   recorded", so the second half of the slide describes what will be recorded rather than what was. The post-loop
   chronicle pass and revise stage should replace it with the real run lines.
2. **"Simple example you can run Monday (2): the instructions"** (entry 24): fourteen lines of 19px code copied
   exactly; legible in the render but the densest slide in the deck. If the reviewer flags it, trim to lines 7–14
   and 19–20 of the agent file.

## For the speaker

- Entry 11 names Codex and Cursor; either narrow to Claude Code or accept the hedge on the slide.
- Entry 24's "under 2,000 tokens" vs the example's 600-token cap: adjust one or the other.
