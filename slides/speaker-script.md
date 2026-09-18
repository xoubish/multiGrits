# Speaker script — Multi-agent workflows

This is a clock and a transition guide, not a second copy of the deck. The speaker reads from
the slides; do not read this document aloud. For every slide: the clock at slide **start**
(mm:ss from the top of content, 00:00 = walk-on), the slide's approximate word count, what that
implies at 140 words/minute, the outline's time budget for that slide, the transition line
(copied from the HTML comment under the slide), and any aside worth saying that isn't on the
slide. Word counts are rough (prose only; code blocks and full citations are shown, not read
verbatim — read the short paraphrase in the aside instead). Rewrite this in your own voice; keep
the numbers.

Total run: 1620 s of content (27:00) + 180 s Q&A = 30:00, per `talk-context.md`. The outline's
per-slide seconds sum to exactly 1620 s, so the clock below is built from the outline's budget,
not from the word counts — the word counts tell you whether a slide is running long against that
budget, not the other way around.

Legend: **clock** = time at start of slide · **words** = approx. spoken words · **@140wpm** =
implied seconds for that word count · **budget** = outline's seconds for that slide.

---

## A. One collaborator, then more

**1. Title — clock 00:00 — words 12 — @140wpm 5s — budget 15s**
Just the title, name, track. Let it sit.
Transition: "Yesterday you got one collaborator."

**2. Yesterday you got one collaborator — clock 00:15 — words 43 — @140wpm 18s — budget 45s**
One-line recap only. Do not re-teach agents or Claude Code — that's Day 1's job.
Transition: "Because the temptation is obvious."

**3. Why not more than one? — clock 01:00 — words 50 — @140wpm 21s — budget 60s**
Pose the question, don't answer it yet.
Transition: "Let me ask a different question first: why do people work in teams?"
*[Cut #3 (outline cuts list, item 4): if running long, fold this slide's line into slide 4 and
drop it as a separate beat.]*

**4a. Why do people work in teams? — clock 02:00 — words 50 — @140wpm 21s — budget 30s (of 60)**
Illustration (teams.svg) sits to the right; let it breathe.
Transition: "For agents, only two of those three hold."

**4b. Why do people work in teams? (2) — clock 02:30 — words 59 — @140wpm 25s — budget 30s (of 60)**
Transition: "That is the whole thesis."

## Context, not intelligence (part of entry 5)

**5a. What multi-agent brings — clock 03:00 — words 45 — @140wpm 19s — budget 20s (of 60)**
This line is the thesis of the whole talk; slow down here.
Transition: "Two papers show the degradation."

**5b. Lost in the middle — clock 03:20 — words 35 (prose; citation shown, not read in full) —
@140wpm 15s — budget 20s (of 60)**
Aside: say the short version — "accuracy dropped more than 20 points when the answer sat in the
middle of the context."
Transition: "The second paper measured how much of the advertised window is actually usable."

**5c. The effective window (RULER) — clock 03:40 — words 39 — @140wpm 17s — budget 20s (of 60)**
Aside: "two papers, two models, two tests — I'm not merging their numbers."
Transition: "Before the patterns, let me fix the words."

## B. Architectures

**6a. Workflows, architectures, three axes — clock 04:00 — words ~65–75 (prose + short
citation paraphrase) — @140wpm ~30s — budget 35s (of 60)**
If entry 11 is cut, add one spoken sentence here: "in practice, one orchestrator and two to five
workers."
Transition: "Underneath any of those names are three choices."

**6b. Three axes — clock 04:35 — words 48 — @140wpm 21s — budget 25s (of 60)**
Transition: "Pattern one."

**7. Pattern 1: fan-out and merge — clock 05:00 — words 51 — @140wpm 22s — budget 60s**
Slide text runs short against budget — the extra ~35s is the diagram and the archive names, said
slowly. Weave in: subagents do not see your conversation; pass what they need, get summaries
back, not dumps.
Transition: "Pattern two is what you do when the pieces are not independent."

**8. Pattern 2: pipeline — clock 06:00 — words 46 — @140wpm 20s — budget 60s**
Same gap as slide 7 — the full-width diagram carries the rest of the time. The point is the
fresh context at each stage, not the sequence itself.
Transition: "Pattern three adds an adversary."

**9. Pattern 3: writer and critic — clock 07:00 — words 52 — @140wpm 22s — budget 60s**
Independence is the point: a reviewer not anchored to the draft.
Transition: "Pattern four is not really a fourth topology."

**10a. Pattern 4: parallel isolated workers — clock 08:00 — words 45 — @140wpm 19s — budget 35s
(of 60)**
Transition: "The tooling for this already exists."

**10b. Pattern 4 (2) — clock 08:35 — words 41 (prose; citation shown) — @140wpm 18s — budget 25s
(of 60)**
Aside: the merge at the end still has to be verified; a clean merge is not a correct merge.
Transition: "So how many agents should you actually run?"

**11a. How many agents? — clock 09:00 — words 40 — @140wpm 17s — budget 15s (of 45)**
Aside spoken, not on slide: the outline names Codex and Cursor too; evidence only confirms Claude
Code's default. Say so out loud.
Transition: "Working systems are small."
*[Cut #3 (outline cuts list, item 3): drop all three "How many agents?" slides and say one
sentence on slide 6a instead: "in practice, one orchestrator and two to five workers."]*

**11b. How many agents? (2) — clock 09:15 — words 30 — @140wpm 13s — budget 15s (of 45)**
Three separate scale points, not a survey.
Transition: "Bigger exists, in research."

**11c. How many agents? (3) — clock 09:30 — words 42 — @140wpm 18s — budget 15s (of 45)**
"Nobody uses it for work" is your assessment, not a measurement — say that.
Transition: "And you are already doing some of this."

**12. You already do this — clock 09:45 — words 59 — @140wpm 25s — budget 45s**
Illustration (two-terminals.svg) to the right.
Transition: "Here is what happened when I replaced myself with a script."

## C. Example: this talk was made by agents

**13a. This deck was built by the pipeline — clock 10:30 — words 47 — @140wpm 20s — budget 20s
(of 45)**
Diagram runs full width under the text.
Transition: "This is the repository."

**13b. Repo layout — clock 10:50 — words ~50–55 (prose + a few file names spoken from the code
block) — @140wpm ~23s — budget 25s (of 45)**
Aside: the full listing is in the handout — don't try to read every line.
Transition: "The first attempt did not have that outline line. Agents wrote the outline too."

**14a. Attempt one, from scratch — clock 11:15 — words 58 — @140wpm 25s — budget 15s (of 75)**
Runs slightly hot here (25s of a 15s slot) — the dollar figure and turn count carry real weight,
say them plainly and move on.
Transition: "Three things broke. The first was my spec."

**14b. Failure 1: the spec contradiction — clock 11:30 — words 75 — @140wpm 32s — budget 20s
(of 75)**
This is the densest slide in the segment; if you're behind the clock anywhere in segment C, trim
your delivery here first (before touching the official cuts below) — the numbers matter more
than the narration.
Transition: "The second failure was the one I had warned about on the pattern slides."

**14c. Failure 2: the shared cost log — clock 11:50 — words 65 — @140wpm 28s — budget 20s
(of 75)**
Say aloud: nothing appends to a shared file any more. Illustration (merge-conflict.svg) used once,
here only.
Transition: "The third failure was money."

**14d. Failure 3: the budget cap — clock 12:10 — words 65 — @140wpm 28s — budget 20s (of 75)**
Transition: "And then the pipeline finished, and passed every check."

**15a. What came out — clock 12:30 — words 55 — @140wpm 24s — budget 30s (of 60)**
This is the screenshot of the old, unpresentable deck.
Transition: "Why did that happen?"

**15b. What came out (2): why — clock 13:00 — words 50 — @140wpm 21s — budget 30s (of 60)**
This is the moment you admit it did not work. Let it land; don't rush past it.
Transition: "So I reset."

**16a. The reset — clock 13:30 — words ~75–90 (prose + the one code line) — @140wpm ~35s —
budget 30s (of 60)**
Transition: "That changed the roster."

**16b. The reset (2): retired and added — clock 14:00 — words 65 — @140wpm 28s — budget 30s
(of 60)**
Transition: "Here is what one of those agents actually is."

**17a. Recipe part one: an agent is a markdown file — clock 14:30 — words ~55 prose + frontmatter
block — @140wpm ~30s — budget 30s (of 60)**
Aside: the description line is truncated at […] on the slide; the full text is in the notes and
the handout if asked.
Transition: "Below the frontmatter, instructions in plain English."

**17b. Recipe part one (2): the instructions — clock 15:00 — words ~55–65 (prose + partial
reading of the code block) — @140wpm ~28s — budget 30s (of 60)**
The last line matters most: the script parses the verdict to decide whether to loop.
Transition: "Part two: how the script calls it."

**18a. Recipe part two: headless with a budget — clock 15:30 — words ~60–75 (prose + command) —
@140wpm ~32s — budget 30s (of 60)**
Transition: "And the script owns the order."

**18b. Recipe part two (2): stage order — clock 16:00 — words ~75–85 (prose + the stage
diagram line) — @140wpm ~36s — budget 30s (of 60)**
Chronicle runs twice so the deck can describe its own build honestly — say that once, clearly.
Transition: "Here is what attempt two has done so far, run by run."

**19a. Attempt two, step by step — clock 16:30 — words 75 — @140wpm 32s — budget 27s (of 75)**
Transition: "Then the chronicler."

**19b. Attempt two (2) — clock 16:57 — words 70 — @140wpm 30s — budget 12s (of 75)**
Running badly over the per-slide slot here — see cut note below.
Transition: "Then the loop: a critic, then the writer, twice."

**19c. Attempt two (3) — clock 17:09 — words 55 — @140wpm 24s — budget 12s (of 75)**
Transition: "Round two."

**19d. Attempt two (4) — clock 17:21 — words 55 — @140wpm 24s — budget 12s (of 75)**
Transition: "Then the chronicler came back."

**19e. Attempt two (5) — clock 17:33 — words 45 — @140wpm 19s — budget 12s (of 75)**
Transition: "Which brings me to the bill."
*[**Cut #1** (outline cuts list, item 1): all five "Attempt two, step by step" slides (19a–19e)
run about 130s of actual reading against a 75s budget — the single most over-budget stretch in
the deck. If you are behind, drop these five slides and say on the next slide (20a): "every stage
is in runs/, one line each in the handout."]*

**20a. What it cost, and the receipts — clock 17:45 — words 85 — @140wpm 36s — budget 20s
(of 45)**
If slides 19a–19e were cut, add the one sentence noted above before the dollar figures.
Transition: "And every dollar has a receipt."

**20b. Receipts (2) — clock 18:05 — words 55 — @140wpm 24s — budget 25s (of 45)**
Transition: "Now the evidence for when this helps and when it hurts."

## D. Where it helps and where it does not

**21a. The one paper that says both — clock 18:30 — words ~50 prose + citation — @140wpm ~30s —
budget 35s (of 60)**
Aside numbers if asked: hybrid −39.0%, decentralized −41.4%, centralized −50.4%, independent
−70.0%.
Transition: "So what decides? The shape of the task."

**21b. Task shape decides — clock 19:05 — words 65 — @140wpm 28s — budget 25s (of 60)**
Second paragraph is your own inference, not a number from the paper — say so.
Transition: "Here is the rest of the evidence, both sides."

**22a. The rest of the evidence: for — clock 19:30 — words ~45 prose + citation — @140wpm ~30s —
budget 25s (of 75)**
Transition: "Against, twice."
*[**Cut #2** (outline cuts list, item 2): the three "rest of the evidence" slides (22a–22c) run
about 35s over their 75s budget combined. If cutting, keep Kim et al. (slide 21) only and drop
22a–22c entirely.]*

**22b. Against (2) — clock 19:55 — words ~45 prose + citation — @140wpm ~33s — budget 25s
(of 75)**
Say "matched or beat," not "similar" — the multi-agent side lost on accuracy too.
Transition: "And the cost side."

**22c. Against (3) — clock 20:20 — words ~50 prose + citation — @140wpm ~28s — budget 25s
(of 75)**
Transition: "When it fails, how does it fail?"

**23a. How it fails — clock 20:45 — words 70 (prose + short citation) — @140wpm 30s — budget 35s
(of 75)**
Aside: inter-annotator agreement κ = 0.88, if asked.
Transition: "Three of those I see every week."

**23b. How it fails (2): the three I see — clock 21:20 — words 55 — @140wpm 24s — budget 40s
(of 75)**
This is the most directly actionable slide in the segment — don't rush it even though the word
count leaves room.
Transition: "So let me set one up, the simple way."

## E. Setting it up

**24a. Simple example you can run Monday — clock 22:00 — words ~50 prose + frontmatter block —
@140wpm ~34s — budget 25s (of 120)**
Aside: the outline said "under 2,000 tokens"; the agent as built says 600 — say the smaller,
real number.
Transition: "The instructions."

**24b. The instructions — clock 22:25 — words ~40–55 (prose + partial code reading) — @140wpm
~23s — budget 20s (of 120)**
Read the three rules aloud: read the file, query the archive, say "not found" rather than
invent.
Transition: "Then what to send back."

**24c. The return format — clock 22:45 — words ~50–65 (prose + code) — @140wpm ~32s — budget 15s
(of 120)**
Weave in: summaries, not dumps — this is the same point as the fan-out slide, now made concrete.
Transition: "One command."

**24d. The command — clock 23:00 — words ~55–60 (prose + command) — @140wpm ~25s — budget 25s
(of 120)**
Transition: "And here is what actually came back."

**24e. The real result — clock 23:25 — words ~55 (prose; only 3 of 10 rows shown, don't read the
whole table) — @140wpm ~24s — budget 35s (of 120)**
This is a real, unedited result. Say the caveat plainly: 7,321 tokens of total output including
thinking, versus a ~250-token visible table — the cap applies to what you see, not everything
the agent emits.
Transition: "That is the simple end. The difficult end is this talk."

**25. Difficult example — clock 24:00 — words 55 — @140wpm 24s — budget 60s**
Most of your own work is still one agent — say that plainly, it's the honest bar.
Transition: "And it is not free."

**26a. Cost, and when it is worth it — clock 25:00 — words ~20 prose + citation — @140wpm ~30s —
budget 25s (of 60)**
Transition: "So spend the multiple carefully."

**26b. Cost (2) — clock 25:25 — words ~75–95 (prose + short citation) — @140wpm ~35–40s — budget
35s (of 60)**
Do not present pricing tables — point to Nick's talk this morning by name.
Transition: "Let me close."

**27. Close — clock 26:00 — words 60 — @140wpm 26s — budget 60s**
Illustration (close.svg) to the right. Slow down for the hand-off line; it is the last thing they
hear before BJ.
Transition: hand to BJ. Then 180s of open-floor Q&A; likely questions are in `handout/qa.md`.

---

## Totals

Approximate total spoken words across all 53 slides: **~3,300**. At 140 wpm that is about
**23 minutes 35 seconds**, against a content budget of 27:00 (1,620 s). That leaves roughly
3.5 minutes of slack, which is consistent with the diagram- and table-heavy slides (7, 8, 9, 10)
reading short against their budgets — that gap is where you point at the diagram, pause, and let
the illustration slides breathe, not where you add material.

## The three cuts, in order of application

1. **Slides 19a–19e** (Attempt two, step by step): drop all five; say on slide 20a "every stage
   is in runs/, one line each in the handout." Saves the most time (~55s against budget, ~130s of
   actual reading against a 75s slot).
2. **Slides 22a–22c** (the rest of the evidence): drop all three; keep Kim et al. (slide 21)
   only. Saves ~75s.
3. **Slides 11a–11c** (how many agents): drop all three; add one spoken sentence to slide 6a —
   "in practice, one orchestrator and two to five workers." Saves ~45s.
4. (Smallest, use last if still tight): fold slide 3 into slide 4 as one sentence rather than a
   separate beat.
