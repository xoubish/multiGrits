# Multi-agent workflows — handout

Shooby Hemmati, IPAC. GRITS AI workshop, Day 2, advanced track. Multi-agent buys you **context, not
intelligence**: a fresh context window, parallel wall-clock, and a reviewer not anchored to the
draft. Two copies of the same model already know the same things. Most tasks do not need more than
one agent.

## The four patterns, and when each one fits

1. **Fan-out and merge** — independent subtasks run in parallel, one merge point collects their
   summaries. Use when the work splits into pieces that don't depend on each other: one agent per
   archive (IRSA, NED, the Exoplanet Archive) for a target list, merged into one table.
2. **Pipeline** — sequential stages, each with a fresh context, files as the hand-off. Use when
   each step depends on the last and you want no stage inheriting the previous stage's clutter:
   planner → implementer → tester.
3. **Writer and critic** — one agent produces, a second reviews adversarially with tools in hand
   (tests, data, schema), for a fixed number of rounds. Use when the output needs an independent
   check, not just the same agent re-reading its own work. A critic without tools rubber-stamps.
4. **Parallel isolated workers** — fan-out with the isolation choice made explicit: one git
   worktree per agent, merged at the end. Use when independent pieces would otherwise write to the
   same files — this is what prevents two agents on one file, last write wins.

## The recipe, literally, from `examples/exoplanet-lookup/`

**1. Subagent frontmatter skeleton** (from `.claude/agents/exoplanet-lookup.md`):

```
---
name: exoplanet-lookup
description: Read-only lookup of confirmed exoplanet parameters from the NASA Exoplanet Archive for a given list of planet names. Returns a compact table, not a dump. Use for quick target-list checks.
tools: Read, Bash
model: haiku
---
```
Below the frontmatter: plain-English instructions (what to read, what to do, what to return), and
an explicit return-format section with a token cap and an instruction to say "not found" rather
than invent a number.

**2. The headless command, with a budget cap** (from `examples/exoplanet-lookup/run.sh`):

```
env -u CLAUDECODE claude -p \
  --agent exoplanet-lookup \
  --allowedTools "Read,Bash" \
  --max-budget-usd 1 \
  --output-format json \
  "Look up the exoplanets listed one per line in targets.txt in the NASA Exoplanet Archive and return the table." \
  > "$OUT"
```
`env -u CLAUDECODE` matters if you're already inside a Claude Code session. `--max-budget-usd 1`
is the cap; `--output-format json` returns the cost and token counts along with the answer.

**3. The one check to run on the return** (from `examples/exoplanet-lookup/README.md` and
`RESULT.md`): the reply should be a single compact markdown table, one row per input name, under
600 tokens, with no prose before or after it except a one-line source header. On the real run this
returned in 82.5 s for $0.0751 on Haiku — but total output including internal thinking tokens was
7,321, well over the 600-token line. **The check is on the table you're shown, not on the agent's
total token spend** — if you need to bound the whole call, budget for that separately with
`--max-budget-usd`, not the return-format instruction alone.

## The first thing to try, Monday

Pull one bounded, read-only task into its own agent file. Run it once, headless, with a budget cap.
Check that the return is short. That's it — that's the whole first step. Many unsupervised agents
means you need sandboxing; that's the next talk in this workshop, not this one.

## Where to find it

- The working example: `examples/exoplanet-lookup/` in this repo (agent file, `run.sh`, `README.md`,
  and the real result in `RESULT.md`).
- This talk's own build, as a recipe: `.claude/agents/` (ten subagent files), `pipeline/run.sh`
  (the orchestrating script), and `runs/` (one directory per agent call — exact prompt, full JSON
  result, return text, and a cost row for every run, so the pipeline can be audited rather than
  trusted).

## Three links

- Claude Code, Subagents (frontmatter reference): https://code.claude.com/docs/en/sub-agents
- Claude Code, Run parallel sessions with worktrees (pattern 4's isolation mechanism):
  https://code.claude.com/docs/en/worktrees
- Anthropic, Building effective agents (the workflow-pattern taxonomy this talk builds on):
  https://www.anthropic.com/research/building-effective-agents
