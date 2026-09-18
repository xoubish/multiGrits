# Q&A — hardest questions, ranked by likelihood

Ten questions this audience is likely to ask, hardest and most likely first. Each answer is grounded in a
file in this repo or a cited source. "If pressed" is the one-line fallback if the first answer gets pushback.

---

## 1. Why not just one good prompt instead of ten agents?

Because most of what multi-agent buys here is fresh context and an independent reviewer, not smarter output
from more calls — and the talk's own thesis says most tasks don't need it. The counter-evidence is in this
repo: attempt one used eleven agent roles and produced a deck that passed every rubric and still wasn't
presentable (`runs/002`–`014`, `research/build-log.md`); a single well-specified human outline plus a small,
fixed pipeline did better. Kim et al. (2026) make the same point quantitatively: multi-agent helps on
decomposable tasks and hurts sequential ones by 39–70% (arXiv 2512.08296).

**If pressed:** one prompt works until the task exceeds one context window or needs a reviewer not anchored
to the draft — most of my own work is still one agent (slide "Cost, and when it is worth it").

## 2. What did it actually cost to make this talk?

As of run 022, about $44.00 total: $29.22 over 1,222 turns for the abandoned first attempt (`runs/002`–`014`,
`runs/cost-report.md`), plus $14.7838 over 328 turns for the second, outline-led attempt (`runs/015`–`022`).
Stages after run 022 (fact-check, notes, qa, cost) are not yet in that number. Every dollar has a
`runs/NNN-<stage>/cost-row.tsv` behind it.

**If pressed:** the number that matters isn't the total, it's that the first $29 bought a deck I threw away —
the second attempt, with a human outline, cost half as much and worked.

## 3. Was the agent-built version of this deck any good?

No, and the deck says so on purpose. It met every measurable constraint — 44 citations confirmed, word counts
under cap, timing to the second (`runs/009-factcheck/factcheck.md`) — and was a wall of cited percentages
with a twelve-minute demo of README screenshots (slide "What came out"). The three critics scored what could
be counted; nobody scored whether it was a talk.

**If pressed:** that failure is the best evidence in the whole deck — it's why the outline is now
hand-written and off-limits to agents.

## 4. How do you know the agent-written analysis and numbers are correct?

I don't take it on faith: every quantitative claim in the deck has a line in `research/evidence.md` naming
its source, an exact figure, and a caveat, and a separate fact-checker agent re-verifies each one against the
primary source before the deck ships (`runs/009-factcheck/factcheck.md`, 44 confirmed / 2 partial / 0 not
found on the first deck). Where evidence-finder couldn't source a claim, it's flagged "Unsupported" in
`research/evidence.md` rather than guessed — e.g., the Codex/Cursor default-agent claim and the diminishing-
returns line, which the slide now states as the speaker's own inference, not a citation.

**If pressed:** "confirmed by a fact-checker" means checked against the source text, not independently
replicated — the Anthropic and Kim et al. numbers are still their numbers, not mine.

## 5. Is any of this reproducible? Can I rerun the pipeline and get the same deck?

The orchestration is deterministic — `pipeline/run.sh` fixes the stage order, and every call is logged to
`runs/NNN-<stage>/` with `prompt.md`, `result.json`, `return.md`, and a cost row, so you can re-run any single
stage and diff the output. The models themselves are not deterministic: the same prompt can return a
differently worded slide, which is why the outline, not the deck text, is the fixed spec, and why the
reviewer and fact-checker re-check every run rather than trusting the last one.

**If pressed:** reproducible process, not reproducible bytes — same script, same stage order, same logged
budget, different token-level output each run.

## 6. Isn't "more context than intelligence" just a repackaged argument for bigger context windows or RAG?

No — the point is the opposite: bigger windows don't fix this. RULER shows a model's *effective* usable
window is often half its advertised size (GPT-4: 128K claimed, ~64K effective, arXiv 2404.06654), and
Lost-in-the-Middle shows quality degrades well before the limit (arXiv 2307.03172). A fresh agent with a
smaller, curated context can outperform a bigger stuffed one because the stuffing itself is the problem.

**If pressed:** RAG and multi-agent are both context-management strategies; this talk just argues fresh
context (a new agent) beats crammed context (a bigger window) for tasks that decompose.

## 7. Why should I trust Anthropic's own 90%-better, 15x-tokens numbers about their own product?

I shouldn't, uncritically, and the slide says so: it's a vendor claim on an internal eval, not independently
replicated (`research/evidence.md`, the Anthropic June 2025 entry). That's why the deck pairs it with
Tran and Kiela (2026), an independent paper where a single agent matched or beat five multi-agent designs at
equal thinking budget (arXiv 2604.02460), and with Kapoor et al. (2024), where a complex agent framework cost
50x a simple baseline and was *less* accurate (arXiv 2407.01502).

**If pressed:** take the "15x tokens" number seriously and the "90% better" number skeptically — the cost
claim and the benefit claim don't carry the same evidentiary weight.

## 8. What actually stops two agents from clobbering the same file, in practice?

Git worktree isolation: Claude Code's `isolation: worktree` runs a subagent in a temporary worktree and
blocks any Edit or Write targeting the main checkout (Anthropic docs, code.claude.com/docs/en/worktrees). This
repo hit the failure it prevents in miniature: two worktrees didn't touch each other's slides, but both
appended to one shared `runs/cost.tsv` and conflicted on the pipeline's own bookkeeping (run 004). The fix was
per-run cost files regenerated into one report, not one shared file written by two writers.

**If pressed:** a clean worktree merge isn't a correct merge — you still have to verify it, which is why the
loop stage runs a reviewer after the write stage, not just a script that checks for merge conflicts.

## 9. Doesn't multi-agent just burn tokens for a marginal gain that a stronger single model would erase?

Sometimes, yes — that's the honest reading of the evidence, not a caveat to bury. Multi-agent runs 3 to 15x a
single chat's tokens by Anthropic's own two posts (arXiv-adjacent blog claims, `research/evidence.md`), and
Kapoor et al. found a 50x-cost agent framework was *less* accurate than a cheap retry baseline (arXiv
2407.01502). My own inference, stated as such on the slide: returns diminish once the single agent is already
strong, so the better your one agent, the less a team adds.

**If pressed:** that inference has no number behind it yet — `research/evidence.md` flags it explicitly as
"TODO evidence," and I'd retract it if the evidence-finder can't source it before Kim et al. is re-checked.

## 10. If an agent decides when to loop or stop, how is that different from the agent owning the outline — didn't you say a human has to own structure?

The loop's stopping rule is owned by the script, not the model: `pipeline/run.sh` runs the critique/revise
loop for a fixed maximum of two rounds and reads the reviewer's first-line `Verdict: PASS`/`REVISE` string,
it doesn't let the reviewer decide to keep going. When round two still said REVISE, the script logged "rounds
exhausted; human review needed" instead of looping again (see the deck's run 021/022 notes) — the human is
the backstop, same as with the outline.

**If pressed:** the boundary is: agents can decide *content* (what to revise), never *process* (how many
times, in what order) — that line is what "deterministic orchestration" means in this talk.

---

## The three questions I can't answer well yet

1. **Do Codex and Cursor really default to one agent with occasional subagents, the way Claude Code does?**
   `research/evidence.md` flags this as Unsupported — the claim on the "How many agents?" slide is sourced
   only for Claude Code. What would settle it: each tool's own docs or a controlled trace comparing default
   agent counts across Claude Code, Codex, and Cursor on the same task.

2. **Is the "diminishing returns once the single agent is strong" claim true, or just a plausible story?**
   It's labeled speaker inference on the slide, not backed by a number in Kim et al. or anywhere else in
   `research/evidence.md`. What would settle it: a study that holds task difficulty fixed and varies base
   single-agent capability, measuring the multi-agent uplift as a function of that capability.

3. **Was the final merge of the parallel write stage (three worktrees, no conflict) actually correct, not
   just clean?** A conflict-free git merge is a necessary condition, not a sufficient one, and the deck's own
   pattern-4 slide admits "a clean merge is not a correct merge." What would settle it: a diff-level review of
   run 018's merge against each worktree's output, or a test that would have caught a silent, non-conflicting
   overwrite.
