# Runs 012 and 013 — first three-critic round (content, design, teaching), then revise

Requested 2026-09-17 after the user asked for an agent that cares about slide aesthetics and one that cares
about people actually learning the workflow. Both were added as critics (pattern 3) and run in parallel with the
existing content critic (pattern 1 applied to the reviewers). Each writes its own `critique.md` in its own
subdirectory; the script declares PASS only if all three pass.

| Critic | Model | Turns | USD | Verdict | Lowest scores |
|---|---|---|---|---|---|
| content | session model | 12 | 2.78 | REVISE | citations 6, demo 6 |
| design (reads the PNG renders) | Sonnet | 49 | 0.68 | REVISE | image treatment 5, readability 6 |
| teaching (scores against learning objectives) | Sonnet | 8 | 0.45 | REVISE | first step 4, generalization 5, take-home 5 |
| slide-writer revise | session model | 26 | 4.71 | | |

Highlights: the design critic caught inconsistent screenshot widths and one appendix capture at half width, by
looking at images rather than markdown (the failure of run 011). The teaching critic found the learning objectives
were never stated, no first step was given, only one of three build failures reached a slide, and the handout
still described a merge conflict that had been fixed (the notes-writer ran while the tree was mid-merge). The
writer applied 30 findings, declined 8 as out of scope (diagrams, outline, handout, publishing the repo) and
flagged each for its owner.

## What the orchestrator did with the declined items

- Diagrams: "Merge + verify" label; a "tests, schema, data" node the critic reads; the overview laid out in two
  rows so its labels stop shrinking. Applied by hand (diagrammer's files).
- Capture step: agent-file captures trimmed to 24 lines so no appendix screenshot is an outlier; two new agent
  captures and appendix slides added.
- Outline: annotated with a status note rather than regenerated, so the run-003 planning record stays intact.
- Handout: notes-writer instructions updated (generic recipe, first step, verified facts only) and the notes stage
  re-run as run 014.
- Publishing the repo: the user's decision; visibility checked and reported.
