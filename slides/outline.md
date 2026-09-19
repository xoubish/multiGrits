# Outline — Multi-agent workflows (GRITS AI workshop, IPAC, September 2026)

> Edited 2026-09-18 on the speaker's instruction: entries 1, 2, 24, 26 and 27 reworded, entries 2 and 3 merged, so the posted slides stand
> alone (no other speakers or sessions named) and read in a formal register. Structure and timing unchanged.

Written by the speaker, 2026-09-17. This file is the structure of the talk. Agents draft slides for each entry
below, in this order, and may use more than one slide per entry when the text needs it. Seconds per entry are the
time budget; the sum is 1620 s of content plus 180 s of Q&A. The speaker reads from the slides, so slides carry
full sentences and complete citations, not talking points.

## A. One collaborator, then more (240 s)

1. **Title.** Multi-agent workflows. Shoubaneh Hemmati, Caltech/IPAC. GRITS AI workshop, September 2026. 15 s.
2. **One collaborator, then more.** The reader has used a coding agent such as Claude Code or Codex on real work;
   that is assumed and not re-explained. A single agent already plans, writes, checks, and debugs on request, and
   has been the best collaborator I have had. The obvious next step is a team of them; the talk poses that
   question before answering it. 85 s.
3. *(Merged into entry 2 on 2026-09-18 on the speaker's instruction; kept as a placeholder so later entry numbers
   and the cuts list stay valid.)*
4. **Why do people work in teams?** Many reasons; four bear on agents: limited time (divide the work), limited
   knowledge (bring in expertise), limited attention (hand off what cannot be held in mind at once; Simon 1971),
   and anchored judgment (have someone else check the draft). Cost shapes all four (an Einstein might do the work of
   five; the affordability punchline is spoken, not written; several cheap models run for the price of one frontier model). The social
   reasons, belonging, motivation, accountability, shared risk, do not transfer. For agents, knowledge is the weakest of the four: two copies of one
   model know the same things, though different models or tools can add some expertise. Attention (a fresh context
   window), time (parallel wall-clock), and independence hold. 60 s. *(Reworded 2026-09-18 on the speaker's instruction.)*
5. **So what multi-agent brings, and the thesis.** More context than intelligence. Windows have grown about 500x in six
   years (GPT-3 2K to 1M today). What fills a window: system prompt, tools, messages both ways, and every tool
   result; tool results dominate (this session's /context panel: 580K of 613K); compaction summarizes and loses
   detail; a subagent's transcript stays in its own window. The usable window has not kept pace, and the human analogy is real but shallow (Jarvella 1971; Guo and
   Vosoughi 2025): lost-in-the-middle, RULER, BABILong, NoLiMa.
   What fills a window and how compaction loses detail (lossy summarization, drift, hierarchical folding: Hu et al. 2026).
   Then the honest counterpoint: given enough budget one long-context model beats splitting (Li et al. 2024), a larger
   window does not remove goal drift (Hu et al. 2026), and at
   equal thinking budget a single agent matched or beat multi-agent designs (Tran and Kiela 2026); splitting pays
   only when the work exceeds one strong window, or independence or wall-clock matter. Parallelism and
   specialization are second-order. Most tasks do not need it. 80 s. *(Reworded 2026-09-18 on the speaker's instruction.)*

## B. Architectures (390 s)

6. **Elements of a multi-agent system, one slide each.** In this talk's terms, three choices: who orchestrates
   (script, model, or human; code deciding the order is a workflow, the model deciding is an agent, Anthropic 2024;
   do not say yet that this repo's pipeline is a workflow, that is the reveal in entry 13), isolation (shared or fresh context, shared files or separate worktrees; a Claude
   Code subagent starts fresh), and topology (shared or fresh context, shared files or separate worktrees; a
   Claude Code subagent starts fresh). The literature says coordination architecture or structure (Kim et al. 2026;
   Tran et al. 2025), orchestrator-workers (Anthropic 2024), context or worktree isolation (Anthropic 2026); the
   three-way split is the speaker's own. The topology slide is a grid of three shapes with a figure and an example each: chain (pipeline), fan-out and
   merge, loop (writer and critic). Isolation is spoken as a property any shape can have, not a fourth shape
   (corrected 2026-09-19). 140 s.
   *(Restructured 2026-09-18 on the speaker's instruction; was "Workflows, architectures, and three axes", 60 s.
   The 20 s came from entry 11.)*
7. to 10. *(Folded into entry 6's topology slide on 2026-09-19 on the speaker's instruction: the 2x2 grid carries
   each pattern's figure, shape, and one example, including the archive fan-out, files as hand-off, the critic with
   tools, and `isolation: worktree`. Entry 6 is now 140 s; the remaining 180 s of the former 240 s are unallocated
   and fall to Q&A unless the speaker moves them.)*
11. **How many agents?** One is today's default (Claude Code runs one agent that spawns a subagent occasionally; only Claude Code
    is documented, so name only it). Working systems use one orchestrator and two to five workers (Anthropic's research system,
    MetaGPT's five roles, ChatDev's seven). Past a thousand exists in research (MacNet, Project Sid) and nobody
    uses it for work. There is no published histogram of practitioner usage; say so. 45 s. *(One landscape slide since 2026-09-19: 1, a handful, tens, 1,000+, with a
   "who" column marked as assessment; 20 s taken back from the pool left by entries 7 to 10.)*
12. **You already do this.** Three concrete habits, each tagged with who orchestrates and which pattern it is: ask
    ChatGPT, paste the answer into Claude, ask if it is right (you orchestrate: writer and critic); five Claude Code
    windows each writing one plot's code, a sixth adding them to the paper (you orchestrate: fan-out and merge); one
    colleague's Claude Code writes a tutorial notebook and delivers a repo, another's reviews and delivers comments on
    a branch, yours applies them and opens a PR (your boss orchestrates: a pipeline). Then: when to make it deliberate
    and hand the orchestration to a script or a model. 45 s. *(Rewritten 2026-09-19.)*
## C. Example: this talk was made by agents (480 s, plus 45 s from the segment-B pool = 525 s)

Rebuilt 2026-09-19 on the speaker's instruction into six beats, with the recipe before the failures so the audience
knows what an agent file is before watching one break. Twenty slides. (The `## C.` header itself was lost in an
earlier edit and is restored here.)

**Beat 1, what I gave it (entry 13, 3 slides, 60 s).**

13a. **This deck was built by a workflow in this repo.** Ten agents, a fixed order, every call logged.
     `{{diagram:meta-pipeline}}` full width. 15 s.
13b. **What I gave it: one spec file.** Not a prompt: `talk-context.md`, 122 lines in nine sections, read by every
     agent before its own instructions. Show the nine section headings, not the text, which names colleagues. The
     transferable artifact is the written brief. 25 s.
13c. **The decisions, on the three axes.** Who orchestrates: Claude Code interactively, with me steering, which then
     wrote the script that replaced it. Topology: a chain, with a fan-out inside two stages and a loop inside another.
     Isolation: every agent starts with an empty conversation; the three that run concurrently also get their own
     copy of the repository so they cannot overwrite each other. Define "worktree" in words, not code; the script
     itself is shown two slides later. 20 s.

**Beat 2, the recipe (entry 17, 9 slides, 240 s; the extra 90 s from the segment-B pool).**
Rebuilt in dependency order 2026-09-19 on the speaker's instruction: define a stage first, then show its four
parts in the order they are needed, then the whole pipeline, then the one stage worth opening up, then the
inventory. Nothing is elided; the load-bearing lines are highlighted.

17a. **What a stage is.** The definition the rest of the segment depends on: every stage is an agent file, a
     prompt template, one `claude -p` call, and a run directory of receipts. The next four slides are those four
     things in that order. 25 s.
17b-d. **An agent is a markdown file.** All 38 lines of `reviewer.md` across three slides that share one title;
     the lead line on each says which lines. Highlight `tools` and `model`, then question 5, then the verdict
     line. 25 + 35 + 25 s.
17e. **The prompt for this stage.** `pipeline/prompts/critique.md` in full. The agent file says who the agent is;
     the template says what this stage wants. Eleven templates, `{{RUN_DIR}}` substituted per call. 30 s.
17f. **One headless call per agent.** The exact `claude -p` line, flag by flag, and what the last line does. 30 s.
17g. **The stages, in order.** The `all` case: the whole pipeline, now that a stage is defined. 25 s.
17h. **The write stage, in full.** The one stage that is not a single agent: `stage_write` verbatim apart from
     error handling, the fan-out into three worktrees and the merge. 30 s.
17i. **What the orchestrator wrote.** The inventory as a closer: ten agent files, eleven templates, 418 lines. 15 s.

**Beat 3, attempt one and what broke (entry 14, 4 slides, 75 s).**

14a. **Attempt one, from scratch.** Eleven agents, and the agents wrote the outline too. $29.22, 455 turns. 15 s.
14b. **Failure 1, the spec contradiction.** Run 002; the agent logged the conflict rather than choosing silently. 20 s.
14c. **Failure 2, the shared cost log.** Run 004; write contention on the pipeline's own bookkeeping. Illustration. 20 s.
14d. **Failure 3, the budget cap.** Run 006; exit code 1, not the 2 the docs describe. 20 s.

**Beat 4, the verdict (entry 15, 2 slides, 60 s).**

15a. **What came out.** Every constraint met, and unpresentable. Screenshot of one of its slides. 30 s.
15b. **What came out, and why.** Agents optimize the rubric; taste cannot go in a rubric. Do not rush this. 30 s.

**Beat 5, the reset (entry 16, 3 slides, 60 s).**

16a. **The outline became mine.** One entry verbatim; agents report structural problems, they do not fix them. 20 s.
16b. **Retired and added.** Eleven agents to ten, and the ten do less deciding. 20 s.
16c. **Research, pushed then pulled.** 7,100 words nobody used, against one evidence-finder that sources the claims I
     actually make: 13 of 16 from the old briefs, 4 flagged unsupported. Research against the claims. 20 s.

**Beat 6, attempt two and where it stands (entries 19 and 20, 3 slides, 120 s).**

19.  **Attempt two, run by run.** One table: runs grouped by stage, with a cost column. 45 s.
20a. **What it cost, and the receipts.** $54.31 over 1,018 turns; what every run directory holds; the audit-trail
     checklist (Gao et al. 2026). 45 s.
20b. **One agent, one slide at a time.** The reviewer looks at rendered images; the slide-writer applies one review; a
     hand-written review goes in the same file and the script cannot tell. That is where this deck is. 30 s.

## D. Where it helps and where it does not (210 s)

21. **The one paper that says both.** Kim et al. 2026, Towards a science of scaling agent systems: centralized
    multi-agent improved a decomposable task by about 80% and every multi-agent variant made a sequential planning
    task 39 to 70% worse, in the same experiment. Task shape decides. 60 s. *(One slide since 2026-09-19: both halves of the result as bullets, plus the task-shape inference flagged as the speaker's.)*

22. **The rest of the evidence, both sides.** For: Anthropic's research system, lead plus subagents, about 90% better
    than a single agent on breadth research, at about 15 times the tokens. Against: Tran & Kiela 2026, at an equal
    thinking budget a single agent matched or beat five multi-agent designs; Kapoor et al. 2024, one agent framework
    cost over 50 times a simple baseline at similar accuracy. Complete citations on the slide. 75 s. *(One slide since 2026-09-19: in-favor and the two againsts as three bullets with compact citations.)*

23. **How it fails.** MAST (Cemri et al. 2025): 1,600 traces, 14 failure modes; most are specification and
    coordination, not model errors. Then the three practical ones: subagents do not see your conversation, so pass
    what they need and ask for a summary; two agents on one file; agents spawning agents instead of a script
    calling agents, which costs you reproducibility. 75 s.

## E. Setting it up: simple and difficult (300 s)

Decisions of 2026-09-17: entry 21 lost its unsupported "diminishing returns" sentence; entry 11 names Claude Code
only; attempt one is described as eleven agent files (fourteen roles if the four researchers and three critics are
counted separately).

24. **A simple example to run first.** *(Three slides since 2026-09-19, was five: the agent file complete on one
    slide with highlights, the command, then all ten result rows.)* One read-only subagent: given ten target names, query one archive with
    astroquery and return a table under 2,000 tokens. Show the agent file, the one command, and the real result from
    `examples/*/RESULT.md`: what it returned, what it cost, how long it took. 180 s.
25. **Folded into 26 on 2026-09-17** (it repeated entries 13 and 26); its minute went to entry 24. 0 s.
26. **Cost, and when it is worth it.** Multi-agent runs 3 to 15 times a single chat's tokens (Anthropic's own
    figures). Cheap or local models on subagents, the frontier model on the orchestrator; pricing is covered elsewhere in the workshop and not repeated here.
    The difficult example is this pipeline. Checklist for "worth it": exceeds one window, independent pieces,
    needs verification, can afford the multiple. Otherwise one agent. 60 s.
27. **Close.** More context than intelligence. Most tasks need one agent. First step Monday: pull one bounded, read-only
    task into its own agent file, run it once headless, check the return is short. Hand-off in one line: many
    unsupervised agents require sandboxing, which is the subject of the following session. 60 s.

## Q&A (180 s)

Open floor. Likely questions are in `handout/qa.md`.

## Sources (not presented)

Every URL cited on a slide, one per line, grouped by segment.

## Cuts if running long

1. Entry 19 (attempt two step by step): say "every stage is in runs/, one line each in the handout" on entry 20.
2. Entry 22 (the rest of the evidence): keep Kim et al. only.
3. Entry 11 (how many agents): one spoken sentence on entry 6.
4. Entry 3: fold into entry 4.
