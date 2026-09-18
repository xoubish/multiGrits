# Runs 028 and 029 — a human-written review, applied by the slide-writer

2026-09-18. The speaker asked for two changes across the whole deck: the posted slides must stand alone for
someone who was not at the workshop (no other speakers or sessions named, no "yesterday", "Day 2", or "next"), and
the register should be formal written prose rather than conversational speech.

Rather than edit 58 slides by hand, the orchestrator put both rules into `talk-context.md` and the slide-writer's
instructions, reworded the five outline entries that embedded in-room wording (the outline is the speaker's file;
this was done on the speaker's instruction and is noted at its top), and wrote the findings as `review.md` in this
directory with `Verdict: REVISE`, in the format the reviewer agent uses. `pipeline/run.sh revise` then picked it up
as the latest critique and the slide-writer applied it (run 029: 12 turns, $3.84).

Outcome: every must-fix applied; one leftover fixed by hand (the reset slide quoted the old wording of outline
entry 1 from the build log; the quote and the log now carry the current entry). Structure, numbers, citations,
code, diagrams and illustrations unchanged. The notes stage was re-run afterwards (run 030) so the speaker script
and handout match.

Why this is worth a sentence in the talk: the review loop accepts a review from anyone who writes one in the
agreed format. The script does not care whether the reviewer was a model or a person.
