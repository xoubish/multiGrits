# Timing check — speaker script

## Method

Counted every word in the authored **Say** and **Transition** lines of `slides/speaker-script.md`
for slides 1–20, plus the two scripted lines on slide 21 (the thesis recap before the floor opens,
and the one-line hand-off after the last question). The open-floor portion of Q&A (~168 of slide
21's 180 s) is deliberately unscripted — content depends on what's asked — so it is not counted as
authored words; this matches the deck's own note that slide 21 is "180 s, mostly open floor." No
`wc -w` was available in this environment, so the count is a manual tally by chunks of ~10 words;
treat it as accurate to within roughly 3%.

## Numbers

- **Scripted content, slides 1–20 (the 27-minute / 1,620 s content segments): ≈2,933 words**
- **Scripted lines on slide 21 (Q&A open/close only): ≈29 words**
- **Total scripted spoken words: ≈2,962**
- **Implied speaking time at 140 wpm: 2,962 / 140 ≈ 21.2 min ≈ 21:09**

By segment (words used / word ceiling at 140 wpm for that segment's seconds):
| Segment | Seconds | Ceiling (words) | Scripted (words) | Used |
|---|---|---|---|---|
| 1. Why, and when not to | 180 | 420 | 410 | 98% |
| 2. Four patterns | 420 | 980 | 861 | 88% |
| 3. Live demo | 720 | 1,680 | 995 | 59% (intentional — screen/wait time, not talk time) |
| 4. Gotchas and cost | 300 | 700 | 667 | 95% |
| 5. Q&A scripted lines only | 180 | 420 | 29 | 2% (rest is open floor by design) |
| **Content total (1–4)** | **1,620** | **3,780** | **2,933** | **78%** |
| **Grand total (1–5, scripted only)** | **1,800** | **4,200** | **2,962** | **71%** |

## Does it fit 25 minutes? (the literal question asked)

**Yes.** 21:09 of scripted speech fits inside 25:00, with about 3:50 to spare.

## Flag: "25 minutes" conflicts with the binding spec — logging it, not silently answering it

`pipeline/prompts/notes.md` (the template behind this stage's instructions) asks whether the script
fits **25 minutes**. `talk-context.md` — the file every agent is told wins on conflict — states the
segment table is **binding**: 27 minutes of content (1,620 s) plus 3 minutes of Q&A and hand-off
(180 s), 30 minutes total, matching the GRITS schedule slot (11:15–11:45). `slides/outline.md` and
`slides/deck.md` both sum to exactly that: 1,620 s of content across slides 1–20, 180 s for slide
21.

This is the same class of inconsistency `runs/002-outline` found and logged: an earlier draft of
`talk-context.md` said "25 minutes of content and 5 minutes of Q&A" before it was corrected to the
27+3 table that is now binding (see `runs/002-outline/README.md` and `runs/002-outline/notes.md`).
`pipeline/prompts/notes.md` appears not to have been updated after that fix and still carries the
stale 25-minute figure. Per the same house rule that run applied — don't silently resolve a spec
contradiction, log it — this is logged here rather than only answering the 25-minute question and
moving on. The fix belongs in `pipeline/prompts/notes.md`, which is not this stage's output path,
so it is not edited here.

Checked against the actual binding budget instead of the stale one:
- Slides 1–20 against the 27:00 content budget: ≈20.9 minutes of scripted speech, leaving ≈6:05 of
  the budget deliberately unfilled by scripted words — almost all of it in the 12-minute live-demo
  segment (slides 11–15), where much of the allotted time is the terminal populating, the critic
  call running, and the audience reading a screen, not continuous talking (see the "used" column
  above: 59% for segment 3 versus 88–98% for the others).
- Slide 21 against its 3:00 budget: 2 scripted lines (≈12 s), the remaining ≈168 s open floor by
  design.
- Grand total against the full 30:00 slot: ≈21:09 of scripted speech. **Fits with margin against
  25, 27, or 30 minutes** — the spec discrepancy doesn't change the verdict, only which number of
  minutes of margin gets quoted.

## Two cut points marked in the script

Full detail is in `slides/speaker-script.md`; `slides/outline.md` has four more ranked options if
further cuts are needed.
1. **Slide 20** ("How it actually fails") — cut the whole slide.
2. **Slide 5** ("Four patterns, one shape each") — skip it; fold its one line into slide 4's
   transition.

## Timing line (for return)

Total scripted spoken words ≈2,962; at 140 wpm that is ≈21:09 of speaking time. That fits inside
25 minutes as literally asked (≈3:50 to spare) and inside the 30-minute slot that `talk-context.md`
actually binds (27 min content + 3 min Q&A) with margin in every segment; the "25 minutes" in this
stage's own prompt is a stale figure from before `talk-context.md`'s 27+3 table was fixed in
`runs/002`/`003`, logged here rather than silently used.
