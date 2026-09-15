# Fact-check — `slides/deck.md`

Method: every URL cited on the Sources slides (and every internal `runs/`/`pipeline/` reference) was
opened directly (WebFetch), and every specific number was independently re-checked against the primary
source's abstract/full text or, where WebFetch choked on PDF encoding, against a second independent
open access mirror (arXiv HTML) or search-engine-indexed excerpt. A citation I could not open was
scored NOT FOUND, never CONFIRMED. Internal repo citations (`run 000`, `run 001`, `run 005`,
`pipeline/run.sh`) were checked by reading the actual files in this repo.

## Status table

| Slide | Claim | URL / ref | Status | Note |
|---|---|---|---|---|
| 3 | "Answer placed mid-context: accuracy drops over 20 points, below the no-documents score" | [Liu 2023] arxiv.org/abs/2307.03172 | CONFIRMED | Paper: GPT-3.5-Turbo ≈75.8% with answer at the start, ≈53.8% at the worst (middle) position (~22-pt swing); closed-book baseline 56.1%, so the middle-position score (53.8%) falls below the no-documents score. |
| 3 | "GPT-4 claimed 128K tokens; effective 64K on a long-context test" | [Hsieh 2024] arxiv.org/abs/2404.06654 | CONFIRMED | RULER Table 3: GPT-4 scores 96.6%(4K)→93.2%(32K)→87.0%(64K)→81.2%(128K); 128K falls below the paper's "satisfactory" threshold, so effective length is marked 64K against a claimed 128K. |
| 3 | "each subagent returns a 1,000–2,000-token summary" | [Anthropic 2025a] anthropic.com/engineering/effective-context-engineering-for-ai-agents | CONFIRMED | Page exists (Sept 2025); exact phrase: "returns only a condensed, distilled summary of its work (often 1,000-2,000 tokens)." |
| 4 | "single agent 0.427 vs multi-agent 0.386" at equal 5k budget | [Tran & Kiela 2026] arxiv.org/abs/2604.02460 | CONFIRMED | Paper's Table 1 aggregate (both datasets, 3 model families) at the 5,000-token budget: SAS 0.427 vs Sequential MAS 0.386, exact match. |
| 4 | "One agent framework cost over 50x a simple retry baseline at similar accuracy" | [Kapoor 2024] arxiv.org/abs/2407.01502 | PARTIAL | Paper confirms LATS costs "over 50 times more" than a simple baseline on HumanEval — but the cheap baseline is named **"Warming,"** not "Retry" (Retry is a different one of the paper's three baselines), and Warming's accuracy (93.2%) was *higher* than LATS's (88.0%), not merely "similar." Direction and magnitude are right; the baseline's name is wrong. |
| 6 | "A lead agent plus subagents beat one agent by 90.2% on breadth research, at about 15x the tokens" | [Anthropic 2025b] anthropic.com/engineering/built-multi-agent-research-system | CONFIRMED | Exact match: "outperformed single-agent Claude Opus 4 by 90.2%..."; "multi-agent systems use about 15× more tokens than chats." This is the URL that resolves — it settles the two-researcher URL conflict flagged in `research/brief.md` §9 and `runs/001-research-fanout/README.md`. |
| 6 (notes) | "15 to 40 percent less wall-clock and about 74 percent more tokens" on GAIA | [Xu 2026] arxiv.org/abs/2608.05791 | PARTIAL | Paper's own text says wall-clock time is "reduced by roughly 15%–40% in most configurations" (confirmed) — but per-level Table 1 shows the ~74% token increase belongs to **Level 1** (67.6k vs 38.8k tokens), where wall-clock savings were only ~2.6%, not 15–40%. The level with 18–65% less wall-clock (Levels 2–3) shows 62–91% more tokens, not 74%. The two numbers as paired on the slide are each real but do not co-occur in one row of the paper. |
| 7 | "Anthropic's five composable workflows... use the simplest solution possible" | [Anthropic 2024] anthropic.com/research/building-effective-agents | CONFIRMED | Page exists (Dec 19, 2024); lists prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer; exact quote: "we recommend finding the simplest solution possible." |
| 7 | "Do not split one sequential job across parallel agents: every variant lost 39–70%" | [Kim 2026] arxiv.org/abs/2512.08296 | CONFIRMED | Exact quote found: "for sequential reasoning tasks, every multi-agent variant we tested degraded performance by 39–70%." Breakdown: Hybrid −39.0%, Decentralized −41.4%, Centralized −50.4%, Independent −70.0%. |
| 8 | "Task verification failures are 23.5% of multi-agent failures" | [Cemri 2025] arxiv.org/abs/2503.13657 | CONFIRMED | MAST taxonomy over 1,600+ traces / 7 frameworks / 14 modes / 3 categories: system design 44.2%, inter-agent misalignment 32.3%, task verification 23.5% — confirmed via the paper's abstract and the NeurIPS proceedings PDF. |
| 8 (notes) | gwBenchmarks: agents "relied on proxy metrics, partial evaluation, or fabricated results" | [gwBench 2026] arxiv.org/abs/2605.11269 | CONFIRMED | Exact quote from abstract; authors Islam, Wadekar, Zhou, "gwBenchmarks: Stress-Testing LLM Agents on High-Precision Gravitational Wave Astronomy." |
| 8 (notes) | Stargazer: agents "achieve a good statistical fit" but "fail to recover correct physical system parameters" | [Stargazer 2026] arxiv.org/abs/2604.15664 | CONFIRMED | Exact quote from abstract; authors Liu, Zhang, Schölkopf, Jin, Menou. |
| 8 (notes) | "chaining a reviewer cut the hallucination score from 0.422 to 0.272 while factual accuracy also slipped from 0.789 to 0.769" | [Jamshidi 2026] arxiv.org/abs/2606.07937 | CONFIRMED | Exact match: "hallucination score from 0.422 at the first agent to 0.272 at the final agent in 3-agent chains" and "decline in factual accuracy from 0.789 to 0.769." |
| 9 | "cannot see what the other was doing" | [Cognition 2025] cognition.com/blog/dont-build-multi-agents | CONFIRMED | Page exists, by Walden Yan, "Don't Build Multi-Agents" (06.12.25). Close paraphrase of actual text: "Subagent 1 and subagent 2 cannot not see what the other was doing." |
| 9 | subagent worktree isolation / blocks writes to main checkout | [Claude Code worktrees] code.claude.com/docs/en/worktrees | CONFIRMED | Page confirms `isolation: worktree` frontmatter and that Claude Code "blocks an Edit, Write... that targets a path in the main checkout." |
| 9 | "the bottleneck is no longer generation, it's verification" | [Osmani] addyosmani.com/blog/code-agent-orchestra/ | CONFIRMED | Exact quote (near-verbatim): "The bottleneck is no longer generation. It's verification." |
| 10 | "260 configurations, 6 benchmarks... +80.8% / −39% to −70%" | [Kim 2026] arxiv.org/abs/2512.08296 | CONFIRMED | Abstract: "260 configurations spanning six agentic benchmarks... +80.8% on decomposable financial reasoning to -70.0% on sequential planning"; full-text range −39% to −70% confirmed above. |
| 12 | "10.9 min wall-clock vs about 38 min sequential; ~7,100 words of briefs, ~800 words returned" | [run 001] `runs/001-research-fanout/README.md` | CONFIRMED | Matches file exactly: 270 tool calls, ~602k subagent tokens, 10.9 min parallel / ~38 min sequential, ~7,100 words of briefs vs ~800 words of summaries returned. |
| 13 | worktree mechanics (`.worktrees/slides`, `.worktrees/diagrams`, branches `wt/slides`/`wt/diagrams`, merge, remove) | [pipeline/run.sh] `stage_write` | CONFIRMED | Read the function directly: matches `git worktree add -B "wt/$w" ...`, background run, `wait`, `git merge --no-edit`, `git worktree remove --force`, `git branch -D`. |
| 14 | "the dry run, run 005, took 319 s and cost $2.37 against the $3 default budget" | [run 005] `runs/005-critique/result.json` | CONFIRMED | `duration_ms: 319401` (≈319 s), `total_cost_usd: 2.3699795` (≈$2.37). Verdict in the file is REVISE, matching the notes' description of the critic loop. |
| 14 | "it prints that warning on exit code 2" | [pipeline/run.sh] `run_agent` | CONFIRMED | Line: `[[ $rc -eq 2 ]] && log "WARNING: $agent hit the --max-budget-usd ceiling (exit 2)..."`. |
| 15 | "Smallest line item: $0.019 for a 9-token reply, because each spawn pays about 4,400 tokens of system prompt" | [run 000] `runs/000-scaffold-verification/README.md` | CONFIRMED | Matches file exactly: "$0.019 for 9 output tokens. The system prompt is ~4,400 cache-creation tokens." |
| 15 | "only the cost stage rebuilds runs/cost-report.md" / critique row appended via log_result.py | [pipeline/run.sh] | CONFIRMED | Read `pipeline/log_result.py` (appends every stage's row to `runs/cost.tsv`) and `pipeline/cost_report.py` (only this script, run by `stage_cost`, rewrites `runs/cost-report.md`). Matches. |
| 16 | fresh subagent gets delegation message, CLAUDE.md, git snapshot; not conversation history or files read | [Claude Code subagents] code.claude.com/docs/en/sub-agents | CONFIRMED | Page's "What loads at startup" section matches point for point, including "It doesn't see your conversation history" and "the files Claude has already read." |
| 17 | "multi-agent used about 15x a chat's tokens" | [Anthropic 2025b] | CONFIRMED | Same post as slide 6; "agents typically use about 4× more tokens... multi-agent systems use about 15× more tokens than chats." |
| 17 | "later guidance says 3–10x" / do not split sequential phases | [Anthropic 2026] claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them | CONFIRMED | Exact match: "multi-agent implementations typically use 3-10x more tokens"; dated Jan 23, 2026; warns against splitting "planning, implementation, and testing of the same feature" across agents. |
| 17 | route cheap/local models to subagents, frontier model on orchestrator | [Claude Code subagents] | CONFIRMED | Page recommends "Control costs by routing tasks to faster, cheaper models like Haiku," `model` field example. |
| 18 | "Independent agents with no central check amplified errors 17.2x; with centralized verification, 4.4x" | [Kim 2026] | CONFIRMED | Exact quote and table confirmed: Independent 17.2×, Decentralized 7.8×, Hybrid 5.1×, Centralized 4.4× (vs. single-agent baseline 1.0×). |
| 19 | "Claude Code workflows forbid clock and random calls, so a relaunch repeats the same steps" | [Claude Code workflows] code.claude.com/docs/en/workflows | CONFIRMED | Exact: "Claude Code makes Date.now(), Math.random(), and a no-argument new Date() throw inside the script, so that a relaunched run repeats the same agent() calls." |
| 19 | "NASA SMD asks for reproducibility in agentic workflows" / "no established science-specific guardrails or factuality-checking mechanisms yet" | [NASA SMD 2025] assets.science.nasa.gov/.../SMD_Data_Computing_Strategy_2025_2030.pdf | CONFIRMED | Opened the PDF directly (Finding 4c, p.37): "As scientists increasingly rely on AI and agentic workflows... There are no established science-specific guardrails or factuality-checking mechanisms to ensure AI outputs conform to physical laws." Near-verbatim match. Minor: the document itself is dated **April 2026** (NASA/SP-20260002277), not 2025, though it covers the "2025–2030" strategy period — the citation label is defensible but the publication date is 2026. |
| 20 | "1,600+ traces, 7 frameworks, 14 failure modes" / 44.2% / 32.3% / 23.5% | [Cemri 2025] | CONFIRMED | Same as slide 8; independently reconfirmed via NeurIPS proceedings PDF and multiple third-party summaries, all reporting identical percentages. |
| 21 (Q&A notes) | agent teams "in plan mode they measured about 7x tokens" | [Claude Code agent teams] code.claude.com/docs/en/agent-teams; [7x] code.claude.com/docs/en/costs | CONFIRMED | Both pages exist; exact quote on the costs page: "Agent teams use approximately 7x more tokens than standard sessions when teammates run in plan mode." Agent-teams page confirms "experimental and disabled by default," interactive-only, and "check whether a lighter option [subagents] does the job" first. |
| Sources 1/4 | URL exists | [Liu 2023] | CONFIRMED | Resolves; correct paper. |
| Sources 1/4 | URL exists | [Hsieh 2024] | CONFIRMED | Resolves; correct paper. |
| Sources 1/4 | URL exists | [Anthropic 2025a] | CONFIRMED | Resolves. |
| Sources 1/4 | URL exists | [Tran & Kiela 2026] | CONFIRMED | Resolves; correct paper, correct authors (Stanford). |
| Sources 1/4 | URL exists | [Kapoor 2024] | CONFIRMED | Resolves; correct paper. |
| Sources 1/4 | URL exists | [Anthropic 2025b] | CONFIRMED | Resolves — this is the URL that should be used repo-wide (see slide 6 row). |
| Sources 2/4 | URL exists | [Xu 2026] | CONFIRMED | Resolves; correct paper and authors (Xu, Tian, Jiang), ICML 2026. |
| Sources 2/4 | URL exists | [Anthropic 2024] | CONFIRMED | Resolves. |
| Sources 2/4 | URL exists | [Kim 2026] | CONFIRMED | Resolves; arXiv 2512.08296, "Towards a Science of Scaling Agent Systems," Kim et al. |
| Sources 2/4 | URL exists | [Cemri 2025] | CONFIRMED | Resolves. |
| Sources 2/4 | URL exists | [gwBench 2026] | CONFIRMED | Resolves. |
| Sources 2/4 | URL exists | [Stargazer 2026] | CONFIRMED | Resolves. |
| Sources 3/4 | URL exists | [Jamshidi 2026] | CONFIRMED | Resolves; title "Hallucination Cascade: Analyzing Error Propagation in Multi-Agent LLM Systems," not literally "chained-agent hallucination" as glossed, but same paper/content. |
| Sources 3/4 | URL exists | [Cognition 2025] | CONFIRMED | Resolves. |
| Sources 3/4 | URL exists | [Osmani] | CONFIRMED | Resolves. |
| Sources 3/4 | URL exists | [Claude Code worktrees] | CONFIRMED | Resolves. |
| Sources 3/4 | URL exists | [Claude Code subagents] | CONFIRMED | Resolves. |
| Sources 3/4 | URL exists | [Anthropic 2026] | CONFIRMED | Resolves; dated Jan 23, 2026, matching the slide notes. |
| Sources 4/4 | URL exists | [Claude Code workflows] | CONFIRMED | Resolves. |
| Sources 4/4 | URL exists | [Claude Code agent teams] + [costs] | CONFIRMED | Both resolve. |
| Sources 4/4 | URL/PDF exists | [NASA SMD 2025] | CONFIRMED | PDF opened directly and read; see slide 19 row. |
| Sources 4/4 | Internal refs exist | [run 000], [run 001], [run 005], [pipeline/run.sh] | CONFIRMED | All four are real files in this repo, read directly; content matches every slide claim that cites them (see rows above). |

## Required edits

1. **Slide 4, Kapoor 2024 ("cost over 50x a simple retry baseline at similar accuracy").**
   The 50x figure is real but belongs to the paper's **"Warming"** baseline, not "Retry," and Warming's
   accuracy (93.2%) was *higher* than the complex agent's (88.0%), not merely similar.
   Corrected wording: *"One agent framework (LATS) cost over 50x a simple baseline (Warming) that matched
   or beat its accuracy [Kapoor 2024]."* Or, if "retry" must stay for brevity, say "a simple baseline"
   instead of "a simple retry baseline."

2. **Slide 6 notes, Xu 2026 ("15 to 40 percent less wall-clock and about 74 percent more tokens").**
   These two numbers do not come from the same configuration in the paper. Wall-clock savings of
   15–40% are real as a general statement, and 74% more tokens is real but specific to the
   *least*-improved level (Level 1, only ~2.6% less wall-clock). Either drop the specific 74% figure and
   say "tokens rose substantially (62–91% in the paper's per-level results)," or pick one paired row, e.g.
   *"Level 3: 65% less wall-clock at 62% more tokens [Xu 2026]."*

3. **Sources 4/4, NASA SMD 2025 citation year.** The PDF itself is dated **April 2026**
   (NASA/SP-20260002277), even though it covers the "2025–2030" strategy period. Consider relabeling the
   reference tag `[NASA SMD 2026]` for accuracy, or keep `[NASA SMD 2025]` only if the deck is
   deliberately citing the strategy's named period rather than its publication date — either is
   defensible, but pick one and be consistent with the "retrieved 2026-09-15" convention used elsewhere
   on the Sources slides.

4. **Sources 3/4, Jamshidi 2026 gloss.** The tag reads "chained-agent hallucination"; the paper's actual
   title is *"Hallucination Cascade: Analyzing Error Propagation in Multi-Agent LLM Systems."* Not
   wrong, but consider using the real title so a reader searching for it finds it faster.

No row was scored NOT FOUND or CONTRADICTED: every citation on the deck opened, matched an existing
document, and the great majority of numbers matched exactly. The two PARTIAL rows above are precision
issues (a mislabeled baseline name; two true numbers from different rows of one paper presented as a
pair), not fabrications — nothing on this deck appears to be an invented source.

## Tally

CONFIRMED: 44 · PARTIAL: 2 · NOT FOUND: 0 · CONTRADICTED: 0
