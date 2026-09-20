# Speaker script — clock and transitions, not a second deck
> **Stale as of 2026-09-19.** Written by `notes-writer` against the 58-slide draft of 2026-09-18. Its
> headline total (3,140 spoken words, 22:26 at 140 wpm) is for that deck. The current 30-slide deck
> carries about 1,944 spoken words, roughly 18 minutes including spoken asides, against the same
> 1,620 s content budget. The per-slide rows below no longer match the slide numbers. Regenerate with
> `pipeline/run.sh notes` once the deck is final.

The speaker reads the slides. This page is a clock and a transition guide: when each slide should
start if the talk is on pace, how many spoken words are on it, what that implies at 140 words per
minute, the line that carries into the next slide, and any aside from the notes that is not on the
slide itself. Rewrite the transitions in your own voice before the talk — the wording here is a
placeholder. Keep the numbers.

**Word count convention.** Counted: body prose and the `<p class="cite">` citation paragraph (the
citations are written to be read aloud in full). Not counted: headings, code blocks, image and
diagram tags, div wrappers, and the HTML-comment notes. "Budget" is the seconds this slide was
assigned in `slides/outline.md` / `slides/deck.md`'s notes (split across sub-slides where one
outline entry became more than one slide). "Impl." is that slide's word count × 60 ÷ 140, rounded
to the nearest second.

**Total: 3,140 spoken words → 22:26 at 140 wpm, against a 27:00 (1,620 s) content budget.** That is
about 4:34 of slack. The clock column below is the cumulative sum of the outline's budgeted
seconds, not of the implied-reading seconds — it tells you where you should be if you are keeping
to the plan, not where the words alone would put you. Q&A opens at 27:00 and runs 3:00 to 30:00.

## Segment A — One collaborator, then more (budget 240 s / 4:00)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 0:00 | 1. Title | 15 s | 9 | 4 s | Say your name and the title over the illustration; do not rush off it. → "One collaborator first." |
| 0:15 | 2. One collaborator | 45 s | 42 | 18 s | One-line framing only — do not re-teach agents or Claude Code. → "The temptation to add more is obvious." |
| 1:00 | 3. Why not more than one? | 60 s | 45 | 19 s | Pose the question, do not answer it yet. → "A different question comes first: why do people work in teams?" |
| 2:00 | 4a. Why do people work in teams? | 30 s | 49 | 21 s | → "For agents, only two of those three hold." |
| 2:30 | 4b. Why do people work in teams? (2) | 30 s | 58 | 25 s | → "That is the thesis." |
| 3:00 | 5a. Context, not intelligence | 20 s | 43 | 18 s | → "Two papers show the degradation." |
| 3:20 | 5b. Lost in the middle | 20 s | 77 | 33 s | Runs over its own 20 s slot because the citation is read in full; the segment as a whole still has room. → "The second paper measured how much of the advertised window is actually usable." |
| 3:40 | 5c. The effective window | 20 s | 78 | 33 s | Same overrun, same reason. → "Before the patterns, the words need fixing." |

Segment A actual: 401 words → 2:52 vs. 4:00 budgeted. Under by about 1:08.

## Segment B — Architectures (budget 390 s / 6:30)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 4:00 | 6a. Workflows, architectures, three axes | 35 s | 65 | 28 s | If cut 3 (entry 11) is taken, add one spoken sentence here: "in practice, one orchestrator and two to five workers." → "Underneath any of those names are three choices." |
| 4:35 | 6b. Three axes (2) | 25 s | 56 | 24 s | → "Pattern one." |
| 5:00 | 7. Pattern 1: fan-out and merge | 60 s | 51 | 22 s | Weave in: subagents do not see your conversation — pass what they need, ask for a summary back, not a dump. → "Pattern two is for pieces that are not independent." |
| 6:00 | 8. Pattern 2: pipeline | 60 s | 49 | 21 s | Diagram runs full width — point at it, do not read it. → "Pattern three adds an adversary." |
| 7:00 | 9. Pattern 3: writer and critic | 60 s | 53 | 23 s | Independence is the point: a reviewer not anchored to the draft. → "Pattern four is not really a fourth topology." |
| 8:00 | 10a. Pattern 4: parallel isolated workers | 35 s | 43 | 18 s | → "The tooling for this already exists." |
| 8:35 | 10b. Pattern 4 (2) | 25 s | 76 | 33 s | Aside: the merge at the end still has to be verified — a clean merge is not a correct merge. → "So how many agents should one actually run?" |
| 9:00 | 11a. How many agents? | 15 s | 52 | 22 s | Codex and Cursor were dropped from this slide on 2026-09-17 — only Claude Code is documented. → "Working systems are small." |
| 9:15 | 11b. How many agents? (2) | 15 s | 71 | 30 s | Three separate scale points, not a survey. → "Larger systems exist in research." |
| 9:30 | 11c. How many agents? (3) | 15 s | 76 | 33 s | "Nobody uses it for work" is an assessment, not a measurement — say so. → "And some of this is already common practice." |
| 9:45 | 12. You already do this | 45 s | 57 | 24 s | → "Here is what happened when I replaced myself with a script." |

Segment B actual: 649 words → 4:38 vs. 6:30 budgeted. Under by about 1:52 overall — but slides
11a–11c alone read at about 1:25 against their combined 45 s slot, which is why entry 11 is the
best-ratio cut if you need one (see below), even though the segment as a whole has room.

## Segment C — Example: this talk was made by agents (budget 480 s / 8:00)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 10:30 | 13a. This deck was built by the pipeline | 20 s | 47 | 20 s | → "This is the repository." |
| 10:50 | 13b. Repo layout (2) | 25 s | 23 | 10 s | Point at the code block; the full listing is in the handout. → "The first attempt did not have that outline line. Agents wrote the outline too." |
| 11:15 | 14a. Attempt one, from scratch | 15 s | 58 | 25 s | → "Three things broke. The first was my spec." |
| 11:30 | 14b. Failure 1, the spec contradiction | 20 s | 72 | 31 s | The agent did the right thing; the spec was wrong. → "The second failure was the one I had warned about on the pattern slides." |
| 11:50 | 14c. Failure 2, the shared cost log | 20 s | 60 | 26 s | Say aloud: nothing appends to a shared file any more. → "The third failure was money." |
| 12:10 | 14d. Failure 3, the budget cap | 20 s | 63 | 27 s | Runs 007 ($2.64) and 008 ($1.62) finished the revision. → "And then the pipeline finished, and passed every check." |
| 12:30 | 15a. What came out | 30 s | 49 | 21 s | The old deck is at commit 707ad48. → "Why did that happen?" |
| 13:00 | 15b. What came out — why | 30 s | 48 | 21 s | This is the moment you admit it did not work. → "The pipeline was reset." |
| 13:30 | 16a. The reset | 30 s | 66 | 28 s | Outline entry copied exactly from `slides/outline.md`. → "That changed the roster." |
| 14:00 | 16b. The reset — retired and added | 30 s | 65 | 28 s | Ten agents now, eleven then. → "Here is what one of those agents actually is." |
| 14:30 | 17a. Recipe part one: an agent is a markdown file | 30 s | 48 | 21 s | Full description line, if asked: "...Scores whether each slide earns its time, not whether it complies with a rubric. Never edits; writes a PASS or REVISE review the script uses to decide whether to loop." → "Below the frontmatter, instructions in plain English." |
| 15:00 | 17b. Recipe part one (2): instructions | 30 s | 28 | 12 s | The seven review questions in between are in the handout. → "Part two: how the script calls it." |
| 15:30 | 18a. Recipe part two: a script calls it headless with a budget | 30 s | 36 | 15 s | `$BUDGET` defaults to 5 after run 006. → "And the script owns the order." |
| 16:00 | 18b. Recipe part two (2): the stage order | 30 s | 59 | 25 s | Chronicle runs twice so the deck can describe its own build honestly. → "Here is what attempt two has done so far, run by run." |
| 16:30 | 19a. Attempt two, step by step | 27 s | 66 | 28 s | → "Then the chronicler." |
| 16:57 | 19b. Step by step (2) | 12 s | 62 | 27 s | Per-worktree cost detail is in the handout if asked. → "Then the loop: a critic, then the writer, twice." |
| 17:09 | 19c. Step by step (3) | 12 s | 63 | 27 s | Run 020 also declined the Tran & Kiela title because no file in the repo had one. → "Round two." |
| 17:21 | 19d. Step by step (4) | 12 s | 61 | 26 s | Run 022 was the last round the loop allows. → "Then the chronicler came back." |
| 17:33 | 19e. Step by step (5) | 12 s | 60 | 26 s | If later stages have run by talk day, check `runs/` — do not quote their numbers from memory. → "Which brings me to the bill." |
| 17:45 | 20a. What it cost, and the receipts | 20 s | 71 | 30 s | $29.22 + $14.7838 ≈ $44.00 running total as of run 022. → "And every dollar has a receipt." |
| 18:05 | 20b. Receipts (2) | 25 s | 46 | 20 s | The parallel write stage nests three subfolders under one run directory. → "Now the evidence for when this helps and when it hurts." |

Segment C actual: 1,151 words → 8:13 vs. 8:00 budgeted. This is the only segment that runs over
its own budget, by about 13 s — negligible against the deck's overall 4:34 of slack, and it is not
one of the three cut candidates below (those are chosen for what is least essential, not for which
segment is tightest).

## Segment D — Where it helps and where it does not (budget 210 s / 3:30)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 18:30 | 21a. The one paper that says both | 35 s | 74 | 32 s | Per-variant figures if asked: hybrid −39.0%, decentralized −41.4%, centralized −50.4%, independent −70.0%. → "So what decides? The shape of the task." |
| 19:05 | 21b. Task shape decides | 25 s | 41 | 18 s | This paragraph is your own inference, not a citation. → "Here is the rest of the evidence, both sides." |
| 19:30 | 22a. The rest of the evidence: for | 25 s | 74 | 32 s | Same Anthropic post: token count alone explained 80% of the variance. → "Against, twice." |
| 19:55 | 22b. The rest of the evidence: against (2) | 25 s | 86 | 37 s | Title on this citation was hand-fetched from the arXiv abstract page; the fact-checker verifies it. → "And the cost side." |
| 20:20 | 22c. The rest of the evidence: against (3) | 25 s | 68 | 29 s | Say "matched or beat," not "similar" — the cheap baseline won on accuracy. → "When it fails, how does it fail?" |
| 20:45 | 23a. How it fails | 35 s | 63 | 27 s | Inter-annotator agreement κ = 0.88, if asked. → "Three of those I see every week." |
| 21:20 | 23b. How it fails (2): three I see | 40 s | 63 | 27 s | → "The simple example follows." |

Segment D actual: 469 words → 3:21 vs. 3:30 budgeted. Under by about 9 s.

## Segment E — Setting it up: simple and difficult (budget 300 s / 5:00)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 22:00 | 24a. Simple example to run first | 40 s | 51 | 22 s | Outline says "under 2,000 tokens"; the agent file as built says 600. → "The instructions." |
| 22:40 | 24b. Simple example (2): instructions | 30 s | 24 | 10 s | Read aloud the three rules: read, query, say "not found" rather than invent. → "Then what to send back." |
| 23:10 | 24c. Simple example (3): return format | 25 s | 31 | 13 s | Weave in: summaries, not dumps. → "One command." |
| 23:35 | 24d. Simple example (4): the command | 40 s | 26 | 11 s | This slack is deliberate — this is where you can run the command live if you choose to. → "And here is what actually came back." |
| 24:15 | 24e. Simple example (5): the real result | 45 s | 47 | 20 s | Full table is in `examples/exoplanet-lookup/RESULT.md` and the handout; it succeeded on the first real attempt. → "That is the simple end. The difficult end is this talk." |
| 25:00 | 26a. Cost, and when it is worth it | 20 s | 73 | 31 s | Do not present pricing — model selection is covered elsewhere in the workshop. → "So the multiple has to be spent carefully." |
| 25:20 | 26b. Cost, and when it is worth it (2) | 20 s | 103 | 44 s | The most over-budget slide relative to its slot (44 s of prose in a 20 s window) — trim to the first two sentences if you are behind the clock here. → "The difficult example." |
| 25:40 | 26c. Cost (3): the difficult example | 20 s | 61 | 26 s | Folded in from the old entry 25 on 2026-09-17. → "To close." |
| 26:00 | 27. Close | 60 s | 54 | 23 s | Hand off to the following session in one line. Q&A opens at 27:00; likely questions are in `handout/qa.md`. |

Segment E actual: 470 words → 3:21 vs. 5:00 budgeted. Under by about 1:39. Most of the slack is
intentional: 24d–24e cover a live demo, not just reading.

Sources slides (not presented) carry no spoken time and are not in the clock above.

## If you are running long: the three places to cut

Taken directly from the top of the cuts list in `slides/outline.md` (its fourth item, folding entry
3 into entry 4, is a spare and not one of the three marked here):

1. **Cut entry 19** (slides 19a–19e, 16:30–17:45, "Attempt two, step by step"). Say instead, on
   slide 20a: "every stage is in `runs/`, one line each in the handout." Saves 75 s of the schedule;
   the prose it replaces reads at about 2:14, so the actual time recovered is closer to 2:09.
2. **Cut entry 22** (slides 22a–22c, 19:30–20:45, "The rest of the evidence"). Keep Kim et al. only
   (slide 21). Saves 75 s of the schedule; the prose it replaces reads at about 1:38.
3. **Cut entry 11** (slides 11a–11c, 9:00–9:45, "How many agents?"). Fold into one spoken sentence
   on slide 6a: "in practice, one orchestrator and two to five workers." Saves 45 s of the schedule;
   the prose it replaces reads at about 1:25 — the largest overrun relative to its own budget of the
   three, so the best ratio of time recovered to content lost.

Do them in this order — 1, then 2, then 3 — and stop once you are back on schedule. The deck has
about 4:34 of slack overall, so none of these should be needed unless something outside the slides
(a question mid-talk, a slow start) has already eaten into the clock.
