Verdict: REVISE

Content critic, run 012. Inputs: `talk-context.md`, `slides/outline.md`, `slides/deck.md`, `diagrams/*.mmd`, plus a file-existence check on `slides/shots/`. Slide numbers below are deck order: 1–26 content, 27–30 Sources, A1–A10 appendix.

## Scores

| # | Criterion | Score |
|---|---|---|
| 1 | Overlap with neighbor talks | 9 |
| 2 | Time budget realism | 8 |
| 3 | Citations | 6 |
| 4 | Plain language | 9 |
| 5 | Thesis clarity | 9 |
| 6 | Demo segment | 6 |
| 7 | Hand-off to sandboxing talk | 8 |

REVISE because criteria 3 and 6 are below 7.

## Checks that passed

- Non-goals, by name: what-an-agent-is (Ricky) — not explained, slide 1 notes say "no definitions"; Claude Code / Codex / OpenCode intro (Jessica, Ricky) — absent; model selection / pricing tables (Nick) — absent, deferred on slides 22 and 20; local LLM setup (Nick) — absent, deferred in slide 26 Q&A; IDE integration (Keto) — absent; sandboxing / permissions in depth (BJ) — only tool-list mentions, no depth.
- Segment sums: 180 + 420 + 720 + 300 = 1620 s content, 180 s Q&A, exactly the binding table. Ten demo slides sum to 720 s.
- Body text: no slide exceeds 40 words (slides 4 and 24 are at 39; slide 3 at 38).
- Every number in body text carries a bracketed tag that resolves on a Sources slide. All 19 screenshot files referenced exist.
- Thesis on slide 1 subtitle and slide 3 title; explicitly paid off on slides 4, 10, 14, 21, 26.
- Diagrams: 6, 5, 4, 4, 8 nodes; all under the 8-node cap; script owns the loop in writer-critic and parallel-workers, matching gotcha 4.

## Findings

### Must-fix

1. **Slide 20 / 22.** Slide 20 notes say "the outliner, researchers, fact-checker, and demo-editor ran on Sonnet" while the same notes say run 001 is not in the cost table and slide 22 notes say run 001 "actually ran on the parent model" — a contradiction the audience can catch across two minutes. Fix: delete "researchers" from the Sonnet list in slide 20 notes. *(criterion 3)*

2. **Slide 13.** `talk-context.md` requires the three build failures (spec contradiction, merge conflict, budget exhaustion) to be shown, but only the merge conflict (slide 16) is on a slide; the other two survive only as a Q&A answer on slide 26. Fix: add one spoken sentence to slide 13 notes while pointing at the listing: "002 caught a contradiction in the spec; 006 hit its budget cap mid-revision; both are logged here." *(criterion 6)*

3. **Slide 11.** The recorded demo states no fallback and no cut order; the outline's fallbacks are for a live call that no longer exists. Fix: add to slide 11 notes: "If an image fails to render, open the file named in that slide's notes in a terminal tab prepared in advance; if the demo runs long, drop slide 18, then slide 15." *(criterion 6)*

4. **Slide 30 (Sources 4).** Lists `[run 000]` and `[run 005]`, which no slide references, and omits the repo files behind slides 16–20 (`runs/004` conflict README, `runs/007-critique/`, `runs/008-revise/changes.md`, `runs/009-factcheck/factcheck.md`, `runs/cost-report.md`), so "$19.32" and "44 confirmed, 2 partial" have no listed source. Fix: replace the two unused entries with tags for those five paths and add the tags to the captions on slides 16–20. *(criterion 3)*

5. **Slide 11 (outline hazard).** `slides/outline.md` still describes a 21-slide deck with a live critic call at demo minutes 6–10 and a cuts list whose slide numbers do not map to this deck, and downstream agents (notes-writer, qa-skeptic) read it. Fix: outliner regenerates Segment 3 and "Cuts if running long" for the recorded, 30-slide deck — owned by the outliner, not the slide-writer. *(criterion 6)*

### Nice-to-have

6. **Slide 26.** Under the label "One line to close:" the hand-off is two lines. Fix: "Many unsupervised agents means you need sandboxing — that is BJ's talk, next." as one line. *(criterion 7)*

7. **Slide 18.** `shots/budget-hit.png` is captured and unused while the budget-exhaustion failure is never shown. Fix: put `budget-hit.png` on slide 18 in place of `changes.png` and move the DECLINED point into slide 17 notes. *(criterion 6)*

8. **Slide 22.** Notes say "the recorded run on slide 12 predates that fix"; the run-001 README is slide 14. Fix: change "slide 12" to "slide 14". *(criterion 3)*

9. **Slide 22.** About 167 spoken words in 70 s (2.4 w/s) with a three-sentence aside on the researcher model pin. Fix: cut the aside to one sentence ("The agent file pins Sonnet; the logged run 001 predates that pin, as its README says"). *(criterion 2)*

10. **Slide 24.** About 146 spoken words in 55 s (2.65 w/s). Fix: drop "The first is more impressive. The second is reproducible." and the final "We will be asked to show our work." *(criterion 2)*

11. **Slides 11–20.** Per-slide seconds are given but no cumulative clock, so the speaker cannot check against the wall. Fix: prefix each demo slide's notes with its window, e.g. "4:00–5:30". *(criterion 6)*

12. **Slide 10.** Notes cite "the Google blog post says 180 configurations and 80.9 percent" but no Google blog URL is on any Sources slide. Fix: add the URL to Sources 2 or delete the aside. *(criterion 3)*

13. **Slide 2.** Diagram node reads "3 critics ⇄ revise" while the body says "a critic loop" and the appendix shows one `critic.md`. Fix: add one clause to slide 2 notes: "three critics, content, visual, teaching, one rubric each" (or the diagrammer relabels the node). *(criterion 3)*

14. **Slide 6.** Body states the 90.2% gain with no context tie, so it reads as an intelligence result. Fix: append "on more sources than fit one window" (body goes 32 → 39 words). *(criterion 5)*

15. **Slide 12.** Title "An agent is a markdown file" reads as defining an agent (Ricky's non-goal). Fix: retitle "A subagent is a markdown file". *(criterion 1)*

16. **Slide 20.** "headless" in body text is undefined jargon; notes use "non-interactive". Fix: replace "headless" with "scripted". *(criterion 4)*

17. **Slide 9.** Three quotations and three tags in 37 words on top of a diagram; densest slide in the deck. Fix: move the Osmani quote to notes only. *(criterion 4)*

18. **Slide 8 (`writer-critic.mmd`).** The slide's message is "critic with tools in hand" but the diagram shows the critic touching nothing but the draft. Fix: diagrammer adds a "tests / data" node the critic reads (5 nodes, under cap). *(criterion 5)*

19. **Slide 9 (`parallel-workers.mmd`).** Learning objective 4 is "merge with a verification step"; the Merge node has no check. Fix: relabel the node "Merge + verify". *(criterion 5)*

20. **Slide 15.** Learning objective 2 names a budget cap; the caption never names the flag. Fix: if visible in the screenshot, add "`--max-budget-usd` caps each call" to the caption (17 → 22 words). *(criterion 6)*
