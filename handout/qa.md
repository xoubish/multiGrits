# Q&A prep — "Multi-agent workflows" (Shooby, GRITS Day 2)

Ten questions this room is most likely to ask, hardest first within reason, ordered by how
likely I think each one is to come up in the 3-minute floor. This audience used Claude Code
once already, sat through Nick on model selection an hour ago, and hears BJ on sandboxing
right after me — they will ask about cost, whether any of this is reproducible, whether an
agent's output is actually correct, and why not just write one good prompt. All four of those
are below. Every answer is grounded in a research brief or a file already in this repo; nothing
here is asserted without a URL or a path.

---

## 1. "What did this whole thing cost, and is that number believable?"

**Answer:** Every stage logs its own prompt, return, tokens, and dollar figure in
`runs/cost-report.md` (this repo); as of this writing the two outline runs alone (002, 003)
cost $1.26 over 566 seconds and about 660k combined tokens, and the critic dry run (run 005)
cost $2.37 in 319 seconds against a $3 default budget cap, independently confirmed by the
fact-checker (`runs/005-critique/result.json`; `runs/009-factcheck/factcheck.md`, this repo).
Anthropic's own guidance puts multi-agent overhead at 3–10x a single-agent chat's tokens,
revised down from an earlier 15x figure measured on their internal research system
(https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them;
https://www.anthropic.com/engineering/built-multi-agent-research-system) — both vendor
numbers, so treat them as an upper bound, not a promise for your workload.

**If pressed:** "Pull it up live — `pipeline/run.sh cost` — I don't give you a number I can't show you the receipt for."

---

## 2. "Why not just use one strong agent with a good prompt instead of four agents coordinating?"

**Answer:** For most single-window tasks, one good prompt wins outright. Tran and Kiela held
thinking-token budget constant and found single agents "consistently match or outperform" five
multi-agent designs on FRAMES and multi-hop QA (0.427 vs 0.386 at a 5,000-token budget), with
multi-agent only pulling ahead once 70% of the context was masked or corrupted
(https://arxiv.org/abs/2604.02460) — that's the context-window argument, not an intelligence
one. Kapoor et al. separately showed a complex agent framework (LATS) cost over 50x a simple
baseline ("Warming") that matched or beat its own HumanEval accuracy
(https://arxiv.org/abs/2407.01502). So the honest rule is: reach for multiple agents only when
the task provably doesn't fit in one window; otherwise every extra agent is coordination tax.

**If pressed:** "If it fits in one window, use one agent — that's the slide right before the patterns, not something I'm hiding."

---

## 3. "How do you know the agent's analysis is actually correct instead of just sounding right?"

**Answer:** We don't take the agent's word for it, because agents are documented to fake
success. In gwBenchmarks, coding agents "frequently relied on proxy metrics, partial
evaluation, or fabricated results to spuriously complete tasks" on gravitational-wave analysis
code (Islam et al. 2026, https://arxiv.org/abs/2605.11269), and in Stargazer, agents "often
achieve a good statistical fit" but "frequently fail to recover correct physical system
parameters" (Liu et al. 2026, https://arxiv.org/abs/2604.15664). MAST independently found task
verification failures make up 23.5% of all failed multi-agent traces across 1,600+ traces and
7 frameworks (Cemri et al. 2025, https://arxiv.org/abs/2503.13657) — which is exactly why the
writer-critic pattern gives the reviewer tools (tests, schema, the data itself) instead of just
the writer's summary to read.

**If pressed:** "A good chi-squared is not a good answer — the critic has to run the check, not read about it."

---

## 4. "If I run this pipeline again tomorrow, do I get the same result? Is any of this reproducible?"

**Answer:** Partially, by construction, not by default. Claude Code's workflow feature makes
clock and random-number calls throw an error inside a scripted run, so a relaunch issues the
same agent calls in the same order (https://code.claude.com/docs/en/workflows), and this
repo's shell script — not the agents — decides topology, order, and budget caps for exactly
that reason. But NASA SMD's 2025–2030 data and computing strategy states plainly there are "no
established science-specific guardrails or factuality-checking mechanisms" for agentic
workflows and flags reproducibility-versus-replicability as an open problem
(https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf).
This repo has already caught its own drift: the researcher agent is pinned to Sonnet, but the
logged run 001 actually ran on the parent model because that session hadn't picked up the pin
(`runs/001-research-fanout/README.md`, this repo).

**If pressed:** "The script and the receipts reproduce; the model's exact wording doesn't — and we log that gap instead of hiding it."

---

## 5. "Half your citations are Anthropic's own blog posts. Isn't that just vendor marketing?"

**Answer:** Fair, and worth naming directly: Anthropic's 90.2%-gain, ~15x-token claim is their
own internal eval, not independently replicated
(https://www.anthropic.com/engineering/built-multi-agent-research-system). But the same shape
shows up in work with nothing to sell: Kim et al. (Google/MIT, 260 configurations, 6
benchmarks, 3 model families) independently found multi-agent gains up to +80.8% on
decomposable tasks and losses up to −70% on sequential ones
(https://arxiv.org/abs/2512.08296), and Tran and Kiela's equal-token-budget study found single
agents matching or beating multi-agent designs outright
(https://arxiv.org/abs/2604.02460). Everywhere this deck leans on one vendor's number, there's
an independent result making the same or a more conservative point next to it.

**If pressed:** "Cross out every Anthropic citation on these slides and the thesis still stands on Kim et al. and Tran and Kiela alone."

---

## 6. "Does any of this hold up on real archive work, or is it all coding benchmarks and cosmology toy problems?"

**Answer:** Some is already deployed, and it's shakier than the toy benchmarks suggest. IPAC's
own AstroFetch (NASA Exoplanet Archive, open beta since July 2026) turns a plain-language
question into ADQL and shows the query, and its own tips page warns "column-name mismatches
are the most common error mode" and that long conversations "dilute accuracy"
(https://astrofetch.ipac.caltech.edu/). On a harder, independent test, the best of 13 models on
ALeRCE hit 97% on simple text-to-query tasks but only 44% row-match on medium queries and 59%
on hard ones (Estevez et al. 2026, https://arxiv.org/abs/2606.18108). The plumbing to reach
IRSA, NED, and the Exoplanet Archive from an agent already exists via astroquery and MCP
wrappers (https://github.com/igaurab/astroquery-mcp) — the accuracy on anything past easy
queries does not, yet.

**If pressed:** "Trust the query it writes the way you'd trust a new grad student's first ADQL — read it before you run it."

---

## 7. "What actually happens when two agents touch the same file, and how do you know the merge is right?"

**Answer:** Mechanically it's the classic failure, and it's measured, not folklore: Kim et al.
found independent agents with no central check amplified errors 17.2x versus 4.4x under
centralized verification, on the same tasks and models
(https://arxiv.org/abs/2512.08296). Git worktrees fix the silent half of it — each agent gets
its own checkout, so a collision becomes a merge conflict git shows you instead of a corrupted
file (https://code.claude.com/docs/en/worktrees) — but isolation does not fix conflicting
implicit decisions between agents that never saw each other's work; it only makes them visible
(Cognition 2025, https://cognition.com/blog/dont-build-multi-agents). The merge still has to
happen in one place with something that checks: tests, a schema, or a critic with tools, which
is what this pipeline's script plus critic loop does.

**If pressed:** "Worktrees turn a silent bug into a visible merge conflict — they don't turn a bad merge into a good one."

---

## 8. "What's the failure rate if you let this run with nobody watching?"

**Answer:** Poor, in every published astronomy case so far. The first cosmology multi-agent
system to reproduce ACT DR6 lensing constraints "required human feedback at all stages," and
its authors warn LLMs "frequently produce over-confident, plausible-looking but physically
incorrect responses" (Laverick et al. 2024, https://arxiv.org/abs/2412.00431). In the FAIR
Universe weak-lensing challenge, "the fully autonomous exploration initially did not reach
expert-level performance"; only agents plus human intervention took first place (Borrett et
al. 2026, https://arxiv.org/abs/2604.09621). Denario's own project lead told the Simons
Foundation that most outputs "were deemed unsuitable in reviews by experts" and only "about 10
percent" raised anything intriguing
(https://www.simonsfoundation.org/2025/11/04/meet-denario-an-ai-assistant-for-every-step-of-the-scientific-process/).

**If pressed:** "Nobody has published an astronomy multi-agent system that works unsupervised yet — that's exactly why BJ's talk is next."

---

## 9. "Isn't the whole 'multi-agent advantage' just extra tokens and compute, not better reasoning?"

**Answer:** Largely, yes, by the vendor's own account: Anthropic says token usage alone
explained 80% of the variance in their BrowseComp result, and their multi-agent system used
about 15x a chat's tokens for its headline 90.2% gain
(https://www.anthropic.com/engineering/built-multi-agent-research-system). Tran and Kiela's
equal-thinking-budget comparison confirms it from the other direction: hold tokens constant and
single agents "consistently match or outperform" five multi-agent designs
(https://arxiv.org/abs/2604.02460). So most of the measured advantage is bought with tokens,
not unlocked by splitting into roles, which is why this talk frames multi-agent as context
management rather than added intelligence.

**If pressed:** "Nobody has yet run the control of just tripling one agent's budget instead of splitting it three ways — that's an open ablation, not a settled no."

---

## 10. "Did the pipeline that built this deck actually get anything wrong?"

**Answer:** Yes, and it's logged rather than smoothed over. The four parallel researchers were
told to write 600–1,200 words each; all four ran over (about 1,260 to 2,500 words) and only one
said why, and two researchers cited the same Anthropic post under two different URLs, which the
orchestrator's hand-merge caught (`runs/001-research-fanout/README.md`, this repo). The
independent fact-check of this deck found two precision errors — a cost baseline mislabeled
"Retry" when the paper calls it "Warming," and a wall-clock/token pair from Xu et al. that
doesn't come from the same row of the same table (`runs/009-factcheck/factcheck.md`, this
repo) — no fabricated sources, but real sloppiness a human caught, not the model noticing on
its own. That tracks with MAST's finding that system-design and specification failures are the
single largest category, 44.2% of all traces (Cemri et al. 2025,
https://arxiv.org/abs/2503.13657).

**If pressed:** "Read `runs/009-factcheck/factcheck.md` — it's the itemized list of exactly what we got wrong and how it was fixed."

---

## The three questions I can't answer well yet

**1. Will the live critic call in today's demo actually finish inside its window, reliably?**
I have exactly one timed sample: run 005 took 319 seconds and cost $2.37 against a $3 default
cap (`runs/005-critique/result.json`, this repo). One data point is not a distribution — I
don't know the P90 finishing time under today's network conditions or usage load. What would
change my mind: several more repeated, timed critique runs under demo-day conditions (same
budget cap, similar time of day), enough to state a real worst-case, not a single dry run
treated as typical.

**2. Does any of this transfer to IPAC's own archive and pipeline work with anything like the
rigor behind the software-engineering benchmarks cited?** The astronomy evidence base is thin
and mostly self-graded — cmbagent, Denario, and AstroReview's 87%-accuracy figure are the
authors evaluating their own systems (`research/briefs/D-astronomy.md`), and the one
independent, held-out test I have (ALeRCE text-to-query) shows accuracy collapsing on anything
past simple queries (https://arxiv.org/abs/2606.18108). What would change my mind: an IPAC-run
pilot on a real archive task, with held-out ground truth and blind human grading, not a
vendor's internal eval or an author grading their own tool.

**3. How much of the measured "multi-agent gain" in the literature is genuine reasoning
benefit versus just more tokens spent, for the specific tasks in this deck (archive fan-out,
ADQL writer-critic)?** Anthropic says token count alone explains 80% of BrowseComp variance,
and Tran and Kiela found equal-budget parity on QA benchmarks
(https://arxiv.org/abs/2604.02460) — but that ablation has only been run on general reasoning
benchmarks (FRAMES, MuSiQue), never on an archive or pipeline task. What would change my mind:
an equal-token-budget comparison of one strong agent versus this deck's own patterns on a real
IPAC task, not an extrapolation from someone else's QA benchmark.
