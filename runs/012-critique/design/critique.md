Verdict: REVISE

## Scores

| # | Criterion | Score |
|---|---|---|
| 1 | Readability from the back of the room | 6 |
| 2 | Visual hierarchy and consistency | 8 |
| 3 | Whitespace and density | 6 |
| 4 | Image treatment | 5 |
| 5 | Typography | 8 |
| 6 | Color and theme | 9 |
| 7 | Title and section slides | 7 |

## Findings

1. Slide 40 (`demo-editor`): the terminal screenshot renders at roughly 480px wide — less than half the width of every other appendix screenshot (32–39 render 900–1075px wide) — because sizing comes only from the fixed `![h:470]` height and this capture is unusually tall/dense, so its code text is by far the smallest, least legible text in the deck. Fix: in the style block, replace fixed-height sizing with a shared bounding box, e.g. `section.shot img { width: auto; height: auto; max-width: 900px; max-height: 470px; }`, and ask the capture step to trim this screenshot to fewer lines so it isn't an outlier. Must-fix.

2. Slides 11–20 and 32–40 (all screenshot slides): image widths vary a lot slide to slide (e.g. slide 15's `stage-write` capture is ~875px wide vs. ~1120px on slides 13/16/19) purely because `h:470` fixes height and lets width float with each source image's aspect ratio, so the "one screenshot, full width" framing promised in the deck is inconsistent. Fix: same CSS bounding-box rule as above (`max-width` + `max-height`, `width/height:auto`) so every capture fills a common footprint instead of drifting in size. Must-fix.

3. Slides 3, 4, 5, 10, 21–26 (bullet/statement content slides): body text clusters in the upper half, leaving a large empty band (roughly a quarter of the slide) between the last line and the footer on every one of these slides, so next to the diagram and screenshot slides they read as under-filled. Fix: vertically balance the non-shot sections, e.g. `section { display: flex; flex-direction: column; justify-content: center; }` (verify the footer/page-number, which the default theme positions with absolute placement, is unaffected). Nice-to-have (consistent, so low risk, but would visibly tighten a third of the deck).

4. Slide 2 (`meta-pipeline` diagram): edge labels ("outline", "task", "merged brief", etc.) are noticeably smaller than the labels on the four pattern diagrams (slides 6–9), because eight nodes are stretched across one horizontal row to fit the slide width. Fix: add a mermaid init directive to bump font size for this diagram only, e.g. `%%{init: {"themeVariables": {"fontSize": "20px"}}}%%` at the top of `diagrams/meta-pipeline.mmd`, or lay it out in two rows so the SVG isn't scaled down as far. Nice-to-have.

5. Slide 15 (`stage_write, two worktrees`): the caption wraps to two lines and its second line ("... `[pipeline/run.sh]`.") sits only ~15–20px above the footer, noticeably tighter than the single-line captions on every neighboring shot slide. Fix: trim the caption to fit one line (drop "The agents decide nothing here" or move it to speaker notes), or add `section.shot p { margin-bottom: 14px; }` for headroom. Nice-to-have.

6. Slide 31 ("Appendix · The agents, as files"): this section-divider uses the same plain left-aligned single heading as a normal content slide, with no subtitle or accent, so it doesn't read as a deliberate transition the way slide 1's title card does. Fix: give divider slides their own class with a one-line subtitle (e.g. "Nine files, one per pipeline stage.") echoing the title-slide treatment. Nice-to-have.

7. Slide 1 (title card): clean and correctly ordered, but the only visual distinction from a default Marp title is font size — no accent rule or color block ties it to the deck's one accent (navy). Fix: add a thin accent rule under the H1 scoped to the title slide, e.g. `section:first-of-type h1 { border-bottom: 3px solid #1e3a5f; padding-bottom: 8px; }`. Nice-to-have.
