# A — Academic literature on multi-agent LLM systems: benefits, costs, and failure modes

## Key findings

1. MetaGPT (ICLR 2024 oral) encodes "Standardized Operating Procedures" into a five-role assembly line and reports 85.9% HumanEval and 87.7% MBPP pass@1, plus 3.75/4 executability on SoftwareDev vs 2.25 for ChatDev, at 31,255 tokens and 541 s per project (Hong et al., 2023/2024, https://arxiv.org/html/2308.00352; https://iclr.cc/virtual/2024/oral/19756).
2. ChatDev v1 claimed role-playing agents finish software "in under seven minutes at a cost of less than one dollar"; the ACL 2024 version reports 88% executability on 1,200 prompts and a quality drop from 0.395 to 0.309 without "communicative dehallucination" (Qian et al., 2023/2024, https://arxiv.org/abs/2307.07924v1; https://arxiv.org/html/2307.07924).
3. AutoGen framed agents as "conversable" and programmable through conversation (Wu et al., Microsoft, 2023, https://arxiv.org/abs/2308.08155); CAMEL used role-play with "inception prompting" (Li et al., NeurIPS 2023, https://arxiv.org/abs/2303.17760); Generative Agents ran 25 agents with a memory stream, reflection, and planning (Park et al., 2023, https://arxiv.org/abs/2304.03442).
4. By 2026 AutoGen "is now in maintenance mode" with Microsoft Agent Framework as "the enterprise-ready successor" (Microsoft, https://github.com/microsoft/autogen), and CAMEL's OWL (NeurIPS 2025) reports 69.09% on GAIA, "#1 among open-source frameworks" (CAMEL-AI, 2025, https://github.com/camel-ai/owl).
5. Multi-agent debate (3 agents, 2 rounds, gpt-3.5-turbo) raised GSM8K from 77.0% to 85.0% and MMLU from 63.9 to 71.1, at the cost of "multiple model instances and rounds" (Du et al., 2023, https://arxiv.org/html/2305.14325).
6. Sampling-and-voting scales with agent count: 15 samples of Llama2-13B match Llama2-70B on GSM8K, but 40 samples of GPT-3.5 (0.85) still trail one GPT-4 call (0.88), and gains shrink as difficulty rises (Li et al., TMLR 2024, https://arxiv.org/html/2402.05120).
7. Mixture-of-Agents layers open models to 65.1% on AlpacaEval 2.0 vs 57.5% for GPT-4o (Wang et al., 2024, https://arxiv.org/abs/2406.04692). Items 5–7 are "more samples of one model," not agents with roles or tools.
8. Vendor claim: Anthropic's orchestrator-plus-subagents research system beat single-agent Opus 4 by 90.2%, but uses about 15x a chat's tokens (a single agent about 4x), token count alone explained 80% of BrowseComp variance, and they call it a poor fit for coding or shared-context tasks (Anthropic, Jun 2025, https://www.anthropic.com/engineering/multi-agent-research-system).
9. Debate "in their current form, do not reliably outperform" self-consistency and is hyperparameter-sensitive (Smit et al., 2024, https://arxiv.org/abs/2311.17371); across 5 MAD methods, 9 benchmarks, and 4 models it "often fail[s] to outperform" CoT and self-consistency "even when consuming significantly more inference-time computation" (Zhang et al., 2025, https://arxiv.org/abs/2502.08788).
10. Accuracy-only leaderboards made agents "needlessly complex and costly"; simple repeated-call baselines are Pareto-efficient on cost vs accuracy (Kapoor et al., 2024, https://arxiv.org/abs/2407.01502).
11. At equal thinking-token budgets, single agents "consistently match or outperform" five MAS designs (sequential, subtask-parallel, parallel-roles, debate, ensemble) on FRAMES and 4-hop MuSiQue across three model families (5k budget: 0.427 vs 0.386); MAS won only when 70% of context was masked or corrupted (Tran and Kiela, Apr 2026, https://arxiv.org/abs/2604.02460; https://arxiv.org/html/2604.02460).
12. Auto-generated MAS "consistently underperform" CoT plus self-consistency "despite being up to 10x more expensive" (Jwalapuram et al., Jun 2026, https://arxiv.org/abs/2606.13003); under one normalized protocol with GPT-4.1 on 10 benchmarks, 5 of 6 MAS trail a matched single agent by 2.56–11.29 points (Fu et al., Jun 2026, https://arxiv.org/abs/2606.05670).
13. Task shape decides: across 260 configurations, multi-agent ranges from +80.8% (decomposable financial reasoning, centralized) to −70.0% (sequential planning); coordination has diminishing returns once the single agent is strong; independent agents amplify errors 17.2x vs 4.4x with centralized verification (Kim et al., Google/MIT, 2025/2026, https://arxiv.org/abs/2512.08296; https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/).
14. MAST (NeurIPS 2025): 1,600+ traces, 7 frameworks (v1: 5 frameworks, 150+ tasks), 14 failure modes in 3 categories: system design 44.2%, inter-agent misalignment 32.3%, task verification 23.5% (κ=0.88; o1 judge 94% accurate, κ=0.77). Largest modes: step repetition 15.7%, reasoning-action mismatch 13.2%, unaware of stopping conditions 12.4%, disobeying task spec 11.8%. Prompt and topology fixes on ChatDev gave only +9.4 and +15.6 points; failures "require more complex solutions" (Cemri et al., 2025, https://arxiv.org/abs/2503.13657; https://arxiv.org/abs/2503.13657v1; https://arxiv.org/html/2503.13657).
15. 2026 follow-ons: ErrorProbe locates "the originating error step" in MAS traces (Li et al., Apr 2026, https://arxiv.org/abs/2604.17658); across 41 LLMs and 7 benchmarks "scaling single-agent performance alone does not automatically yield robust multi-agent intelligence" (Hu et al., Dec 2025, https://arxiv.org/abs/2512.08743); SIMAS finds performance "does not scale monotonically with agent count" (Li et al., May 2026, https://arxiv.org/abs/2606.00655); a May 2026 survey warns "errors can propagate across agents and interaction rounds" (Qi et al., https://arxiv.org/abs/2605.14892).
16. Practitioner positions, one sentence each. Anthropic (Dec 2024): find "the simplest solution possible" and compose five workflows (prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer) before building autonomous agents (https://www.anthropic.com/research/building-effective-agents). Cognition (Yan, Jun 2025): avoid parallel subagents because "actions carry implicit decisions, and conflicting decisions carry bad results"; run one linear thread with context compression (https://cognition.com/blog/dont-build-multi-agents). Anthropic (Sep 2025): recall degrades as context grows, so subagents do the deep work and return "a condensed, distilled summary (often 1,000-2,000 tokens)" (https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents). Osmani (Mar 2026): "context overload" is why one agent stops scaling, worktrees mean "no merge conflicts while they work," and "the bottleneck is no longer generation. It's verification" (https://addyosmani.com/blog/code-agent-orchestra/). SearchSwarm (Jun 2026) formalizes subagents that "return only summarized results, conserving the main agent's context budget" (Lan et al., https://arxiv.org/abs/2606.09730).
17. Surveys for a pattern taxonomy: Guo et al. (2024) organize MAS by agents-environment interface, agent profiling, communication, and capability acquisition (https://arxiv.org/abs/2402.01680); Tran et al. (2025) by actors, type (cooperation/competition/coopetition), structure (peer-to-peer/centralized/distributed), strategy, and coordination protocol (https://arxiv.org/abs/2501.06322).

## Numbers worth quoting

- 15x: tokens used by multi-agent vs a chat; 4x for a single agent; 80% of BrowseComp variance explained by token count alone. https://www.anthropic.com/engineering/multi-agent-research-system
- 90.2%: Anthropic's vendor-measured gain over single-agent Opus 4 on an internal research eval. https://www.anthropic.com/engineering/multi-agent-research-system
- 44.2% / 32.3% / 23.5%: MAST failure shares for system design / inter-agent misalignment / verification. https://arxiv.org/html/2503.13657
- 14 failure modes, 1,600+ traces, 7 frameworks, κ=0.88 human agreement. https://arxiv.org/abs/2503.13657
- +80.8% to −70.0%: multi-agent vs single-agent change depending on task type. https://arxiv.org/abs/2512.08296
- 17.2x vs 4.4x: error amplification, independent agents vs centralized coordination. https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/
- 2.56–11.29 points: how far 5 of 6 multi-agent workflows trail a matched single agent (GPT-4.1, 10 benchmarks). https://arxiv.org/abs/2606.05670
- 10x: cost premium of auto-generated MAS that still lose to CoT plus self-consistency. https://arxiv.org/abs/2606.13003
- 0.427 vs 0.386: single agent vs sequential MAS at an equal 5k thinking-token budget. https://arxiv.org/html/2604.02460
- 77.0 to 85.0: GSM8K with 3-agent, 2-round debate on gpt-3.5-turbo. https://arxiv.org/html/2305.14325
- 15: samples of Llama2-13B needed to match Llama2-70B on GSM8K; 40 samples of GPT-3.5 (0.85) still below one GPT-4 call (0.88). https://arxiv.org/html/2402.05120
- 1,000–2,000 tokens: recommended size of a subagent's returned summary. https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- Under 7 minutes, under $1: ChatDev v1 headline claim. https://arxiv.org/abs/2307.07924v1

## Suggested slide points

- Most of the "multi-agent advantage" is extra tokens: 80% of variance is token count (Anthropic, https://www.anthropic.com/engineering/multi-agent-research-system); at equal thinking budget single agents match or win (Tran and Kiela 2026, https://arxiv.org/abs/2604.02460).
- Multi-agent fails three ways: design/spec 44%, inter-agent misalignment 32%, verification 24% (MAST, https://arxiv.org/html/2503.13657).
- Task shape decides: +81% on decomposable tasks, −70% on sequential planning (Kim et al., https://arxiv.org/abs/2512.08296).
- Centralize the merge: independent agents amplify errors 17.2x, centralized 4.4x (Google Research, https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/).
- Subagents return summaries, not dumps: 1–2k tokens back to the orchestrator (Anthropic, https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).
- Don't parallelize decisions: Cognition's Flappy Bird example, "conflicting decisions carry bad results" (https://cognition.com/blog/dont-build-multi-agents).

## Astronomy or IPAC angle

- The one case where the literature agrees multi-agent helps, breadth-first search over sources that exceed one context window (Anthropic, https://www.anthropic.com/engineering/multi-agent-research-system; decomposable tasks in Kim et al., https://arxiv.org/abs/2512.08296), maps directly onto archive work: querying IRSA, NED, and the Exoplanet Archive for a target list is fan-out-and-merge with a deterministic merge step.
- Sequential planning is where multi-agent lost 70% (Kim et al.): a strictly ordered calibration or reduction pipeline is a job for one agent or, better, a script, not a swarm.
- MAST's largest modes (step repetition, ignoring stopping conditions, incorrect verification, https://arxiv.org/html/2503.13657) are the failures pipeline engineers already guard against with idempotent stages, explicit termination, and independent QA; the same discipline applies to agents.

## Unverified

- MAST per-framework failure rates (roughly 41–87%) were read off Figure 5 by a summarizer; need exact values from the paper.
- Which MAST intervention gave +9.4 vs +15.6 points (role-specification prompts vs added verification/topology) may be swapped in extraction; check Section 6 and Appendix H of https://arxiv.org/html/2503.13657.
- Microsoft Agent Framework 1.0 GA (April 2, 2026) and AutoGen maintenance mode (October 2025): dates come only from secondary search snippets; the AutoGen README confirms status without dates, and the devblog index (https://devblogs.microsoft.com/agent-framework/) shows no product-wide GA post.
- MetaGPT's MGX launch on February 19, 2025: from an X post snippet, not opened.
- Google blog (Jan 2026) says 180 configurations, 4 benchmarks, +80.9%; arXiv v3 (Apr 2026) says 260, 6, +80.8%. Cite one version.
- OWL's GAIA score: README lists both 58.18 (Mar 2025) and 69.09; confirm the current entry.
- Claims that production MAS fail "between 41% and 87%" (https://arxiv.org/abs/2605.03310) and that "token duplication" runs 53–86% (https://arxiv.org/html/2604.16339v1) are attributed to MAST, but I could not find those numbers in MAST itself.
- Generative Agents' venue (UIST 2023) is not shown on the arXiv page.

## Sources

https://arxiv.org/abs/2503.13657
https://arxiv.org/abs/2503.13657v1
https://arxiv.org/html/2503.13657
https://arxiv.org/abs/2305.14325
https://arxiv.org/html/2305.14325
https://arxiv.org/abs/2402.05120
https://arxiv.org/html/2402.05120
https://arxiv.org/abs/2406.04692
https://www.anthropic.com/engineering/multi-agent-research-system
https://www.anthropic.com/research/building-effective-agents
https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
https://cognition.com/blog/dont-build-multi-agents
https://arxiv.org/abs/2402.01680
https://arxiv.org/abs/2501.06322
https://arxiv.org/abs/2605.14892
https://arxiv.org/abs/2604.02460
https://arxiv.org/html/2604.02460
https://arxiv.org/abs/2606.13003
https://arxiv.org/abs/2606.05670
https://arxiv.org/abs/2606.09730
https://arxiv.org/abs/2606.00655
https://arxiv.org/abs/2512.08296
https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/
https://arxiv.org/abs/2512.08743
https://arxiv.org/abs/2311.17371
https://arxiv.org/abs/2502.08788
https://arxiv.org/abs/2407.01502
https://arxiv.org/abs/2604.17658
https://arxiv.org/abs/2605.03310
https://arxiv.org/html/2604.16339v1
https://arxiv.org/abs/2308.00352
https://arxiv.org/html/2308.00352
https://iclr.cc/virtual/2024/oral/19756
https://arxiv.org/abs/2307.07924
https://arxiv.org/abs/2307.07924v1
https://arxiv.org/html/2307.07924
https://arxiv.org/abs/2308.08155
https://arxiv.org/abs/2303.17760
https://arxiv.org/abs/2304.03442
https://github.com/microsoft/autogen
https://github.com/camel-ai/owl
https://devblogs.microsoft.com/agent-framework/
https://addyosmani.com/blog/code-agent-orchestra/
