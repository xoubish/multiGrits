# Timing check — speaker script (run 014)

## Method

Counted every word in the authored **Say** and **Transition** lines of `slides/speaker-script.md`
for slides 1–25 (the segments `talk-context.md` binds to 27 minutes / 1,620 s of content), plus only
the two scripted lines on slide 26 (the thesis-and-first-step line before the floor opens, and the
one-line hand-off after the last question). Slide 26's remaining ≈142 s of its 180 s budget is
deliberately open floor — content depends on what's asked — so it is not counted as authored words,
matching the deck's own note that the slide is "180 s, mostly open floor." No `wc -w` was available
in this environment; counting was a manual tally in chunks of ~10 words, accurate to within roughly
3%.

## Numbers

- **Scripted content, slides 1–25 (27-minute / 1,620 s content budget): ≈3,069 words**
- **Scripted lines on slide 26 (Q&A open/close only): ≈89 words**
- **Total scripted spoken words: ≈3,158**
- **Implied speaking time at 140 wpm: 3,158 / 140 ≈ 22.6 min ≈ 22:33**

By segment (words used / word ceiling at 140 wpm for that segment's seconds):

| Segment | Seconds | Ceiling (words) | Scripted (words) | Used |
|---|---|---|---|---|
| 1. Why, and when not to (slides 1–4) | 180 | 420 | 411 | 98% |
| 2. Four patterns (slides 5–10) | 420 | 980 | 862 | 88% |
| 3. Recorded demo (slides 11–20) | 720 | 1,680 | 1,262 | 75% (screen/read time, not talk time) |
| 4. Gotchas and cost (slides 21–25) | 300 | 700 | 660 | 94% |
| 5. Q&A scripted lines only (slide 26) | 180 | 420 | 89 | 21% (rest is open floor by design) |
| **Content total (1–4, slides 1–25)** | **1,620** | **3,780** | **3,069** | **81%** |
| **Grand total (1–5, scripted only)** | **1,800** | **4,200** | **3,158** | **75%** |

## Does it fit the binding 27-minute content budget (1,620 s)?

**Yes.** Slides 1–25 total ≈3,069 scripted words ≈ 21.9 minutes (≈21:55) of speech, against the
1,620 s (27-minute) content budget in `talk-context.md` — about 5 minutes of margin, concentrated in
the recorded-demo segment (slides 11–20), which is screen-time-heavy by design (terminal output
populating, a screenshot being read) rather than continuous talking.

Adding the two scripted Q&A lines (slide 26, ≈89 words ≈ 38 s) against its separate 180 s (3-minute)
budget leaves ≈142 s of that slot open for actual questions, exactly as `talk-context.md` specifies
("Q&A and hand-off to BJ — 3"). Grand total scripted speech across the full 30-minute slot: ≈3,158
words ≈ 22:33, comfortably inside 30:00.

No spec conflict found this run: `talk-context.md`'s 27-minute content / 3-minute Q&A split
(1,620 s + 180 s = 1,800 s) is used directly, matching both `slides/outline.md`'s segment table and
the per-slide seconds already in `slides/deck.md`'s own speaker-note comments — all three agree.

## The two cut points marked in the script

Full detail is in `slides/speaker-script.md`; `slides/outline.md` lists four more ranked options if
further cuts are ever needed beyond these two.

1. **Slide 25** ("How it actually fails") — cut the whole slide (~40 s / ~74 words); say one clause
   instead while moving to Q&A.
2. **Slide 5** ("Four patterns, one shape each") — skip it (~20 s / ~39 words); fold its one line
   into slide 4's transition.

## Timing line (for return)

Total scripted spoken words ≈3,158; at 140 wpm that is ≈22:33 of speaking time. Slides 1–25 alone
(≈3,069 words ≈21:55) fit inside the binding 27-minute / 1,620 s content budget in `talk-context.md`
with about 5 minutes to spare; the two scripted Q&A lines (≈89 words ≈38 s) fit inside the separate
3-minute Q&A-and-hand-off slot, leaving ≈142 s open for questions. No stale or conflicting time
figure was found in the source files this run.
