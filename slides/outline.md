# Outline — Multi-agent workflows (GRITS Day 2, 11:15–11:45)

Written by the speaker, 2026-09-17. This file is the structure of the talk. Agents draft slides for each entry
below, in this order, and may use more than one slide per entry when the text needs it. Seconds per entry are the
time budget; the sum is 1620 s of content plus 180 s of Q&A. The speaker reads from the slides, so slides carry
full sentences and complete citations, not talking points.

## A. One collaborator, then more (240 s)

1. **Title.** Multi-agent workflows. Shooby Hemmati, IPAC. GRITS Day 2, advanced track. 15 s.
2. **Yesterday you got one collaborator.** One-line recap only: on Day 1 you learned what an agent is and used
   Claude Code or Codex. Do not re-explain. Today is about when a second one is worth having. 45 s.
3. **Why not more than one?** These agents have been the best collaborator I have had: do this, check that, write
   the code, debug it. The obvious next thought is a team of them. Pose the question honestly; do not answer yet. 60 s.
4. **Why do people work in teams?** Three reasons: limited time, limited knowledge, limited attention. For agents
   only two of the three hold. Two copies of the same model know exactly the same things, so adding agents adds no
   expertise. It adds attention (a fresh context window) and time (parallel wall-clock), plus one thing people
   also get from a colleague: independence, a reviewer not anchored to the draft. 60 s.
5. **So what multi-agent brings, and the thesis.** Context, not intelligence. One agent's window fills and its
   quality degrades before it hits the token limit (lost-in-the-middle, RULER). Parallelism and specialization are
   second-order. Most tasks do not need it. 60 s.

## B. Architectures (390 s)

6. **Workflows, architectures, and three axes.** The words are used loosely. Anthropic's "Building effective
   agents" separates workflows (code decides the order of calls) from agents (the model decides) and lists five
   workflow patterns: prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer. Any
   multi-agent design is three choices: topology, who orchestrates (script, model, or human), and isolation (shared
   or fresh context, shared files or separate worktrees). 60 s.
7. **Pattern 1, fan-out and merge.** {{diagram:fan-out}} Independent pieces, one merge point. Astronomy: one agent
   per archive (IRSA, NED, Exoplanet Archive) for a target list, merged into one table. 60 s.
8. **Pattern 2, pipeline.** {{diagram:pipeline}} Sequential steps, each with a fresh context, files as the hand-off.
   Planner, implementer, tester. 60 s.
9. **Pattern 3, writer and critic.** {{diagram:writer-critic}} One produces, one reviews adversarially with tools in
   hand (tests, data, schema), the loop runs a fixed number of rounds. A critic without tools rubber-stamps. 60 s.
10. **Pattern 4, parallel isolated workers.** {{diagram:parallel-workers}} Not a fourth topology: fan-out with the
    isolation choice made explicit. One git worktree per agent, merged at the end. The failure it prevents: two
    agents, one file, last write wins. 60 s.
11. **How many agents?** One is today's default (Claude Code, Codex, Cursor run one agent that spawns a subagent
    occasionally). Working systems use one orchestrator and two to five workers (Anthropic's research system,
    MetaGPT's five roles, ChatDev's seven). Past a thousand exists in research (MacNet, Project Sid) and nobody
    uses it for work. There is no published histogram of practitioner usage; say so. 45 s.
12. **You already do this.** Running the same task in Claude Code and Codex and comparing is writer-and-critic with
    you as orchestrator. Two terminals on two tasks is fan-out. Claude Code spawns an Explore subagent without
    asking. The question is when to make it deliberate, and when to replace yourself with a script. 45 s.

## C. Example: this talk was made by agents (480 s)

Source for every entry in this segment: `research/build-log.md`. Copy file text and numbers exactly.

13. **This deck was built by the pipeline in this repo.** {{diagram:meta-pipeline}} The repo layout as text:
    talk-context.md, slides/outline.md, .claude/agents/, pipeline/run.sh, research/, diagrams/, runs/. 45 s.
14. **Attempt one, from scratch.** Eleven agents: four researchers in parallel, an outliner, a slide-writer and
    diagrammer in worktrees, three critics, a fact-checker, notes, Q&A, a demo editor. What it cost. Three
    failures, with run numbers: a spec contradiction the outliner caught, a merge conflict when both worktrees
    appended to one cost log, a revision stopped by its budget cap. 75 s.
15. **What came out.** The screenshot `shots/first-deck-gotcha.png` (and `first-deck-thesis.png` if a second slide
    is needed). Every constraint was met: citations, word counts, timing to the second. It was a wall of cited
    percentages and a twelve-minute demo of screenshots of README files. Why: the critics scored what could be
    counted, and nobody scored whether it was a talk. Agents optimize the rubric you write. 60 s.
16. **The reset.** I wrote this outline by hand. Retired: the outliner, the researchers, the three critics, the demo
    editor. Added: an evidence-finder that sources only the claims I make, an example-builder that runs the
    take-home example for real, one reviewer that sits in the audience, a chronicler that records the build, an
    illustrator. 60 s.
17. **Recipe, part one: an agent is a markdown file.** `.claude/agents/reviewer.md` verbatim (trimmed to fit):
    frontmatter with name, description, tools, model; then instructions in plain English. The other nine files are
    in the repo and the handout. 60 s.
18. **Recipe, part two: a script calls it headless with a budget.** The `claude -p` line from `pipeline/run.sh`
    verbatim, then the stage order: evidence, example, chronicle, write (three worktrees), review loop, chronicle,
    fact-check, notes and Q&A in parallel, cost. Which of the four patterns each stage is. 60 s.
19. **Attempt two, step by step.** Each run from 015 onward: stage, agent, model, what it read, what it wrote, cost.
    One line per run, from the build log. 75 s.
20. **What it cost, and the receipts.** Both attempts, in dollars. Every call left runs/NNN-stage/ with the prompt
    sent, the JSON result, the return text, and a cost row. That is how you audit a pipeline instead of trusting it. 45 s.

## D. Where it helps and where it does not (210 s)

21. **The one paper that says both.** Kim et al. 2026, Towards a science of scaling agent systems: centralized
    multi-agent improved a decomposable task by about 80% and every multi-agent variant made a sequential planning
    task 39 to 70% worse, in the same experiment. Task shape decides. Diminishing returns once the single agent is
    already strong. 60 s.
22. **The rest of the evidence, both sides.** For: Anthropic's research system, lead plus subagents, about 90% better
    than a single agent on breadth research, at about 15 times the tokens. Against: Tran & Kiela 2026, at an equal
    thinking budget a single agent matched or beat five multi-agent designs; Kapoor et al. 2024, one agent framework
    cost over 50 times a simple baseline at similar accuracy. Complete citations on the slide. 75 s.
23. **How it fails.** MAST (Cemri et al. 2025): 1,600 traces, 14 failure modes; most are specification and
    coordination, not model errors. Then the three practical ones: subagents do not see your conversation, so pass
    what they need and ask for a summary; two agents on one file; agents spawning agents instead of a script
    calling agents, which costs you reproducibility. 75 s.

## E. Setting it up: simple and difficult (300 s)

24. **Simple example you can run Monday.** One read-only subagent: given ten target names, query one archive with
    astroquery and return a table under 2,000 tokens. Show the agent file, the one command, and the real result from
    `examples/*/RESULT.md`: what it returned, what it cost, how long it took. 120 s.
25. **Difficult example.** This pipeline: ten agents, a script that owns order, loop, and isolation, logs for every
    call. When to bother: when the work exceeds one context window, the pieces are independent, and the output
    needs an independent check. Otherwise one agent. 60 s.
26. **Cost, and when it is worth it.** Multi-agent runs 3 to 15 times a single chat's tokens (Anthropic's own
    figures). Cheap or local models on subagents, the frontier model on the orchestrator; pricing is Nick's talk.
    Checklist for "worth it": exceeds one window, independent pieces, needs verification, can afford the multiple. 60 s.
27. **Close.** Context, not intelligence. Most tasks need one agent. First step Monday: pull one bounded, read-only
    task into its own agent file, run it once headless, check the return is short. Hand-off in one line: many
    unsupervised agents means you need sandboxing, and that is BJ, next. 60 s.

## Q&A (180 s)

Open floor. Likely questions are in `handout/qa.md`.

## Sources (not presented)

Every URL cited on a slide, one per line, grouped by segment.

## Cuts if running long

1. Entry 19 (attempt two step by step): say "every stage is in runs/, one line each in the handout" on entry 20.
2. Entry 22 (the rest of the evidence): keep Kim et al. only.
3. Entry 11 (how many agents): one spoken sentence on entry 6.
4. Entry 3: fold into entry 4.
