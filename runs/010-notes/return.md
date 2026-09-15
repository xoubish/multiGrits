I've written all three files:

- **`slides/speaker-script.md`** — running clock, spoken text, and transitions for all 21 slides (deck.md unchanged), with the two marked cut points (slide 20, slide 5).
- **`handout/handout.md`** — one page: four patterns, the eight agent files in `.claude/agents/` and what each does, the two pipeline commands, where logs/cost report live (flagging that `runs/cost-report.md` is stale past run 003 and `runs/cost.tsv` has an unresolved git merge-conflict marker in it), and five links.
- **`runs/010-notes/timing.md`** — word count, method, and a logged spec discrepancy (see below).

**Timing line:** Total scripted spoken words ≈2,962; at 140 wpm that's ≈21:09 of speaking time — fits inside 25 minutes as asked (≈3:50 to spare) and inside the 30-minute slot `talk-context.md` actually binds (27 min content + 3 min Q&A), with margin in every segment.

One thing worth flagging rather than quietly stepping around: this stage's own prompt (`pipeline/prompts/notes.md`) asks whether the script fits **25 minutes**, but `talk-context.md` — binding by its own rule — sets this talk at 27 minutes of content + 3 minutes Q&A = 30 minutes, and `slides/outline.md`/`slides/deck.md` both sum to exactly that. This looks like the same stale-number bug `runs/002-outline` already found and fixed once (an old draft said "25 + 5"); the notes prompt template just never got updated after that correction. It doesn't change the verdict here (21:09 fits under any of 25, 27, or 30), so I logged it in `timing.md` instead of editing the prompt file, which isn't this stage's output.
