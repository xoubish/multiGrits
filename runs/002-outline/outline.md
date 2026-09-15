# Outline — Multi-agent workflows (GRITS Day 2, 11:15–11:45)

21 slides (≤25 limit). Segment order and content follow the fixed structure in `talk-context.md`.

## Timing reconciliation (read this first)

`talk-context.md`'s segment table sums to 27 min of content + 3 min Q&A = 30 min, but its own prose
says "25 minutes of content and 5 minutes of Q&A" (also 30 min), and the outliner's own instructions
require slide time budgets to sum to exactly **1500 seconds (25 min)**. The two numbers inside
talk-context.md do not agree with each other (27+3 vs 25+5). Resolution used below, logged also in
`runs/002-outline/notes.md`:

- **Content slides (segments 1–4): exactly 1500 s**, holding the Live Demo segment at the table's
  literal 12 min (720 s, needed for clean minute markers) and scaling Why/Patterns/Gotchas down from
  3/7/5 min to 2:30/6:10/4:20 (proportional to the table's relative weights) so the total lands on 1500 s.
- **Q&A + hand-off: 300 s (5 min)**, matching the prose exactly rather than the table's "3."
- Grand total: 1500 + 300 = 1800 s = 30 min, matching "30 minutes total." No segment is dropped;
  all five appear below.

Diagram slides (4 required, one per pattern) are marked **[DIAGRAM]**.

---

## Segment 1 — Why, and when not to (150 s)

**1. Title** — *Multi-agent workflows* — Shooby Hemmati, IPAC, GRITS Day 2.
Message: n/a (title card). Evidence: n/a. Time: 10 s.

**2. This deck was built by the pipeline you're about to see** *(meta-demo framing, required)*
Message: Everything on screen for the next 25 minutes — outline, slides, diagrams, citations — came
out of the same repo and the same six-stage pipeline the demo will show live.
Evidence: `runs/001-research-fanout/README.md`; `runs/README.md`; "The meta-demo" section of
`talk-context.md`.
Time: 20 s. Segment: Why.

**3. Why go multi-agent: context, not intelligence**
Message: One agent's context window fills up and quality degrades before it runs out of tokens;
delegating keeps the main thread clean.
Evidence: Liu et al., "Lost in the Middle," https://arxiv.org/abs/2307.03172 (>20-point mid-context
drop); Anthropic, https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
(subagents return a 1,000–2,000-token summary).
Time: 70 s. Segment: Why.

**4. When not to: most tasks don't need this**
Message: At equal token budgets, single agents match or beat multi-agent designs on reasoning tasks;
coordination overhead is real, and simple retry beats fancy orchestration on cost-vs-accuracy.
Evidence: Tran & Kiela 2026, https://arxiv.org/abs/2604.02460 (0.427 vs 0.386 at equal 5k-token
budget); Kapoor et al., https://arxiv.org/abs/2407.01502 (Pareto-efficient simple baselines).
Time: 50 s. Segment: Why.

---

## Segment 2 — Four patterns, one diagram each (370 s)

**5. Four patterns, one shape each** *(transition)*
Message: Every multi-agent design on this stage reduces to one of four shapes; here they are, cheapest
first.
Evidence: n/a (organizational). Time: 20 s. Segment: Patterns.

**6. Pattern 1 · Fan-out and merge** **[DIAGRAM]**
Message: Independent subtasks run in parallel and get merged centrally — the one case the literature
agrees on for breadth-first work.
Evidence: Anthropic, https://www.anthropic.com/engineering/built-multi-agent-research-system (90.2%
gain over single-agent Opus 4); Kim et al., https://arxiv.org/abs/2512.08296 (+80.8% on a decomposable
task, centralized).
Time: 80 s. Segment: Patterns.

**7. Pattern 2 · Pipeline** **[DIAGRAM]**
Message: Planner, implementer, tester in sequence, each stage a fresh context — but don't split one
sequential job across parallel agents.
Evidence: Anthropic, https://www.anthropic.com/research/building-effective-agents (five composable
workflows); Kim et al., https://arxiv.org/abs/2512.08296 (sequential planning: −39% to −70%).
Time: 80 s. Segment: Patterns.

**8. Pattern 3 · Writer and critic** **[DIAGRAM]**
Message: A critic with tools in hand catches real errors; a critic without tools tends to rubber-stamp.
Evidence: Cemri et al. (MAST), https://arxiv.org/abs/2503.13657 (task verification failures, 23.5%);
Islam et al. (gwBenchmarks), https://arxiv.org/abs/2605.11269, and Liu et al. (Stargazer),
https://arxiv.org/abs/2604.15664 (agents fake or mis-fit results).
Time: 80 s. Segment: Patterns.

**9. Pattern 4 · Parallel isolated workers** **[DIAGRAM]**
Message: Separate git worktrees remove the two-agents-one-file failure; the bottleneck moves to
verification.
Evidence: Anthropic, https://code.claude.com/docs/en/worktrees (`isolation: worktree`, writes to main
checkout blocked); Cognition, https://cognition.com/blog/dont-build-multi-agents (implicit-decision
conflicts); Osmani, https://addyosmani.com/blog/code-agent-orchestra/ ("no merge conflicts while they
work").
Time: 80 s. Segment: Patterns.

**10. Task shape decides — the reconciling result**
Message: One paper explains both halves of this deck: +80.8% on decomposable work, −70% on sequential
work, from the same 260-configuration study.
Evidence: Kim et al., https://arxiv.org/abs/2512.08296.
Time: 30 s. Segment: Patterns.

---

## Segment 3 — Live demo of one pattern (720 s = 12 min)

Minute-by-minute; every artifact shown already exists in this repo except the one live call in minute
6–10.

**11. Live: the pipeline builds — and checks — this talk** (min 0:00–1:00)
On screen: title slide, then cut to a terminal at the repo root.
Message: The next 11 minutes are the repo, not slides.
Fallback (state out loud now): if any live call fails, times out, or hits the `--max-budget-usd` cap,
fall back to the runs already logged in `runs/000-scaffold-verification/` and
`runs/001-research-fanout/` and narrate them the same way.
Evidence: `runs/README.md`. Time: 60 s.

**12. Pattern 1, already run: the research fan-out** (min 1:00–4:00)
On screen: `runs/001-research-fanout/README.md` (4 researchers, ~602k subagent tokens, 10.9 min
wall-clock in parallel vs ~38 min sequential), then `research/briefs/*.md`, then the merged
`research/brief.md`.
Message: Four parallel researchers wrote ~7,100 words; the orchestrator read them and merged by hand
into one brief — that merge is the centralizing step the patterns slide called for.
Evidence: `runs/001-research-fanout/README.md`. Time: 180 s.

**13. Pattern 4, already run: parallel worktrees** (min 4:00–6:00)
On screen: `pipeline/run.sh`, the `stage_write()` function (two worktrees, `slide-writer` and
`diagrammer`, run in the background, merged and removed), then `git log --oneline` showing the two
merge commits.
Message: The script opens the worktrees, runs both agents at once, merges both branches — the script
owns the loop, not the agents.
Evidence: `pipeline/run.sh` (lines 85–111); `runs/README.md`. Time: 120 s.

**14. Live now: the critic vs. this deck** (min 6:00–10:00)
On screen: run `pipeline/run.sh critique` in the terminal; watch `runs/0NN-critique/prompt.md` get
written, `result.json` populate, then open `critique.md` — a PASS/REVISE verdict scored against 7
criteria, including "demo segment: concrete, minute by minute, with a stated fallback" (this slide,
scoring itself).
Message: This is the writer-and-critic pattern, live, against the exact deck and outline being
presented.
Fallback: if the call errors or exceeds the $3 budget cap (exit code 2, per `pipeline/run.sh`), open
the critique already produced in an earlier dry run and read its findings aloud instead of re-running.
Evidence: `.claude/agents/critic.md`; `pipeline/run.sh` (`stage_critique`). Time: 240 s.

**15. What that cost** (min 10:00–12:00)
On screen: `runs/cost-report.md` (from `pipeline/cost_report.py`) and the $0.019-for-9-output-tokens
line from the run 000 smoke test.
Message: Every stage left a receipt — prompt, return, tokens, dollars — that's how you audit a
multi-agent pipeline instead of trusting it.
Evidence: `runs/000-scaffold-verification/README.md`; `pipeline/cost_report.py`. Time: 120 s.

---

## Segment 4 — Gotchas and cost (260 s)

**16. Gotcha: subagents are context-blind**
Message: A fresh subagent gets your delegation message, `CLAUDE.md`, and a git snapshot — not your
conversation. Make it return a summary, not a dump.
Evidence: https://code.claude.com/docs/en/sub-agents. Time: 55 s.

**17. Gotcha: cost multiplies with agent count**
Message: Multi-agent runs ~3–15x a single chat's tokens; put cheap or local models on subagents,
the frontier model on the orchestrator — pricing details are Nick's talk.
Evidence: https://www.anthropic.com/engineering/built-multi-agent-research-system (15x, June 2025);
https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them (3–10x, Jan 2026).
Time: 60 s.

**18. Gotcha: isolate the files, centralize the merge**
Message: Two agents editing one file is the classic failure — worktrees fix it — and a centralized
merge cuts error amplification from 17.2x to 4.4x versus independent agents.
Evidence: https://code.claude.com/docs/en/worktrees; Kim et al., https://arxiv.org/abs/2512.08296.
Time: 60 s.

**19. Gotcha: script the orchestration**
Message: Prefer a script that calls agents over agents spawning agents — reproducibility needs a plan
that doesn't change between runs.
Evidence: https://code.claude.com/docs/en/workflows (`Date.now()`/`Math.random()` throw so reruns
repeat); NASA SMD 2025–2030 strategy, https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf
("no established science-specific guardrails" for agentic workflows).
Time: 50 s.

**20. How it actually fails**
Message: System design 44%, inter-agent misalignment 32%, verification 24% — coordination overhead
shows up as specific, catalogued failures, not vague risk.
Evidence: Cemri et al. (MAST), https://arxiv.org/abs/2503.13657.
Time: 35 s.

---

## Segment 5 — Q&A and hand-off to BJ (300 s, separate from the 1500 s content budget)

**21. Questions — and a hand-off**
Message: One line to close: many unsupervised agents means you need sandboxing — that's the next talk.
Evidence: `talk-context.md` non-goals section (internal, no external URL — this is a scheduling
hand-off, not a factual claim).
Time: 300 s, mostly open floor.

---

## Cuts if running long

Ordered by what to drop first; none of these touch slide 2, the four diagram slides, or the live
critic call (minute 6–10 of the demo), which are load-bearing requirements.

1. **Slide 20** (How it actually fails / MAST breakdown) — cut whole slide; mention "multi-agent fails
   in catalogued, specific ways" verbally in one clause while moving from slide 19 to Q&A.
2. **Slide 5** (four-patterns transition) — skip the slide, say the line while slide 4 is still up.
3. **Slide 13** (parallel worktrees walkthrough) — fold into slide 12's narration as one spoken
   sentence ("the write stage that made this deck used the same worktree pattern") instead of a
   separate terminal detour.
4. **Slide 10** (task-shape-decides recap) — drop the dedicated slide; state the +80.8%/−70% number
   once, during slide 7 (Pipeline), instead of twice.
5. **Slide 19** (script-the-orchestration gotcha) — compress into one spoken sentence appended to
   slide 18 instead of its own slide.
6. **Slide 15** (cost-report screen time) — if the live critic call (slide 14) overran its 240 s,
   shorten this to a single spoken number ("that run cost $X") instead of opening the file on screen.
