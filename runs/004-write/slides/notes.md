# Slide-writer notes — run 004, write stage (slides worktree)

Date: 2026-09-15. Output: `slides/deck.md`, replacing the skeleton entirely.

## Slide count

**24 slides** (limit 25). The outline's 21 content slides, in the outline's order and numbering, plus
three Sources slides (22–24). Sources were split across three slides so each stays under the 40-word
body cap while carrying full URLs; a `section.sources` class shrinks the font so long URLs fit. If the
critic reads "a Sources slide" as strictly singular, the three can be collapsed into one at the cost
of the word cap on that slide.

## Constraint check

- One idea per slide; body text counted by whitespace tokens, excluding the h1, diagram tokens, and
  HTML comments. Highest counts: slide 9 (37), slide 19 (38), slide 4 (36), slide 8 (36). All ≤ 40.
- Five diagram tokens used, one per line: `meta-pipeline` (slide 2), `fan-out` (6), `pipeline` (7),
  `writer-critic` (8), `parallel-workers` (9). Nothing drawn; nothing written to `diagrams/`.
- Every number on a slide has a bracketed tag; 23 tags, all resolved on slides 22–24. Repo files
  (`run 000`, `run 001`, `pipeline/run.sh`) are cited by path since there is no public URL yet.
- Speaker notes are an HTML comment under every slide, with segment timing and the demo fallbacks.
- Nothing from the brief's "Unverified" section appears on a slide.

## Deviations from the outline, deliberate

- Slide 13: outline names the worktrees `slide-writer` and `diagrammer`. Those are the agent names;
  `pipeline/run.sh stage_write` names the worktrees `slides` and `diagrams` (branches `wt/slides`,
  `wt/diagrams`). Slide uses the script's names so the terminal matches the slide.
- Slide 6 cites Xu 2026 (GAIA time-vs-tokens trade) instead of Kim 2026; Kim's +80.8% is kept for
  slide 10 so the number appears once, per the outline's own "cuts if running long" note.
- Slide 8 puts MAST's 23.5% on the slide and moves Jamshidi's 0.422→0.272 / 0.789→0.769 figures to
  the notes; both fit the word cap only one at a time.
- Slide 21 drops "11:45" so no unsourced number sits on the slide.

## Three slides I am least confident in

1. **Slide 6 (Fan-out and merge).** It carries two vendor numbers (90.2%, ~15x) from Anthropic's own
   post. The brief flags the post's URL as disputed between two researchers; I used the
   `built-multi-agent-research-system` slug from the outline, and the fact-checker must confirm it
   resolves. The 90.2% figure is an internal eval with no independent replication, and the slide
   says "breadth research" where the post says "internal research eval" — a paraphrase the
   fact-checker may tighten.

2. **Slide 14 (Live critic).** The body promises a specific on-screen sequence
   (`runs/0NN-critique/critique.md`, PASS/REVISE, criterion 6 text) that depends on the live call
   succeeding within its budget. The criterion text was verified against `.claude/agents/critic.md`,
   but the slide is scored by the very critic it describes, and a REVISE verdict on this slide
   during the talk is possible. The fallback is in the notes, not on the slide, which is a judgment
   call on word count.

3. **Slide 9 (Parallel isolated workers).** Three quotations on one slide is dense for 90 seconds,
   and the Osmani post has no date in the brief, so its tag is `[Osmani]` without a year, unlike
   every other tag. The claim "isolation removes the shared-file fight" is my summary of the
   worktrees doc, not a quotation; the doc says writes to the main checkout are blocked, which is
   narrower.

## For the fact-checker

- Anthropic multi-agent post URL (see slide 6 above).
- Kim 2026 numbers are arXiv v3 (260 configs, +80.8%), not the Google blog (180, +80.9%).
- Osmani post date.
- "~7,100 words" and "~800 words" on slide 12 come from `runs/001-research-fanout/README.md`
  observations, not from a measured count in this run.
