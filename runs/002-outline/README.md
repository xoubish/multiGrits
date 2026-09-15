# Run 002 — outline (headless, `pipeline/run.sh outline`, agent `outliner` on Sonnet)

First real headless stage. 22 turns, ~40k output tokens, $0.84, 7.2 minutes. Output snapshotted here as
`outline.md`; `slides/outline.md` was then regenerated in run 003.

## What happened, and why it is a slide

The outliner found a contradiction in the spec. `talk-context.md`'s segment table summed to 27 minutes of
content plus 3 of Q&A, its prose said 25 plus 5, and the outliner's own instructions demanded 1500 seconds.
It could not satisfy all three, so it picked a resolution, scaled three segments down, and logged the choice
at the top of the outline and in `notes.md` so downstream agents would not "fix" it a different way.

That is the right behavior for an agent handed an inconsistent spec, and it is also a warning: a less careful
agent would have silently picked one number. The fix was to the spec, not the agent: the table is now marked
binding in `talk-context.md`, the outliner's constraint reads 1620 s, and the stage was re-run as 003.

Lesson for the deck: every pipeline stage needs one authoritative input. When two inputs disagree, the
agent's job is to say so, not to choose quietly. Cheap to re-run once the spec is fixed; the script made
the re-run identical except for the corrected input.

## Other notes the outliner left (see `notes.md`)

- The "script the orchestration" gotcha has the thinnest evidence: a tool feature and a policy quote, no before/after number.
- It deliberately dropped an unverified MAST sub-attribution rather than risk a wrong citation.
- The 240 s budget for the live critic call is a guess; nothing in the repo has timed that stage yet.
- It left the five-CLI comparison table out of the deck to respect the Day 1 non-goal, suggesting the handout instead.
