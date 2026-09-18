**Verdict: REVISE** — written to `runs/021-critique/review.md`.

The deck is close: the thesis lands by slide 6, the recipe segment (slides 21, 28, 30–33, 37, 45–48) genuinely lets someone replicate the workflow, every build-story number and quoted file text matches `research/build-log.md`, and the failure admission on slides 23–27 is the strongest part of the talk. Five must-fixes remain, three matter most:

1. **Slide 52 (and slide 1)** — The `bg right:45%` close illustration is cover-cropped: the star, the person and the agent window are all sliced by the slide edges, so the final slide looks like a broken render. Fix: `![bg right:45% fit](illustrations/close.svg)`, same on slide 1.

2. **Slide 41** — Tran and Kiela (April 2026) has authors, year and arXiv id but no title, and no file in the repo has one; by the deck's own rule it is a tag, not a citation. Fix: evidence-finder/fact-checker supplies the title, or drop the slide and take the outline's cut 2 (Kim et al. only).

3. **Slide 39** — "Returns diminish once the single agent is already strong" is an unsourced factual claim about Kim et al.; the slide-writer's own note says `research/evidence.md` has no number for it. Fix: add the figure to the cite line, or rewrite as the speaker's own inference.

Also must-fix: slide 46 is fourteen lines of 19px code with nothing to read aloud (split in two or move the return format to the handout), and the diagram labels on slides 13 and 20 render at ~12–14px (give writer-critic full width like slide 12; enlarge the meta-pipeline font). Nice-to-haves and five structural notes for the speaker (the eleven-vs-fourteen agent count on slide 22, cut candidates 3/11/25, and the placeholder on slide 35) are in the file.
