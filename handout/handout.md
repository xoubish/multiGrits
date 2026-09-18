# Multi-agent workflows — handout

GRITS AI workshop, Day 2, advanced track. Shooby Hemmati, IPAC. This page is for someone who
was not in the room. The thesis: multi-agent buys you **context, not intelligence** — a fresh
context window, parallel wall-clock, and an independent reviewer. Two copies of the same model
know exactly the same things. Most tasks do not need more than one agent.

## The four patterns, and the task shape that calls for each

1. **Fan-out and merge** — independent pieces, one merge point. Use when you have several
   independent lookups or subtasks that need combining into one output (e.g., one agent per
   archive — IRSA, NED, the Exoplanet Archive — merged into one table).
2. **Pipeline** — sequential stages, each with a fresh context, files as the hand-off. Use when
   the work must happen in order and each stage benefits from starting clean (planner →
   implementer → tester).
3. **Writer and critic** — one agent produces, another reviews adversarially with tools in hand
   (tests, data, schema), for a fixed number of rounds. Use when the output needs an independent
   check, not just a re-read by its own author. A critic without tools just rubber-stamps.
4. **Parallel isolated workers** — fan-out with the isolation choice made explicit: one git
   worktree per agent, merged at the end. Use when several workers would otherwise edit the same
   files — this is what prevents two agents, one file, last write wins.

## The recipe

**An agent is a markdown file.** Frontmatter, then plain-English instructions. Skeleton (shape
matches `.claude/agents/reviewer.md` and `examples/exoplanet-lookup/.claude/agents/exoplanet-lookup.md`
in this repo):

```
---
name: <agent-name>
description: <when to use this agent, one or two sentences>
tools: <comma-separated list, e.g. Read, Bash>
model: <haiku | sonnet | opus | inherit>
---
You are given <what it is handed>.

Do this:
1. <step>
2. <step>

Return only <the exact shape of the reply, and a token cap>. Say "not found" rather than
invent a number.
```

**A script calls it headless, with a budget cap.** This is the exact command from
`examples/exoplanet-lookup/README.md` and `RESULT.md`:

```
env -u CLAUDECODE claude -p --agent exoplanet-lookup --allowedTools "Read,Bash" \
  --max-budget-usd 1 --output-format json \
  "Look up the exoplanets listed one per line in targets.txt in the NASA Exoplanet Archive and return the table."
```

**The one check to run on the return** (from `examples/exoplanet-lookup/RESULT.md`): does the
reply start with the one-line source header and a single compact table under the stated token
cap, with "not found" for any name that had no match — not an invented number? In the real run,
the visible table was ~250 tokens against a 600-token cap, but total output including thinking
was 7,321 tokens — so the check is on what the reply *shows* you, not on everything the agent
emitted internally.

## First thing to try

Pull one bounded, read-only task into its own agent file. Run it once, headless, with a budget
cap. Check that the return is short.

## Where to find it

- The runnable example: `examples/exoplanet-lookup/` in this repo (agent file, `targets.txt`,
  `run.sh`, and the real result in `RESULT.md`).
- This repo (multiGrits): the pipeline that built this talk — `.claude/agents/`,
  `pipeline/run.sh`, `research/build-log.md`, and one `runs/NNN-<stage>/` directory per agent
  call, each with the exact prompt sent, the full JSON result, and a cost row.

## Links (three)

- Anthropic (Dec 2024), *Building effective agents* — https://www.anthropic.com/research/building-effective-agents
- Anthropic (2026), *Subagents*, Claude Code docs — https://code.claude.com/docs/en/sub-agents
- Kim et al. (2026), *Towards a Science of Scaling Agent Systems*, arXiv 2512.08296 —
  https://arxiv.org/abs/2512.08296
