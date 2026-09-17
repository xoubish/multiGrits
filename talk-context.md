# Talk context — single source of truth for every agent

Every agent in this repo reads this file first. If a prompt conflicts with it, this file wins.

## The event

- Workshop: GRITS AI workshop at IPAC (Caltech), two half-days.
- This talk: Day 2, 11:15–11:45, track labeled **Advanced**.
- Speaker: Shooby (Shoubaneh Hemmati), IPAC.
- Title: **Multi-agent workflows**.
- Length: 30 minutes total. The segment table below is binding: 27 minutes of content (1620 s) and 3 minutes of Q&A plus hand-off.

## Audience

IPAC staff: astronomers, science software engineers, data pipeline and archive engineers
(IRSA, NED, NASA Exoplanet Archive, Euclid, Roman, SPHEREx, NEO Surveyor teams).
Day 2 attendees self-selected as advanced. Assume they have used Claude Code at least once
(taught on Day 1). They are skeptical of hype and care about reproducibility, cost, and correctness.

## Full schedule — what neighbors cover. Do not duplicate.

Day 1: Foundations & Everyday Tools
- 10:00 AI at IPAC (Wendy): accounts and limits
- 10:10 Getting Started with AI (Nick, Jessica): hesitation, security, ethics/environment,
  good tasks for AI, ChatGPT/Claude.ai tips, prompt basics, evaluating output accuracy
- 11:00 Command-Line AI Tools (Jessica): intro to Claude Code and other CLI tools
- 11:30 Open Discussion: Workflow Tips & Collaboration (Ricky): agentic AI, Claude Code /
  Codex / OpenCode / Qwen Code, developing with AI across teams

Day 2: Advanced Workflows & Local Models
- 10:00 Model Selection (Nick)
- 10:30 Local LLMs (Nick)
- 11:00 Integration of local LLMs into IDEs (Keto)
- 11:15 **Multi-agent workflows (Shooby) — this talk**
- 11:45 Sandboxing AI (BJ)

## Explicit non-goals for this talk

- Do not explain what an agent is. (Day 1, Ricky.)
- Do not introduce Claude Code, Codex, or OpenCode from scratch. (Day 1, Jessica and Ricky.)
- Do not present model selection or pricing tables. (Nick, Day 2.) You may say
  "put cheap or local models on subagents" and point to Nick's talk.
- Do not cover local LLM setup (Nick) or IDE integration (Keto).
- Do not cover sandboxing or permissions in depth. (BJ, immediately after.)
  End with a one-line hand-off: many unsupervised agents means you need sandboxing.

## Thesis and fixed structure

Thesis: the main reason to go multi-agent is **context**, not intelligence. One agent's
context window fills up and quality degrades, so you delegate to keep the main thread clean.
Parallelism and specialization come second. Most tasks do not need multiple agents, and
coordination overhead is real.

| Segment | Minutes |
|---|---|
| Why, and when not to | 3 |
| Four patterns, one diagram each | 7 |
| Live demo of one pattern | 12 |
| Gotchas and cost | 5 |
| Q&A and hand-off to BJ | 3 |
| **Total** | **30** |

The four patterns:
1. **Fan-out and merge** — orchestrator sends independent subtasks to subagents, merges summaries.
2. **Pipeline** — planner, implementer, tester in sequence; each stage gets a fresh context.
3. **Writer and critic** — one agent produces, another reviews adversarially with tools in hand.
4. **Parallel isolated workers** — several agents on separate git worktrees, merged at the end.

Gotchas to land:
- Subagents do not see your conversation. Pass what they need; have them return summaries, not dumps.
- Cost multiplies with agent count. Cheap or local models on subagents, frontier model on the orchestrator.
- Two agents editing one file is the classic failure. Isolation via worktrees fixes it.
- Prefer deterministic orchestration (a script that calls agents) over agents spawning agents. Reproducibility.
- Unsupervised agents need sandboxing. Hand-off to BJ.

## Learning objectives (what an attendee can do afterwards; the teaching critic scores against these)

1. State when multi-agent helps and when it hurts, with one measured number for each side.
2. Write a subagent as a markdown file and call it from a script, headless, with a budget cap.
3. Pick one of the four patterns for a given task by its shape, and say why in one sentence.
4. Isolate parallel workers and merge with a verification step; recognise the two-agents-one-file failure.
5. Read a run's logs to audit what an agent did, what it returned, and what it cost.

## The meta-demo

This deck is itself built by a multi-agent pipeline in this repo.

Demo mode: **recorded**. Nothing runs live on stage. The 12-minute demo segment walks through terminal
screenshots of the pipeline's real runs and logs, captured from this repo by `pipeline/capture.py` and placed on
ten slides, one screenshot each, by the `demo-editor` agent (`pipeline/run.sh shots`). The slides say plainly that these are captures. The first demo slide shows the repository layout; an appendix
after Sources shows every agent definition file as a screenshot.
Failures that happened during the build (spec contradiction, worktree merge conflict, budget exhaustion) are
shown, not hidden.

Stages:
1. Research fan-out (4 researchers in parallel, web access) → `research/briefs/*.md` → merged `research/brief.md`
2. Outline planner → `slides/outline.md`
3. Slide writer and diagrammer in parallel (separate worktrees) → `slides/deck.md`, `diagrams/*.mmd`
4. Critic loop: three critics in parallel (content, visual design, teaching) → `runs/*/<critic>/critique.md`; revise; repeat
5. Fact-checker with web tools → `runs/*/factcheck.md`
6. Speaker notes, hostile Q&A, handout, cost report

## Style constraints for all outputs

- Every factual claim carries a citation with a URL. Unverifiable claims go under an "Unverified" heading.
- Plain language, no hype. Prefer numbers with sources.
- Slides: Marp markdown. At most 30 presented slides; an appendix after the Sources slides (agent files,
  repo layout) is allowed and not counted. Screenshot slides carry exactly one screenshot each, full width. One idea per slide. At most 40 words of body text per slide.
  Speaker notes go in HTML comments below each slide.
- Diagrams: Mermaid, one per pattern, at most 8 nodes each.
- Astronomy flavor is welcome but secondary.
- Write only to your assigned output path. Never modify another agent's files.
