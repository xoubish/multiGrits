# Outline notes — where the research brief (or talk-context) was thin

## 1. Timing: no contradiction found this run

The prompt asked me to log any contradiction in the spec and use the table if so. I checked
carefully: `talk-context.md` line 11 ("27 minutes of content (1620 s) and 3 minutes of Q&A plus
hand-off") is fully consistent with its own segment table (3+7+12+5=27 min content, 3 min Q&A,
30 min total). Unlike `runs/002-outline/notes.md`, which documents a prose-vs-table conflict
(25+5 vs 27+3) in an earlier draft of this file, the version I read has no second, conflicting
prose statement. I used the table directly: Why 180 s, Patterns 420 s, Demo 720 s, Gotchas 300 s
(sum 1620 s), Q&A 180 s, total 1800 s — matching the instruction's "1620 s content / 180 s Q&A"
exactly, no rescaling needed. Logged here in case a later run finds the contradiction has
returned (e.g. if `talk-context.md` is edited again).

## 2. Gotcha "script the orchestration" (slide 19) is the thinnest-evidenced of the five gotchas

The other three Gotchas-segment slides rest on a measured before/after number (context-blindness
is documented subagent mechanics; cost has Anthropic's 15x / 3–10x; isolate-and-centralize has the
17.2x vs 4.4x error-amplification result). "Prefer deterministic orchestration" rests only on a
tool feature (Claude Code workflows make `Date.now()`/`Math.random()` throw) and a policy quote
(NASA SMD: "no established science-specific guardrails or factuality-checking mechanisms"),
neither of which is a controlled comparison. Kept the slide because `talk-context.md` names this
gotcha explicitly, but it is the first gotcha slide flagged as thin, and it is also listed near the
top of "Cuts if running long."

## 3. Slide 20 deliberately omits a number the brief flags as unverified

`research/brief.md` §6 and `research/briefs/A-literature.md` "Unverified" both note that MAST's
"prompt and topology fixes gave only +9.4 and +15.6 points" is real, but which intervention
produced which number was read off a figure by a summarizer and is explicitly marked "not for
slides." Slide 20 uses only the three verified top-line percentages (44.2% / 32.3% / 23.5%) and
leaves the +9.4/+15.6 detail out entirely rather than risk a mis-attributed citation reaching the
fact-checker stage.

## 4. Slide 14's 240 s time budget is a judgment call, not an evidence-backed estimate

Nothing in `research/brief.md` or the four briefs times a full `pipeline/run.sh critique`
invocation against a real deck. The only timing data point anywhere in the repo's research or run
logs is the run-000 smoke test (a 9-token reply, $0.019, one turn), which is not representative of
a critic reading `talk-context.md`, `slides/outline.md`, `slides/deck.md`, and `diagrams/*.mmd`
end to end and writing scored findings. 240 s is sized to fit the fixed 12-minute demo segment,
not a number the pipeline has actually produced yet. The stated fallback (open a pre-run critique
instead of re-running live) mitigates the risk of the estimate being wrong; it does not fix the
underlying gap in the evidence.

## 5. Tool-comparison table (brief B) intentionally given no slide

`research/briefs/B-tools.md` has a rich five-CLI comparison (Claude Code, Codex, OpenCode, Gemini
CLI, Qwen Code — subagent mechanism, isolation, model-per-agent, headless flags) that would make a
clean, well-sourced slide. Left out on purpose: `talk-context.md`'s non-goals say not to introduce
Claude Code, Codex, or OpenCode "from scratch" (Day 1 territory), and a five-tool feature grid
reads as exactly that kind of introduction. This is a deliberate omission driven by the non-goals
list, not a thin spot in the brief — noted here so the slide-writer doesn't reach for it later
thinking it was simply missed.

## 6. Pattern 3 (writer/critic) evidence is thick but skews negative

The brief's writer/critic evidence (MAST verification failures, gwBenchmarks and Stargazer faking
or mis-fitting results, Jamshidi et al.'s hallucination-vs-accuracy tradeoff) is strong but is
almost entirely about failure modes, with no equally strong "here is a critic pattern that clearly
worked" number to balance it, unlike Pattern 1 (Anthropic 90.2%, Kim et al. +80.8%) or Pattern 4
(Osmani's verification-bottleneck framing paired with the worktree mechanism). Slide 8's message
was written to land on "a critic with tools catches real errors; without tools it rubber-stamps"
rather than claim the pattern is unambiguously validated, since the brief does not support that
stronger claim.
