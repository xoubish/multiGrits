# Build log — how this deck was built

Written by the `chronicler` agent from the run logs under `runs/`, `runs/cost-report.md`, and the run-directory
READMEs. Every fact below carries a pointer to the file it came from. Where a run has no README and its return is
ambiguous, this file says "not recorded" instead of guessing.

## 1. Attempt one, from scratch (runs 000–014)

The first pipeline let agents write the outline itself, not just the slides. Eleven agent roles did the work:
four `researcher`s, an `outliner`, a `slide-writer` and `diagrammer` in worktrees, three critics (content, design,
teaching), a `fact-checker`, `notes-writer`, `qa-skeptic`, and a `demo-editor` [README.md].

**Stage 0, scaffold verification.** Before any content stage, the orchestrator delegated a question to a
docs-reading subagent (`claude-code-guide`) to check which subagent frontmatter keys and headless flags actually
exist in Claude Code 2.1.270, rather than trusting memory: confirmed keys `name`, `description`, `tools`,
`disallowedTools`, `model`, `permissionMode`, `memory`, `skills`, `isolation: worktree`, `maxTurns`, `background`,
`effort`, `hooks`; `color` was invented and does not exist [runs/000-scaffold-verification/README.md]. A smoke test
of `claude -p --agent outliner` showed a fixed per-spawn tax of about $0.019 for 9 output tokens, mostly ~4,400
cache-creation tokens of system prompt [runs/000-scaffold-verification/README.md].

**Stage 1, research fan-out (run 001).** Pattern 1, fan-out and merge, run interactively: the orchestrator wrote
`talk-context.md` and four topic prompts, launched four `general-purpose` subagents in parallel (literature, tools,
context/cost, astronomy), each writing one brief to `research/briefs/` and returning a summary of at most 200
words. Totals: 270 tool calls, ~602k subagent tokens, 10.9 minutes wall-clock in parallel versus an estimated 38
minutes sequential; ~7,100 words of briefs compressed to ~800 words of returned summaries
[runs/001-research-fanout/README.md]. Merged by hand into `research/brief.md` (~2,100 words). Cost recorded by
hand from the session's `/cost`, not in `runs/cost-report.md` [runs/README.md].

**Failure 1: the spec contradiction (run 002).** The `outliner` (Sonnet, 22 turns, ~40k output tokens, $0.84,
7.2 minutes) found that `talk-context.md`'s segment table summed to 27 minutes of content plus 3 of Q&A, its prose
said 25 plus 5, and the outliner's own instructions demanded 1500 seconds. It could not satisfy all three, so it
picked a resolution, scaled three segments down, and logged the choice in `notes.md` rather than silently choosing
[runs/002-outline/README.md]. The fix was to the spec: the table was marked binding, the outliner's constraint
corrected to 1620 s, and the stage re-run as run 003 (Sonnet, 16 turns, $0.43, 133 s), producing 21 slides across
five segments summing to exactly 1500 s of content plus a 300 s Q&A [runs/002-outline/README.md;
runs/003-outline/return.md; runs/cost-report.md].

**Failure 2: the merge conflict on a shared cost log (run 004).** The `write` stage created two worktrees
(`.worktrees/slides` for `slide-writer` on the session model, `.worktrees/diagrams` for `diagrammer` on Sonnet) and
ran both at once: slide-writer 13 turns, 26k output tokens, $2.37, 5.2 min; diagrammer 16 turns, 9k output tokens,
$0.22, 1.4 min [runs/004-write/README.md; runs/cost-report.md]. The slides branch merged cleanly, but the diagrams
branch conflicted on `runs/cost.tsv`: `log_result.py` appended one row to a single shared cost log from inside each
worktree, so both branches edited the same lines of the same file. The two agents never touched each other's
outputs — `slides/` and `diagrams/` were perfectly isolated — the collision came from the orchestration's own
bookkeeping [runs/004-write/README.md]. Fixed by having each run directory write its own `cost-row.tsv` and having
`pipeline/cost_report.py` regenerate `runs/cost.tsv` from every `result.json`, so parallel workers no longer share
a write path [runs/004-write/README.md; runs/README.md].

**Failure 3: the budget cap (run 006).** The first revise pass off `runs/005-critique/critique.md` (session model,
Fable 5.1) exhausted the then-default $3 `--max-budget-usd` ceiling after 34 turns; `result.json` showed
`terminal_reason: budget_exhausted` / `subtype: error_max_budget_usd`, but the process exit code was 1, not the 2
the docs describe [runs/004-write/README.md]. The stage had already applied most of its changes (`changes.md`
lists 24 items, 20 changed, 2 declined out of scope, 1 partial, 1 no-change) [runs/006-revise/changes.md]. Run 007
(critique, $2.64) and run 008 (revise, $1.62) finished the revision [runs/cost-report.md]. Fix: default budget
raised to $5, and the script now detects budget exhaustion from `result.json` content rather than trusting the
exit code [runs/004-write/README.md; pipeline/run.sh].

The rest of the run: fact-check (run 009, Sonnet, 62 turns, $1.95) confirmed 44 citations and marked 2 partial with
0 not found [runs/cost-report.md]; notes and Q&A (run 010, parallel, $0.89 + $0.59); a recorded demo (run 011,
Sonnet, 44 turns, $1.96, 13 min) replaced live-demo slides with screenshots and added a ten-slide appendix — the
agent stacked two screenshots per slide, which rendered unreadable at ~6px, so a human split it into ten
one-screenshot slides afterward [runs/011-shots/README.md]; a three-critic round (runs 012–013: content, design,
teaching in parallel, all three verdicts REVISE, then one $4.71 revise) added critics for aesthetics and learning,
and a final notes pass (run 014, $1.28) [runs/012-critique/README.md; runs/cost-report.md]. Total for runs 002–014:
**$29.22**, 455 turns, 578,569 output tokens, 6,169 seconds [runs/cost-report.md]. (Turn count corrected 2026-09-18: the earlier figure of 1,222 did not match the sum of `num_turns` over the 17 result.json files for runs 002 to 014.)

**The outcome.** The deck met every constraint the rubric measured: citations complete, word counts under the cap,
segment timing to the second (44 confirmed citations, 2 partial, 0 not found from run 009). It was, in the
speaker's own account, "a wall of cited percentages" and "a twelve-minute demo of screenshots of README files"
[slides/outline.md, entry 15]. Nobody had measured whether it was a talk: three critics scored citation counts,
word-per-second density, and seconds-per-slide, and none asked whether a slide earned its place
[talk-context.md; README.md]. The deck is preserved in git history at commit `707ad48`
[talk-context.md; README.md], and one slide of it is kept as a screenshot for the talk:
`slides/shots/first-deck-gotcha.png`, `slides/shots/first-deck-thesis.png`, `slides/shots/first-deck-demo.png`
[slides/shots/*.png].

## 2. The reset

In the speaker's own words: "The outline (slides/outline.md) is written by the speaker, by hand, and is the single
source of structure: slide order, per-slide message, time budgets, and the cuts list. No agent generates or
reorders it. Agents draft slides, diagrams, evidence, notes, and reviews *for* that outline. If an agent finds a
structural problem, it reports it to the speaker (a `## For the speaker` section) and does not fix it."
[talk-context.md].

Why: "the first pipeline in this repo generated its own outline from a research brief and a segment table, then
optimised a deck against a rubric of citations, word counts, and seconds. Every constraint was met and the deck was
a wall of cited percentages nobody wanted to present. Agents optimise what you measure; taste has to be a human's."
[talk-context.md].

**Retired**, per the README: "`outliner` (the speaker owns the outline), four `researcher`s (push-mode briefs
nobody used; replaced by pull-mode `evidence-finder`), `critic`, `design-critic`, `teaching-critic` (three rubrics
that rewarded compliance; replaced by one `reviewer`), `demo-editor` (the screenshot demo is gone)." [README.md]

**Added**, per the slide entry the speaker wrote: "an evidence-finder that sources only the claims I make, an
example-builder that runs the take-home example for real, one reviewer that sits in the audience, a chronicler
that records the build, an illustrator." [slides/outline.md, entry 16]

The roster and stages were rewritten on 2026-09-17; runs from 015 onward use the new agents [README.md].

## 3. Attempt two, step by step (runs 015 onward)

Numbers below are read from each run's own `cost-row.tsv`; `runs/cost-report.md` and `runs/cost.tsv` have not been
regenerated since run 014 (the `cost` stage runs at the end of the pipeline and has not run again as of this
writing), so figures for runs 015 onward are cited to their individual `cost-row.tsv` files, not the report.

- **Run 015 — `evidence`.** Agent `evidence-finder`, models `claude-haiku-4-5-20251001` and `claude-sonnet-5`, tools
  WebSearch/WebFetch/Read/Write/Glob/Grep. Read `slides/outline.md` and `research/brief.md`/`research/briefs/`.
  Wrote `research/evidence.md` and `runs/015-evidence/unsupported.md` (folded into `research/evidence.md`'s
  Unsupported section per its return). Return: found sources for 13 of 16 claims entirely from existing
  briefs/fact-check, needed the web for 3 (MacNet, Project Sid, ChatDev's seven roles), and flagged 4 claims as
  unsupported rather than guessed (Codex/Cursor default-agent behavior, the "one agent is today's default"
  generalization, the Monday example's real numbers since `example` had not run yet, and the build-log numbers
  since `chronicle` had not run yet) [runs/015-evidence/return.md]. 37 turns, $0.7286, 171 s wall time
  [runs/015-evidence/cost-row.tsv]. Pipeline stage (pull-mode, single agent).

- **Run 016 — `example`.** Agent `example-builder`, models `claude-haiku-4-5-20251001` and `claude-sonnet-5`, the
  only agent with Bash. Read outline entry 24 (the Monday example spec) and confirmed `astroquery` was installed.
  Wrote `examples/exoplanet-lookup/` (`README.md`, `.claude/agents/exoplanet-lookup.md`, `run.sh`, `targets.txt`,
  `RESULT.md`) and `runs/016-example/notes.md`. Return: built and ran a haiku subagent that looked up ten real
  exoplanet names against the NASA Exoplanet Archive via astroquery, headless with `--max-budget-usd 1`; it
  succeeded on the first real attempt (one workaround needed: writing under a path containing the literal string
  `.claude/agents` tripped a sandbox permission check, worked around with a Python script); returned a 10-row table
  of ~250 tokens, well under the 600-token cap, though total output including thinking tokens was 7,321
  [runs/016-example/return.md; runs/016-example/notes.md; examples/exoplanet-lookup/RESULT.md]. The one `claude -p`
  call the agent made and recorded in `RESULT.md` cost $0.0751, ran 82.5 s, 8 turns; the run-level `cost-row.tsv`
  reports 28 turns and $0.3209 for the whole agent session (setup, the workaround, and the recorded call together),
  207 s wall [runs/016-example/cost-row.tsv; examples/exoplanet-lookup/RESULT.md]. Pipeline stage (single agent,
  the one permitted to run Bash for real).

- **Run 017 — `chronicle`.** Agent `chronicler`, models `claude-haiku-4-5-20251001` and `claude-sonnet-5`, tools
  Read/Glob/Grep/Write. Read every file its prompt names under `runs/`, `runs/cost-report.md`, `research/*`,
  `.claude/agents/*.md`, `slides/outline.md`, `README.md`, and `talk-context.md`. Wrote `research/build-log.md`
  (this file, first version, covering runs 000–017) and `runs/017-chronicle/numbers.md`. Return: "Wrote
  `research/build-log.md` covering runs 000–017, and copied section 5 to `runs/017-chronicle/numbers.md`,"
  noting the deck's slide count for attempt two was not yet recorded and an unresolved discrepancy between the
  README's "eleven" agent-role count and the fourteen roles it names [runs/017-chronicle/return.md]. 38 turns,
  $0.4361, 128 s wall time [runs/017-chronicle/cost-row.tsv]. Pipeline stage (single agent), the first of two
  chronicle passes the outline calls for [talk-context.md].

- **Run 018 — `write`.** Pattern 4, parallel isolated workers: three agents in three git worktrees, run at once,
  merged by the script.
  - `slides` worktree, agent `slide-writer`, session model (`claude-fable-5-1`/haiku), 16 turns, $3.0735, 359 s.
    Read `talk-context.md`, `slides/outline.md`, `research/evidence.md`, `research/build-log.md`. Wrote
    `slides/deck.md`, 53 slides (51 presented + 2 Sources); no `slides/illustrations/README.md` existed yet at
    write time, so no illustrations were placed. Flagged four TODOs: the Codex/Cursor default-agent claim, an
    unsupported "diminishing returns" sentence, a missing Tran & Kiela title, and a real-vs-outline discrepancy
    (the built example caps replies at 600 tokens, the outline says "under 2,000")
    [runs/018-write/slides/return.md; runs/018-write/slides/notes.md; runs/018-write/slides/cost-row.tsv].
  - `diagrams` worktree, agent `diagrammer`, `claude-sonnet-5`, 16 turns, $0.1811, 60 s. Wrote five Mermaid files:
    `fan-out.mmd`, `pipeline.mmd`, `writer-critic.mmd`, `parallel-workers.mmd`, `meta-pipeline.mmd`, 5–6 nodes each
    [runs/018-write/diagrams/return.md; runs/018-write/diagrams/cost-row.tsv].
  - `illustrations` worktree, agent `illustrator`, session model, 10 turns, $0.9379, 115 s. Wrote five SVGs
    (`title`, `teams`, `two-terminals`, `merge-conflict`, `close`) to `slides/illustrations/` plus
    `slides/illustrations/README.md` placing each one [runs/018-write/illustrations/return.md;
    runs/018-write/illustrations/cost-row.tsv]. Stage total: 42 turns, $4.1925, three branches merged with no
    conflict (disjoint files: `slides/deck.md`, `diagrams/*.mmd`, `slides/illustrations/*`).

- **Run 019 — `critique`.** Writer-critic round 1 (critic half). Agent `reviewer`, session model, tools
  Read/Glob/Grep/Write, 64 turns, $2.9727, 150 s. Read `talk-context.md`, `slides/outline.md`, `slides/deck.md`
  with its notes, and all 54 rendered PNGs in `slides/build/png/`. Return/verdict: **REVISE**; three findings
  mattered most — the five illustrations from run 018 were never placed in `deck.md` despite the README existing,
  two agent-file code blocks (slides 30, 45) rendered at ~7px because of an unbroken `description:` line, two
  Mermaid diagrams (slides 12, 20) were squeezed unreadable in a narrow column, and the Tran & Kiela citation
  (slide 41) had no title; everything else, including every build-story number checked against
  `research/build-log.md`, was reported sound [runs/019-critique/review.md; runs/019-critique/cost-row.tsv].

- **Run 020 — `revise`.** Writer-critic round 1 (writer half). Agent `slide-writer`, session model, 27 turns,
  $1.6625, 132 s. Read `runs/019-critique/review.md` and `slides/deck.md`. Applied the illustrations (all five
  placed per the README), fixed the two shrunk code blocks, took the two squeezed diagrams full-width, raised
  `.cite` from 20px to 22px, widened two pattern-diagram columns, and added the outline's entry-1 text as a code
  block on slide 28; declined the Tran & Kiela title (no file in the repo has one) and left the "attempt two"
  placeholder slide for the second chronicle pass, wrote `runs/020-revise/changes.md`
  [runs/020-revise/return.md; runs/020-revise/changes.md; runs/020-revise/cost-row.tsv].

- **Run 021 — `critique`.** Writer-critic round 2 (critic half). Agent `reviewer`, session model, 63 turns,
  $2.9859, 171 s. Return/verdict: **REVISE** again; five must-fixes remained, three mattering most — the two
  `bg right:45%` illustrations (slides 1, 52) were cover-cropped, the Tran & Kiela citation still lacked a title,
  and a "diminishing returns" sentence on slide 39 still had no source in `research/evidence.md`. Confirmed again
  that every build-story number on slides 21–37 and 48 matched `research/build-log.md` exactly, and flagged for
  the speaker (not counted in the verdict) that slide 22 says "eleven agent roles" then lists fourteen
  [runs/021-critique/review.md; runs/021-critique/cost-row.tsv].

- **Run 022 — `revise`.** Writer-critic round 2 (writer half), the last round `--rounds 2` allows. Agent
  `slide-writer`, session model, 29 turns, $1.4847, 100 s. Fixed the illustration crops (`fit`), split the
  fourteen-line code slide in two (entry 24 now five slides), took the writer-critic diagram full width, raised
  `.cite` to 24px, and rewrote the "diminishing returns" line as the speaker's own inference rather than an
  unsourced fact; declined the Tran & Kiela title again (no source found) and instead marked it on the slide as
  "title to be confirmed by the fact-checker"; declined the placeholder slide again, pending the second chronicle
  pass. Wrote `runs/022-revise/changes.md`. Per `pipeline/run.sh`'s `stage_loop`, this was the second and last
  scheduled round; the loop function logs "rounds exhausted; human review needed" if the verdict is still REVISE,
  and no further `critique` run exists in `runs/` as of this writing — the loop's final verdict is therefore
  **not recorded** (no run 023-critique exists to confirm PASS or a third REVISE)
  [runs/022-revise/return.md; runs/022-revise/changes.md; runs/022-revise/cost-row.tsv; pipeline/run.sh].

Stages not yet run as of this writing: a second `chronicle` pass beyond this one, `revise` to place its update,
`factcheck`, `notes` and `qa` in parallel, and `cost` (to regenerate `runs/cost-report.md` and `runs/cost.tsv`
through run 022). This chronicle pass is itself that second `chronicle` call, logged as `runs/023-chronicle`
[talk-context.md; pipeline/run.sh].

## 4. The recipe

**Folder layout**, verbatim from `README.md`:

```
talk-context.md          audience, schedule, non-goals, thesis, style rules for every agent
slides/outline.md        HUMAN-WRITTEN. Slide order, per-slide message, time budgets, cuts. No agent edits it.
.claude/agents/          ten subagent definitions (see table below)
pipeline/run.sh          deterministic orchestration: stages, the review loop, worktree isolation
pipeline/prompts/        the prompt template for each stage
pipeline/render.sh       Marp render with diagrams pre-rendered to SVG
pipeline/cost_report.py  per-stage, per-model cost table from the run logs
research/evidence.md     one source per claim in the outline (written by evidence-finder)
research/build-log.md    how this deck was built, step by step, with pointers into runs/ (written by chronicler)
research/briefs/         the four briefs from the first pipeline's research fan-out; evidence-finder reuses them
examples/                the take-home example, built and actually run by example-builder
slides/deck.md           Marp deck; speaker-script.md; illustrations/ (SVGs); build/ (rendered, untracked)
diagrams/                Mermaid, one file per diagram token in the deck
handout/                 handout.md, qa.md
runs/                    one directory per agent call: exact prompt, full JSON result, return text, cost row
```
[README.md]

**One complete agent file, verbatim** — `.claude/agents/reviewer.md`:

```
---
name: reviewer
description: Sits in the audience. Reads the deck as a skeptical IPAC engineer and looks at the rendered slide images. Scores whether each slide earns its time, not whether it complies with a rubric. Never edits; writes a PASS or REVISE review the script uses to decide whether to loop.
tools: Read, Glob, Grep, Write
model: inherit
---
You are the one reviewer. You replace three earlier critics whose rubrics counted citations, words per second, and
seconds per slide; the deck they passed was unpresentable. Do not count things. Judge whether the talk works.

Read `talk-context.md`, `slides/outline.md` (the speaker's plan; you review the deck against it, not the other way
round), `slides/deck.md` with its notes, and LOOK at every `slides/build/png/deck.NNN.png` with the Read tool.

Answer these, with slide numbers, in a short paragraph each:
1. Would I know what this talk is about by slide 3, and would I care?
2. Which slides could I delete without anyone noticing? Name them.
3. The speaker reads from the slides. Can I read every slide from the back of the room (nothing under about
   24px, no slide over about 60 words), and does the text read naturally aloud rather than like a caption or a
   table row? Name any slide that should be split in two.
3b. Is every citation complete on the slide itself: authors, year, title, venue or arXiv id, and the finding in
   plain words with its number? Name any that is just a tag or a bare number.
4. After 30 minutes, could I write one subagent file and call it from a script, and could I replicate this repo's
   workflow from the slides alone (layout, an agent file, the outline format, the command, the stage order)? Which
   slides taught me, and what is missing? Check the build-story slides against `research/build-log.md`: any number
   or file text that differs is a must-fix.
5. Is there a moment where the speaker admits something did not work? If not, say where one belongs.
6. Does it look like one deck? Point at the slide that looks most out of place in the images. Read
   `slides/illustrations/README.md` if it exists: is every illustration placed on its slide, does it sit well
   beside the text, and is any of them doing harm (clutter, competing with a diagram)? Unplaced is a must-fix.
7. Does any slide say something a neighbouring talk covers (the non-goals in talk-context.md), or say something the
   notes do not support?

Then findings: slide number, the problem in one sentence, the fix in one sentence, severity must-fix or
nice-to-have. A structural problem in the outline is reported to the speaker, not to the slide-writer: put it
under a separate `## For the speaker` heading and do not count it in the verdict.

Write to the run directory you are given as `review.md`. First line exactly `Verdict: PASS` or `Verdict: REVISE`.
REVISE only if at least one must-fix remains. Fewer, sharper findings beat many small ones. Return the verdict
and the three findings that matter most.
```
[.claude/agents/reviewer.md]

**One outline entry, verbatim** — the first entry of `slides/outline.md`:

```
1. **Title.** Multi-agent workflows. Shooby Hemmati, IPAC. GRITS AI workshop, September 2026. 15 s.  <!-- entry reworded 2026-09-18 on the speaker's instruction; quoted here as it now stands -->
```
[slides/outline.md, entry 1]

**The `run_agent` function's `claude -p` line, verbatim**, from `pipeline/run.sh`:

```
  env -u CLAUDECODE claude -p --agent "$agent" \
    --output-format json \
    --permission-mode acceptEdits \
    --allowedTools "$tools" \
    --max-budget-usd "$BUDGET" \
    --no-session-persistence \
    "$(cat "$run_dir/prompt.md")" > "$run_dir/result.json"
```
[pipeline/run.sh]

**Stage order**, per `README.md` and `pipeline/run.sh`'s `all` case:

```
evidence  →  example  →  chronicle  →  write (slide-writer + diagrammer + illustrator, 3 worktrees, merged)
  →  loop (critique → revise, until PASS or 2 rounds)  →  chronicle  →  revise  →  factcheck
  →  notes & qa (parallel)  →  cost
```
[README.md; pipeline/run.sh]

**Where logs land:** every stage writes `runs/NNN-<stage>/` containing `prompt.md` (exact prompt sent),
`result.json` (full headless JSON output), `return.md` (what the agent returned), `exit-code`, and any
stage-specific output file (e.g. `critique.md`/`review.md`, `factcheck.md`, `changes.md`, `notes.md`). The parallel
`write` stage nests `slides/`, `diagrams/`, `illustrations/` subdirectories, one per worktree, as seen in
`runs/018-write/`. Each run directory gets its own `cost-row.tsv`; `pipeline/cost_report.py` regenerates
`runs/cost.tsv` and `runs/cost-report.md` from every `result.json` — nothing appends to a shared file, because run
004 showed why [runs/README.md].

## 5. Numbers

**Total cost so far:** $29.22 for attempt one (runs 002–014; run 001 was interactive and its cost is recorded by
hand, not in this total) [runs/cost-report.md; runs/README.md], plus $14.7838 for attempt two so far (runs
015–022, summed from each run's own `cost-row.tsv` since `runs/cost-report.md` has not been regenerated past run
014) [runs/015-evidence/cost-row.tsv; runs/016-example/cost-row.tsv; runs/017-chronicle/cost-row.tsv;
runs/018-write/slides/cost-row.tsv; runs/018-write/diagrams/cost-row.tsv; runs/018-write/illustrations/cost-row.tsv;
runs/019-critique/cost-row.tsv; runs/020-revise/cost-row.tsv; runs/021-critique/cost-row.tsv;
runs/022-revise/cost-row.tsv]. Running total across both attempts as of run 022: **≈$44.00** ($29.22 + $14.7838 =
$44.0038). This chronicle pass (run 023) and every stage after it (a further chronicle-placing revise, factcheck,
notes, qa, cost) are not yet run and their cost is not included.

**Per attempt:**
- Attempt one (runs 002–014, headless stages only): $29.22, 455 turns, 578,569 output tokens, 6,169 seconds
  [runs/cost-report.md]. Run 001 (interactive research fan-out) is additional and not logged in dollars here
  [runs/README.md].
- Attempt two (runs 015–022 so far): $14.7838, 328 turns, 1,593 s wall time summed across the ten cost-rows listed
  above (evidence 37t/$0.7286/171s; example 28t/$0.3209/207s; chronicle-1 38t/$0.4361/128s; write/slides
  16t/$3.0735/359s; write/diagrams 16t/$0.1811/60s; write/illustrations 10t/$0.9379/115s; critique-1
  64t/$2.9727/150s; revise-1 27t/$1.6625/132s; critique-2 63t/$2.9859/171s; revise-2 29t/$1.4847/100s)
  [cost-row.tsv files cited individually above]. Remaining stages (a second chronicle, a placing revise,
  factcheck, notes, qa, cost) not yet run; not recorded.

**Agents count:**
- Then (attempt one): 11 named roles per the README's retirement line — four `researcher`s, `outliner`,
  `slide-writer`, `diagrammer`, `critic`, `design-critic`, `teaching-critic`, `fact-checker`, `notes-writer`,
  `qa-skeptic`, `demo-editor` — fourteen distinct role names in that list against the README's stated count of
  eleven; run 021's reviewer flagged this same discrepancy on slide 22 as a "for the speaker" item, unresolved as
  of this writing [README.md; runs/021-critique/review.md].
- Now (attempt two): 10 — `evidence-finder`, `example-builder`, `chronicler`, `slide-writer`, `diagrammer`,
  `illustrator`, `reviewer`, `fact-checker`, `notes-writer`, `qa-skeptic` [README.md; .claude/agents/*.md].

**Slides count:**
- Then (attempt one, final): 25 slides (21 presented + 4 sources), stated as the ceiling in run 006's revise notes
  [runs/006-revise/return.md]. Run 011's demo rework split 5 slides into 10 and added a 10-slide appendix, and the
  spec afterward allowed up to 30 presented slides [runs/011-shots/README.md].
- Now (attempt two): the deck went through three drafts. Run 018 (`write`) produced 53 slides (51 presented + 2
  Sources) [runs/018-write/slides/return.md]. Run 019's reviewer counted 54 rendered PNGs, one more than run 018
  reported — a discrepancy this file does not resolve, since no run explains the difference; run 020 (`revise`)
  reported the count as "unchanged (54)" relative to what the reviewer saw [runs/019-critique/review.md;
  runs/020-revise/return.md]. Run 022 (`revise`), after splitting one dense code slide into two, reported "55
  slides plus two Sources" [runs/022-revise/return.md]. Counting heading markers (`^#`/`^##`) directly in the
  current `slides/deck.md` gives 55 [slides/deck.md], consistent with run 022's own count; the exact total
  including the two Sources slides is therefore about 57, but this file reports the components as each run stated
  them rather than reconciling them by inference.


## 6. Runs 023 to 029 (added by the orchestrator, 2026-09-18, from runs/cost.tsv)

The chronicler's second pass (run 023, 77 turns, $0.77) covered runs 015 to 022 and could not
record itself. Since then: run 024 revise placed the build-log entries; run 025 fact-check; run 026 Q&A skeptic and a
notes pass; run 027 notes (superseding 026's); run 028 a review written by the speaker (no model cost) asking that the
posted slides stand alone and read formally; run 029 revise applied it (12 turns, $3.84).
Attempt two, runs 015 to 029: $23.81, 536 turns, 3,281 s. Both attempts: $53.03.
