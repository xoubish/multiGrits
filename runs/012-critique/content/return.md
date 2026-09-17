Written to `runs/012-critique/content/critique.md`. No other file touched.

**Verdict: REVISE** — criteria 3 (Citations) and 6 (Demo) score 6; the other five score 8–9.

Scores: Overlap 9 · Time 8 · Citations 6 · Plain language 9 · Thesis 9 · Demo 6 · Hand-off 8

**Three most important findings**

1. **Slide 20 / 22 — internal contradiction (must-fix).** Slide 20 notes say the researchers ran on Sonnet; the same notes say run 001 is not in the cost table, and slide 22 notes say run 001 ran on the parent model. Fix: delete "researchers" from slide 20's Sonnet list.

2. **Slide 13 — two of three required failures are hidden (must-fix).** `talk-context.md` says the spec contradiction, merge conflict, and budget exhaustion are shown; only the merge conflict is on a slide, and `shots/budget-hit.png` sits unused. Fix: one spoken sentence on slide 13 pointing at `002` and `006` in the listing (and, nice-to-have, swap `budget-hit.png` onto slide 18).

3. **Slide 11 — recorded demo has no stated fallback or cut order (must-fix).** The outline's fallbacks are for a live critic call that no longer exists, and the outline itself is stale (21 slides, live demo) while downstream agents still read it. Fix: add to slide 11 notes "if an image fails to render, open the named file in a prepared terminal tab; if long, drop slide 18 then 15", and have the outliner regenerate Segment 3.

Also must-fix: Sources 4 lists `[run 000]` and `[run 005]`, which nothing cites, while the files behind slides 16–20 ($19.32, 44/2/0/0) are not listed. Segment timings, ≤40-word bodies, non-goals, and thesis pay-off all check out.
