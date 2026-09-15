Verdict: REVISE

# Critique — run 005 — `slides/deck.md` (24 slides: 21 presented + 3 sources) and `diagrams/*.mmd`

## Scores (0–10; REVISE if any < 7)

| # | Criterion | Score |
|---|---|---|
| 1 | Overlap with neighbor talks | 9 |
| 2 | Time budget realism | 7 |
| 3 | Citations | 8 |
| 4 | Plain language | 7 |
| 5 | Thesis clarity | 8 |
| 6 | Demo segment | **6** |
| 7 | Hand-off to sandboxing talk | 9 |

Trigger for REVISE: criterion 6. The one live moment of the 12-minute demo is scheduled in a way that will likely not finish inside its window, and its fallback names no file.

## What is right (no action)

- Every non-goal checked by name: no agent definition (slide 1 notes say so), no Claude Code/Codex/OpenCode intro, no pricing table (slide 17 points to Nick), no local-LLM setup, no IDE, sandboxing kept to one hand-off line (slide 21).
- Segment times sum to 180 + 420 + 720 + 300 + 180 = 1800 s, matching the binding table.
- Every number in slide body text carries a source tag and every tag resolves to a URL or repo path on slides 22–24. No body text exceeds 40 words (slide 19 is at 39).
- Thesis is the title of slide 3, ~40 s in, and is called back on slides 4, 7, 12, 16.
- All five diagrams are ≤ 8 nodes; writer-critic.mmd correctly puts the script, not an agent, in charge of the loop.

## Findings

### Must-fix

1. **Slide 14** — The live critic call is budgeted "one to three minutes" inside a 240 s window that must also hold the critic explanation and reading findings aloud; a critic that reads nine files and writes a scored report (this run) routinely takes longer than that, so the audience may never see the result. Fix: launch `pipeline/run.sh critique` in the background at demo 0:00 on slide 11, walk slides 12–13 while it runs, return at 6:00 to the finished `critique.md`, and state a hard cutoff in the notes ("no critique.md by 9:00 → fallback").
2. **Slide 14** — The fallback says "open the critique.md from an earlier dry run in runs/" without naming a file, unlike slide 11's fallback which names `runs/000-…` and `runs/001-…`. Fix: name it (`runs/005-critique/critique.md`) and have it already open in the second terminal tab.
3. **Slide 9 (notes)** — "Of the CLIs the researchers surveyed, only Claude Code documents this; Codex, OpenCode, and Gemini do not" is an uncited negative claim about competitors that can go stale by the talk date, and it drifts into Ricky's Day 1 tool-comparison territory. Fix: cut the sentence, or cite `research/brief.md` with the check date and list it under an "Unverified" heading on Sources 3.
4. **Slide 8** — Body text stacks four separate claims from four sources (Cemri, gwBench, Stargazer, Jamshidi), breaking the one-idea-per-slide rule and requiring two read-aloud quotes in 90 s. Fix: keep "Give the critic tools" plus the 23.5% line on the slide; move the gwBench, Stargazer, and Jamshidi sentences to the notes.
5. **Slide 19** — "`Date.now()` and `Math.random()` throw" is JavaScript-runtime jargon for an audience of astronomers and archive engineers. Fix: replace with "Claude Code workflows forbid clock and random calls, so a relaunch repeats the same steps [Claude Code workflows]" and keep the function names in the notes.
6. **Slide 6 / `diagrams/fan-out.mmd`** — Researcher summaries flow directly into "Merged brief," bypassing the Orchestrator, which contradicts the slide's point (and slide 18's 17.2x vs 4.4x argument) that one central agent does the merge. Fix: route the four `summary` edges back to `O` and add `O -->|"merge"| M` (still 6 nodes).

### Nice-to-have

7. **Slide 2** — 76 words of notes plus an 8-node diagram walk in 30 s is 2.5 words/s with no slack. Fix: cut "The outline, the slide text, the diagrams, every citation" and the "Point at the diagram left to right…" list; point silently.
8. **Slide 4** — 134 words of notes in 60 s leaves no slack. Fix: drop the "FRAMES and MuSiQue" clause and the Pareto sentence; keep the two numbers and the closing line.
9. **Slide 3** — "closed-book" and "RULER" are unexplained ML terms in body text. Fix: "below its no-documents score" and "effective 64K on a long-context test [Hsieh 2024]".
10. **Slide 6** — "GAIA" and "Lead-plus-subagents" are unexplained. Fix: "a lead agent plus subagents" and "on a general-assistant benchmark (GAIA)".
11. **Slide 21** — Thesis is not restated before the hand-off. Fix: add one line above the hand-off: "Go multi-agent for context, not intelligence; most tasks need one agent."
12. **Slide 10** — "Task shape decides" is not tied back to the thesis. Fix: add to notes: "Decomposable means each piece fits its own window; that is the context argument again."
13. **Slide 14 (notes)** — Says the critic scores "from 1 to 10"; the rubric is 0 to 10. Fix: change to "0 to 10".
14. **Slide 14 (notes)** — "exit code 2" for the budget cap is uncited. Fix: cite the Claude Code CLI reference page or drop the number.
15. **Slide 21 (notes)** — The agent-teams answer ("experimental, off by default, ~7x tokens in plan mode") has no source. Fix: add `[Claude Code agent teams] https://code.claude.com/docs/en/agent-teams` to Sources 3.
16. **Slides 8, 20 / Sources 2** — MAST category percentages changed between arXiv versions (v1 reported ~37/31/31 on ~150 traces; the deck's 44.2/32.3/23.5 and "1,600+ traces" are from a later version). Fix: pin the version on the Cemri line ("arXiv v3 / NeurIPS 2025 camera-ready") as already done for Kim.
17. **Sources 1–2** — Five 2026 arXiv preprints (2604.02460, 2608.05791, 2605.11269, 2604.15664, 2606.07937) are listed by number only; a wrong digit is unrecoverable for the audience. Fix: add paper titles to each line (the notes already have most).
18. **Slide 17 (notes)** — Naming Haiku, Sonnet, and the Explore agent edges into Nick's model-selection talk. Fix: keep "cheaper or local model on subagents, frontier on the orchestrator" and cut the model names.
19. **Slide 17 (notes)** — "a vendor with an interest in selling tokens, so if anything they are not inflated" is muddled. Fix: "a vendor promoting multi-agent has no reason to overstate its cost."
20. **Slide 15** — The cost report must include the live critique run that just finished, but the notes never say to regenerate it. Fix: add "run `pipeline/cost_report.py` first" to the notes, or confirm `run.sh critique` appends and rebuilds.
21. **Slide 13** — Worktree names differ from the outline (`slide-writer`/`diagrammer` in outline; `slides`/`diagrams`, `wt/slides` in deck). Fix: match whatever `stage_write` actually uses and update the outline or deck to agree.
22. **Slide 7 / `diagrams/pipeline.mmd`** — Final node "Merged result" implies a merge in a pattern with nothing to merge. Fix: rename to "Tested result".
23. **Slides 2, 6–9** — `{{diagram:…}}` is not Marp syntax and Marp does not render Mermaid without a plugin. Fix: confirm the build step inlines pre-rendered SVGs before the talk; otherwise five slides show placeholder text.
24. **Slide 1** — "Say who you are and one sentence" in 10 s is 30 words at 3 words/s. Fix: budget 20 s and take it from slide 2's trim (finding 7).
