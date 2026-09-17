Verdict: **REVISE**

I reviewed `talk-context.md`, the `deck.md` style block, and all 40 rendered slides in `slides/build/png/`. Full critique written to `runs/012-critique/design/critique.md`.

Scores (0–10): readability 6, hierarchy/consistency 8, whitespace/density 6, image treatment 5, typography 8, color/theme 9, title/section slides 7.

The three fixes that would improve the most slides:

1. **Normalize screenshot sizing across all 19 screenshot slides** (11–20, 32–40). Sizing today is driven only by a fixed `![h:470]` height, so width floats with each capture's aspect ratio — slide 40 (`demo-editor`) renders barely 480px wide with by far the smallest, near-illegible code text in the deck, and slide 15 is noticeably narrower than its neighbors. Fix: `section.shot img { width: auto; height: auto; max-width: 900px; max-height: 470px; }` so every capture fills the same footprint.

2. **Balance vertical whitespace on bullet/statement slides** (3, 4, 5, 10, 21–26). Body text sits in the upper half, leaving roughly a quarter of the slide empty above the footer, so these read as under-filled next to the diagram/screenshot slides. Fix: `section { display: flex; flex-direction: column; justify-content: center; }` on non-shot sections.

3. **Fix the meta-pipeline diagram's undersized labels** (slide 2). Eight nodes stretched across one horizontal row scale down further than the four pattern diagrams, making its edge labels the smallest diagram text in the deck. Fix: bump font size via a mermaid init directive in `diagrams/meta-pipeline.mmd`, or reflow it to two rows.

Minor/one-off notes (slide 15 caption crowding the footer, slide 31's plain appendix divider, slide 1's title card lacking an accent) are logged in the critique file as nice-to-haves.
