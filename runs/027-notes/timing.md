# Timing — derived from `slides/deck.md` word counts, per `slides/speaker-script.md`

Method: counted each presented slide's spoken prose (paragraphs and citation captions; excludes
headings, code blocks, and image tags, which are pointed at, not read aloud) in `slides/deck.md`,
in outline order, across all 27 outline entries (title through close). The two "Sources" slides are
marked "not presented" in the deck and carry no spoken time, so they are excluded.

- **Total spoken words: 3,002**
- **Implied time at 140 words per minute: 3,002 ÷ 140 = 21.44 min = 21:26**
- **Content budget in `slides/outline.md`: 1,620 s = 27:00** (plus 180 s / 3:00 of Q&A, 30:00 total)

## Does it fit?

Yes, with margin: 21:26 of implied reading time against a 27:00 content budget leaves about 5:34 of
slack. That slack is not evenly spread — per-segment breakdown:

| Segment | Words | Implied | Budget | Slack |
|---|---|---|---|---|
| A. One collaborator, then more | 416 | 2:58 | 4:00 | +1:02 |
| B. Architectures | 634 | 4:32 | 6:30 | +1:58 |
| C. Example: this talk was made by agents | 1,115 | 7:58 | 8:00 | +0:02 |
| D. Where it helps and where it does not | 403 | 2:53 | 3:30 | +0:37 |
| E. Setting it up: simple and difficult | 434 | 3:06 | 5:00 | +1:54 |

Segment C (the meta-example) has almost no slack — its word count matches its 8-minute budget to
within two seconds, because it is mostly dense, specific run-by-run reporting. Segments B and E
carry the most slack, by design: B's pattern slides (fan-out, pipeline, writer-critic) each pair a
short paragraph with a diagram meant to be pointed at, and E's live-demo slide (24d–e) is budgeted
for running the command, not just describing it.

Within segments, several individual slides read over their own per-slide sub-budget even though
their segment as a whole fits — these are exactly the citation-heavy slides (5b/5c on lost-in-the-
middle and RULER, 10b on worktrees, all of 11a–c on agent counts, all of 14a–d on attempt one's
failures, all of 19a–e on the run-by-run log, all of 22a–c on the evidence-for-and-against, and 26a–
b on cost) — because reading a full author-year-arXiv-finding citation aloud takes longer than the
outline's compressed per-slide seconds assume. This is not a coincidence: three of the outline's
four listed cuts (entries 19, 22, and 11) are exactly the three slide groups with the worst
implied-time-to-budget ratio, which is why they were chosen as the cuts in the first place.

**Line for the record: 3,002 spoken words, 21:26 at 140 wpm, against a 27:00 content budget — fits, with about 5:30 of margin, concentrated in the pattern and demo slides rather than the meta-example segment.**
