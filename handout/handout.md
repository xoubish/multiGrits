# Multi-agent workflows — handout
> **Stale as of 2026-09-19.** This handout was written by `notes-writer` for the 58-slide draft of
> 2026-09-18. It still describes *four* patterns; the deck now presents three shapes (chain, fan-out,
> loop) with isolation as a property rather than a fourth shape, and it is 30 slides. The recipe and
> the `examples/exoplanet-lookup/` walkthrough below are still accurate. Regenerate with
> `pipeline/run.sh notes` once the deck is final.

Shoubaneh Hemmati, Caltech/IPAC. GRITS AI workshop, September 2026. Multi-agent buys **more context than
intelligence**: a fresh context window, parallel wall-clock, and a reviewer not anchored to the
draft. Two copies of the same model already know the same things. Most tasks do not need more than
one agent.

## The four patterns, and the task shape that calls for each

1. **Fan-out and merge** — independent subtasks run in parallel to one merge point. Use when the
   work splits into pieces that do not depend on each other: one agent per archive (IRSA, NED, the
   Exoplanet Archive) for a target list, merged into one table.
2. **Pipeline** — sequential stages, each with a fresh context, files as the hand-off. Use when
   each step depends on the last and no stage should inherit the previous stage's clutter: a
   planner, then an implementer, then a tester.
3. **Writer and critic** — one agent produces, a second reviews adversarially with tools in hand
   (tests, data, schema), for a fixed number of rounds set by the script. Use when the output needs
   an independent check, not just the same agent re-reading its own draft. A critic without tools
   rubber-stamps.
4. **Parallel isolated workers** — fan-out with the isolation choice made explicit: one git
   worktree per agent, merged at the end. Use when independent pieces would otherwise write to the
   same files; this is what stops two agents on one file, last write wins.

## The recipe, literally, from `examples/exoplanet-lookup/`

**1. Subagent frontmatter skeleton** (`.claude/agents/exoplanet-lookup.md`, lines 1–6):

```
---
name: exoplanet-lookup
description: Read-only lookup of confirmed exoplanet parameters from the NASA Exoplanet Archive for a given list of planet names. Returns a compact table, not a dump. Use for quick target-list checks.
tools: Read, Bash
model: haiku
---
```

Below the frontmatter: plain-English instructions (what to read, what to do, what to return), and
a return-format section with a token cap and an instruction to say "not found" rather than invent
a number.

**2. The headless command, with a budget cap** (the exact call recorded in
`examples/exoplanet-lookup/RESULT.md`):

```
env -u CLAUDECODE claude -p --agent exoplanet-lookup --allowedTools "Read,Bash" \
  --max-budget-usd 1 --output-format json \
  "Look up the exoplanets listed one per line in targets.txt in the NASA Exoplanet Archive and return the table."
```

`env -u CLAUDECODE` matters if you are already inside a Claude Code session. `--max-budget-usd 1`
is the cap. `--output-format json` returns the cost and token counts along with the answer.

**3. The one check to run on the return** (`examples/exoplanet-lookup/README.md`, "What a good
return looks like"): the reply should be a single compact markdown table, one row per input name
(`name | host | period_days | radius_earth | mass_earth | disc_year`), under 600 tokens, with no
prose before or after it except a one-line source header. On the real run recorded in `RESULT.md`
this held: the table itself was about 250 tokens, returned in 82.5 s for $0.0751 on
`claude-haiku-4-5`. One caveat from that same file: the agent's *total* output, including internal
thinking tokens, was 7,321 — the check above is on the table you are shown, not on everything the
agent emits; budget for the whole call separately if that matters.

## The first thing to try, from the closing slide

"A first step is to pull one bounded, read-only task into its own agent file, run it once headless
with a budget cap, and check that the return is short." Many unsupervised agents need sandboxing;
that is a separate subject, not covered here.

## Where to find it

- The working example: `examples/exoplanet-lookup/` — the agent file, `run.sh`, `README.md`, and
  the real result in `RESULT.md`.
- This talk's own build, as a recipe: `.claude/agents/` (ten subagent files), `pipeline/run.sh`
  (the orchestrating script), and `runs/` (one directory per agent call — exact prompt, full JSON
  result, return text, and a cost row for every run).
- This repository's origin remote, as configured in `.git/config`: `https://github.com/xoubish/multiGrits`.

## Three links

- Claude Code, Subagents (frontmatter reference): https://code.claude.com/docs/en/sub-agents
- Claude Code, Run parallel sessions with worktrees (pattern 4's isolation mechanism):
  https://code.claude.com/docs/en/worktrees
- Anthropic, Building effective agents (the workflow-pattern taxonomy this talk builds on):
  https://www.anthropic.com/research/building-effective-agents
