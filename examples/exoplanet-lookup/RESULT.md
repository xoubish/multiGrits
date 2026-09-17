# Result — exoplanet-lookup

## Command

```
env -u CLAUDECODE claude -p --agent exoplanet-lookup --allowedTools "Read,Bash" \
  --max-budget-usd 1 --output-format json \
  "Look up the exoplanets listed one per line in targets.txt in the NASA Exoplanet Archive and return the table."
```

Run log: `runs/20260917-165001.json`.

## Return

```
NASA Exoplanet Archive, pscomppars

| name | host | period_days | radius_earth | mass_earth | disc_year |
|------|------|-------------|--------------|------------|-----------|
| Kepler-10 b | Kepler-10 | 0.837 | 1.47 | 3.24 | 2011 |
| Kepler-22 b | Kepler-22 | 290 | 2.10 | 9.10 | 2011 |
| TRAPPIST-1 e | TRAPPIST-1 | 6.10 | 0.920 | 0.692 | 2017 |
| HD 209458 b | HD 209458 | 3.52 | 15.6 | 232 | 1999 |
| WASP-12 b | WASP-12 | 1.09 | 22.0 | 467 | 2008 |
| GJ 1214 b | GJ 1214 | 1.58 | 2.73 | 8.41 | 2009 |
| 55 Cnc e | 55 Cnc | 0.737 | 1.88 | 7.99 | 2004 |
| HAT-P-7 b | HAT-P-7 | 2.20 | 16.9 | 585 | 2008 |
| K2-18 b | K2-18 | 32.9 | 2.37 | 8.92 | 2015 |
| Proxima Cen b | Proxima Cen | 11.2 | 1.02 | 1.05 | 2016 |
```

## Numbers

- Model: `claude-haiku-4-5`
- Output tokens: 7,321 (of which 893 thinking tokens; the table itself is ~250 tokens)
- Cost: $0.0751
- Wall time: 82.5 s (`duration_ms`), 42.4 s of that spent in API calls
- Turns: 8 (agent ran a Python/astroquery call via Bash, then formatted the table)

## Verdict

The table itself is well under the 600-token cap stated in the agent's instructions
(roughly 250 tokens), but the agent's *total* output — including internal thinking
tokens and tool-call scaffolding — was 7,321 tokens; the cap should be read as "the table
you show me," not "everything the agent emits," and a future revision should ask the agent
to disable extended thinking or should budget for it explicitly.
