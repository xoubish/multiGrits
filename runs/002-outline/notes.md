# Outline notes — where the research brief (or talk-context) was thin

## 1. Timing: talk-context.md is internally inconsistent, not the research brief

Not a research-brief gap, but worth logging because it shaped every time budget in `slides/outline.md`.
The segment table in `talk-context.md` sums to 27 min of content + 3 min Q&A = 30 min; its own prose
says "25 minutes of content and 5 minutes of Q&A" = 30 min. The outliner's instructions additionally
require slide time budgets to sum to exactly 1500 s. All three numbers can't hold at once. Resolution:
content segments scaled to sum to exactly 1500 s (Live Demo held at the table's literal 12 min for
clean minute markers; Why/Patterns/Gotchas scaled down proportionally from 3/7/5 to 2:30/6:10/4:20);
Q&A set to the prose's 5 min (300 s) rather than the table's 3. Documented at the top of `outline.md`
so the slide-writer and critic don't silently "fix" it a different way.

## 2. Gotcha "script the orchestration" (slide 19) has the thinnest evidence of the five gotchas

The other four gotchas rest on a measured number (context-blindness on documented subagent behavior;
cost on Anthropic's 15x/3–10x; file-isolation-plus-merge on the 17.2x vs 4.4x error-amplification
result). "Prefer deterministic orchestration" rests only on a tool feature (Claude Code workflows make
`Date.now()`/`Math.random()` throw) and a policy quote (NASA SMD: "no established science-specific
guardrails or factuality-checking mechanisms"), neither of which is a before/after number. Kept the
slide because talk-context.md requires this gotcha by name, but flagging that it's the weakest-sourced
of the five and first candidate if the critic wants a citation upgrade.

## 3. Slide 20 deliberately drops a number the brief flags as unverified

`research/brief.md` §5.3 and §11 both note that "prompt and topology fixes gave only +9.4 and +15.6
points" is a real MAST finding, but *which* intervention produced which number was extracted from a
figure and is listed under "Unverified... not for slides" in `research/briefs/A-literature.md`. Slide
20 uses only the three verified top-line percentages (44.2% / 32.3% / 23.5%) and omits the +9.4/+15.6
detail entirely rather than risk a mis-attributed citation reaching the fact-checker stage.

## 4. Slide 14's time budget (240 s) is a judgment call, not an evidence-backed estimate

Nothing in `research/brief.md` or the briefs times a full `pipeline/run.sh critique` invocation against
a real deck — the only timing data point in the repo is the 000 smoke test (a 9-token reply, $0.019,
one turn), which is not representative of a critic reading `talk-context.md`, `slides/outline.md`,
`slides/deck.md`, and `diagrams/*.mmd` end to end and writing scored findings. 240 s is a guess sized
to fit the fixed 12-minute demo segment, not a number the pipeline has produced yet. The stated fallback
(open a pre-run critique instead of re-running live) is the mitigation, not a fix to this gap.

## 5. Tool-comparison table (brief B) intentionally not given a slide

`research/briefs/B-tools.md` has a rich five-CLI comparison (Claude Code, Codex, OpenCode, Gemini CLI,
Qwen Code — subagent mechanism, isolation, model-per-agent, headless flags). It would make a clean
slide, but talk-context.md's non-goals say not to introduce Claude Code, Codex, or OpenCode "from
scratch" (that's Day 1). Left out as a deliberate omission rather than a content gap; if the critic asks
for it, it belongs in the handout, not the deck.
