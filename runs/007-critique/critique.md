Verdict: REVISE

# Critique — run 007 (deck `slides/deck.md`, outline `slides/outline.md`, 5 diagrams)

Reviewed against `talk-context.md`. 25 slides (21 content + 4 sources), at the limit. Segment sums match the binding table exactly (180 / 420 / 720 / 300 / 180 s). All repo-internal numbers were checked against the cited files and are correct ($0.019, 9 tokens, ~4,400 tokens; 270 tool calls, ~602k tokens, 10.9 vs ~38 min, ~7,100 / ~800 words; worktree names, merge-commit message, exit code 2). All 24 citation tags resolve to a URL or repo path on slides 22–25. The demo fallback file `runs/005-critique/critique.md` exists.

## Scores

| # | Criterion | Score |
|---|---|---|
| 1 | Overlap with neighbor talks | 9 |
| 2 | Time budget realism | 7 |
| 3 | Citations | **6** |
| 4 | Plain language | 8 |
| 5 | Thesis clarity | 9 |
| 6 | Demo segment | 9 |
| 7 | Hand-off to sandboxing talk | 8 |

REVISE because criterion 3 is below 7: one uncited claim in body text, and two spoken claims that the repo's own files (shown on screen during the demo) contradict.

## Findings

### Must-fix

1. **Slide 17** — Notes say "it is how this repo runs: the researcher agent pins a smaller model while the orchestrator runs the larger one," but `runs/001-research-fanout/README.md` (on screen at slide 12) states the researchers ran on the parent model because the pinned agent was not discovered. Fix: say "the agent file pins Sonnet; the logged run 001 actually ran on the parent model, see the README note; the fresh session in today's demo picks up the pin."
2. **Slide 14** — Notes call the critic "a read-only agent," but `.claude/agents/critic.md` lists `tools: Read, Glob, Grep, Write`, which the audience will see on screen. Fix: say "it reads everything and writes only its own `critique.md`; it never edits the deck."
3. **Slide 8** — Body claim "A critic that only reads the writer's text tends to agree with it" carries no citation. Fix: rephrase as advice ("Give the critic tools so it can check, not just read") or attach [gwBench 2026] / [Stargazer 2026] to it in the body.
4. **Slide 19** — Notes run ~175 spoken words in a 55 s slot (~190 wpm), the largest overrun in the deck. Fix: cut the `--bare` sentence and the `Date.now()`/`Math.random()` parenthetical (~35 words), which also removes the uncited `--bare` claim.
5. **Slide 6 / `diagrams/fan-out.mmd`** — Researcher summaries flow straight to "Merged brief," bypassing the orchestrator, which contradicts the slide text "the orchestrator merges" and slide 18's centralize-the-merge point. Fix: route the four `summary` edges back to `O` and add `O -->|"merge"| M`, or relabel `M` as "Orchestrator merge" (still ≤8 nodes).

### Nice-to-have

6. **Slide 23 / 20** — MAST shares (44.2 / 32.3 / 23.5) are cited to "latest arXiv version," which is not a stable reference. Fix: pin "arXiv v3" (or whichever version) on slide 23 and in slide 20 notes.
7. **Slide 10** — ~110 spoken words in 40 s (~165 wpm). Fix: drop the 17.2x / 4.4x sentence; it is delivered on slide 18.
8. **Slide 20** — ~110 spoken words in 40 s (~165 wpm). Fix: cut the "biggest individual modes were…" sentence.
9. **Slide 12** — Notes say "one researcher wrote 1,670 and explained why," but the README table shows A ~1,800, B ~2,500, D ~2,200 words, so three of four exceeded the 1,200-word limit. Fix: say "all four ran over the 600–1,200 limit; only B said why."
10. **Slide 14** — Dry run 005 took 319 s and cost $2.37 against the $3 default `--budget`, leaving ~40 s to the 6:00 mark and $0.63 to a forced exit-2 fallback. Fix: add those two numbers to the notes and launch the live call with `--budget 5`.
11. **Slide 14 (and outline slide 14)** — Deck starts the live call at 0:00 on slide 11; the outline still says 6:00. Fix: update `slides/outline.md` slide 14 to "launched at 0:00, read at 6:00."
12. **Slide 9** — "worktree" is never defined for an audience that used Claude Code once. Fix: add one clause to notes: "a second checkout of the same repo in its own directory."
13. **Slide 15** — Notes use "cache-creation tokens." Fix: say "system-prompt tokens, cached after the first call."
14. **Slide 6** — Body holds two benchmarks (Anthropic 2025b, Xu 2026) at 39 words plus a diagram, against one idea per slide. Fix: move the Xu 2026 line to the notes.
15. **Slide 21** — Notes expand the one-line hand-off into three sentences and deliver it before Q&A rather than as the closing words. Fix: speak only the slide's single line, after the last question, then name BJ.
16. **Slide 1** — Thesis first appears on slide 3 (~40 s in). Fix: add subtitle "Context, not intelligence."
17. **Slide 7 / `diagrams/pipeline.mmd`** — Terminal node "Merged result" though nothing is merged in a pipeline. Fix: rename to "Result."

## Criterion notes

- **Overlap (9):** Every non-goal checked by name. No agent definition (Ricky), no Claude Code/Codex/OpenCode intro (Jessica, Ricky), no pricing table and an explicit pointer to Nick on slide 17 and in slide 21 Q&A, no local-LLM setup (Nick) or IDE integration (Keto), sandboxing limited to one line plus BJ's name (slide 21). Permission mentions on slides 9, 13, 14 are one clause each.
- **Time (7):** Body text ≤40 words on every slide (slides 6 and 19 at 39). Spoken notes exceed ~150 wpm on slides 10, 19, 20; all three are on the cut list, but slide 19 is fifth to cut.
- **Citations (6):** See findings 1–3, 6. Everything else resolves and the repo-internal figures match their sources.
- **Plain language (8):** No hype terms. Jargon: worktree, cache-creation tokens, frontier model (acceptable for this audience).
- **Thesis (9):** Stated in slide 3's title; called back explicitly on slides 4, 10, 12, 16, 21.
- **Demo (9):** Minute marks 0:00–1:00, 1:00–4:00, 4:00–6:00, 6:00–10:00, 10:00–12:00; whole-segment fallback (slide 11, tab 3) plus live-call fallback with a 9:00 hard cutoff (slide 14); fallback artifact exists; dry-run timing supports the plan with thin margin (finding 10).
- **Hand-off (8):** Present on slide 21, one line on the slide; notes over-expand it (finding 15).
