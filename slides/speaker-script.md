# Speaker script — Multi-agent workflows

GRITS AI workshop, Day 2, 11:15–11:45. Source: `slides/deck.md` as revised in run 013 (26 content
slides + 4 reference-only Sources slides = 30 presented; appendix of 11 agent-file slides after
Sources, not counted and not narrated). `slides/outline.md` is the run-003 planning record and is
now stale in slide numbers and segment 3 detail (see its own status note); every clock, title, and
number below is taken from `slides/deck.md`'s own speaker-note comments, which match
`talk-context.md`'s binding segment table exactly.

Running clock is minutes:seconds from the start of the talk (0:00 = walking on stage). Word
ceilings use 140 words/minute; "Say" + "Transition" together are built to land at or under each
slide's ceiling. This file does not change `slides/deck.md`.

**The two places to cut if running long** (deck.md itself flags both; `slides/outline.md` ranks six
options in total if more time is needed):
1. **Slide 25 — "How it actually fails."** Drop the whole slide. While moving from slide 24 to
   Q&A, say only: "Multi-agent fails in specific, catalogued ways, not vague risk." Saves ~40 s.
2. **Slide 5 — "Four patterns, one shape each."** Skip it. Say its one line while slide 4 is still
   on screen, then go straight to slide 6. Saves ~20 s.

---

## Segment 1 — Why, and when not to (0:00–3:00)

### Slide 1 — Title (0:00 · ceiling 47 words)
**Say:** I'm Shooby Hemmati, IPAC. This is Multi-agent workflows: context, not intelligence — when
a second agent helps, when it doesn't, and what it costs. You all used Claude Code yesterday, so I
won't define "agent."
**Transition:** Let's start with how this deck itself got made.
*(~47 words)*

### Slide 2 — This deck was built by the pipeline you are about to see (0:20 · ceiling 47 words)
**Say:** Everything here came from one repo, one scripted pipeline: four researchers, an outliner, a
writer and diagrammer in parallel, a critic loop, a fact-checker, every run logged. You leave able
to pick a pattern, write one subagent, read a run's logs.
**Transition:** Now, why go multi-agent at all?
*(~48 words — tightest slide in the deck; if behind pace, cut "You leave able to... read a run's
logs" and just point at the diagram.)*

### Slide 3 — Why multi-agent: context, not intelligence (0:40 · ceiling 187 words)
**Say:** The reason to go multi-agent isn't that two models are smarter than one — it's that one
model's context window fills up and its quality degrades well before it hits the token limit. Liu
and colleagues found that in twenty-document question answering, GPT-3.5 lost over twenty points
when the answer sat in the middle of the context — ending below its score with no documents at all.
Hsieh's RULER benchmark found the claimed window isn't the usable window: GPT-4 advertised 128K
tokens, held up to about 64K, and half of seventeen models failed by 32K. The fix is delegation:
hand a bounded subtask to a fresh agent with a clean window, let it do the reading and tool calls,
and have it return a short summary — Anthropic's own guidance is one to two thousand tokens. Your
main thread stays small. Parallelism and specialization are real, but they come second. Astronomy
version: an agent that's read forty FITS headers into context is worse at the forty-first. Delegate
the audit.
**Transition:** So that's the case for; now the honest case against.
*(~184 words)*

### Slide 4 — When not to: most tasks don't need this (2:00 · ceiling 140 words)
**Say:** This is the honest case against, before the patterns, so nobody thinks I'm selling. Tran
and Kiela held thinking tokens constant and compared one agent to five multi-agent designs: single
agents matched or beat multi-agent every time — 0.427 versus 0.386 at a five-thousand-token budget.
Multi-agent only won when seventy percent of the context was masked or corrupted — which is the
context argument again, not an intelligence argument. Kapoor and colleagues found one published
agent framework cost over fifty times a simple baseline that matched or beat its accuracy. So: if
your task fits in one window and one agent, use one agent. Every extra agent is a coordination cost
paid in tokens, wall-clock, and debugging.
**Transition:** Every design I've seen reduces to one of four shapes — here they are.
*(~132 words)*

---

## Segment 2 — Four patterns, one diagram each (3:00–10:00)

### Slide 5 — Four patterns, one shape each (3:00 · ceiling 47 words) — **CUT #2**
**Say:** Every multi-agent design I've seen reduces to one of these four shapes, or a composition
of them. One diagram each, about ninety seconds, then one slide that reconciles why some help and
some hurt.
**Transition:** Pattern one: fan-out and merge.
*(~39 words)*
**If cutting:** skip this slide entirely; deliver the "Say" line while slide 4 is still on screen,
then go straight to slide 6.

### Slide 6 — Pattern 1 · Fan-out and merge (3:20 · ceiling 210 words) [DIAGRAM]
**Say:** Shape: the work splits into independent pieces. An orchestrator sends each piece to its own
subagent and merges the returns in one place — that central merge matters, and we'll see why later.
This is the one case the literature agrees on: breadth-first work over more sources than fit in one
window. Anthropic's research system — an Opus lead with Sonnet subagents — beat single-agent Opus by
90.2 percent on their internal eval, using roughly fifteen times the tokens of a chat. That's a
vendor number, so treat it as an upper bound on both the gain and the cost; the gain itself is a
context result, not an intelligence result — more sources fit across several windows than in one.
Independently, Xu, Tian and Jiang measured fifteen to forty percent less wall-clock time for roughly
sixty to ninety percent more tokens on a general-assistant benchmark — you're buying time with
tokens. Astronomy shape: a target list checked against IRSA, NED, and the Exoplanet Archive in
parallel, one agent per archive, merged into one table.
**Transition:** Pattern two flips this: steps that depend on each other.
*(~185 words)*

### Slide 7 — Pattern 2 · Pipeline (4:50 · ceiling 210 words) [DIAGRAM]
**Say:** Shape: step three depends on step two. Stages run in order, each with its own clean context
and a file hand-off — planner writes a plan, implementer reads it and writes code, tester reads the
code and runs it. Nobody carries the whole history. This is the pipeline that built this deck:
outline, then write, then critique. Anthropic's building-effective-agents post lists five composable
workflows and its main advice is to use the simplest solution possible — a pipeline is just prompt
chaining with files in between. The warning: sequential means sequential. Kim and colleagues tried
every multi-agent variant on a sequential planning task, and every one degraded it, by 39 to 70
percent. If step three depends on step two, don't fan it out — put it in a pipeline, or in one
thread.
**Transition:** Pattern three: what happens when the output needs checking.
*(~143 words — well under ceiling; if slide 10 gets cut, add here: "same paper, on a decomposable
task, gave plus 80.8 percent — task shape decides.")*

### Slide 8 — Pattern 3 · Writer and critic (6:20 · ceiling 210 words) [DIAGRAM]
**Say:** Shape: the output needs checking before it's trusted. One agent produces, a second reviews
adversarially and sends findings back — loop once or twice, then stop. The key design decision is
what the critic can touch: a critic with the test suite, the schema, and the data can actually
check. In the failure taxonomy we'll see in full later, task-verification failures are 23.5 percent
of all failed traces — verification is where multi-agent systems break most often, after design and
coordination. Two astronomy benchmarks show why this matters: gwBenchmarks found agents that
"relied on proxy metrics, partial evaluation, or fabricated results." Stargazer found agents that
get "a good statistical fit" but "fail to recover correct physical system parameters." A good
chi-squared isn't a good answer — the critic needs to run the physics check, not read the summary.
And a critic isn't free: Jamshidi and colleagues found chaining a reviewer cut hallucination from
0.422 to 0.272, while factual accuracy also slipped, from 0.789 to 0.769. This is the pattern the
recorded demo shows next, against this very deck.
**Transition:** And pattern four: when several agents share one repo.
*(~187 words — if short on time, keep only the gwBenchmarks sentence and drop the Jamshidi number.)*

### Slide 9 — Pattern 4 · Parallel isolated workers (7:50 · ceiling 210 words) [DIAGRAM]
**Say:** Shape: several agents need to edit the same repo at once. Each gets its own git worktree —
a second checkout of the same repo, in its own directory — they work at once on separate branches,
and a merge step at the end brings them together. This is how the slide-writer and the diagrammer
produced this deck at the same time without touching each other's files. Cognition's objection to
multi-agent is exactly the failure this pattern addresses: parallel subagents can't see what the
other is doing, so they make conflicting implicit decisions. Isolation doesn't fix the conflicting
decisions — it makes them visible as a merge conflict instead of a silently corrupted file. Claude
Code documents this directly: a subagent with isolation set to worktree gets its own worktree, and
the harness blocks writes to the main checkout. Two ideas here on purpose: the worktree mechanism,
and that isolation reveals rather than resolves. What happens at the merge — and the verification
bottleneck it creates — comes up again in the gotchas.
**Transition:** One study explains why some of these help and others hurt.
*(~184 words)*

### Slide 10 — Task shape decides (9:20 · ceiling 93 words)
**Say:** Kim and colleagues, Google and MIT: 260 configurations, six benchmarks, three model
families. On a decomposable financial task, centralized multi-agent improved results by 80.8
percent. On a sequential planning task, every multi-agent variant made it worse, by 39 to 70 percent
— same paper, same models. The difference is task shape: decomposable means each piece fits its own
window, which is the context argument again.
**Transition:** That's the four patterns. Now, twelve minutes inside the repo that built this talk.
*(~79 words)*

---

## Segment 3 — Recorded demo: the pipeline that built this talk (10:00–22:00)

Note for the whole segment: nothing runs live. Every image is a screenshot already committed to
this repo, captured by `pipeline/capture.py`, placed on these slides by the demo-editor agent. Ten
slides, 720 s total. Words deliberately run under the 140-wpm ceiling here, leaving time to read a
number off the screen and let the audience look.

### Slide 11 — Recorded from this repo · the layout (10:00 · 60 s · ceiling 140 words)
**Say:** For the next twelve minutes, nothing runs live. Every image is a screenshot of a real,
finished run in this repo, captured by a script and placed on these slides by another agent, the
demo-editor. Here's the repo, two levels deep: `.claude/agents` holds the eleven agent definitions;
`pipeline` is the script that calls them in a fixed order; `research`, `slides`, and `diagrams` are
what those calls write; `runs` is a receipt for every call; `handout` is what's left over for the
audience. That's the whole talk, as files.
**Transition:** First: what is a subagent, really? Just a file.
*(~98 words)*

### Slide 12 — A subagent is a markdown file (11:00 · 60 s · ceiling 140 words)
**Say:** Here's `ls` on `.claude/agents`, and the top of `critic.md`. A subagent is a markdown file:
a frontmatter block with a name, a description, the tools it may use, and the model it runs on —
then instructions in plain English. This line is how the script calls every stage, trimmed to the
flags that matter: `claude -p --agent critic --allowedTools Read,Glob,Grep,Write --max-budget-usd 5
"$(cat prompt.md)"`. `-p` means one prompt in, one result out, no interactive session. `--agent`
picks the file by name. `--allowedTools` is the tool list the script grants. `--max-budget-usd` is
the spend cap — run 006 hit it. This file doesn't decide when the critic runs. The script does.
**Transition:** Here's the receipt for a run like that one.
*(~138 words — tight; if behind pace, drop "run 006 hit it.")*

### Slide 13 — Already run · one directory per stage (12:00 · 60 s · ceiling 140 words)
**Say:** `ls` on `runs`: numbered directories, one per stage, in the order they ran — scaffold
check, research fan-out, two outline passes, the write stage, critique and revise rounds,
fact-check, notes, Q&A, and the demo edit that made these slides. Two are worth pointing at: run 002
caught a contradiction in the spec — two different time budgets — before any slide was written; run
006 hit its budget cap mid-revision. Both are logged here, and both come back shortly. Inside one,
`runs/007-critique`: the exact prompt sent, the full JSON result with tokens and cost, the text the
agent returned, its exit code, and its output file. None of these are re-run today — every one
already has a receipt.
**Transition:** Rewind to the very first stage: the research fan-out.
*(~131 words)*

### Slide 14 — Already run · the research fan-out (13:00 · 90 s · ceiling 210 words)
**Say:** The run-001 README. Four researchers, one topic each: literature, tools, context and cost,
astronomy, each with web access. 270 tool calls, about 602,000 subagent tokens, 10.9 minutes
wall-clock because they ran at once, against about 38 minutes one after another. Three things worth
saying. First: the four wrote about 7,100 words of briefs, but returned only about 800 words of
summary to the orchestrator, which read the full briefs from disk on its own schedule — that's the
compression from the context slide, working in practice. Second: two researchers cited the same
Anthropic post under two different URLs; the merge caught it, because independent agents disagree on
details — the habit is that the merge step deduplicates citations by URL, not by title. Third: the
brief asked for 600 to 1,200 words each; all four ran over, and only one said why. Agents drift on
soft limits; schemas hold better.
**Transition:** That fan-out fed the outline. Next: two agents writing at once.
*(~161 words)*

### Slide 15 — Already run · stage_write, two worktrees (14:30 · 75 s · ceiling 175 words)
**Say:** The loop from the run script. For each of two workers — slides and diagrams — it creates a
git worktree on its own branch, runs the slide-writer or diagrammer agent inside it with a
restricted tool list, commits, both in the background, then waits for both. The merge and cleanup
follow. The point: this is a shell script. The agents decide nothing here — not to spawn each other,
not to run in parallel, not which files they may touch. The script decided the topology, the order,
the tool lists, and the budget cap. That's the script-the-orchestration gotcha, in practice.
**Transition:** One of those two branches hit a conflict — here's what happened.
*(~113 words)*

### Slide 16 — Already run · the merge conflict (15:45 · 90 s · ceiling 210 words)
**Say:** Both agents finished cleanly and touched only their own files — slides and diagrams —
perfectly isolated. The collision came from the script's own bookkeeping: both worktrees appended a
row to one shared file, `runs/cost.tsv`, and the merge stopped on a real conflict. That's the
two-agents-one-file failure from the gotchas, caught by git exactly because the work was isolated,
not despite it. Nobody had thought of the cost log as "the agents' file." The fix: each run now
writes its own cost row, and the shared report is rebuilt from all of them. Two other failures from
this build are logged here too, neither hidden: run 002, the outliner found the spec gave two
different time budgets and stopped before writing a slide; run 006, the first revise pass ran out of
its three-dollar budget cap after 34 turns. A real failure teaches more than a clean run.
**Transition:** Both failures got fixed and re-run. Here's what a clean pass looks like: the
critic's verdict.
*(~169 words)*

### Slide 17 — Already run · the critic's verdict (17:15 · 90 s · ceiling 210 words)
**Say:** This is the critic's output on an earlier version of this very deck. A fixed rubric, seven
named criteria scored zero to ten, a pass or revise verdict — revise if any score is below seven.
The critic has four tools: read, glob, grep, write — so it reads everything and writes only its own
critique. It never touches the deck. Reading the scores: here it found a body claim with no
citation, and two spoken claims contradicted by files the audience would see. Revise. One finding,
verbatim: a finding without a slide number and a fix is not a finding — and these have both.
**Transition:** So it sent the deck back. Here's how the writer answered.
*(~117 words)*

### Slide 18 — Already run · the writer's response (18:45 · 75 s · ceiling 175 words)
**Say:** This is the slide-writer's answer to that critique, item by item. Every must-fix item is
marked CHANGED, with what changed. Two are marked DECLINED, out of scope, because they belong to a
file this agent isn't allowed to write — the diagrams — and are flagged for the diagrammer instead.
That refusal is the point: each agent writes only its assigned files, and says so when a fix belongs
to someone else. The loop itself — critique, then revise, then critique again — was run by the
script, twice, and stopped on the round limit.
**Transition:** Every claim in that deck still needed checking against its source.
*(~106 words)*

### Slide 19 — Already run · the fact-check (20:00 · 60 s · ceiling 140 words)
**Say:** The fact-checker's report. It opens every URL on the Sources slides and checks every number
against the source, never against its own memory. Tally: 44 confirmed, 2 partial, 0 not found, 0
fabricated. The two partial rows are precision issues — a mislabeled baseline name, and two true
numbers from different rows of one paper paired as if from one. Not invented sources. The
required-edits list gave corrected wording for each, and those edits are in the deck you're looking
at.
**Transition:** One more receipt before we leave the demo: what all this cost.
*(~93 words)*

### Slide 20 — Already run · what it cost (21:00 · 60 s · ceiling 140 words)
**Say:** The cost report, rebuilt from every stage's own result file. The total: $19.32 across the
logged, scripted stages — outline through the recorded-demo edit. The interactive research fan-out
billed to an interactive session and isn't in this table. Notice the model column: the expensive
rows are the slide-writer and critic on the session model; the outliner, fact-checker, and
demo-editor ran on Sonnet for a fraction of the cost — that's model tiering, and pricing beyond that
is Nick's talk. Every stage left a prompt, a return, tokens, and dollars. That's how you audit a
pipeline instead of trusting it.
**Transition:** That's the demo. Now, the gotchas.
*(~105 words)*

**If the demo runs long:** drop slide 18 first, then slide 13 (the content critic's approved order),
folding each one's one-line point into the neighbouring slide's narration instead of a separate
screen.

---

## Segment 4 — Gotchas and cost (22:00–27:00)

### Slide 21 — Gotcha · Subagents are context-blind (22:00 · ceiling 152 words)
**Say:** Mechanics from the Claude Code docs: a subagent starts with its own system prompt, the
message you send it, the project CLAUDE.md, and the repository state. It does not get your
conversation history, the files you've opened, or anything you said three turns ago — every time a
subagent "ignores" something, this is why. Two habits. First, write the delegation like a contractor
who just walked in: the goal, the files, the constraints, the output path. Second, tell it what to
return — a summary of at most N words, or a JSON object matching a schema. The researchers in this
repo returned 200-word summaries and wrote the full briefs to disk. The orchestrator's context
stayed small, which was the whole point of the context slide.
**Transition:** That summary discipline matters more once you're paying for several agents at once.
*(~139 words)*

### Slide 22 — Gotcha · Cost multiplies with agent count (23:05 · ceiling 163 words)
**Say:** Anthropic's June 2025 post measured agents at about 4x a chat's tokens, and multi-agent at
about 15x. Their January 2026 guidance says 3 to 10 times, and adds: don't split sequential phases
of the same work across agents. Both numbers come from a vendor promoting multi-agent, which has no
reason to overstate its cost. The mitigation is tiering: route subagents to cheaper or local models,
keep the frontier model on the orchestrator — the thread that has to make judgment calls. That's
first-party guidance in the Claude Code docs. In this repo, the researcher agent file pins Sonnet;
the logged run 001 predates that pin. Nick covered model selection and pricing this morning; I'm not
repeating the tables — his slides have the numbers.
**Transition:** Cost isn't the only thing that multiplies — so does file-conflict risk.
*(~136 words)*

### Slide 23 — Gotcha · Isolate the files, centralize the merge (24:15 · ceiling 163 words)
**Say:** The classic failure: two agents, one file, last write wins, and nobody notices until the
tests fail or the deck has half of each version. Worktrees fix the mechanical half: each agent gets
its own checkout, so the collision becomes a merge conflict git shows you, rather than a silent
overwrite — that's the write stage you just saw. The second half is who merges. Kim and colleagues:
with no central check, errors compounded 17.2x; with centralized verification, 4.4x — same tasks,
same models. So merge in one place, and give that place a way to check: tests, a schema, a critic
with tools. Osmani, from running several coding agents this way, put it plainly: once generation is
parallel, the bottleneck moves to verification. Budget for that.
**Transition:** Last gotcha: who decides the order agents run in.
*(~136 words)*

### Slide 24 — Gotcha · Script the orchestration (25:25 · ceiling 128 words)
**Say:** Two ways to get four agents running: ask an agent to spawn the others and let it decide the
order — or write a script that calls each agent with a fixed prompt and a fixed budget, and logs the
return. For pipeline and archive work, pick the second. Claude Code's own workflow feature makes the
same choice: the plan lives in a script, and clock or random-number calls throw an error, so a
relaunched run repeats the same calls in the same order. NASA SMD's own data strategy asks for
reproducibility in agentic workflows, and says plainly there are no established science-specific
guardrails yet.
**Transition:** One more number, then we open the floor: how it actually fails.
*(~117 words)*

### Slide 25 — How it actually fails (26:20 · ceiling 93 words) — **CUT #1**
**Say:** MAST: Cemri and colleagues annotated over 1,600 execution traces across seven multi-agent
frameworks and found fourteen failure modes in three categories — system design and specification,
44.2 percent; inter-agent misalignment, 32.3 percent; task verification, 23.5 percent. Most failures
are design problems, so the fixes are the gotchas we just went through — and the fixes are partial:
prompt and topology interventions alone gained only about 9 to 16 points. Multi-agent is
engineering, not magic.
**Transition:** Let's land the thesis, and open the floor.
*(~82 words)*
**If cutting:** drop this slide whole; while moving from slide 24 to Q&A, say only: "Multi-agent
fails in specific, catalogued ways, not vague risk."

---

## Segment 5 — Q&A and hand-off to BJ (27:00–30:00, mostly open floor)

### Slide 26 — Questions (27:00 · 180 s budget, ~142 s of it open floor)
**Say (opening, before the floor):** Go multi-agent for context, not intelligence. Most tasks need
one agent. First thing to try Monday: pull one bounded, read-only subtask out of your normal Claude
Code session into its own agent file, run it once with `claude -p --agent`, and check that the
summary it returns is short — under about 2,000 tokens. You'll need Claude Code CLI access, a repo
with a CLAUDE.md, and permission to run it non-interactively on your machine.
*(~77 words ≈ 33 s)*

**[Open floor — not scripted, ~142 s. Likely questions with grounded answers, reference only:]**
- "Does this work with local models?" → Yes for subagents doing bounded reading and extraction; the
  orchestrator is where you want the strongest model. See Nick's session.
- "How much did this deck cost?" → Read the total from `runs/cost-report.md`.
- "What about agent teams in Claude Code?" → Experimental, off by default, interactive-only; docs
  say try subagents first; in plan mode they measured about 7x tokens.
- "Did the pipeline get anything wrong?" → Yes, three times, all logged: run 002 (spec
  contradiction), run 004 (worktree merge conflict on a shared cost log), run 006 (budget cap
  exhausted mid-revision). The fact-checker found 44 confirmed citations, 2 partial, 0 fabricated.

**Say (closing, after the last question):** Many unsupervised agents means you need sandboxing —
that's BJ's talk, next.
*(~12 words ≈ 5 s)*

---

Slides 27–30 (Sources 1 of 4 through 4 of 4) are reference-only, not narrated; leave them on screen
briefly at the very end, or jump to them only if someone asks for a citation. The appendix (agent
files, 11 slides) is not presented unless there is spare time or someone asks afterward.

## Word tally (method and numbers in `runs/014-notes/timing.md`)

Scripted words, slides 1–25 (the 27-minute / 1,620 s content budget): ≈3,069. Scripted words, slide
26 (opening + closing lines only; the rest of its 180 s is open floor by design): ≈89. Total
scripted spoken words: ≈3,158. At 140 words/minute that is ≈22.6 minutes (≈22:33) of speech inside
the full 30-minute slot, with slides 1–25 alone at ≈21.9 minutes against their 27-minute budget —
comfortable margin, concentrated in the demo segment (slides 11–20), which is intentionally
screen-time-heavy rather than talk-heavy.
