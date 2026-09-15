# Context-window degradation and the cost of multi-agent systems

## Key findings

1. Position matters: GPT-3.5-Turbo's 20-document QA accuracy drops more than 20 points when the answer is mid-context, below its 56.1% closed-book (no documents) score; extended-context variants did no better (Liu et al. 2023, "Lost in the Middle", https://arxiv.org/abs/2307.03172).
2. More retrieved documents barely help: 50 instead of 20 improved GPT-3.5-Turbo ~1.5% and Claude-1.3 ~1% (Liu et al. 2023, https://arxiv.org/pdf/2307.03172).
3. Claimed context is not effective context: of 17 models claiming 32K+, only about half passed RULER's threshold (85.6, Llama2-7B at 4K) at 32K; GPT-4 claimed 128K, effective 64K; Yi-34B claimed 200K, effective 32K (Hsieh et al. 2024, "RULER", https://arxiv.org/abs/2404.06654, https://arxiv.org/html/2404.06654).
4. When the question and the answer share no literal words, degradation is severe: 11 of 13 models fell below 50% of their short-context baseline by 32K tokens; GPT-4o dropped from 99.3% to 69.7% (Modarressi et al. 2025, "NoLiMa", https://arxiv.org/abs/2502.05167).
5. Across 18 models (Claude, GPT, Gemini, Qwen), performance fell as input grew; on LongMemEval a focused ~300-token prompt beat the full ~113K-token prompt for every model, and one distractor measurably hurt (Hong, Troynikov, Huber 2025, Chroma "Context Rot", vendor report, https://www.trychroma.com/research/context-rot).
6. 2026 result: Opus 4.6, GPT 5.4 and Gemini 3.1 miss a dangerous coding-agent action 2x to 30x more often when it occurs after 800K tokens of benign activity than when shown alone (Martin & Roger 2026, https://arxiv.org/abs/2605.12366).
7. 2026 result: in long-horizon search, models "give up or provide uncertain incorrect answers long before exhausting the context window"; premature termination rises with context length at fixed difficulty (Xia et al. 2026, https://arxiv.org/abs/2606.29718).
8. Anthropic's stated mechanism: attention is a finite budget, n tokens create n^2 pairwise relationships, and training data skews short. Their fix is subagents that each return "a condensed, distilled summary (often 1,000-2,000 tokens)" (Anthropic 2025, vendor post, https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).
9. In Anthropic's research system an Opus 4 lead with Sonnet 4 subagents beat single-agent Opus 4 by 90.2% on an internal eval; token usage alone explained 80% of BrowseComp variance; subagents are framed as "compression" via separate context windows (Anthropic 2025, vendor post, https://www.anthropic.com/engineering/built-multi-agent-research-system).
10. The same post: agents use about 4x the tokens of chat, multi-agent systems about 15x, so they pay off only when "the value of the task is high enough" (Anthropic 2025, https://www.anthropic.com/engineering/built-multi-agent-research-system).
11. Later Anthropic guidance: "3 to 10 times more tokens than single-agent approaches for equivalent tasks" (duplicated context, coordination messages, handoff summaries); do not split "sequential phases of the same work" (Phillips et al., Anthropic, Jan 2026, vendor post, https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them).
12. Independent measurement over 260 configurations, 6 benchmarks, 3 model families: centralized coordination improved a parallelizable finance task 80.9%, but every multi-agent variant degraded a sequential planning task 39-70%; independent agents amplified errors 17.2x vs 4.4x centralized (Kim et al., Google/MIT, 2025-2026, https://arxiv.org/abs/2512.08296, https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/).
13. Cost-controlled evaluation: on 164 HumanEval problems simple retry/warming/escalation baselines matched "state-of-the-art" agents; LATS cost over 50x more than warming at similar accuracy; most agent benchmarks lacked a proper holdout set (Kapoor et al. 2024, "AI Agents That Matter", https://arxiv.org/abs/2407.01502, https://arxiv.org/pdf/2407.01502).
14. More LLM calls is non-monotone: Vote and Filter-Vote accuracy "can first increase but then decrease" with call count; extra calls help easy queries and hurt hard ones (Chen et al. 2024, https://arxiv.org/abs/2403.02419).
15. Parallelism buys latency with tokens: on GAIA, structural parallelism cut wall-clock 15-40% (Level 2: 320 s to 170-280 s) while tokens rose ~74% (38.8K to 67.6K) (Xu, Tian, Jiang 2026, ICML, https://arxiv.org/abs/2608.05791, https://arxiv.org/html/2608.05791); parallel teams with early termination reached 2.2x speedup (Zhang et al. 2025, workshop paper, https://arxiv.org/abs/2507.08944).
16. Model tiering is first-party guidance: Claude Code subagents take a model field (haiku, sonnet, opus, inherit); docs say "Control costs by routing tasks to faster, cheaper models like Haiku"; the built-in Explore agent runs on Haiku; a subagent "starts fresh and may need time to gather context" (Anthropic docs 2026, https://code.claude.com/docs/en/sub-agents). The Managed Agents example pairs a claude-opus-5 coordinator with claude-haiku-4-5 workers (https://platform.claude.com/docs/en/managed-agents/multiagent-orchestration).
17. Counterpoint: Cognition argues parallel subagents produce inconsistent work because they "cannot see what the other was doing" and prefers one thread plus a compressor model (Yan 2025, vendor post, https://cognition.com/blog/dont-build-multi-agents).

## Numbers worth quoting

- >20 percentage points: drop in GPT-3.5-Turbo 20-doc QA when the answer is mid-context; below 56.1% closed-book. https://arxiv.org/abs/2307.03172
- 64K of 128K: GPT-4 effective vs claimed context on RULER; ~half of 17 models pass at 32K. https://arxiv.org/abs/2404.06654
- 99.3% to 69.7%: GPT-4o on NoLiMa from short to 32K context; 11 of 13 models below 50% of baseline. https://arxiv.org/abs/2502.05167
- ~300 vs ~113K tokens: focused prompt beats full prompt for all 18 models (Chroma). https://www.trychroma.com/research/context-rot
- 4x and 15x: tokens for agents vs chat, multi-agent vs chat (Anthropic). https://www.anthropic.com/engineering/built-multi-agent-research-system
- 3-10x: multi-agent token overhead (Anthropic, Jan 2026). https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them
- +80.9% / -39% to -70%: multi-agent effect on parallelizable vs sequential tasks (Google/MIT). https://arxiv.org/abs/2512.08296
- >50x: LATS cost vs a simple warming baseline at similar HumanEval accuracy. https://arxiv.org/pdf/2407.01502
- 15-40% less wall-clock, ~74% more tokens: structural parallelism on GAIA. https://arxiv.org/html/2608.05791
- up to 90%: research-time cut from parallel subagents and tool calls (Anthropic, vendor). https://www.anthropic.com/engineering/built-multi-agent-research-system
- 5x: list-price ratio, Opus 5 ($5/$25 per MTok) vs Haiku 4.5 ($1/$5); 10x for Fable 5.1 ($10/$50). https://platform.claude.com/docs/en/about-claude/pricing

## Suggested slide points

- Context rot is measured, not folklore: all 18 models degrade with input length; a 300-token prompt beats a 113K-token one (Chroma 2025, https://www.trychroma.com/research/context-rot).
- Claimed window is not usable window: GPT-4 128K claimed, 64K effective; half of models fail at 32K (RULER 2024, https://arxiv.org/abs/2404.06654).
- Delegation is compression: subagents burn tokens in their own window and hand back 1-2K tokens (Anthropic 2025, https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).
- Budget for 3-15x tokens; token usage explains 80% of the quality gain (Anthropic 2025/2026, https://www.anthropic.com/engineering/built-multi-agent-research-system).
- Multi-agent helps parallel tasks (+81%) and hurts sequential ones (-39 to -70%) (Kim et al. 2025, https://arxiv.org/abs/2512.08296).
- Cheap models on subagents is official guidance: Claude Code model field, Haiku-based Explore agent (https://code.claude.com/docs/en/sub-agents). Pricing: see Nick's talk.

## Astronomy or IPAC angle

- Archive output is the classic context filler: an IRSA or NED cone search returning thousands of rows is the "verbose output" Anthropic's docs say to isolate in a subagent that returns a summary (https://code.claude.com/docs/en/sub-agents). Liu et al. found 20 to 50 documents adds ~1.5%; more catalog rows in the main thread will not help either (https://arxiv.org/abs/2307.03172).
- Pipeline stages (calibration, extraction, photometry) are sequential with shared state; the Google/MIT result (-39 to -70% on sequential tasks) argues for a handoff pipeline with fresh contexts, not parallel agents on one stage (https://arxiv.org/abs/2512.08296).
- A monitoring agent watching a nightly QA log loses recall after hundreds of thousands of tokens (2-30x more misses at 800K); restart or summarize periodically (https://arxiv.org/abs/2605.12366).

## Unverified

- "Agentic models require 5 to 30 times more tokens per task than a chatbot", attributed to Gartner (March 2026) in a search snippet; not found in the cited survey (https://arxiv.org/html/2605.09104). Need the Gartner note.
- S-Bus speedups (4.17x at 4, 8.72x at 8, 17.92x at 16 agents) came from a search summary; the visible text says "5-10x at N=5" for commit coordination, not reasoning (https://arxiv.org/html/2605.17076). Need the results table.
- A third-party 2026 blog reports 1M-token needle scores (GPT-5.5 96%, Gemini 3 99%, Opus 4.7 89%) and a 200-400K effective range; not opened (https://www.digitalapplied.com/blog/long-context-retrieval-needle-in-haystack-2026).
- Blog claims that Haiku is "roughly 15x cheaper than Opus" conflict with the current 5x list-price ratio; cite the pricing page, not blogs.

## Sources

https://arxiv.org/abs/2307.03172
https://arxiv.org/pdf/2307.03172
https://arxiv.org/abs/2502.05167
https://arxiv.org/abs/2404.06654
https://arxiv.org/html/2404.06654
https://www.trychroma.com/research/context-rot
https://arxiv.org/abs/2605.12366
https://arxiv.org/abs/2606.29718
https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
https://www.anthropic.com/engineering/built-multi-agent-research-system
https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them
https://claude.com/blog/subagents-in-claude-code
https://code.claude.com/docs/en/sub-agents
https://platform.claude.com/docs/en/managed-agents/multiagent-orchestration
https://platform.claude.com/docs/en/about-claude/pricing
https://arxiv.org/abs/2512.08296
https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/
https://arxiv.org/abs/2407.01502
https://arxiv.org/pdf/2407.01502
https://arxiv.org/abs/2403.02419
https://arxiv.org/abs/2608.05791
https://arxiv.org/html/2608.05791
https://arxiv.org/abs/2507.08944
https://arxiv.org/abs/2605.17076
https://arxiv.org/html/2605.17076
https://arxiv.org/abs/2605.09104
https://arxiv.org/html/2605.09104
https://cognition.com/blog/dont-build-multi-agents
