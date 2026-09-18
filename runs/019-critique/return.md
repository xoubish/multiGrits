**Verdict: REVISE** — written to `runs/019-critique/review.md`.

The three findings that matter most:

1. **Slides 1, 4, 19, 24, 52 — illustrations unplaced (must-fix).** `slides/illustrations/README.md` lists five SVGs with suggested Marp lines; none appears anywhere in `deck.md`. Add the lines as the README specifies (`bg right:45%` on the title and close, `w:520` beside the text on 4, 19, 24).

2. **Slides 30 and 45 — the agent files are unreadable (must-fix).** The one-line `description:` in each frontmatter block forces Marp to shrink the whole code block to ~7px, so the one thing those slides exist to show cannot be read. Break the description across a few lines (or trim it with a visible marker) so the block renders at the theme's 19px. Same class of problem on **slides 12 and 20**, where left-to-right Mermaid chains squeezed into the narrow column render as unreadable strips; go top-down or full-width.

3. **Slide 41 (and 54) — Tran & Kiela citation has no title (must-fix).** Authors, year, arXiv id and finding are there; the title is missing, and the note admits `research/evidence.md` lacks it. The fact-checker or evidence-finder should supply it.

Everything else is sound: the opening lands by slide 3, the build-story numbers on slides 22–36 and 48 all match `research/build-log.md` exactly, the failure admission (slides 23–27, 48) is real, there is no overlap with neighbouring talks, and the recipe slides (21, 30–33, 37, 45–48) would let someone replicate the workflow. Structural notes (the unsupported "diminishing returns" sentence on slide 39, slide 49 repeating 20 and 51, the 2,000-vs-600 token cap) are under `## For the speaker` and do not count toward the verdict.
