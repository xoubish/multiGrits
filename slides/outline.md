# Outline — Multi-agent workflows (GRITS Day 2, 11:15–11:45)

21 slides (≤25 limit). Segment order and content follow the fixed structure in `talk-context.md`.

## Timing check (read this first)

`talk-context.md` states the length as "30 minutes total" and calls the segment table binding:
27 minutes of content (1620 s) and 3 minutes of Q&A plus hand-off (180 s). The table itself
(Why 3 + Patterns 7 + Demo 12 + Gotchas 5 = 27; Q&A 3) sums consistently to 27 + 3 = 30, and the
prose does not state a conflicting number anywhere else in the file. **No contradiction found this
run** — unlike an earlier draft of this outline (see `runs/002-outline/notes.md`), the current
`talk-context.md` is internally consistent, so the table is used directly with no rescaling:

- Why, and when not to — 3 min = **180 s**
- Four patterns, one diagram each — 7 min = **420 s**
- Live demo of one pattern — 12 min = **720 s**
- Gotchas and cost — 5 min = **300 s**
- Content subtotal: **1620 s**, matching the instruction exactly.
- Q&A and hand-off to BJ — 3 min = **180 s**.
- Grand total: 1620 + 180 = **1800 s = 30 min**.

Diagram slides (4 required, one per pattern) are marked **[DIAGRAM]**.

---

## Segment 1 — Why, and when not to (180 s)

**1. Title** — *Multi-agent workflows* — Shooby Hemmati, IPAC, GRITS Day 2, Advanced track.
Message: n/a (title card). Evidence: n/a. Time: 10 s. Segment: Why.

**2. This deck was built by the pipeline you're about to see** *(meta-demo framing, required)*
Message: Everything on screen for the next 25 minutes — the outline, these slides, the diagrams,
every citation — came out of the same repo and the same multi-agent pipeline the demo segment
shows running live.
Evidence: `runs/001-research-fanout/README.md`; `runs/README.md`; "The meta-demo" section of
`talk-context.md`.
Time: 30 s. Segment: Why.

**3. Why go multi-agent: context, not intelligence**
Message: One agent's context window fills up and quality degrades well before it runs out of
tokens; delegating bounded subtasks to fresh subagents keeps the main thread clean.
Evidence: Liu et al., "Lost in the Middle," https://arxiv.org/abs/2307.03172 (>20-point mid-context
drop, below closed-book score); Anthropic,
https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents (subagents
return a condensed 1,000–2,000-token summary).
Time: 80 s. Segment: Why.

**4. When not to: most tasks don't need this**
Message: At equal token budgets, single agents match or beat multi-agent designs on reasoning
tasks; coordination overhead is real, and simple retry/escalation baselines beat fancy
orchestration on cost vs. accuracy.
Evidence: Tran & Kiela 2026, https://arxiv.org/abs/2604.02460 (0.427 vs 0.386 at an equal 5k-token
budget); Kapoor et al., https://arxiv.org/abs/2407.01502 (simple baselines Pareto-efficient; one
agent framework cost >50x a simple baseline at similar accuracy).
Time: 60 s. Segment: Why.

---

## Segment 2 — Four patterns, one diagram each (420 s)

**5. Four patterns, one shape each** *(transition)*
Message: Every multi-agent design on this stage reduces to one of four shapes; here they are.
Evidence: n/a (organizational, previews the four patterns named in `talk-context.md`).
Time: 20 s. Segment: Patterns.

**6. Pattern 1 · Fan-out and merge** **[DIAGRAM]**
Message: Independent subtasks run in parallel and get merged centrally — the one case the
literature agrees on for breadth-first work.
Evidence: Anthropic, https://www.anthropic.com/engineering/built-multi-agent-research-system
(90.2% gain over single-agent Opus 4, ~15x tokens); Kim et al.,
https://arxiv.org/abs/2512.08296 (+80.8% on a decomposable task, centralized coordination).
Time: 90 s. Segment: Patterns.

**7. Pattern 2 · Pipeline** **[DIAGRAM]**
Message: Planner, implementer, tester run in sequence, each stage gets a fresh context — but don't
split one sequential job across parallel agents.
Evidence: Anthropic, https://www.anthropic.com/research/building-effective-agents (five composable
workflows; "the simplest solution possible"); Kim et al., https://arxiv.org/abs/2512.08296
(sequential planning degraded 39–70% by every multi-agent variant).
Time: 90 s. Segment: Patterns.

**8. Pattern 3 · Writer and critic** **[DIAGRAM]**
Message: A critic with tools in hand catches real errors; a critic without tools tends to
rubber-stamp, and even a working critic is not free.
Evidence: Cemri et al. (MAST), https://arxiv.org/abs/2503.13657 (task verification failures,
23.5% of traces); Islam et al. (gwBenchmarks), https://arxiv.org/abs/2605.11269, and Liu et al.
(Stargazer), https://arxiv.org/abs/2604.15664 (agents fake or mis-fit results); Jamshidi et al.,
https://arxiv.org/abs/2606.07937 (hallucination fell 0.422→0.272 but factual accuracy also slipped
0.789→0.769 across chained agents).
Time: 90 s. Segment: Patterns.

**9. Pattern 4 · Parallel isolated workers** **[DIAGRAM]**
Message: Separate git worktrees remove the two-agents-one-file failure; once generation is
parallel, the bottleneck moves to verification.
Evidence: Anthropic, https://code.claude.com/docs/en/worktrees (`isolation: worktree`, writes to
main checkout blocked); Cognition, https://cognition.com/blog/dont-build-multi-agents (parallel
subagents "cannot see what the other was doing," implicit-decision conflicts); Osmani,
https://addyosmani.com/blog/code-agent-orchestra/ ("no merge conflicts while they work," "the
bottleneck is no longer generation, it's verification").
Time: 90 s. Segment: Patterns.

**10. Task shape decides — the reconciling result**
Message: One 260-configuration study explains both halves of this deck: +80.8% on decomposable
work, −39 to −70% on sequential work, from the same experiment.
Evidence: Kim et al., https://arxiv.org/abs/2512.08296.
Time: 40 s. Segment: Patterns.

---

## Segment 3 — Live demo of one pattern (720 s = 12 min)

Minute-by-minute; every artifact shown already exists in this repo except the one live call in
minute 6–10.

**11. Live: the pipeline builds — and checks — this talk** (on screen 0:00–1:00)
On screen: title slide, then cut to a terminal at the repo root; `ls runs/` shows the numbered
stage directories.
Message: The next 11 minutes are the repo, not slides.
Fallback: if the terminal, network, or any live call fails at any point in this segment, fall back
to narrating the logs already committed in `runs/000-scaffold-verification/` and
`runs/001-research-fanout/` from a second terminal tab opened in advance, using the same
minute-by-minute script.
Evidence: `runs/README.md`. Time: 60 s.

**12. Pattern 1, already run: the research fan-out** (on screen 1:00–4:00)
On screen: `runs/001-research-fanout/README.md` (4 researchers, parallel web access, ~10.9 min
wall-clock vs. ~38 min sequential), then `research/briefs/*.md` (four ~1,800-word briefs), then
the merged `research/brief.md`.
Message: Four parallel researchers produced ~7,000 words; the orchestrator read all four and
merged them by hand into one brief — that hand merge is the centralizing step Pattern 1's slide
called for.
Evidence: `runs/001-research-fanout/README.md`. Time: 180 s.

**13. Pattern 4, already run: parallel worktrees** (on screen 4:00–6:00)
On screen: `pipeline/run.sh`, the `stage_write()` function (two worktrees, `slide-writer` and
`diagrammer`, launched together, merged and removed), then `git log --oneline` showing the two
merge commits side by side.
Message: The script opens both worktrees, runs both agents at once, and merges both branches — the
script owns the loop, not the agents.
Evidence: `pipeline/run.sh` (`stage_write` function); `runs/README.md`. Time: 120 s.

**14. Live now: the critic vs. this deck** (launched at 0:00 on slide 11; on screen 6:00–10:00)
On screen: run `pipeline/run.sh critique` in the terminal; watch `runs/0NN-critique/prompt.md` get
written, `result.json` populate, then open `critique.md` — a PASS/REVISE verdict scored against
named criteria, including "demo segment: concrete, minute by minute, with a stated fallback" (this
slide, scoring itself).
Message: This is the writer-and-critic pattern, live, run against the exact deck and outline being
presented right now.
Fallback: if the call errors, times out, or exceeds the `--max-budget-usd` cap, stop the run,
say so out loud, and open the critique already produced in an earlier dry run instead — read its
findings aloud rather than re-running live.
Evidence: `.claude/agents/critic.md`; `pipeline/run.sh` (`stage_critique`). Time: 240 s.

**15. What that cost** (on screen 10:00–12:00)
On screen: `runs/cost-report.md` (built by `pipeline/cost_report.py` from `runs/cost.tsv`), plus
the $0.019-for-a-9-token-reply line from the run-000 smoke test.
Message: Every stage left a receipt — prompt, return, tokens, dollars — that's how you audit a
multi-agent pipeline instead of trusting it.
Evidence: `runs/000-scaffold-verification/README.md`; `pipeline/cost_report.py`. Time: 120 s.

---

## Segment 4 — Gotchas and cost (300 s)

**16. Gotcha: subagents are context-blind**
Message: A fresh subagent gets your delegation message, `CLAUDE.md`, and a git snapshot — not your
conversation history or the files you've read. Make it return a summary, not a dump.
Evidence: https://code.claude.com/docs/en/sub-agents.
Time: 65 s. Segment: Gotchas.

**17. Gotcha: cost multiplies with agent count**
Message: Multi-agent runs several times a single chat's tokens; put cheap or local models on
subagents, the frontier model on the orchestrator — pricing tables are Nick's talk, not this one.
Evidence: https://www.anthropic.com/engineering/built-multi-agent-research-system (~15x tokens vs.
chat, Jun 2025); https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them
(3–10x, Jan 2026); https://code.claude.com/docs/en/sub-agents (route to "faster, cheaper models
like Haiku").
Time: 70 s. Segment: Gotchas.

**18. Gotcha: isolate the files, centralize the merge**
Message: Two agents editing one file is the classic failure — worktrees fix it — and centralizing
the merge cuts error amplification from 17.2x to 4.4x versus independent agents merging themselves.
Evidence: https://code.claude.com/docs/en/worktrees; Kim et al., https://arxiv.org/abs/2512.08296.
Time: 70 s. Segment: Gotchas.

**19. Gotcha: script the orchestration**
Message: Prefer a script that calls agents over agents spawning agents — reproducibility needs a
plan that doesn't change between runs.
Evidence: https://code.claude.com/docs/en/workflows (`Date.now()`/`Math.random()` throw so a
relaunched run repeats the same calls); NASA SMD 2025–2030 strategy,
https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf
("no established science-specific guardrails or factuality-checking mechanisms" for agentic
workflows).
Time: 55 s. Segment: Gotchas.

**20. How it actually fails**
Message: System design 44%, inter-agent misalignment 32%, task verification 24% — coordination
overhead shows up as specific, catalogued failure modes, not vague risk.
Evidence: Cemri et al. (MAST), https://arxiv.org/abs/2503.13657 (1,600+ traces, 7 frameworks, 14
failure modes).
Time: 40 s. Segment: Gotchas.

---

## Segment 5 — Q&A and hand-off to BJ (180 s, separate from the 1620 s content budget)

**21. Questions — and a hand-off**
Message: One line to close: many unsupervised agents means you need sandboxing — that's the very
next talk.
Evidence: `talk-context.md` non-goals section (internal scheduling hand-off, not a factual claim;
no external URL).
Time: 180 s, mostly open floor. Segment: Q&A.

---

## Cuts if running long

Ordered by what to drop first. None of these touch slide 2, the four diagram slides (6, 7, 8, 9),
or the live critic call (minutes 6–10 of the demo, slide 14) — those are load-bearing requirements.

1. **Slide 20** (How it actually fails / MAST breakdown) — cut whole slide; say "multi-agent fails
   in specific, catalogued ways, not vague risk" in one clause while moving from slide 19 to Q&A.
2. **Slide 5** (four-patterns transition) — skip the slide; deliver the line while slide 4 is still
   on screen.
3. **Slide 13** (parallel-worktrees walkthrough) — fold into slide 12's narration as one spoken
   sentence ("the write stage that made this deck used the same worktree pattern") instead of a
   separate terminal detour.
4. **Slide 10** (task-shape-decides recap) — drop the dedicated slide; state the +80.8%/−70% number
   once, during slide 7 (Pipeline), instead of twice.
5. **Slide 19** (script-the-orchestration gotcha) — compress into one spoken sentence appended to
   slide 18 instead of its own slide.
6. **Slide 15** (cost-report screen time) — if the live critic call (slide 14) ran over its 240 s,
   shorten this to a single spoken number ("that run cost $X") instead of opening the file on
   screen.
