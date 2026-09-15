# Speaker script — Multi-agent workflows

GRITS AI workshop, Day 2, 11:15–11:45. 30-minute slot per `talk-context.md` (binding): 27 min of
content (1,620 s, slides 1–20) + 3 min Q&A and hand-off (180 s, slide 21). Running clock below is
minutes:seconds from the start of the talk. Per-slide time budgets and clock are taken from the
speaker-note comments already in `slides/deck.md`; they match `slides/outline.md`'s segment totals
exactly, so the same clock works against either file.

Word targets use 140 words/minute. "Say" + "Transition" together must fit under the slide's target;
the number after each slide title is that ceiling. Deck.md is not changed by this script.

**Two places to cut if running long** (see full detail at the slide, and four more ranked options in
`slides/outline.md`'s "Cuts if running long"):
1. **Slide 20** — drop the whole slide.
2. **Slide 5** — skip it; fold its one line into slide 4's transition.

---

## Segment 1 — Why, and when not to (0:00–3:00)

### Slide 1 — Title (0:00 · ceiling 47 words)
**Say:** I'm Shooby Hemmati, from IPAC. This talk is about multi-agent workflows — when a second
agent helps, when it doesn't, and what it costs. You all used Claude Code yesterday, so I'll skip
defining what an agent is.
**Transition:** Here's the twist: this deck built itself.
*(~44 words)*

### Slide 2 — This deck was built by the pipeline you are about to see (0:20 · ceiling 47 words)
**Say:** Everything on screen for the next twenty-five minutes came from one repo and one scripted
pipeline: four researchers, an outliner, a parallel writer and diagrammer, a critic loop, a
fact-checker. Every run is logged — inspectable, not a claim that it beats a person.
**Transition:** Why go multi-agent?
*(~47 words — tightest slide in the deck; if you're behind pace already, cut "inspectable, not a
claim that it beats a person" and just point at the diagram.)*

### Slide 3 — Why multi-agent: context, not intelligence (0:40 · ceiling 187 words)
**Say:** The reason to go multi-agent isn't that two models are smarter than one — it's that one
model's context window fills up, and quality degrades well before the token limit. Liu and
colleagues showed it directly: in twenty-document question answering, GPT-3.5 lost more than twenty
points of accuracy when the answer sat mid-context, worse than with no documents at all. Hsieh and
colleagues' RULER benchmark found the same gap between claimed and usable context: GPT-4 advertised
a hundred twenty-eight thousand tokens, held up to about sixty-four thousand. The fix is delegation —
hand a bounded subtask to a fresh agent with a clean window, let it do the reading, and have it
return a short summary; Anthropic's own guidance is one to two thousand tokens. Your main thread
stays small. Parallelism and specialization are real benefits, but secondary. Astronomy version: an
agent that's read forty FITS headers is worse at the forty-first — delegate the audit.
**Transition:** So when does a second agent not help?
*(~180 words)*

### Slide 4 — When not to: most tasks don't need this (2:00 · ceiling 140 words)
**Say:** Most tasks don't need this. Tran and Kiela held thinking-token budgets equal and compared a
single agent to five multi-agent designs across reasoning tasks: the single agent matched or beat
multi-agent every time — 0.427 versus 0.386 at a five-thousand-token budget. Multi-agent only won
once seventy percent of the context was masked or corrupted, which is the context argument again,
not an intelligence one. Kapoor and colleagues found one published agent framework cost more than
fifty times a simple retry baseline for similar accuracy. So: if your task fits in one window and
one agent, use one agent. Every extra agent is a coordination cost you pay in tokens, wall-clock,
and debugging time.
**Transition:** Start with one agent — here are the four shapes for when you need more.
*(~139 words)*

---

## Segment 2 — Four patterns, one diagram each (3:00–10:00)

### Slide 5 — Four patterns, one shape each (3:00 · ceiling 47 words) — **CUT #2 CANDIDATE**
**Say:** Every multi-agent design I've seen reduces to one of four shapes, or a mix of them. One
diagram each, about ninety seconds, then a slide that reconciles why some help and some hurt.
**Transition:** Pattern one: fan-out and merge.
*(~38 words)*
**If cutting:** skip this slide entirely; while slide 4 is still on screen, add one clause — "so
here are the four shapes, one diagram each" — and go straight to slide 6.

### Slide 6 — Pattern 1 · Fan-out and merge (3:20 · ceiling 210 words) [DIAGRAM]
**Say:** Here's the shape: an orchestrator splits work into independent pieces, sends each to its
own subagent, and merges the returns in one place. That central merge matters — we'll see why
later. This is the one case the literature agrees on: breadth-first work over more sources than fit
in one window. Anthropic's own research system — an Opus lead with Sonnet subagents — beat
single-agent Opus by ninety point two percent on their internal evaluation, using roughly fifteen
times the tokens of a single chat. That's a vendor number, so treat it as an upper bound on both
the gain and the cost. An independent measurement: Xu, Tian, and Jiang, on the GAIA benchmark,
found fifteen to forty percent less wall-clock time for about seventy-four percent more tokens.
You're buying time with tokens. Astronomy shape: a target list checked against IRSA, NED, and the
Exoplanet Archive in parallel, via astroquery, one agent per archive, merged into one table.
Independent by construction.
**Transition:** Next: when the work is sequential, not independent.
*(~186 words)*

### Slide 7 — Pattern 2 · Pipeline (4:50 · ceiling 210 words) [DIAGRAM]
**Say:** Here the stages run in order, each with its own clean context and a file handoff. Planner
writes a plan, implementer reads the plan and writes code, tester reads the code and runs it —
nobody carries the whole history. This is the pipeline that built this deck: outline, then write,
then critique. Anthropic's building-effective-agents post lists five composable workflows — prompt
chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer — and its main advice
is to use the simplest solution possible. A pipeline is prompt chaining with files in between. The
warning: sequential means sequential. Kim and colleagues tried every multi-agent variant on a
sequential planning task, and every one degraded it, by thirty-nine to seventy percent. If step
three depends on step two, don't fan it out — put it in a pipeline, or in one thread.
**Transition:** But feedback loops are their own pattern — writer and critic.
*(~161 words — well under ceiling; if slide 10 gets cut, add here: "same paper, on a decomposable
task, gave plus eighty point eight percent — task shape decides.")*

### Slide 8 — Pattern 3 · Writer and critic (6:20 · ceiling 210 words) [DIAGRAM]
**Say:** One agent produces, a second reviews adversarially and sends findings back; loop once or
twice, then stop. The key design decision is what the critic can touch. A critic with the test
suite, the schema, and the data can actually check. In the MAST failure taxonomy, task-verification
failures are twenty-three point five percent of all failed traces — verification is where
multi-agent systems break most often, after design and coordination. Two astronomy benchmarks show
why this matters for us: gwBenchmarks found agents that relied on proxy metrics, partial
evaluation, or fabricated results; Stargazer found agents that achieve a good statistical fit but
fail to recover correct physical parameters. A good chi-squared is not a good answer — the critic
needs to run the physics check, not read the summary. A critic isn't free, either: Jamshidi and
colleagues found chaining a reviewer cut the hallucination score from 0.422 to 0.272, while factual
accuracy also slipped from 0.789 to 0.769. Reviewers edit true things too. This is the pattern the
recorded demo shows next, against this deck.
**Transition:** One more shape: isolating agents that work at the same time.
*(~204 words — if short on time here, keep only the gwBenchmarks sentence and drop the Jamshidi
number.)*

### Slide 9 — Pattern 4 · Parallel isolated workers (7:50 · ceiling 210 words) [DIAGRAM]
**Say:** Several agents each get their own git worktree — a second checkout of the same repo, in
its own directory — and work at the same time on separate branches; a merge step at the end brings
them together. This is how the slide-writer and the diagrammer produced this deck at once, without
touching each other's files. Cognition's objection to multi-agent is exactly the failure this
pattern addresses: parallel subagents can't see what the other is doing, so they make conflicting
implicit decisions. Isolation doesn't fix the conflicting decisions — it makes them visible as a
merge conflict instead of a silently corrupted file. Claude Code documents this directly: a
subagent set to worktree isolation gets its own worktree, and writes to the main checkout are
blocked. Osmani's observation, from running several coding agents this way: once generation is
parallel, the bottleneck moves to verification. You end up reviewing more code, faster than you can
read it. Budget for that.
**Transition:** One study ties all four patterns together — task shape decides.
*(~189 words)*

### Slide 10 — Task shape decides (9:20 · ceiling 93 words)
**Say:** Kim and colleagues — Google and MIT — ran two hundred sixty configurations across six
benchmarks, three model families. On a decomposable financial task, centralized multi-agent
improved results by eighty point eight percent. On a sequential planning task, every multi-agent
variant made it worse, by thirty-nine to seventy percent. Same paper, same models — the difference
is task shape. Returns also diminish once the single agent is already strong.
**Transition:** Now let's watch the pipeline itself run.
*(~83 words)*

---

## Segment 3 — Recorded demo: the pipeline that built this talk (10:00–22:00)

Note for this whole segment: nothing runs live. Every image is a screenshot already committed to this repo,
captured by `pipeline/capture.py` before the talk. Ten slides, one screenshot each, 720 s in total. Words run
under the 140-wpm ceiling on purpose, leaving room to read a real number or finding off the screen.

### Slide 11 — Recorded from this repo · the layout (10:00 · 60 s · ceiling 140 words)
**Say:** For the next twelve minutes nothing runs live. Everything on screen is a screenshot of a real, finished run in this repo, captured by a script and placed on these slides by another agent. This is the repo, two levels deep. Agents are the markdown files in `.claude/agents`. `pipeline` is the script that calls them in order. `research`, `slides`, and `diagrams` are what those calls write. `runs` is a receipt for every call. `handout` is what is left over for you.
**Transition:** One of those agent files, up close.
*(~88 words)*

### Slide 12 — An agent is a markdown file (11:00 · 60 s · ceiling 140 words)
**Say:** This is the critic. A name, a description, the tools it may use, the model it runs on, and then instructions in plain English. That is the entire agent. What is not in this file is any orchestration: it does not decide when it runs or what happens to its verdict. The script does. There are nine of these; they are all in the appendix.
**Transition:** Now what those calls leave behind.
*(~71 words)*

### Slide 13 — Already run · one directory per stage (12:00 · 60 s · ceiling 140 words)
**Say:** Every stage that has run is a numbered directory: scaffold check, research fan-out, two outline passes, the write stage, critique and revise rounds, fact-check, notes, Q&A, and the edit that produced these slides. Inside one: the exact prompt sent, the JSON result with tokens and cost, the text the agent returned, its exit code, and its output. Nothing here gets re-run today. Every one already has a receipt.
**Transition:** The first of those: four researchers at once.
*(~76 words)*

### Slide 14 — Already run · the research fan-out (13:00 · 90 s · ceiling 210 words)
**Say:** Four researchers, one topic each, literature, tools, context and cost, astronomy, each with web access. Two hundred seventy tool calls, about six hundred thousand tokens, ten point nine minutes wall-clock because they ran together, against about thirty-eight minutes one after another. Three things to notice. They wrote about seven thousand words of briefs but returned only about eight hundred words of summary; the orchestrator read the briefs from disk on its own schedule. That is the compression from the context slide. Two of them cited the same Anthropic post under two different URLs; the merge caught it. And the brief asked for six hundred to twelve hundred words; all four ran over, and only one said why. Agents drift on soft limits.
**Transition:** Then the write stage, which ran two agents at once in separate worktrees.
*(~135 words)*

### Slide 15 — Already run · stage_write, two worktrees (14:30 · 75 s · ceiling 175 words)
**Say:** This is the loop from the script. For each of two workers, slides and diagrams, it creates a git worktree on its own branch, runs the writer or the diagrammer inside it with a restricted tool list, commits, both in the background, then waits for both. The merge and cleanup follow. The point: this is a shell script. The agents did not decide to spawn each other, to run in parallel, or which files they may touch. The script decided all of that.
**Transition:** And here is what happened when it merged.
*(~91 words)*

### Slide 16 — Already run · the merge conflict (15:45 · 90 s · ceiling 210 words)
**Say:** Both agents finished cleanly and touched only their own files. Perfectly isolated. The collision came from the script's own bookkeeping: both worktrees appended a row to one shared cost log, and the merge stopped on a real conflict. This is the two-agents-one-file failure, caught by git exactly because the work was isolated, not despite it. Nobody had thought of the cost log as the agents' file. The fix was to give each run its own cost row and rebuild the shared report from all of them. I kept this slide because a real failure teaches more than a clean run.
**Transition:** Next, the critic on an earlier version of this deck.
*(~110 words)*

### Slide 17 — Already run · the critic's verdict (17:15 · 90 s · ceiling 210 words)
**Say:** This is the critic's output on an earlier version of this very deck. Seven named criteria scored zero to ten, a PASS or REVISE verdict, REVISE if anything is below seven. The critic reads everything and writes only its own critique; it cannot edit the deck. Read the scores off the screen. Here it found a body claim with no citation and two spoken claims that the repo's own files contradicted. REVISE. [Read one finding aloud, verbatim.] A finding without a slide number and a fix is not a finding. These have both.
**Transition:** And the writer's answer.
*(~97 words)*

### Slide 18 — Already run · the writer's response (18:45 · 75 s · ceiling 175 words)
**Say:** The slide-writer's response, item by item. Every must-fix is marked CHANGED with what changed. Two are marked DECLINED, out of scope, because they belong to the diagrams, a file this agent is not allowed to write, so it flagged them for the diagrammer instead. That refusal is the point: each agent writes only its assigned files and says so when a fix belongs to someone else. The loop, critique then revise then critique again, was run by the script, twice.
**Transition:** Then every citation got checked.
*(~85 words)*

### Slide 19 — Already run · the fact-check (20:00 · 60 s · ceiling 140 words)
**Say:** The fact-checker opened every URL on the Sources slides and checked every number against the source, never against its own memory. Forty-four confirmed, two partial, zero not found, zero fabricated. The two partials were precision issues, a mislabeled baseline and two true numbers from different rows of one paper paired as one. Not invented sources. Its corrected wording is in the deck you are looking at.
**Transition:** Last: the bill.
*(~69 words)*

### Slide 20 — Already run · what it cost (21:00 · 60 s · ceiling 140 words)
**Say:** Nineteen dollars and thirty-two cents for every logged headless stage, outline through the edit that made these slides. The research fan-out ran interactively and is not in this table. Look at the model column: the expensive rows are the writer and the critic on the big model; the outliner, fact-checker, and demo editor ran on a smaller one for a fraction of the cost. That is model tiering; pricing beyond that is Nick's talk. Every stage left a prompt, a return, tokens, and dollars. That is how you audit a pipeline instead of trusting it.
**Transition:** That is the demo. Now the gotchas, starting with what a subagent cannot see.
*(~109 words)*

**If cutting:** drop slides 13 and 18 (the receipts listing and the writer's response) and say their one-line
point while on the neighbouring slide.

---

## Segment 4 — Gotchas and cost (22:00–27:00)

### Slide 21 — Gotcha · Subagents are context-blind (22:00 · ceiling 152 words)
**Say:** A fresh subagent starts with its own system prompt, the message you send it, the project
CLAUDE.md, and the repository state. It does not get your conversation history, the files you've
opened, or anything you said three turns ago. Every time someone tells me a subagent "ignored"
something, this is why. Two habits: write the delegation like you're briefing a contractor who just
walked in — the goal, the files, the constraints, the output path. And tell it what to return: a
summary of at most N words, or a JSON object matching a schema. The researchers in this repo
returned two-hundred-word summaries and wrote the full briefs to disk — the orchestrator's context
stayed small, which was the whole point of the context slide.
**Transition:** Next gotcha: cost.
*(~146 words)*

### Slide 22 — Gotcha · Cost multiplies with agent count (23:05 · ceiling 163 words)
**Say:** Anthropic's own June-2025 post measured agents at about four times a chat's tokens, and
multi-agent at about fifteen times. Their January-2026 guidance says three to ten times, and adds:
don't split sequential phases of one job across agents. Both numbers come from a vendor promoting
multi-agent, which has no reason to overstate its own cost. The mitigation is tiering: route
subagents to cheaper or local models, keep the frontier model on the orchestrator — the thread
making judgment calls. That's first-party guidance in the Claude Code subagent docs. In this repo,
the researcher agent file pins Sonnet, but the logged fan-out run actually ran on the parent model,
because that session hadn't picked up the pin. A fresh session would; this run predates the fix. Nick covered
model selection and pricing this morning; I'm not repeating his tables.
**Transition:** Next: the classic failure — two agents, one file.
*(~161 words)*

### Slide 23 — Gotcha · Isolate the files, centralize the merge (24:15 · ceiling 163 words)
**Say:** Two agents, one file, last write wins, and nobody notices until the tests fail or the deck
has half of each version. Worktrees fix the mechanical half: each agent gets its own checkout, so
the collision becomes a merge conflict, not a silent overwrite — that's the write stage you saw in
the demo. The second half is about who merges. Kim and colleagues measured error amplification:
independent agents with no central check compounded errors seventeen point two times; with
centralized verification, four point four times. So merge in one place, and give that place a way
to check: tests, a schema, a critic with tools. Here the merge is a shell script plus a critic;
yours might be a CI job. Either is fine — what fails is letting each agent decide that its output
is good.
**Transition:** One more gotcha, short: script the orchestration.
*(~163 words)*

### Slide 24 — Gotcha · Script the orchestration (25:25 · ceiling 128 words)
**Say:** Two ways to get four agents running: ask an agent to spawn the others, or write a script
that calls each with a fixed prompt and budget, and logs the return. The first is more impressive;
the second is reproducible — for pipeline and archive work, pick the second. Claude Code's own
workflow feature makes the same choice: the plan lives in a script, and the runtime makes clock and
random-number calls throw an error, so a relaunched run repeats the same calls. NASA's SMD data
strategy asks for reproducibility in agentic workflows, and says plainly there are no established
science-specific guardrails yet.
**Transition:** One more slide on how this fails, then questions.
*(~124 words)*

### Slide 25 — How it actually fails (26:20 · ceiling 93 words) — **CUT #1 CANDIDATE**
**Say:** MAST annotated over sixteen hundred execution traces across seven multi-agent frameworks:
system design failures, forty-four percent; inter-agent misalignment, thirty-two percent; task
verification, twenty-three point five percent. Most failures are design problems — the fixes are
the gotchas we just went through. And the fixes are partial: their interventions gained only about
nine to sixteen points. Multi-agent is engineering, not magic.
**Transition:** Let's open it up for questions.
*(~73 words)*
**If cutting:** skip this slide; while moving from slide 24 to Q&A, say only: "Multi-agent fails in
specific, catalogued ways, not vague risk — the fixes are the gotchas we just covered."

---

## Segment 5 — Q&A and hand-off to BJ (27:00–30:00, mostly open floor)

### Slide 26 — Questions (27:00 · 180 s, ~168 s of it unscripted)
**Say (opening, before the floor):** To close in one breath: go multi-agent for context, not
intelligence — most tasks need one agent. Questions?
*(~17 words)*

**[Open floor — audience questions. Prepared answers below are reference only, not part of the word
budget, since only a subset will actually get asked.]**
- "Does this work with local models?" → Yes for subagents doing bounded reading and extraction; the
  orchestrator is where you want the strongest model. See Nick's session.
- "How much did this deck cost?" → Read the total from `runs/cost-report.md`.
- "What about agent teams in Claude Code?" → Experimental, off by default, interactive-only; docs
  say try subagents first; in plan mode they measured about 7x tokens.
- "Did the pipeline get anything wrong?" → Yes; the fact-checker's report is in `runs/`, and the
  Unverified section of `research/brief.md` lists what the researchers couldn't confirm.

**Say (closing, after the last question):** Many unsupervised agents means you need sandboxing.
That's BJ's talk, next.
*(~12 words)*

---

Slides 27–30 (Sources 1 of 4 through 4 of 4) are reference-only and not presented aloud; leave them
on screen briefly at the very end, or skip straight to them only if someone asks for a citation.
