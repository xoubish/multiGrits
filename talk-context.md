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

## Thesis

The main reason to go multi-agent is **context**, not intelligence. Two copies of one model know the same things;
adding agents adds attention (a fresh context window), time (parallel wall-clock), and independence (a reviewer
not anchored to the draft). Most tasks do not need multiple agents, and coordination overhead is real.

## Structure: the outline is the spec

`slides/outline.md` is written by the speaker, by hand, and is the single source of structure: slide order,
per-slide message, time budgets, and the cuts list. No agent generates or reorders it. Agents draft slides,
diagrams, evidence, notes, and reviews *for* that outline. If an agent finds a structural problem, it reports it
to the speaker (a `## For the speaker` section) and does not fix it.

Why: the first pipeline in this repo generated its own outline from a research brief and a segment table, then
optimised a deck against a rubric of citations, word counts, and seconds. Every constraint was met and the deck was
a wall of cited percentages nobody wanted to present. Agents optimise what you measure; taste has to be a human's.
That outcome is part of the talk.

The four patterns the talk names, in the outline's order:
1. **Fan-out and merge** — orchestrator sends independent subtasks to subagents, merges summaries.
2. **Pipeline** — planner, implementer, tester in sequence; each stage gets a fresh context.
3. **Writer and critic** — one agent produces, another reviews adversarially with tools in hand.
4. **Parallel isolated workers** — several agents on separate git worktrees, merged at the end.

Points to weave in where the outline places them (not a segment of their own):
- Subagents do not see your conversation. Pass what they need; have them return summaries, not dumps.
- Cost multiplies with agent count. Cheap or local models on subagents, frontier model on the orchestrator.
- Two agents editing one file is the classic failure. Isolation via worktrees fixes it.
- Prefer deterministic orchestration (a script that calls agents) over agents spawning agents.
- Unsupervised agents need sandboxing. One-line hand-off to BJ at the end.

## What an attendee can do afterwards

1. Say when multi-agent helps and when it hurts, with one number for each side.
2. Write a subagent as a markdown file and call it from a script, headless, with a budget cap.
3. Pick one of the four patterns for a task by its shape, in one sentence.
4. Recognise the two-agents-one-file failure and know that worktrees plus a verified merge fix it.

## The meta-example

This deck's slides, diagrams, evidence, notes, and Q&A are drafted by the agents in `.claude/agents/`, called in a
fixed order by `pipeline/run.sh`, with every call logged under `runs/`. The talk tells this as a recipe, so that
someone who sees only the slides can replicate the workflow: the first attempt from scratch and why it failed (a
spec contradiction, a merge conflict on a shared log, a budget cap hit mid-revision, and a deck that met every
constraint and was not presentable), then the hand-written outline and each stage of the second attempt in order,
with the real files as text: the folder layout, one complete agent file, one outline entry, the exact headless
command, the stage order, and what each cost. The source for all of it is `research/build-log.md`, written by the
chronicler from the run logs; slides copy it and never reconstruct history themselves. No screenshot walkthrough.
Nothing runs live unless the speaker decides otherwise in the outline.

Stages: `evidence` (one source per claim in the outline) → `example` (build and run the take-home example) →
`chronicle` (the build log so far) → `write` (slide-writer, diagrammer and illustrator in parallel worktrees) → `loop` (one reviewer, then revise) → `chronicle` again and one `revise` to place it → `factcheck` →
`notes` and `qa` in parallel → `cost`.

## Style constraints for all outputs

- The slides are posted afterwards and must stand alone for a reader who was not in the room. No references to
  other sessions, other speakers by name, "yesterday", "this morning", "Day 1", "Day 2", or "next". Venue and
  date appear once, on the title slide and in the footer, as "GRITS AI workshop, IPAC, September 2026".
- Register: formal written prose that also reads well aloud. Complete declarative sentences; no colloquial
  fragments ("Do this. Check that."), no chatty asides ("So I reset."), no second-person address of the room.
  Rhetorical questions only as slide titles. First person is allowed where the build narrative needs it (what the
  speaker did and decided), and nowhere else.
- The speaker reads from the slides. Slides are complete: full sentences that read well aloud.
- Marp markdown. One or more slides per outline entry, in outline order; split rather than shrink; continuation
  slides carry their own subtitle, never a "(2)" suffix. The repository URL appears on the title and Sources slides. At most about
  60 words of body per slide so it stays readable at 24px from the back. Graphics welcome alongside text.
- Citations appear on the slide in full: authors and year, title, venue or arXiv id, and the finding in plain
  words with its number and condition. URLs on the Sources slides. The fact-checker verifies every one.
- Speaker notes in an HTML comment under each slide carry the time budget and the transition, not the content.
- Diagrams: Mermaid, at most 7 nodes, shared theme, legible when sharing a slide with three sentences.
- Illustrations: at most five in the deck, flat two-colour SVG, no text inside, for moments not mechanisms.
- Code on slides is real text from this repo or `examples/`, copied exactly.
- Plain language, no hype. Astronomy examples come from the speaker's outline.
- Write only to your assigned output path. Never modify another agent's files. Never modify `slides/outline.md`.
