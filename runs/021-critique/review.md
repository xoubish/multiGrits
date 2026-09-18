Verdict: REVISE

Reviewer: one pass over `talk-context.md`, `slides/outline.md`, `slides/deck.md` with notes, all 54 rendered PNGs, `slides/illustrations/README.md`, and `research/build-log.md`.

## 1. Do I know what the talk is about by slide 3, and do I care?

Yes. Slide 2 states the question in one sentence ("when is a second one worth having?") and slide 3 makes it personal and poses the honest temptation. By slide 6 the thesis is on screen in five words. An IPAC engineer who used Claude Code yesterday would care, because the question is exactly the one they have. Slide 3 is the weakest of the three: it is 60 s of stalling on a question the audience has already asked themselves, and the outline lists it as a cut candidate.

## 2. Slides I could delete without anyone noticing

Slide 3 (the outline's own cut 4). Slide 18 (past a thousand agents) adds a fact nobody will act on; slides 16–17 already make the "small systems" point. Slide 35's second paragraph ("Run 018 onward") says nothing yet; the whole slide is a placeholder until the second chronicle pass. Slide 49 repeats slide 51's checklist almost verbatim and slide 20's description of the pipeline; if it stays, it needs a job the neighbours do not do. These are outline entries, so they are for the speaker, not the slide-writer.

## 3. Can I read every slide from the back, and does it read aloud?

Body text at 26px reads well and almost every slide is a paragraph the speaker can say as written; slides 5, 6, 39, 44 and 52 are the best examples. Three things fail from the back. Slide 46 is a fourteen-line block of 19px monospace with no sentence to read aloud; it should be split into the three rules (slide A) and the return format (slide B), or the return format goes to the handout. The writer-critic diagram on slide 13 and the meta-pipeline diagram on slide 20 render their labels at roughly 12–14px ("Tests, schema, data", "evidence + build log") and cannot be read past the third row. The `.cite` class is 22px, under the deck's own 24px rule; every citation line is affected. No slide is over about 60 words of body, though slides 22, 25 and 43 are at the limit.

## 3b. Is every citation complete on the slide?

Almost all are: Liu (7), Hsieh (8), Anthropic effective-agents (9), worktrees (15), Subagents (16), the three on 17, the two on 18, Kim (38), Anthropic research (40), Kapoor (42), MAST (43, finding and numbers in the body, tag in the cite line, acceptable), the two on 50, custom-subagents (51). One is incomplete: slide 41, Tran and Kiela (April 2026), has authors, year and arXiv id but no title, and the notes say no file in the repo has it. That is a bare tag by the deck's own standard. Slide 39 carries a claim ("returns diminish once the single agent is already strong") with no citation at all; see 7.

## 4. Could I do this afterwards?

Yes, and this is the deck's strongest segment. Slide 30 shows an agent file's frontmatter, slide 31 its instructions, slide 32 the exact headless call with budget and JSON output, slide 33 the stage order with each stage named as one of the four patterns, slide 21 the folder layout, slide 28 the outline entry format, slide 37 what a run directory contains, and slides 45–48 a second, complete agent that I could copy on Monday including its real output and cost. That is the full recipe the context file asks for. Missing: nothing structural; the "revise" stage between the second chronicle and factcheck is on slide 33 but never explained anywhere (notes on slide 33 explain chronicle running twice, not revise).

Build-story check against `research/build-log.md`: every number and every quoted file text on slides 21–37 and 48 matches the log ($29.22, 1,222 turns, 578,569 tokens, 6,169 s; runs 002/003 details; run 004 `runs/cost.tsv` and `cost-row.tsv`; run 006 $3, 34 turns, 20 of 24, exit code 1 vs 2; 44/2/0 citations; run 015 37 turns $0.7286 171 s, 13 of 16, 4 flagged; run 016 28 turns $0.3209 207 s; $1.0495, 65 turns, $30.27; the reviewer.md lines; the `claude -p` block; the stage-order block; the outline entry; the folder lines; $0.0751, 82.5 s, 8 turns, ~250 and 7,321 tokens). No must-fix here. One inherited oddity: slide 22 says "eleven agent roles" and then lists fourteen; the build log itself flags that its source does not add up. Reported to the speaker below.

## 5. Does the speaker admit something did not work?

Yes, and at length: slides 23–25 are three concrete failures with run numbers, slide 26 shows one of the bad slides, slide 27 names the cause ("nobody scored whether it was a talk"), and slide 48 adds the small honest caveat that the token cap covered the table, not the 7,321 tokens of thinking. Slide 16 also admits the Codex/Cursor claim is unchecked. This is the right amount and in the right place.

## 6. Does it look like one deck?

Mostly. Typeface, navy headings, grey citation lines and the code-block style are consistent across all 54 slides, and the four Mermaid diagrams share one theme. Illustrations: all five in `slides/illustrations/README.md` are placed where the README suggests (title on 1, teams on 4, two-terminals on 19, merge-conflict on 24, close on 52), and teams, two-terminals and merge-conflict sit well beside their text at the suggested widths and compete with nothing. The two `bg right:45%` placements are the problem. On slide 52 the close illustration is cropped hard: the star is sliced by the top edge, the agent window runs off the right edge, the person is cut in half at the left; it looks like a rendering error, and it is the last thing the audience sees. Slide 1 has the same cover-crop, less badly (the telescope from the README's description is gone and the left window is half cut). Slide 46 is the other slide that looks out of place: no heading text, no sentence, one grey box of code. Slides 26 and 27 are fine as a pair; the tiny screenshots are the point, though the audience will not be able to read what "a wall of cited percentages" looked like.

## 7. Non-goals and unsupported claims

No slide re-explains agents or Claude Code, none shows pricing, none goes into sandboxing; slide 51 correctly points to Nick and slide 52 hands to BJ in one line. Slide 15 is about a Claude Code feature but it is used to make the isolation point, not to teach the tool, so it is fine. Two statements are not supported by the notes or evidence: slide 39's second paragraph (diminishing returns for a strong single agent) has no source, and the slide-writer's own note says `research/evidence.md` has no number or quote for it from Kim et al.; and slide 41's citation lacks a title because no repo file has one. Slide 16's Codex/Cursor sentence is honestly hedged on the slide, so it passes.

## Findings

1. **Slide 52** — The `bg right:45%` close illustration is cover-cropped so the star, the person and the agent window are all sliced by the slide edges and it reads as a broken render on the final slide. Fix: use `![bg right:45% fit](illustrations/close.svg)` (or `contain`) and apply the same to slide 1. **Must-fix.**
2. **Slide 41** — The Tran and Kiela citation has no title, so by the deck's own rule it is a tag, not a citation. Fix: evidence-finder or fact-checker supplies the title from arXiv 2604.02460; if none can be verified before talk day, drop slide 41 and keep the outline's cut 2 (Kim et al. only). **Must-fix.**
3. **Slide 39** — "The returns diminish once the single agent is already strong" is a factual claim about Kim et al. with no number, quote or source in `research/evidence.md`. Fix: evidence-finder adds the supporting figure from Kim et al. and it goes into the cite line, or the sentence is rewritten as the speaker's own inference ("my reading is that..."). **Must-fix.**
4. **Slide 46** — Fourteen lines of 19px monospace with no readable sentence; it cannot be read from the back or spoken aloud. Fix: split into two slides, "Do this" (lines 1–9) with one sentence above it, and "Return format" (the rest) with one sentence, or move the return format to the handout and keep only the three rules. **Must-fix.**
5. **Slides 13 and 20** — Diagram labels render at roughly 12–14px ("Script (owns the loop)", "Tests, schema, data", "evidence + build log") and are illegible past the front rows. Fix: give the writer-critic diagram full width under the text as slide 12 does, and have the diagrammer raise the Mermaid font size or shorten edge labels on the meta-pipeline. **Must-fix.**
6. **All citation lines** — `.cite` is 22px, under the deck's own 24px floor. Fix: set `.cite { font-size: 24px }` and let slides 38 and 40 lose one clause each if they overflow. **Nice-to-have.**
7. **Slide 35** — "Run 018 onward" is a placeholder paragraph that teaches nothing today. Fix: when the second chronicle pass has run, the revise stage replaces it with one line per run from the build log, as the note already says; until then it is honest but empty. **Nice-to-have.**
8. **Slides 26–27** — The screenshots are too small to show what the bad deck looked like. Fix: crop each screenshot to its title and bullets and render at `w:560`. **Nice-to-have.**
9. **Slide 33** — The `revise` stage after the second chronicle appears in the stage order but is never explained on the slide or in its note. Fix: one clause in the paragraph: "then one revise pass to place the new build-log entries." **Nice-to-have.**

## For the speaker

- Entry 14 / slide 22: the build log says "eleven agent roles" and then lists fourteen (four researchers, outliner, slide-writer, diagrammer, three critics, fact-checker, notes-writer, Q&A skeptic, demo editor). The log itself flags that README's count does not add up. Someone in this audience will count. Decide whether it is eleven files or fourteen roles and fix the README so the chronicler and slides inherit the right number.
- Entry 3 (slide 3) spends 60 s posing a question the audience has already asked; the cut list already names it. Consider taking cut 4 now rather than on the day.
- Entry 25 (slide 49) says what entry 26's checklist and entry 13's description already say. Give it a distinct job (for example, the one thing about the pipeline that surprised you) or fold it into 26.
- Entry 11 (slides 16–18) is 45 s across three slides for the point "one orchestrator, two to five workers, and no histogram exists"; cut 3 (one spoken sentence on entry 6) would give that time to the recipe.
- Entry 19 cannot be honest until the second chronicle pass runs; if it does not run before the talk, take cut 1.
