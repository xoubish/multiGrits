# Merged research brief — Multi-agent workflows (GRITS, IPAC, Day 2)

Orchestrator's merge of four parallel researcher briefs, 2026-09-15. Sources: `research/briefs/A-literature.md`
(academic evidence), `B-tools.md` (tool mechanics), `C-context-cost.md` (context degradation and cost),
`D-astronomy.md` (astronomy and IPAC). Every claim below carries a URL from one of them. Items the researchers
could not verify are collected at the end and must not appear on slides as fact.

## 1. What the talk can claim, in one paragraph

Long-context performance degrades in every measured model family, so one agent that accumulates context
gets worse as it works. Delegating bounded subtasks to subagents that return short summaries is a way to
keep the main thread's context small; Anthropic calls this "compression" and attributes most of its
multi-agent gain to spending more tokens in separate windows. Independent 2025–2026 studies then narrow the
claim: at equal token budgets single agents match or beat multi-agent designs on reasoning tasks, multi-agent
helps decomposable tasks and hurts sequential ones, and multi-agent systems fail in specific, catalogued
ways. So the honest pitch is: go multi-agent for context and for parallelizable breadth, budget several
times the tokens, centralize the merge, verify with tools, and script the orchestration.

## 2. Evidence for the thesis: context, not intelligence

- Position matters: GPT-3.5-Turbo's 20-document QA drops more than 20 points when the answer is mid-context, below its closed-book score (Liu et al. 2023, https://arxiv.org/abs/2307.03172).
- Claimed window is not usable window: GPT-4 claimed 128K, effective 64K on RULER; about half of 17 models fail at 32K (Hsieh et al. 2024, https://arxiv.org/abs/2404.06654).
- Without literal word overlap, 11 of 13 models fall below 50% of their short-context baseline by 32K; GPT-4o 99.3% to 69.7% (NoLiMa, https://arxiv.org/abs/2502.05167).
- Across 18 models, a focused ~300-token prompt beat the full ~113K-token prompt for every model on LongMemEval (Chroma "Context Rot" 2025, vendor report, https://www.trychroma.com/research/context-rot).
- 2026: frontier models miss a dangerous agent action 2x to 30x more often after 800K tokens of benign activity (Martin & Roger 2026, https://arxiv.org/abs/2605.12366); long-horizon agents give up earlier as context grows (Xia et al. 2026, https://arxiv.org/abs/2606.29718).
- Mechanism and fix, per Anthropic: attention is a finite budget; subagents do the deep work and return "a condensed, distilled summary (often 1,000-2,000 tokens)" (https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).
- Anthropic's research system: Opus 4 lead plus Sonnet 4 subagents beat single-agent Opus 4 by 90.2% on an internal eval, and token usage alone explained 80% of BrowseComp variance (vendor claim; URL conflict noted in section 9).
- A fresh Claude Code subagent receives its system prompt, the delegation message, CLAUDE.md and a git snapshot, not the parent's history or files read (https://code.claude.com/docs/en/sub-agents). This is the mechanical reason for the "pass what they need" gotcha.

## 3. The honest case against, which the talk must state

- Equal budget, 2026: with thinking tokens held constant, single agents "consistently match or outperform" five multi-agent designs on FRAMES and MuSiQue; 0.427 vs 0.386 at a 5k budget; multi-agent won only when 70% of context was masked or corrupted (Tran & Kiela, Apr 2026, https://arxiv.org/abs/2604.02460).
- Auto-generated multi-agent systems underperform chain-of-thought plus self-consistency "despite being up to 10x more expensive" (Jwalapuram et al., Jun 2026, https://arxiv.org/abs/2606.13003); 5 of 6 multi-agent workflows trail a matched single agent by 2.56–11.29 points on 10 benchmarks (Fu et al., Jun 2026, https://arxiv.org/abs/2606.05670).
- Debate does not reliably beat self-consistency even with much more compute (Smit et al., https://arxiv.org/abs/2311.17371; Zhang et al. 2025, https://arxiv.org/abs/2502.08788).
- Cost-controlled evaluation: simple retry and escalation baselines are Pareto-efficient; one agent framework cost over 50x a simple baseline at similar accuracy (Kapoor et al. 2024, https://arxiv.org/abs/2407.01502).
- More calls is non-monotone: accuracy can rise then fall with call count (Chen et al. 2024, https://arxiv.org/abs/2403.02419).
- Cognition's position: parallel subagents "cannot see what the other was doing"; conflicting implicit decisions produce inconsistent work; prefer one thread plus compression (Yan 2025, https://cognition.com/blog/dont-build-multi-agents).
- Cost multipliers from the vendor itself: agents ~4x a chat's tokens, multi-agent ~15x (Anthropic 2025); later guidance "3 to 10 times more tokens" and do not split "sequential phases of the same work" (Anthropic, Jan 2026, https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them).

## 4. Task shape decides: the reconciling result

Kim et al. (Google/MIT, arXiv v3 Apr 2026, https://arxiv.org/abs/2512.08296; blog https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/):
260 configurations, 6 benchmarks, 3 model families. Centralized multi-agent improved a decomposable financial
task by 80.8%; every multi-agent variant degraded a sequential planning task by 39–70%; independent agents
amplified errors 17.2x versus 4.4x with centralized verification; returns diminish once the single agent is
already strong. This single paper justifies both halves of the talk: fan-out for breadth, one thread or a
script for sequential work, and a centralized merge with verification. (Blog says 180 configs and +80.9%;
cite the arXiv v3 numbers.)

## 5. Evidence per pattern

1. **Fan-out and merge.** Breadth-first work over more sources than fit one window is the case where the
   literature agrees (Anthropic research system; Kim et al. decomposable tasks). Parallelism trades tokens
   for latency: on GAIA, structural parallelism cut wall-clock 15–40% while tokens rose ~74% (Xu, Tian, Jiang 2026, https://arxiv.org/abs/2608.05791). Centralize the merge (17.2x vs 4.4x error amplification, Kim et al.). Specialized roles beat generic headcount: 98.67% vs 94.95% micro-F1 for role-specialized vs two generic agents extracting simulation parameters from astronomy papers (SimAgents, https://arxiv.org/abs/2507.08958).
2. **Pipeline.** Anthropic's five composable workflows (prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer) and "the simplest solution possible" (https://www.anthropic.com/research/building-effective-agents). Google ADK's `SequentialAgent`/`ParallelAgent`/`LoopAgent` run sub-agents "without consulting an AI model" (https://adk.dev/agents/workflow-agents/). Do not split sequential phases of one piece of work across agents (Anthropic Jan 2026; Kim et al. -39 to -70%).
3. **Writer and critic.** MAST's third failure category is task verification (23.5%), and its largest modes are step repetition 15.7%, reasoning-action mismatch 13.2%, unaware of stopping conditions 12.4% (Cemri et al., NeurIPS 2025, https://arxiv.org/abs/2503.13657). Independent astronomy benchmarks show agents fake success: coding agents "relied on proxy metrics, partial evaluation, or fabricated results" (gwBenchmarks, https://arxiv.org/abs/2605.11269); agents "achieve a good statistical fit" but "fail to recover correct physical system parameters" (Stargazer, https://arxiv.org/abs/2604.15664). A reviewer without tools rubber-stamps; give it tests and schemas. Chaining reduced hallucination score 0.422 to 0.272 but factual accuracy also slipped 0.789 to 0.769 (Jamshidi et al. 2026, https://arxiv.org/abs/2606.07937): a critic is not free.
4. **Parallel isolated workers.** Cognition's objection (implicit conflicting decisions) is exactly what isolation plus a merge step addresses. Only Claude Code documents per-subagent git worktree isolation, `isolation: worktree` (v2.1.203+), with the harness blocking writes to the main checkout (https://code.claude.com/docs/en/worktrees); Qwen Code's experimental Agent Team allows one worktree for one writer; Codex, OpenCode and Gemini document none (B brief tables). Osmani: worktrees mean "no merge conflicts while they work" and "the bottleneck is no longer generation. It's verification" (https://addyosmani.com/blog/code-agent-orchestra/).

## 6. Failure modes and gotchas, with evidence

- MAST taxonomy: 14 failure modes in 3 categories over 1,600+ traces and 7 frameworks: system design 44.2%, inter-agent misalignment 32.3%, task verification 23.5%; prompt and topology fixes gave only +9.4 and +15.6 points (https://arxiv.org/abs/2503.13657).
- Performance "does not scale monotonically with agent count" (SIMAS, https://arxiv.org/abs/2606.00655); "scaling single-agent performance alone does not automatically yield robust multi-agent intelligence" (Hu et al., https://arxiv.org/abs/2512.08743).
- Per-spawn overhead measured in this repo: a 9-token headless reply cost $0.019 because the system prompt is ~4,400 cache-creation tokens (`runs/000-scaffold-verification/README.md`). Do not fan out trivially small tasks.
- Model tiering is first-party guidance: Claude Code docs say to route to "faster, cheaper models like Haiku"; the built-in Explore agent runs on Haiku; Managed Agents pairs an Opus coordinator with Haiku workers (https://code.claude.com/docs/en/sub-agents; https://platform.claude.com/docs/en/managed-agents/multiagent-orchestration). Pricing itself is Nick's talk.
- Agent teams in Claude Code: experimental, off by default, interactive-only, ~7x tokens in plan mode; the docs say try subagents first (https://code.claude.com/docs/en/agent-teams; https://code.claude.com/docs/en/costs).
- Reproducibility: Claude Code's dynamic workflows put the plan in a script and make `Date.now()`/`Math.random()` throw so a relaunched run repeats the same calls (https://code.claude.com/docs/en/workflows). `--bare` makes every machine load identical inputs (https://code.claude.com/docs/en/headless). NASA SMD's 2025–2030 strategy asks for reproducibility practices for "agentic workflows" and notes there are "no established science-specific guardrails or factuality-checking mechanisms" (https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf).

## 7. Tool mechanics the slides may show (from B)

- Five CLIs converge on one file per role with name, description, tools, model: `.claude/agents/*.md`, `.codex/agents/*.toml`, `.opencode/agents/*.md`, `.gemini/agents/*.md`, `.qwen/agents/*.md` (docs linked in B).
- Claude Code: `Agent` tool, depth 3, 20 concurrent by default; headless `claude -p --agent <name> --output-format json --json-schema --max-budget-usd` with subagent spend counted toward the cap; JSON returns `total_cost_usd` (https://code.claude.com/docs/en/sub-agents; https://code.claude.com/docs/en/headless).
- Codex: `codex exec --json --output-schema`; OpenCode: `opencode run --agent --format json`; Gemini and Qwen: `-p` with JSON output (URLs in B).
- Frameworks by who picks the next step: graph (LangGraph, ADK), role crew (CrewAI), conversation (AG2/AutoGen, now in maintenance mode), handoff (OpenAI Agents SDK), supervisor (Claude Agent SDK, smolagents). One slide at most.

## 8. Astronomy and IPAC material (from D)

- Cosmology already runs ~30-agent pipelines: cmbagent, "no human-in-the-loop", 66% one-shot vs 78% planning-and-control on DS-1000 (https://arxiv.org/abs/2507.07257). Its predecessor reproduced ACT DR6 lensing constraints for $1.55 and 274K tokens in 40 minutes, but "required human feedback at all stages" (https://arxiv.org/html/2412.00431v2).
- Denario shipped 11 AI-drafted papers; its lead says "Denario has fabricated data" and about 10% of outputs raised an intriguing question (https://www.simonsfoundation.org/2025/11/04/meet-denario-an-ai-assistant-for-every-step-of-the-scientific-process/).
- Agents plus a human won the FAIR Universe weak-lensing challenge; fully autonomous agents did not reach expert level (https://arxiv.org/abs/2604.09621).
- Mephisto: multi-agent tree search over CIGALE fits 256 COSMOS2020 galaxies within ±20% of grid search using ~1% of evaluations, ~$2 and 200K tokens per galaxy (https://arxiv.org/html/2510.08354v1).
- AstroVisBench: at least 58% of best-model runs produce no plot or a plot with major errors (https://arxiv.org/abs/2505.20538). Text-to-SQL on ALeRCE: 97% simple, 44% medium, 59% hard (https://arxiv.org/abs/2606.18108).
- IPAC is already in this space: AstroFetch at the NASA Exoplanet Archive, open beta since 2026-07-16, writes and shows ADQL; its tips page says "Long conversations consume more context and tokens, which slows responses and dilutes accuracy" (https://astrofetch.ipac.caltech.edu/). IRSA is prototyping RAG assistants for TAP and SPHEREx (https://www.ipac.caltech.edu/page/aas248). STScI's March 2026 workshop had talks on Euclid multi-agent archive discovery and IRSA's API assistant (agenda URL in D).
- Archive tool access exists: official ADS `scix-mcp`; a community astroquery MCP exposing 141 functions including IRSA (7), NED (15), Exoplanet Archive (7) (https://github.com/adsabs/scix-mcp; https://github.com/igaurab/astroquery-mcp).

Demo ideas for the handout (from D): parallel FITS header audit; parallel multi-archive cross-check of a
target list via astroquery; parallel pipeline-log triage; writer-critic on an ADQL query against `pscomppars`;
literature fan-out with the ADS MCP server.

## 9. Conflicts and cautions for the fact-checker

- Anthropic multi-agent post URL: A cites `anthropic.com/engineering/multi-agent-research-system`, C cites `anthropic.com/engineering/built-multi-agent-research-system`. Confirm which resolves; cite one.
- Kim et al.: blog says 180 configurations and +80.9%; arXiv v3 says 260 and +80.8%. Cite arXiv v3.
- Anthropic's token multiple: 15x (Jun 2025 post) vs 3–10x (Jan 2026 post). Quote both with dates or say "several times".
- Pricing figures appear in C. Leave them out of the deck; point to Nick.
- Mephisto cost: ~$2 and 200K tokens per galaxy in the paper text; a search snippet said ~$1 and 100K. Use the paper.

## 10. Numbers table for slides

| Number | Meaning | Source |
|---|---|---|
| >20 points | mid-context QA drop, GPT-3.5 | https://arxiv.org/abs/2307.03172 |
| 64K of 128K | effective vs claimed context, GPT-4 | https://arxiv.org/abs/2404.06654 |
| 300 vs 113K tokens | focused prompt beats full prompt, 18 models | https://www.trychroma.com/research/context-rot |
| 1,000–2,000 tokens | recommended subagent return size | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| 4x, 15x | agent, multi-agent tokens vs chat | Anthropic 2025 (URL to confirm) |
| 80% | BrowseComp variance explained by tokens | Anthropic 2025 (URL to confirm) |
| +80.8% / −70% | multi-agent on decomposable vs sequential tasks | https://arxiv.org/abs/2512.08296 |
| 17.2x vs 4.4x | error amplification, independent vs centralized | https://arxiv.org/abs/2512.08296 |
| 0.427 vs 0.386 | single vs multi-agent at equal 5k budget | https://arxiv.org/abs/2604.02460 |
| 44 / 32 / 24 % | MAST failure categories | https://arxiv.org/abs/2503.13657 |
| 15–40% less time, 74% more tokens | parallelism on GAIA | https://arxiv.org/abs/2608.05791 |
| $0.019 for 9 tokens | per-spawn overhead, this repo | runs/000-scaffold-verification/README.md |
| $1.55, 40 min | one multi-agent cosmology analysis | https://arxiv.org/html/2412.00431v2 |
| ~10% | Denario outputs judged intriguing | Simons Foundation 2025 |
| 58% | AstroVisBench runs with no or broken plot | https://arxiv.org/abs/2505.20538 |

## 11. Unverified, collected from all four briefs. Not for slides.

- Gartner "5 to 30 times more tokens" (C). S-Bus per-agent speedups (C). Third-party 1M-token needle blog (C).
- MAST per-framework failure rates read off a figure; which MAST intervention gave +9.4 vs +15.6 (A).
- Microsoft Agent Framework GA date; MetaGPT MGX launch date; OWL's current GAIA score (A).
- Codex worktree support; Gemini CLI parallelism; OpenAI SDK and ADK per-agent model fields; whether `isolation: worktree` applies to SDK `AgentDefinition` (B).
- Denario expert score table; "33% text-to-SQL on SDSS"; contents of the Euclid, MAST, and AstroGenesis workshop talks; AstroReview's self-reported 87%; AstroAgents paper not opened (D).
