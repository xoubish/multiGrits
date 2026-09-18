# Changes — run 020 revise, from runs/019-critique/review.md

Build log check: research/build-log.md section 3 lists runs 015, 016, 017; the deck already covers all three (entry 19 slides). No build-story update needed.

- Slides 1, 4, 19, 24, 52 (illustrations unplaced) — CHANGED. Placed all five per slides/illustrations/README.md: `title.svg` as `bg right:45%` on the title; `teams.svg` `w:520` in a `.cols` grid on entry 4 slide 1; `two-terminals.svg` `w:520` beside entry 12; `merge-conflict.svg` `w:460` beside the shared-cost-log failure (entry 14 slide 3, text trimmed to fit, dropped sentence moved to notes); `close.svg` as `bg right:45%` on the close. Notes name each illustration.
- Slides 30, 45 (frontmatter code blocks auto-shrunk) — CHANGED. Truncated the one-line `description:` at a visible `[…]` after its first clause, wrapped to two lines; the slide text says it is cut short and where the full line lives; notes carry the omitted text verbatim. Also added `pre code { white-space: pre-wrap }` to the style so no code block can force a shrink again. No file text altered, only trimmed.
- Slides 12, 20 (pipeline and meta-pipeline diagrams squeezed) — CHANGED. Dropped the `.cols` grid on both; the token now sits full width under the text in a `.wide` div. Did not change the diagrams' orientation; that is the diagrammer's file, not mine.
- Slides 41, 54 (Tran and Kiela title missing) — DECLINED, cannot fix here. Grepped the whole repo: no file carries a title for arXiv 2604.02460. Inventing one would break the no-invented-facts rule. TODO evidence kept in the notes and flagged in my return for the evidence-finder or fact-checker.
- All `.cite` at 20px — CHANGED. Raised to 22px. Slide 38 (Kim et al.) was checked for overflow; the body is two sentences and one cite, so it was left as one slide.
- Slides 11, 13 (pattern diagram labels small) — CHANGED. Added a `.cols-even` class (1fr 1fr) and applied it to patterns 1, 3, and 4; pattern 2 went full width instead.
- Slide 28 (no outline entry shown) — CHANGED. Added the verbatim entry 1 from research/build-log.md section 4 as a code block on entry 16 slide 1, and trimmed the surrounding text to stay near 60 words.
- Slide 35 (placeholder for runs 018 onward) — DECLINED for now, as the reviewer suggested; the second chronicle pass has not run and the build log still says "not recorded". The post-chronicle revise stage replaces it.
- `## For the speaker` items — not acted on, per instructions.
