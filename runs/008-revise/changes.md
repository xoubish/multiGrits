# Run 008 — revise from critique 007

Input: `runs/007-critique/critique.md` (verdict REVISE, criterion 3 at 6). Output: `slides/deck.md` edited in place. Slide count unchanged at 25 (21 content + 4 sources); no slide body exceeds 40 words; all diagram tokens untouched; every new number in body or notes carries a tag that resolves on the Sources slides (new tag: `[run 005]`).

## Must-fix

1. **Slide 17 (researcher model claim)** — CHANGED. Notes now say the researcher agent file pins Sonnet, run 001 actually ran on the parent model because that session had not picked up the pinned agent (matches `runs/001-research-fanout/README.md`), and a fresh session picks up the pin.
2. **Slide 14 ("read-only" critic)** — CHANGED. Notes now list the critic's four tools (Read, Glob, Grep, Write) and say it reads everything, writes only its own `critique.md`, and never edits the deck. Verified against `.claude/agents/critic.md`.
3. **Slide 8 (uncited body claim)** — CHANGED. Replaced "A critic that only reads the writer's text tends to agree with it" with advice: "Give the critic tools so it can check, not just read: tests, schemas, data." The gwBench and Stargazer evidence stays in the notes with its tags. Body is now 24 words.
4. **Slide 19 (notes overrun, uncited `--bare`)** — CHANGED. Cut the `--bare` sentence and the `Date.now()`/`Math.random()` parenthetical. Notes drop from ~175 to ~140 words for the 55 s slot.
5. **Slide 6 / `diagrams/fan-out.mmd` (summaries bypass the orchestrator)** — DECLINED, out of scope. I never write to `diagrams/`; that file belongs to the diagrammer. Flagged for a diagrammer run: route the four `summary` edges back to `O` and add `O -->|"merge"| M`, or relabel `M` "Orchestrator merge". On the slide side I made the body text explicit ("the orchestrator merges the summaries in one place") so the spoken and written claim is correct regardless of the diagram.

## Nice-to-have

6. **Slides 23 / 20 (MAST version)** — CHANGED, with a substitution. `research/brief.md` records no arXiv version number for MAST, so I could not honestly pin "v3". Slide 23 now reads "arXiv version retrieved 2026-09-15" and both slide 20 and slide 23 notes tell the fact-checker to pin the version number.
7. **Slide 10 (notes overrun)** — CHANGED. Dropped the 17.2x / 4.4x sentence; it is delivered on slide 18.
8. **Slide 20 (notes overrun)** — CHANGED. Cut the "biggest individual modes were…" sentence.
9. **Slide 12 (1,670-word claim)** — CHANGED. Notes now say all four researchers ran over the 600–1,200 limit, from about 1,260 to 2,500 words, and only B said why. Matches the README table.
10. **Slide 14 (dry-run margin, `--budget 5`)** — CHANGED. Slide 11 body command and notes now read `pipeline/run.sh critique --budget 5`; slide 14 notes carry the dry-run numbers (319 s, $2.37 against the $3 default) with a new `[run 005]` tag, resolved on Sources 4 of 4 to `runs/005-critique/result.json` and the `runs/cost.tsv` row. Verified `--budget` exists in `pipeline/run.sh`.
11. **Slide 14 / `slides/outline.md` (launch time mismatch)** — DECLINED, out of scope. `slides/outline.md` is the outliner's file. The deck is internally consistent (launch at 0:00 on slide 11, read at 6:00 on slide 14); the outline should be updated by its owner to "launched at 0:00, read at 6:00".
12. **Slide 9 (define worktree)** — CHANGED. Notes add "a second checkout of the same repo in its own directory".
13. **Slide 15 ("cache-creation tokens")** — CHANGED. Now "about 4,400 tokens, cached after the first call".
14. **Slide 6 (two benchmarks in body)** — CHANGED. Moved the Xu 2026 line out of the body; it remains in the notes with its tag. Body drops from 39 to 30 words and holds one idea.
15. **Slide 21 (hand-off over-expanded)** — CHANGED. Notes now say: restate thesis, open the floor, and after the last question speak only the slide's one line, then name BJ.
16. **Slide 1 (thesis late)** — CHANGED. Added subtitle "Context, not intelligence" and told the speaker to read it.
17. **Slide 7 / `diagrams/pipeline.mmd` ("Merged result")** — DECLINED, out of scope. Diagram file; flagged for the diagrammer to rename the terminal node to "Result".

## For the next critic pass

- Two must-fix items (5) and one nice-to-have (17) need a diagrammer run before they can close.
- Outline drift (11) needs the outliner.
