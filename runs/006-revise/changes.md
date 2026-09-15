# Run 006 — revise from `runs/005-critique/critique.md`

Deck is now 25 slides (21 presented + 4 sources), the ceiling. No body over 40 words (slide 6 and slide 19 at 39, Sources 2 at 39).

## Must-fix

1. Slide 14 (timing): CHANGED. Critic now launches at demo 0:00 on slide 11 in tab 2; slides 12–13 run while it works; slide 14 returns to it at 6:00; hard cutoff at 9:00 in the notes.
2. Slide 14 (fallback): CHANGED. Fallback names `runs/005-critique/critique.md`, pre-opened in tab 3.
3. Slide 9 notes: CHANGED. Cut the Codex/OpenCode/Gemini sentence; `research/brief.md` lists Codex worktree support and Gemini parallelism as unverified.
4. Slide 8: CHANGED. Body is "give the critic tools" plus the 23.5% line; gwBench, Stargazer, Jamshidi moved to notes with their tags. Sources still list them.
5. Slide 19: CHANGED. Body says "forbid clock and random calls"; `Date.now()`/`Math.random()` kept in notes.
6. `diagrams/fan-out.mmd`: DECLINED (out of scope: writer never writes to `diagrams/`). Slide 6 body now says "the orchestrator merges". Diagrammer to-do: route the four `summary` edges to `O`, add `O -->|"merge"| M`.

## Nice-to-have

7. Slide 2: CHANGED. Notes cut to ~45 words, 20 s.
8. Slide 4: CHANGED. Dropped FRAMES/MuSiQue and the Pareto sentence.
9. Slide 3: CHANGED. "no-documents score", "a long-context test"; RULER named in notes.
10. Slide 6: CHANGED. "A lead agent plus subagents"; "a general-assistant benchmark"; GAIA named in notes. 39 words.
11. Slide 21: CHANGED. Thesis line added above the hand-off.
12. Slide 10 notes: CHANGED. Added the tie-back to slide 3.
13. Slide 14 notes: CHANGED. "0 to 10", matches `.claude/agents/critic.md`.
14. Slide 14 notes: CHANGED. Exit code 2 now cites `[pipeline/run.sh]`, which logs the budget-cap warning on that code.
15. Slide 21 notes / Sources 4: CHANGED. Added `[Claude Code agent teams]` with the agent-teams URL and the costs page for the 7x figure.
16. Sources 2: CHANGED. Cemri line reads "MAST, latest arXiv version"; notes flag that earlier versions report different shares and ask the fact-checker to pin the version.
17. Sources: PARTLY. Exact titles for the five 2026 preprints are not in `research/brief.md`, so I added author names and short descriptors instead of guessing titles; Kapoor and Liu got their known titles. Split Sources into four slides to stay under 40 words each.
18. Slide 17 notes: CHANGED. Removed Haiku, Sonnet, Explore.
19. Slide 17 notes: CHANGED. "a vendor promoting multi-agent has no reason to overstate its cost."
20. Slide 15: CHANGED. `run.sh critique` appends to `runs/cost.tsv` via `log_result.py` but only `run.sh cost` rebuilds the report; body and notes now say to run `pipeline/run.sh cost` first.
21. Slide 13: CHANGED to match `stage_write` exactly (`.worktrees/slides`, `.worktrees/diagrams`, `wt/slides`, `wt/diagrams`). The outline is the one that disagrees; not my file, flagged for the outliner.
22. `diagrams/pipeline.mmd`: DECLINED (out of scope). Diagrammer to-do: rename "Merged result" to "Tested result".
23. Diagram tokens: NO DECK CHANGE. `pipeline/inline_diagrams.py` (run by `pipeline/render.sh`) inlines the `.mmd` files and appends a Mermaid loader. Note: the loader pulls Mermaid from a CDN, so the built deck needs network at talk time; worth a pre-render or a local copy before the day.
24. Slide 1: CHANGED. 20 s, taken from slide 2.
