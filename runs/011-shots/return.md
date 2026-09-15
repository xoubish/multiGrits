## Summary

I read `talk-context.md`, `slides/deck.md`, `slides/speaker-script.md`, `slides/shots/manifest.json`, `pipeline/captures.json`, all nine `.claude/agents/*.md` files, and the relevant `runs/*` logs to ground every fact used.

**The five recorded-demo slides** (replacing the old live-demo segment, same positions 11–15, same 720 s total):

| Slide | Title | Time |
|---|---|---|
| 11 | Recorded from this repo · the layout, and an agent as a file | 100 s |
| 12 | Already run · the research fan-out | 150 s |
| 13 | Already run · parallel worktrees, and the merge conflict | 160 s |
| 14 | Already run · the critic's verdict, and the writer's response | 170 s |
| 15 | Already run · fact-check, and what it cost | 140 s |

Each uses two existing screenshots side by side (`![w:560]`), one honest caption (≤20 words), and speaker notes carrying the narration + time budget. Slide 11 shows `repo-tree.png` (required) plus `agent-file.png`, and states plainly that everything is a script-captured screenshot, not a live run. No terminal tabs, launches, waits, or fallbacks remain. All screenshots already existed — nothing was added to `pipeline/captures.json`.

I added the required unpresented **appendix** after Sources (4 of 4): a divider slide, then one slide per `.claude/agents/*.md` file in pipeline order, each with its screenshot, name, one-line role, and a model/tools note.

I rewrote **Segment 3** of `slides/speaker-script.md` to match (same clock 10:00–22:00, ceilings recomputed at 140 wpm from the new budgets), and fixed three stray live-demo references discovered elsewhere: one in `slides/deck.md` (Pattern 3 slide) and its mirror in the speaker script, plus one "like today's demo" phrase in the Gotcha·Cost slide (deck.md) and its mirror in the speaker script. All details, screenshots used, and every non-demo line touched are recorded in `runs/011-shots/changes.md`.
