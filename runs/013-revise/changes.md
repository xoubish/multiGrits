# Run 013 — revise from run 012 critiques

Slide-writer response to `runs/012-critique/{content,design,teaching}/critique.md`. Output: `slides/deck.md` only.
Slide count and order unchanged (26 content + 4 Sources = 30 presented; 10 appendix), so `slides/speaker-script.md`
headers and clocks were not touched. Where two critics asked for the same thing (the three build failures), both
placements were applied; where the "full width" screenshot rule conflicted with a 900px box, talk-context.md won.

## Content critic

### Must-fix
1. Slide 20 notes, Sonnet list — CHANGED: deleted "researchers"; list now reads "outliner, fact-checker, and demo-editor", matching `runs/cost-report.md` and the run-001 README.
2. Slide 13 notes, two unshown failures — CHANGED: added the spoken sentence pointing at 002 (spec contradiction) and 006 (budget cap) in the listing, with a forward pointer to slide 16, where both now also appear in body text (see Teaching 5a).
3. Slide 11 notes, fallback and cut order — CHANGED: added the render-failure fallback (terminal tab, file named in each slide's notes) and a cut order. Cut order is "18, then 13" rather than the critic's "18, then 15": it matches the speaker script's existing demo cut list, and slide 15 carries the script-owns-the-topology point that gotcha 4 depends on, while slide 13's new spoken line is now duplicated on slide 16.
4. Sources 4, unused and missing repo tags — CHANGED: removed `[run 000]` and `[run 005]` (and the run-005 note); added `[run 004]`, `[run 007]`, `[run 008]`, `[run 009]`, `[cost report]`, plus `[run 002]` and `[run 006]` for the failures now on slide 16; tags added to captions on slides 16–20. To make room, `[Claude Code workflows]` and `[Claude Code agent teams]` moved to Sources 3.
5. `slides/outline.md` stale Segment 3 and cuts list — DECLINED (out of scope): the outline is the outliner's file. Flag for the outliner: regenerate Segment 3 and "Cuts if running long" for the recorded, 30-slide deck; the notes-writer and qa-skeptic read it.

### Nice-to-have
6. Slide 26 hand-off as one line — CHANGED: "Many unsupervised agents means you need sandboxing — BJ's talk, next." (talk-context's exact phrase kept).
7. Put `budget-hit.png` on slide 18 — DECLINED: the budget failure is now on slide 16's body and slide 13's notes; slide 18's writer's-response screenshot carries the "each agent writes only its own files and declines the rest" lesson that objectives 4 and 5 lean on, and the speaker script is built around it.
8. Slide 22 notes "slide 12" → "slide 14" — CHANGED.
9. Slide 22 notes, researcher-pin aside — CHANGED: cut to one sentence.
10. Slide 24 notes, pace — CHANGED: dropped "The first is more impressive. The second is reproducible." and "We will be asked to show our work."
11. Slides 11–20, cumulative clock — CHANGED: every demo slide's notes now open with its window (10:00–11:00 … 21:00–22:00), taken from the speaker script.
12. Slide 10 notes, Google blog with no URL — CHANGED: added the blog URL (from `research/brief.md`) to the `[Kim 2026]` line on Sources 2 and pointed the aside at it.
13. Slide 2, "3 critics" vs "a critic loop" — CHANGED: notes now say "three critics, content, visual, teaching, one rubric each". Body left as "a critic loop" so no untagged number is added to the slide.
14. Slide 6, 90.2% needs a context tie — CHANGED: "on breadth research over more sources than fit one window" (body 39 words).
15. Slide 12 title — CHANGED: "A subagent is a markdown file".
16. Slide 20 "headless" — CHANGED: "scripted".
17. Slide 9 density, Osmani to notes — CHANGED: Osmani removed from slide 9 body; moved to slide 23 body (per Teaching 6a), slide 9 now 27 words.
18. `writer-critic.mmd` tests/data node — DECLINED (out of scope): diagrammer's file. Flag for the diagrammer: add a "tests / data" node the critic reads (5 nodes, under cap).
19. `parallel-workers.mmd` "Merge + verify" — DECLINED (out of scope): diagrammer's file. Flag for the diagrammer: relabel the Merge node "Merge + verify".
20. Slide 15 caption, budget flag — DECLINED: `--max-budget-usd` lives in `run_agent`, not in the `stage_write` loop the screenshot shows, so it is not visible there; the flag is now literal text on slide 12 instead.

## Design critic

1. Slide 40 `demo-editor` capture too narrow (must-fix) — CHANGED in part: fixed `![h:470]` sizing replaced on all 19 shot slides by a shared CSS bounding box (`width/height: auto; max-width: 100%; max-height: 470px`). This alone cannot widen a 1174px-tall capture; the remaining half is the capture step's. Flag for `pipeline/capture.py` / demo-editor: trim `agent-demo-editor` to the frontmatter plus the first dozen lines (noted in that slide's speaker notes too).
2. All shot slides, inconsistent widths (must-fix) — CHANGED: same bounding-box rule. Used `max-width: 100%` rather than the suggested 900px because talk-context.md requires screenshots "full width"; the short captures (runs-ls, fanout, factcheck at 430px native) now render at native size instead of being upscaled. Two slides (12, 16) use a `cap2` class with `max-height: 400px` because their captions run to two or three lines and would otherwise overflow; noted here as the one deliberate footprint exception.
3. Under-filled text slides (nice) — CHANGED: `section { display: flex; flex-direction: column; justify-content: center; }`, with `.shot` and `.sources` pinned back to `flex-start`. Footer and page number are absolutely positioned in the default theme, so unaffected.
4. `meta-pipeline.mmd` font size (nice) — DECLINED (out of scope): diagrammer's file. Flag for the diagrammer: add the `%%{init}%%` fontSize directive or lay the eight nodes out in two rows.
5. Slide 15 caption on one line (nice) — CHANGED: "The script creates the worktrees, runs both agents, waits, then merges [pipeline/run.sh]."; "the agents decide nothing here" kept in notes.
6. Appendix divider treatment (nice) — CHANGED: `divider` class, centred, with the subtitle "Nine files in `.claude/agents/`, in pipeline order".
7. Title-slide accent (nice) — CHANGED: `title` class on slide 1 with a 3px navy rule under the H1. System fonts and offline rendering unchanged.

## Teaching critic

1a. Objectives never stated (must-fix) — CHANGED: slide 2 body gains "You leave able to: pick a pattern, write one subagent, read a run's logs." (38 words); notes drop "not claiming it beats a person, only inspectable" and read the objectives line instead, as the critic proposed.
1b. Literal invocation with budget cap never shown (must-fix) — CHANGED: slide 12 now carries the `run_agent` command as text, trimmed to the flags that matter: `claude -p --agent critic --allowedTools Read,Glob,Grep,Write --max-budget-usd 5 "$(cat prompt.md)"` (default cap 5 per `pipeline/run.sh`). Notes explain each flag and name the three omitted ones (`--output-format json`, `--permission-mode acceptEdits`, `--no-session-persistence`). Frontmatter skeleton remains visible in the screenshot on the same slide.
2. Handout generic template (must-fix) — DECLINED (out of scope): `handout/handout.md` is the notes-writer's file. Flag for the notes-writer: replace the per-agent list with a three-line template (frontmatter skeleton, the slide-12 command, one check on the return) and trim "Five links" to three. The recipe's command half is now on slide 12 and its check half ("summary length") on slide 26.
3. No first step (must-fix) — CHANGED: slide 26 body gains "First step: put one bounded, read-only subtask in its own agent file. Run it once. Check summary length." (body 39 words); notes carry the full Monday sentence plus prerequisites (CLI access, a repo with `CLAUDE.md`, permission to run non-interactively).
4. Shape tag in pattern titles (nice) — CHANGED: "shape: independent pieces / sequential steps / needs verifying / shared repo"; `pattern` class drops those H1s to 38px so they stay on one line; each pattern's notes open with the shape sentence.
5a. Spec contradiction and budget cap not shown (must-fix) — CHANGED: slide 16 body now reads "… two agents, one file [run 004]. Also caught: a spec contradiction [run 002]; a revision stopped by its budget cap [run 006]." (35 words); notes explain both from `runs/002-outline/README.md` and `runs/004-write/README.md`. Time taken from slide 16's own headroom; slide 25 left intact.
5b. Dedup habit on slide 14 (nice) — CHANGED in notes: "the merge step deduplicates citations by URL, not by title."
6a. Osmani to slide 23 (nice) — CHANGED: slide 23 body now 38 words with the Osmani quote as its third line; Kim clause in notes shortened as suggested.
6b. MAST undefined before use (nice) — CHANGED: "(MAST)" added to slide 25 body; slide 8 notes now say "the failure taxonomy we will see in full on slide 25".
7a. Repo URL missing (must-fix) — CHANGED as far as this agent can: Sources 4 now carries the origin remote `https://github.com/xoubish/multiGrits` as the base for every repo path, and its notes tell Shooby to confirm the repo is public before 11:15 Day 2, else inline frontmatter and command in the handout. This agent cannot publish the repo or verify its visibility (no network tool). Flag for Shooby.
7b. Handout's stale `cost.tsv` conflict warning (must-fix) — DECLINED (out of scope): handout is the notes-writer's file. Flag for the notes-writer with the facts: per `runs/004-write/README.md` the conflict was resolved, `pipeline/cost_report.py` now regenerates `runs/cost.tsv` from every `result.json`, and `runs/cost-report.md` is complete through run 011 ($19.32), so the sentence should be deleted, not annotated.

## Constraint check after edits
- 30 presented slides (26 content + 4 Sources), appendix of 10 after Sources, order unchanged.
- Body words, changed slides: 2 → 38; 6 → 39; 9 → 27; 12 → 30 incl. the command; 16 → 35; 23 → 38; 25 → 27; 26 → 39. All others unchanged and ≤ 39.
- Every new number carries a tag that resolves on Sources 2–4 (`[run 002]`, `[run 004]`, `[run 006]`, `[run 007]`, `[run 008]`, `[run 009]`, `[cost report]`, `[pipeline/run.sh]`, Kim blog URL).
- Diagram tokens untouched; `diagrams/` not written. One screenshot per shot slide. System fonts, offline rendering.
