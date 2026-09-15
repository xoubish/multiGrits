Wrote `handout/qa.md` (ten hard questions, grounded answers with URLs, "if pressed" fallbacks, plus the three the speaker can't answer well yet) and `runs/010-qa/questions.md`. The ten question titles, in order:

1. What did this whole thing cost, and is that number believable?
2. Why not just use one strong agent with a good prompt instead of four agents coordinating?
3. How do you know the agent's analysis is actually correct instead of just sounding right?
4. If I run this pipeline again tomorrow, do I get the same result? Is any of this reproducible?
5. Half your citations are Anthropic's own blog posts. Isn't that just vendor marketing?
6. Does any of this hold up on real archive work, or is it all coding benchmarks and cosmology toy problems?
7. What actually happens when two agents touch the same file, and how do you know the merge is right?
8. What's the failure rate if you let this run with nobody watching?
9. Isn't the whole "multi-agent advantage" just extra tokens and compute, not better reasoning?
10. Did the pipeline that built this deck actually get anything wrong?

Notes on how I grounded this: beyond the four research briefs, I read the actual run logs (`runs/000` through `runs/009`, including `runs/009-factcheck/factcheck.md`) since they're now committed and give real, fact-checked numbers rather than the deck's slightly-off phrasing in two spots (the Kapoor "Warming" vs. "Retry" baseline, and the Xu et al. wall-clock/token pairing) — I used the corrected versions in the handout rather than repeating the deck's imprecision.
