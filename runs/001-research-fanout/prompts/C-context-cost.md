TOPIC C — Evidence on context-window degradation and on the cost of multi-agent systems.

Output path: research/briefs/C-context-cost.md

This brief supports the talk's thesis that context, not intelligence, is the reason to go multi-agent,
and the gotcha that cost multiplies with agent count.

Cover, with citations and numbers:
- Long-context degradation: "Lost in the Middle" (Liu et al. 2023), NoLiMa, RULER, the Chroma
  "context rot" report (2025), and any 2026 results. Quote the actual measured drop-offs.
- Why context isolation helps: evidence that fresh, focused contexts perform better than one
  long accumulated context. Include Anthropic's stated reasons in the multi-agent research system post.
- Cost multipliers: Anthropic's reported token multiples for agents vs. chat and for multi-agent vs.
  single agent; any independent measurements. "AI Agents That Matter" (Kapoor et al. 2024) on
  cost-controlled evaluation. "Are More LLM Calls All You Need?" (Chen et al. 2024) on compound systems.
- Model tiering: evidence or vendor guidance on using smaller models for subagents and a frontier
  model as orchestrator. Do NOT compile a pricing table; another speaker covers pricing.
  Relative ratios with a source are fine.
- Latency and parallelism: any measured wall-clock gains from parallel subagents.
