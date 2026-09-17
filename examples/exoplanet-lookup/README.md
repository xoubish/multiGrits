# exoplanet-lookup

A single read-only subagent that takes ten confirmed exoplanet names and returns their
orbital period, radius, mass, and discovery year from the NASA Exoplanet Archive, as one
compact table. This is the "try this Monday" example: one bounded task, one agent file, one
headless call, a budget cap.

## Prerequisites

- Claude Code CLI (`claude`) installed and logged in.
- Network access to the NASA Exoplanet Archive (queried via `astroquery`).
- Python 3 with `astroquery` installed (`pip install astroquery`).

## Files

- `targets.txt` — ten real, published exoplanet names.
- `.claude/agents/exoplanet-lookup.md` — the subagent: frontmatter (name, description,
  tools, model) plus plain-English instructions, under 25 lines.
- `run.sh` — the exact headless call the deck teaches, writing JSON to `runs/`.

## Run it

```
bash run.sh
```

This runs, from inside this directory:

```
env -u CLAUDECODE claude -p --agent exoplanet-lookup --allowedTools "Read,Bash" \
  --max-budget-usd 1 --output-format json "<prompt>"
```

`env -u CLAUDECODE` is needed if you run this from inside another Claude Code session.

## What a good return looks like

A single markdown table, one row per input name (`name | host | period_days | radius_earth |
mass_earth | disc_year`), under 600 tokens, no extra prose. See `RESULT.md` for the actual
return, cost, and wall time from a real run.
