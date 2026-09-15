I fact-checked every citation on `slides/deck.md`, including all four Sources slides, by opening each URL/PDF directly and independently re-verifying every specific number against primary-source text (not just abstracts), plus reading the four internal repo files (`run 000`, `run 001`, `run 005`, `pipeline/run.sh`) cited on Sources 4/4.

**Tally: CONFIRMED: 44 · PARTIAL: 2 · NOT FOUND: 0 · CONTRADICTED: 0**

No NOT FOUND or CONTRADICTED rows — every citation resolved to a real document that says what the slide claims. Nothing on this deck appears fabricated.

The two PARTIAL rows (full detail and suggested fixes in `runs/009-factcheck/factcheck.md`):

1. **Slide 4, [Kapoor 2024]** — "cost over 50x a simple retry baseline at similar accuracy." The 50x figure is real, but it's LATS vs. the paper's **"Warming"** baseline, not "Retry" (a different one of the paper's three baselines), and Warming actually scored *higher* (93.2%) than LATS (88.0%), not just "similar." Fix: name the baseline "Warming," not "retry."

2. **Slide 6 notes, [Xu 2026]** — "15–40% less wall-clock and about 74% more tokens" on GAIA. Both numbers are real individually, but they don't co-occur in the same row of the paper's results table: the 74%-more-tokens figure is Level 1, where wall-clock savings were only ~2.6% (not 15–40%); the levels with real 15–65% wall-clock savings show 62–91% more tokens, not 74%. Fix: pick one matched pair from the table instead of combining two different rows.

Report written to `runs/009-factcheck/factcheck.md`. Deck itself was not touched, per instructions.
