Brief written to /Users/shemmati/Desktop/multiGrits/research/briefs/C-context-cost.md (about 1,210 words of prose, exact heading format, 28 sources opened). No other files touched.

Key verified findings:
- Long-context degradation: Lost in the Middle (>20-point drop mid-context, below 56.1% closed-book); RULER (GPT-4 128K claimed, 64K effective; half of 17 models fail at 32K); NoLiMa (11 of 13 models below 50% of baseline at 32K; GPT-4o 99.3% to 69.7%); Chroma Context Rot (18 models; ~300-token focused prompt beats ~113K full prompt); two 2026 arXiv papers (2-30x more missed detections after 800K tokens; premature termination rises with context length).
- Why isolation helps: Anthropic's n^2 attention-budget argument, subagents returning 1,000-2,000-token summaries, 90.2% gain with token usage explaining 80% of variance.
- Cost: Anthropic 4x (agents) and 15x (multi-agent) vs chat; later Anthropic guidance 3-10x; Kapoor et al. LATS >50x cost of a simple baseline; Chen et al. non-monotone returns; Google/MIT +80.9% on parallel tasks, -39 to -70% on sequential.
- Tiering: Claude Code docs explicitly recommend Haiku subagents; Managed Agents example is Opus 5 coordinator with Haiku 4.5 workers; list-price ratio 5x (10x vs Fable 5.1).
- Latency: 15-40% wall-clock cut for ~74% more tokens (GAIA); up to 2.2x with early termination.

Unverified (flagged in brief): Gartner 5-30x claim, S-Bus per-agent speedups, a third-party 1M-token blog, and blog "15x cheaper Haiku" claims.
