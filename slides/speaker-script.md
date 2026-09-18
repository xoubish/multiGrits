# Speaker script — clock and transitions, not a second deck

This is a clock, not a copy of the slides. The speaker reads the slide; this page tells you when
you should be starting each one, how many words are on it, what that implies at a spoken pace of
140 words per minute, the line that carries you into the next slide, and any aside worth
remembering that isn't on the slide. Rewrite the transitions in your own voice — the words here are
a placeholder, not a script to memorize. The numbers (clock, budget, word count) are the part to
keep.

Total: 1620 s (27:00) of content + 180 s (3:00) of Q&A = 30:00. Clock below starts at 0:00 and
counts up through the close; Q&A begins at 27:00.

Word counts are the slide's spoken prose (headings, code blocks, and image tags are not counted —
you point at code, you don't read it aloud). "Budget" is the seconds assigned in `slides/outline.md`
(split across multiple slides per entry where the outline covers more than one). "Impl." is that
slide's word count ÷ 140 wpm × 60. Where impl. exceeds budget, the slide is genuinely tight — slow
down there costs you time somewhere else; where impl. is well under budget, that's where a pause,
a gesture at a diagram, or an ad-lib fits without pushing the clock.

Total across the deck: **3,002 spoken words → 21:26 at 140 wpm**, against a 27:00 content budget.
That's about 5:34 of slack — most of it sits on the pattern slides (7–9), the diagram slides, and
the live-demo slide (24e), which the outline budgeted generously on purpose for pointing, not
reading. The slides that run over their own sub-budget are the citation-heavy ones (5b, 5c, 10b,
11a–c, 14, 19, 22, 26a–b) — they are exactly the slides on the cuts list below, which is not a
coincidence: reading a full citation aloud at 140 wpm takes longer than the outline's compressed
per-slide seconds assume.

## Segment A — One collaborator, then more (0:00–4:00, budget 240 s)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 0:00 | 1. Title | 15 s | 12 | 5 s | Say your name and title over the illustration; don't rush off it. → "Yesterday you got one collaborator." |
| 0:15 | 2. Yesterday you got one collaborator | 45 s | 42 | 18 s | One-line recap only — do not re-teach agents or Claude Code. → "Because the temptation is obvious." |
| 1:00 | 3. Why not more than one? | 60 s | 49 | 21 s | Pose the question, don't answer it yet. **Cut #4**: fold this into slide 4 if running long. → "Let me ask a different question first: why do people work in teams?" |
| 2:00 | 4a. Why do people work in teams? | 30 s | 51 | 22 s | → "For agents, only two of those three hold." |
| 2:30 | 4b. Why do people work in teams? (2) | 30 s | 58 | 25 s | → "That is the whole thesis." |
| 3:00 | 5a. Context, not intelligence | 20 s | 45 | 19 s | → "Two papers show the degradation." |
| 3:20 | 5b. Lost in the middle | 20 s | 78 | 33 s | Runs over its 20 s slot by reading the full citation — that's fine, it's compensated elsewhere in the segment. → "The second paper measured how much of the advertised window is actually usable." |
| 3:40 | 5c. The effective window | 20 s | 81 | 35 s | Same overrun as 5b, same reason. → "Before the patterns, let me fix the words." |

Segment A actual: 416 words → 2:58 vs. 4:00 budgeted. Comfortable.

## Segment B — Architectures (4:00–9:45, budget 390 s)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 4:00 | 6a. Workflows, architectures, three axes | 35 s | 67 | 29 s | If entry 11 is cut, add here: "in practice, one orchestrator and two to five workers." → "Underneath any of those names are three choices." |
| 4:35 | 6b. Three axes (2) | 25 s | 48 | 21 s | → "Pattern one." |
| 5:00 | 7. Pattern 1: fan-out and merge | 60 s | 50 | 21 s | Weave in: subagents don't see your conversation; pass what they need, get summaries back. → "Pattern two is what you do when the pieces are not independent." |
| 6:00 | 8. Pattern 2: pipeline | 60 s | 45 | 19 s | Diagram runs full width — point at it, don't read it. → "Pattern three adds an adversary." |
| 7:00 | 9. Pattern 3: writer and critic | 60 s | 52 | 22 s | Point: independence is the point — a reviewer not anchored to the draft. → "Pattern four is not really a fourth topology." |
| 8:00 | 10a. Pattern 4: parallel isolated workers | 35 s | 44 | 19 s | → "The tooling for this already exists." |
| 8:35 | 10b. Pattern 4 (2) | 25 s | 80 | 34 s | Aside: the merge at the end still has to be verified — a clean merge is not a correct merge. → "So how many agents should you actually run?" |
| 9:00 | 11a. How many agents? | 15 s | 47 | 20 s | **Cut #3**: drop this whole entry (11a–c) and say one sentence on slide 6 instead. Codex/Cursor were dropped from this slide — Claude Code only is documented. → "Working systems are small." |
| 9:15 | 11b. How many agents? (2) | 15 s | 69 | 30 s | Three separate scale points, not a survey. → "Bigger exists, in research." |
| 9:30 | 11c. How many agents? (3) | 15 s | 75 | 32 s | "Nobody uses it for work" is your assessment, not a measurement — say so. → "And you are already doing some of this." |
| 9:45→10:30 | 12. You already do this | 45 s | 57 | 24 s | → "Here is what happened when I replaced myself with a script." |

Segment B actual: 634 words → 4:32 vs. 6:30 budgeted. If you skip the cut, this segment runs long
by about 1:12 (entry 11 alone reads at 82 s against its 45 s budget) — cutting it is the fix, not
speeding up.

## Segment C — Example: this talk was made by agents (10:30–18:30, budget 480 s)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 10:30 | 13a. This deck was built by the pipeline | 20 s | 46 | 20 s | → "This is the repository." |
| 10:50 | 13b. Repo layout (2) | 25 s | 22 | 9 s | Point at the code block; full listing is in the handout. → "The first attempt did not have that outline line. Agents wrote the outline too." |
| 11:15 | 14a. Attempt one, from scratch | 15 s | 58 | 25 s | → "Three things broke. The first was my spec." |
| 11:30 | 14b. Failure 1, the spec contradiction | 20 s | 71 | 30 s | The agent did the right thing; the spec was wrong. → "The second failure was the one I had warned about on the pattern slides." |
| 11:50 | 14c. Failure 2, the shared cost log | 20 s | 58 | 25 s | Aside: say aloud — nothing appends to a shared file any more. → "The third failure was money." |
| 12:10 | 14d. Failure 3, the budget cap | 20 s | 60 | 26 s | → "And then the pipeline finished, and passed every check." |
| 12:30 | 15a. What came out | 30 s | 48 | 21 s | The old deck is at commit 707ad48. → "Why did that happen?" |
| 13:00 | 15b. What came out — why | 30 s | 45 | 19 s | This is the moment you admit it did not work. → "So I reset." |
| 13:30 | 16a. The reset | 30 s | 64 | 27 s | Outline entry copied exactly from `slides/outline.md`. → "That changed the roster." |
| 14:00 | 16b. The reset — retired and added | 30 s | 63 | 27 s | Ten agents now, eleven then. → "Here is what one of those agents actually is." |
| 14:30 | 17a. Recipe part one: an agent is a markdown file | 30 s | 49 | 21 s | Full description line, if asked: "...Scores whether each slide earns its time, not whether it complies with a rubric. Never edits; writes a PASS or REVISE review the script uses to decide whether to loop." → "Below the frontmatter, instructions in plain English." |
| 15:00 | 17b. Recipe part one (2): instructions | 30 s | 24 | 10 s | The seven review questions in between are in the handout. → "Part two: how the script calls it." |
| 15:30 | 18a. Recipe part two: a script calls it headless with a budget | 30 s | 36 | 15 s | `$BUDGET` defaults to 5 after run 006. → "And the script owns the order." |
| 16:00 | 18b. Recipe part two (2): the stage order | 30 s | 52 | 22 s | Chronicle runs twice so the deck can describe its own build honestly. → "Here is what attempt two has done so far, run by run." |
| 16:30 | 19a. Attempt two, step by step | 27 s | 64 | 27 s | **Cut #1**: drop this whole run-by-run entry (19a–e) and say "every stage is in `runs/`, one line each in the handout" on slide 20. → "Then the chronicler." |
| 16:57 | 19b. Step by step (2) | 12 s | 59 | 25 s | Per-worktree cost detail is in the handout if asked. → "Then the loop: a critic, then the writer, twice." |
| 17:09 | 19c. Step by step (3) | 12 s | 59 | 25 s | Run 020 also declined an unsourced title — say so only if asked. → "Round two." |
| 17:21 | 19d. Step by step (4) | 12 s | 60 | 26 s | Run 022 was the last round the loop allows. → "Then the chronicler came back." |
| 17:33 | 19e. Step by step (5) | 12 s | 61 | 26 s | If later stages have run by talk day, don't quote their numbers from memory — check `runs/`. → "Which brings me to the bill." |
| 17:45 | 20a. What it cost, and the receipts | 20 s | 70 | 30 s | $29.22 + $14.7838 ≈ $44.00 running total as of run 022. → "And every dollar has a receipt." |
| 18:05→18:30 | 20b. Receipts (2) | 25 s | 46 | 20 s | The parallel write stage nests three subfolders under one run directory. → "Now the evidence for when this helps and when it hurts." |

Segment C actual: 1,115 words → 7:58 vs. 8:00 budgeted — this is the tightest, most accurate match
in the deck; it has almost no slack, which is exactly where **Cut #1** (drop 19a–e) buys you real
time (about 55 s) if you're running long by this point.

## Segment D — Where it helps and where it does not (18:30–22:00, budget 210 s)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 18:30 | 21a. The one paper that says both | 35 s | 73 | 31 s | Per-variant figures if asked: hybrid −39.0%, decentralized −41.4%, centralized −50.4%, independent −70.0%. → "So what decides? The shape of the task." |
| 19:05 | 21b. Task shape decides | 25 s | 23 | 10 s | This paragraph is your own inference, not a citation. → "Here is the rest of the evidence, both sides." |
| 19:30 | 22a. The rest of the evidence: for | 25 s | 68 | 29 s | **Cut #2**: drop this whole entry (22a–c) and keep Kim et al. only (slide 21). Aside: same Anthropic post says token count alone explained 80% of the variance. → "Against, twice." |
| 19:55 | 22b. The rest of the evidence: against (2) | 25 s | 72 | 31 s | Title on this citation was hand-fetched from the arXiv abstract page; fact-checker verifies it. → "And the cost side." |
| 20:20 | 22c. The rest of the evidence: against (3) | 25 s | 60 | 26 s | Say "matched or beat," not "similar" — the cheap baseline won on accuracy. → "When it fails, how does it fail?" |
| 20:45 | 23a. How it fails | 35 s | 56 | 24 s | Inter-annotator agreement κ = 0.88, if asked. → "Three of those I see every week." |
| 21:20→22:00 | 23b. How it fails (2): the three I see | 40 s | 51 | 22 s | → "So let me set one up, the simple way." |

Segment D actual: 403 words → 2:53 vs. 3:30 budgeted. **Cut #2** removes about 1:26 if needed —
this is the single biggest lever on the cuts list.

## Segment E — Setting it up: simple and difficult (22:00–27:00, budget 300 s)

| Clock | Slide | Budget | Words | Impl. | Transition / aside |
|---|---|---|---|---|---|
| 22:00 | 24a. Simple example you can run Monday | 40 s | 46 | 20 s | → "The instructions." |
| 22:40 | 24b. Simple example (2): instructions | 30 s | 23 | 10 s | Read aloud the three rules: read, query, say "not found" rather than invent. → "Then what to send back." |
| 23:10 | 24c. Simple example (3): return format | 25 s | 29 | 12 s | Weave in: summaries, not dumps. → "One command." |
| 23:35 | 24d. Simple example (4): the command | 40 s | 23 | 10 s | This slack is deliberate — this is where you can actually run the command live if you choose to. → "And here is what actually came back." |
| 24:15→25:00 | 24e. Simple example (5): the real result | 45 s | 39 | 17 s | Full table is in `examples/exoplanet-lookup/RESULT.md` and the handout; it succeeded on the first real attempt. → "That is the simple end. The difficult end is this talk." |
| 25:00 | 26a. Cost, and when it is worth it | 20 s | 67 | 29 s | Do not present pricing tables — point to Nick's talk. → "So spend the multiple carefully." |
| 25:20 | 26b. Cost, and when it is worth it (2) | 20 s | 98 | 42 s | This is the most over-budget slide in the deck relative to its slot (42 s of prose in a 20 s window) — trim to the first two sentences if you're behind the clock here. → "Let me close." |
| 25:40→26:00 | 26c. Cost (3): the difficult example | 20 s | 55 | 24 s | Folded in from the old entry 25. → "So, to close." |
| 26:00 | 27. Close | 60 s | 54 | 23 s | Hand off to BJ in one line. Q&A opens at 27:00; likely questions are in `handout/qa.md`. |

Segment E actual: 434 words → 3:06 vs. 5:00 budgeted. Most of the slack here is intentional —
24d/24e cover a live demo, not just reading.

Sources slides (not presented) carry no spoken time and are not in the clock above.

## If you are running long: the three (four) cuts, in order

Taken directly from the cuts list in `slides/outline.md`:

1. **Cut entry 19** (Attempt two, step by step — slides 19a–e, 16:30–17:45). Say instead, on slide
   20: "every stage is in `runs/`, one line each in the handout." Saves about 1:15 of budgeted time
   and, per the word counts above, closer to 2:00 of actual reading time since this entry runs the
   most over its own budget in the deck.
2. **Cut entry 22** (The rest of the evidence — slides 22a–c, 19:30–20:45). Keep Kim et al. (slide
   21) only. Saves 1:15 budgeted, about 1:26 actual.
3. **Cut entry 11** (How many agents — slides 11a–c, 9:00–9:45). Fold into one spoken sentence on
   slide 6: "in practice, one orchestrator and two to five workers." Saves 45 s budgeted, about
   1:22 actual — the largest overrun-to-budget ratio of the three.
4. **Fold entry 3 into entry 4** (slide 3, 1:00–2:00) if you need a fourth cut. Skip the "why not
   more than one?" slide and open directly with "why do people work in teams?"

Cut #3 has the best ratio of time saved to content lost; cut #1 saves the most wall-clock time.
Do them in this order — 1, then 2, then 3 — and stop once you're back on schedule.
