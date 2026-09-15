---
marp: true
theme: default
paginate: true
style: |
  section { font-size: 28px; }
  h1 { font-size: 44px; }
  footer { font-size: 16px; color: #888; }
  section.sources { font-size: 17px; }
  section.sources h1 { font-size: 30px; }
footer: "Multi-agent workflows · GRITS AI workshop · IPAC"
---

# Multi-agent workflows

**Shooby Hemmati · IPAC**
GRITS AI workshop · Day 2 · Advanced track

<!--
Segment 1, slide 1 of 4. 10 s.
Title card only. Say who you are and one sentence: this is a talk about when a second agent helps, when it does not, and what it costs. Everyone here used Claude Code yesterday, so no definitions.
-->

---

# This deck was built by the pipeline you are about to see

{{diagram:meta-pipeline}}

Four researchers, an outliner, a writer and a diagrammer in parallel worktrees, a critic loop, a fact-checker. Every run is logged in `runs/` [run 001].

<!--
30 s.
Framing: everything on screen for the next 25 minutes came out of one repo and one scripted pipeline. The outline, the slide text, the diagrams, every citation. The logs are committed; you will see them in the demo segment. Point at the diagram left to right: research fan-out, outline, write stage in two worktrees, critic loop, fact-checker, then the notes and handout. I am not claiming the pipeline is better than a person. I am claiming it is inspectable.
-->

---

# Why multi-agent: context, not intelligence

- Answer placed mid-context: accuracy drops over 20 points, below closed-book [Liu 2023]
- GPT-4 claimed 128K tokens; effective 64K on RULER [Hsieh 2024]
- Fix: delegate bounded subtasks; each subagent returns a 1,000–2,000-token summary [Anthropic 2025a]

<!--
80 s. This is the thesis slide.
The reason to go multi-agent is not that two models are smarter than one. It is that one model's context window fills up and its quality degrades long before it hits the token limit.
Liu et al.: in 20-document QA, GPT-3.5 lost over 20 points when the answer sat in the middle of the context, ending below its closed-book score. Hsieh et al. (RULER): the claimed window is not the usable window; GPT-4 advertised 128K, held up to about 64K, and about half of 17 models failed at 32K.
The delegation move: hand a bounded subtask to a fresh agent with a clean window, have it do the reading and tool calls, and return a short summary. Anthropic's own guidance is a 1,000 to 2,000-token return. Your main thread stays small. Parallelism and specialization are real benefits but they come second to this.
Astronomy version: an agent that has read 40 FITS headers into its context is worse at the 41st. Delegate the audit.
-->

---

# When not to: most tasks don't need this

- Equal token budget, reasoning tasks: single agent 0.427 vs multi-agent 0.386 [Tran & Kiela 2026]
- One agent framework cost over 50x a simple retry baseline at similar accuracy [Kapoor 2024]
- Coordination overhead is real. Start with one.

<!--
60 s. The honest case against, stated before the patterns so nobody thinks I am selling.
Tran and Kiela held thinking tokens constant and compared a single agent to five multi-agent designs on FRAMES and MuSiQue. Single agents matched or beat multi-agent in every case; 0.427 vs 0.386 at a 5k budget. Multi-agent only won when 70 percent of the context was masked or corrupted, which is the context argument from the previous slide, not an intelligence argument.
Kapoor et al. did cost-controlled evaluation: simple retry and escalation baselines sit on the Pareto frontier, and one published agent framework cost more than 50 times a simple baseline for similar accuracy.
So: if your task fits in one window and one agent, use one agent. Every extra agent is a coordination cost you pay in tokens, wall-clock, and debugging.
-->

---

# Four patterns, one shape each

1. Fan-out and merge
2. Pipeline
3. Writer and critic
4. Parallel isolated workers

Pick by task shape, not by ambition.

<!--
Segment 2 begins. 20 s transition.
Every multi-agent design I have seen in practice reduces to one of these four shapes, or a composition of them. One diagram each, about 90 seconds each, then one slide that reconciles why some help and some hurt. If running long, skip this slide and say the line while slide 4 is still up.
-->

---

# Pattern 1 · Fan-out and merge

{{diagram:fan-out}}

Independent subtasks in parallel; one place merges. Lead-plus-subagents beat a single agent by 90.2% on breadth research, at about 15x the tokens [Anthropic 2025b]. Wall-clock down 15–40%, tokens up 74% on GAIA [Xu 2026].

<!--
90 s.
Shape: an orchestrator splits work into independent pieces, sends each to its own subagent, and merges the returns in one place. The merge being central matters; we will see why on slide 18.
This is the one case the literature agrees on: breadth-first work over more sources than fit in one window. Anthropic's research system, an Opus lead with Sonnet subagents, beat single-agent Opus by 90.2 percent on their internal eval, and they say it used roughly 15 times the tokens of a chat. Vendor numbers, so treat them as an upper bound on both the gain and the cost.
Independent measurement of the trade: Xu, Tian and Jiang on GAIA got 15 to 40 percent less wall-clock and about 74 percent more tokens. You are buying time with tokens.
Astronomy shape: a target list checked against IRSA, NED, and the Exoplanet Archive in parallel via astroquery, one agent per archive, merged into one table. Independent by construction.
-->

---

# Pattern 2 · Pipeline

{{diagram:pipeline}}

Planner, implementer, tester in sequence. Each stage starts with a fresh context. Use "the simplest solution possible" [Anthropic 2024]. Do not split one sequential job across parallel agents: every variant lost 39–70% [Kim 2026].

<!--
90 s.
Shape: stages in order, each with its own clean context and a file handoff. Planner writes a plan, implementer reads the plan and writes code, tester reads the code and runs it. Nobody carries the whole history. This is the pipeline that built this deck: outline, then write, then critique.
Anthropic's building-effective-agents post lists five composable workflows (prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer) and its main advice is to use the simplest solution possible. A pipeline is prompt chaining with files in between.
The warning: sequential means sequential. Kim et al. tried every multi-agent variant on a sequential planning task and every one of them degraded it by 39 to 70 percent. If step 3 depends on step 2, do not fan it out; put it in a pipeline or in one thread.
-->

---

# Pattern 3 · Writer and critic

{{diagram:writer-critic}}

Give the critic tools: tests, schemas, data. Verification failures are 23.5% of multi-agent failures [Cemri 2025]. Agents "fabricated results" [gwBench 2026] or fit well with wrong physics [Stargazer 2026]. A critic is not free [Jamshidi 2026].

<!--
90 s.
Shape: one agent produces, a second reviews adversarially and sends findings back; loop once or twice, then stop.
The key design decision is what the critic can touch. A critic that only reads the writer's text tends to agree with it. A critic with the test suite, the schema, and the data can actually check. In MAST, the failure taxonomy on slide 20, task verification failures are 23.5 percent of all failed traces; verification is where multi-agent systems break most often after design and coordination.
Two astronomy benchmarks show why this matters for us. gwBenchmarks (gravitational-wave coding tasks) found agents "relied on proxy metrics, partial evaluation, or fabricated results." Stargazer found agents that "achieve a good statistical fit" but "fail to recover correct physical system parameters." A good chi-squared is not a good answer. The critic needs to know the physics or run the check.
And a critic costs something beyond tokens: Jamshidi et al. found chaining a reviewer cut the hallucination score from 0.422 to 0.272 but factual accuracy also slipped from 0.789 to 0.769. Reviewers edit true things too.
This is the pattern we will run live in the demo.
-->

---

# Pattern 4 · Parallel isolated workers

{{diagram:parallel-workers}}

One worktree per agent; merge at the end. Parallel agents "cannot see what the other was doing" [Cognition 2025]; isolation removes the shared-file fight [Claude Code worktrees]. Then "the bottleneck is no longer generation, it's verification" [Osmani].

<!--
90 s.
Shape: several agents each get their own git worktree, work at the same time on separate branches, and a merge step at the end brings them together. This is how the slide writer and the diagrammer produced this deck at the same time without touching each other's files.
Cognition's objection to multi-agent is exactly the failure this pattern addresses: parallel subagents cannot see what the other is doing, so they make conflicting implicit decisions. Isolation does not fix the conflicting decisions; it makes them visible as a merge conflict instead of a silently corrupted file. Claude Code documents this directly: a subagent with isolation set to worktree gets its own worktree and the harness blocks writes to the main checkout. Of the CLIs the researchers surveyed, only Claude Code documents this; Codex, OpenCode, and Gemini do not.
Osmani's observation from running several coding agents this way: once generation is parallel, the bottleneck moves to verification. You end up reviewing more code faster than you can read it. Budget for that.
-->

---

# Task shape decides

Same experiment, 260 configurations, 6 benchmarks [Kim 2026]:

- Decomposable task, centralized multi-agent: **+80.8%**
- Sequential planning task, every multi-agent variant: **−39% to −70%**

<!--
40 s. The reconciling result.
Kim et al. (Google and MIT) is one study that explains both halves of this talk. 260 configurations, 6 benchmarks, 3 model families. On a decomposable financial task, centralized multi-agent improved results by 80.8 percent. On a sequential planning task, every multi-agent variant made it worse, by 39 to 70 percent. Same paper, same models. The difference is the task shape.
They also found returns diminish once the single agent is already strong, and that independent agents amplified errors 17.2x versus 4.4x with a central verifier; that number comes back on slide 18.
Cite the arXiv v3 numbers; the Google blog post says 180 configurations and 80.9 percent from an earlier version.
If running long, drop this slide and say the numbers once during Pattern 2.
-->

---

# Live: the pipeline builds — and checks — this talk

On screen: terminal at the repo root. `ls runs/`

From here on, the demo is the repo, not slides.

<!--
Segment 3, demo. 0:00–1:00 of 12 min.
Switch to the terminal. `ls runs/` shows the numbered stage directories: 000 scaffold verification, 001 research fan-out, 002 and 003 outline, 004 write, then whatever critique runs exist. Each directory has the prompt sent, the JSON return, and a README.
Say: each of these is one agent call with a receipt. We will look at two that already ran, then run one live.
FALLBACK for the whole segment: a second terminal tab is already open at the repo root. If the terminal, network, or any live call fails at any point, switch tabs and narrate the committed logs in runs/000-scaffold-verification/ and runs/001-research-fanout/ using the same minute-by-minute script. Say out loud that you are on the fallback.
-->

---

# Already run · Pattern 1, the research fan-out

On screen: `runs/001-research-fanout/README.md` → `research/briefs/` → `research/brief.md`

Four researchers in parallel: 10.9 min wall-clock vs about 38 min sequential; ~7,100 words of briefs, ~800 words returned [run 001]. The orchestrator merged by hand.

<!--
1:00–4:00.
Open the run-001 README. Point at the table: four researchers (literature, tools, context and cost, astronomy), each with web access, 270 tool calls total, about 602k subagent tokens, 10.9 minutes wall-clock because they ran at once; about 38 minutes if run one after another.
Open research/briefs/ and show the four files. Then open research/brief.md, the merged one. Three observations from the README worth saying aloud:
1. The four researchers wrote about 7,100 words but returned only about 800 words of summaries to the orchestrator, which read the briefs from disk on its own schedule. That is the compression from slide 3 working.
2. Two researchers cited the same Anthropic post under two different URLs. The merge caught it. Independent agents disagree on details, so the merge has to be one place.
3. The instructions said 600 to 1,200 words. One researcher wrote 1,670 and explained why. Agents drift on soft limits; JSON schemas hold better.
The hand merge is the centralizing step from Pattern 1.
-->

---

# Already run · Pattern 4, parallel worktrees

On screen: `pipeline/run.sh`, function `stage_write`; then `git log --oneline`

Two worktrees, `slides` and `diagrams`, launched together, merged, removed. The script owns the loop, not the agents [pipeline/run.sh].

<!--
4:00–6:00.
Open pipeline/run.sh and scroll to stage_write. Walk the loop: for each of `slides` and `diagrams`, `git worktree add` on branch wt/slides or wt/diagrams, cd into it, run the slide-writer or diagrammer agent with a restricted tool list, commit; both in the background, then `wait`; then merge each branch back and remove the worktree.
Then `git log --oneline` to show the two "pipeline: merge ... worktree" commits side by side.
The point to land: this is a shell script. The agents did not decide to spawn each other. The script decided the topology, the order, the tool lists, and the budget cap. That is slide 19 in practice: deterministic orchestration.
If running long, fold this into slide 12's narration as one sentence.
-->

---

# Live now · Pattern 3, the critic vs. this deck

On screen: `pipeline/run.sh critique` → `runs/0NN-critique/critique.md`

A PASS/REVISE verdict against named criteria, including "demo segment: concrete, minute by minute, with a stated fallback". This slide is being graded while you watch.

<!--
6:00–10:00. The one live call.
Run `pipeline/run.sh critique` in the terminal. While it runs (expect one to three minutes), show what is being written: the run directory appears, prompt.md is the exact text sent to the critic, result.json fills in when it returns. Then open critique.md.
Talk through what the critic is: .claude/agents/critic.md, a read-only agent with a fixed rubric. It never edits the deck. It scores named criteria from 1 to 10 and returns PASS or REVISE; REVISE if anything is below 7. Criterion 6 is "demo segment: concrete, minute by minute, with a stated fallback," so this slide is being scored right now.
Read one or two findings aloud, whatever they are. If it says REVISE, good: that is the loop working, and the writer would get these findings as input on the next pass.
FALLBACK: if the call errors, times out, or hits the --max-budget-usd cap (exit code 2), stop the run, say so, and open the critique.md from an earlier dry run in runs/. Read its findings aloud instead of re-running.
-->

---

# What that cost

On screen: `runs/cost-report.md`

Every stage left a receipt: prompt, return, tokens, dollars. Smallest line item: $0.019 for a 9-token reply, because each spawn pays about 4,400 tokens of system prompt [run 000].

<!--
10:00–12:00.
Open runs/cost-report.md, built by pipeline/cost_report.py from runs/cost.tsv, which the script appends to after every stage from the JSON fields total_cost_usd, num_turns, duration_ms, and the token counts. Read the total for the whole talk so far aloud, and the per-stage lines.
Then the smallest receipt: the run-000 smoke test asked the outliner to reply "OK from outliner." Nine output tokens cost $0.019, because the system prompt is about 4,400 cache-creation tokens and every spawn pays that before it does any work. Lesson: there is a fixed per-agent tax; do not fan out trivially small tasks.
The larger point: this is how you audit a multi-agent pipeline instead of trusting it. Prompt in, return out, tokens and dollars per stage, all in git.
If the live critic ran over, compress this to one spoken number.
-->

---

# Gotcha · Subagents are context-blind

A fresh subagent gets: your delegation message, `CLAUDE.md`, a git snapshot.
Not: your conversation, the files you read [Claude Code subagents].

Pass what it needs. Ask for a summary, not a dump.

<!--
Segment 4, gotchas. 65 s.
Mechanics from the Claude Code docs: a subagent starts with its own system prompt, the message you send it, the project CLAUDE.md, and the repository state. It does not get your conversation history, the files you have opened, or anything you said three turns ago. Every time someone tells me a subagent "ignored" something, this is why.
Two habits. First, write the delegation as if to a contractor who just walked in: the goal, the files, the constraints, the output path. In this repo that is what the shared role file and per-topic prompt in runs/001 do. Second, tell it what to return: a summary of at most N words, or a JSON object matching a schema. The researchers here returned 200-word summaries and wrote the full briefs to disk. The orchestrator's context stayed small, which was the whole point of slide 3.
-->

---

# Gotcha · Cost multiplies with agent count

Vendor's own numbers: multi-agent used about 15x a chat's tokens [Anthropic 2025b]; later guidance says 3–10x [Anthropic 2026].

Cheap or local models on subagents, frontier model on the orchestrator [Claude Code subagents]. Pricing: see Nick's talk.

<!--
70 s.
Anthropic's June 2025 post measured agents at about 4x a chat's tokens and multi-agent at about 15x. Their January 2026 guidance says 3 to 10 times and adds: do not split sequential phases of the same work across agents. Both numbers are from the vendor with an interest in selling tokens, so if anything they are not inflated.
The mitigation is tiering. Route subagents to cheaper or local models and keep the frontier model on the orchestrator, which is the thread that has to make judgment calls. This is first-party guidance: the Claude Code docs say to route to faster, cheaper models like Haiku, the built-in Explore agent runs on Haiku, and the researcher agent in this repo pins Sonnet while the orchestrator runs the larger model.
Nick covered model selection and pricing this morning; I am not repeating the tables. Point at his slides for the numbers.
-->

---

# Gotcha · Isolate the files, centralize the merge

Two agents editing one file is the classic failure. Worktrees fix it [Claude Code worktrees].

Independent agents with no central check amplified errors 17.2x; with centralized verification, 4.4x [Kim 2026].

<!--
70 s.
The classic failure: two agents, one file, last write wins, and nobody notices until the tests fail or the deck has half of each version. Worktrees fix the mechanical half: each agent gets its own checkout, so the collision becomes a merge conflict that git shows you rather than a silent overwrite. That is slide 9 and the write stage you saw in the demo.
The second half is about who merges. Kim et al. measured error amplification: when independent agents worked with no central check, errors compounded 17.2x; with centralized verification the figure was 4.4x. Same tasks, same models. So merge in one place, and give that place a way to check: tests, a schema, a critic with tools.
In this repo the merge is a shell script plus a critic. In your pipeline it might be a CI job. Either is fine; what fails is letting each agent decide for itself that its output is good.
-->

---

# Gotcha · Script the orchestration

Prefer a script that calls agents over agents spawning agents.

Claude Code workflows make `Date.now()` and `Math.random()` throw, so a relaunch repeats the same calls [Claude Code workflows]. NASA SMD asks for reproducibility in agentic workflows [NASA SMD 2025].

<!--
55 s.
Two ways to get four agents running. One: ask an agent to spawn the others, and let it decide how many, in what order, with what instructions. Two: write a script that calls each agent with a fixed prompt and a fixed budget, and logs the return. The first is more impressive. The second is reproducible. For pipeline and archive work, pick the second.
Claude Code's own workflow feature makes the same choice: the plan lives in a script, and the runtime makes Date.now() and Math.random() throw so a relaunched run issues the same calls in the same order. The headless `--bare` flag exists for the same reason: identical inputs on every machine.
This matters here specifically. NASA SMD's 2025–2030 data and computing strategy asks for reproducibility practices for agentic workflows and says plainly that there are no established science-specific guardrails or factuality-checking mechanisms yet. We will be asked to show our work.
If running long, compress this into one sentence at the end of slide 18.
-->

---

# How it actually fails

1,600+ traces, 7 frameworks, 14 failure modes [Cemri 2025]:

- System design: 44.2%
- Inter-agent misalignment: 32.3%
- Task verification: 23.5%

Coordination overhead is catalogued, not vague.

<!--
40 s.
MAST, Cemri et al., NeurIPS 2025: they annotated more than 1,600 execution traces across 7 multi-agent frameworks and found 14 failure modes in 3 categories. System design and specification, 44.2 percent. Inter-agent misalignment, 32.3 percent. Task verification, 23.5 percent. The biggest individual modes were step repetition, reasoning-action mismatch, and not knowing when to stop.
Two takeaways. Most failures are design problems, so the fixes are the gotchas we just went through: pass what the subagent needs, isolate the files, script the orchestration, give the critic tools. And the fixes are partial: their prompt and topology interventions gained only about 9 to 16 points. Multi-agent is engineering, not magic.
First slide to cut if running long; say the one-line version while moving to Q&A.
-->

---

# Questions

One line to close: many unsupervised agents means you need sandboxing.

That is the next talk: BJ, on sandboxing AI.

<!--
Segment 5. 180 s, mostly open floor.
Hand-off line: everything in this talk assumes the agents are doing what you asked. Once you have four or ten of them running unattended in worktrees with write access and shell, the question of what they are allowed to touch becomes the main one. That is BJ's talk, starting right after this.
Likely questions and short answers:
- "Does this work with local models?" Yes for subagents doing bounded reading and extraction; the orchestrator is where you want the strongest model. See Nick's session.
- "How much did this deck cost?" Read the total from runs/cost-report.md.
- "What about agent teams in Claude Code?" Experimental, off by default, interactive-only, and the docs say to try subagents first; in plan mode they measured about 7x tokens.
- "Did the pipeline get anything wrong?" Yes; the fact-checker's report is in runs/, and the Unverified section of research/brief.md lists what the researchers could not confirm.
-->

---

<!-- _class: sources -->

# Sources (1 of 3)

- [Liu 2023] https://arxiv.org/abs/2307.03172
- [Hsieh 2024] https://arxiv.org/abs/2404.06654
- [Anthropic 2025a] https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- [Tran & Kiela 2026] https://arxiv.org/abs/2604.02460
- [Kapoor 2024] https://arxiv.org/abs/2407.01502
- [Anthropic 2025b] https://www.anthropic.com/engineering/built-multi-agent-research-system
- [Xu 2026] https://arxiv.org/abs/2608.05791
- [Anthropic 2024] https://www.anthropic.com/research/building-effective-agents

<!--
Reference slide, not presented. Liu 2023: "Lost in the Middle." Hsieh 2024: RULER. Anthropic 2025a: effective context engineering for AI agents. Tran & Kiela 2026: single vs multi-agent at equal token budgets. Kapoor 2024: "AI Agents That Matter" (cost-controlled evaluation). Anthropic 2025b: "How we built our multi-agent research system," June 2025; two researchers cited this post under different slugs, so the fact-checker should confirm this URL resolves. Xu 2026: Xu, Tian, Jiang, parallelism on GAIA. Anthropic 2024: "Building effective agents."
-->

---

<!-- _class: sources -->

# Sources (2 of 3)

- [Kim 2026] https://arxiv.org/abs/2512.08296
- [Cemri 2025] https://arxiv.org/abs/2503.13657
- [gwBench 2026] https://arxiv.org/abs/2605.11269
- [Stargazer 2026] https://arxiv.org/abs/2604.15664
- [Jamshidi 2026] https://arxiv.org/abs/2606.07937
- [Cognition 2025] https://cognition.com/blog/dont-build-multi-agents
- [Osmani] https://addyosmani.com/blog/code-agent-orchestra/
- [Claude Code worktrees] https://code.claude.com/docs/en/worktrees

<!--
Kim 2026: Kim et al., "Towards a science of scaling agent systems," arXiv v3, April 2026; slide numbers are from the arXiv version, not the Google blog. Cemri 2025: MAST, "Why do multi-agent LLM systems fail?", NeurIPS 2025. gwBench 2026: Islam et al., gwBenchmarks. Stargazer 2026: Liu et al., Stargazer. Jamshidi 2026: chained-agent hallucination vs factual accuracy. Cognition 2025: Walden Yan, "Don't build multi-agents." Osmani: Addy Osmani, "Code agent orchestra" (undated on the page as cited). Claude Code worktrees: official docs page.
-->

---

<!-- _class: sources -->

# Sources (3 of 3)

- [Claude Code subagents] https://code.claude.com/docs/en/sub-agents
- [Anthropic 2026] https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them
- [Claude Code workflows] https://code.claude.com/docs/en/workflows
- [NASA SMD 2025] https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf
- [run 000] `runs/000-scaffold-verification/README.md` (this repo)
- [run 001] `runs/001-research-fanout/README.md` (this repo)
- [pipeline/run.sh] `pipeline/run.sh`, function `stage_write` (this repo)

<!--
Claude Code subagents and workflows: official docs pages. Anthropic 2026: "Building multi-agent systems: when and how to use them," January 2026. NASA SMD 2025: Science Mission Directorate Data and Computing Strategy 2025–2030 (PDF). The last three are files in this repository; the repo URL goes here once it is public.
-->
