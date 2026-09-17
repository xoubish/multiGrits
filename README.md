# multiGrits

Material for the **Multi-agent workflows** session at the GRITS AI workshop (IPAC, Day 2, 11:15–11:45).

The speaker writes the outline. Agents draft everything downstream of it (slides, diagrams, evidence, the
take-home example, notes, Q&A) and one reviewer checks the result. A shell script calls them in a fixed order
and logs every call. The first version of this repo let agents write the outline too; the deck that came out
met every constraint and was unpresentable. That story is in the talk.

## Layout

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

## The agents

| Agent | Model | Tools | Job |
|---|---|---|---|
| `evidence-finder` | sonnet | web, read, write | For each claim the outline makes, find one source and the exact number. Reuses verified briefs first. |
| `example-builder` | sonnet | read, write, **bash** | Build the "try this Monday" example under `examples/` and run it headless with a $1 cap. Records the real return and cost. |
| `chronicler` | sonnet | read, write | Writes research/build-log.md, the step-by-step account of how this deck was built, from runs/ and the cost table, with the real files as text. Runs before the draft and again after the review loop. |
| `slide-writer` | inherit | read, write, edit | One or more slides per outline entry. Full sentences the speaker can read aloud, complete citations on the slide, about 60 words max. Also applies reviews. |
| `diagrammer` | sonnet | read, write | Mermaid diagrams with a shared theme, at most 7 nodes, legible beside text. Runs in its own worktree. |
| `illustrator` | inherit | read, write | At most five flat SVG illustrations for the moments a diagram cannot carry (title, why teams, the failure, the close). Writes only to slides/illustrations/, in its own worktree. |
| `reviewer` | inherit | read, write | Sits in the audience. Reads the deck and looks at the rendered PNGs. Asks whether each slide earns its time. PASS or REVISE. |
| `fact-checker` | sonnet | web, read, write | Opens every source in the notes and checks the number said matches the number published. |
| `notes-writer` | sonnet | read, write | Speaker script with a running clock; one-page handout with the copyable recipe. |
| `qa-skeptic` | sonnet | read, write | Ten hardest audience questions with grounded answers. |

Retired: `outliner` (the speaker owns the outline), four `researcher`s (push-mode briefs nobody used; replaced by
pull-mode `evidence-finder`), `critic`, `design-critic`, `teaching-critic` (three rubrics that rewarded compliance;
replaced by one `reviewer`), `demo-editor` (the screenshot demo is gone).

## How the pipeline maps to the four patterns

| Pattern | Where it is used |
|---|---|
| Fan-out and merge | `notes-writer` and `qa-skeptic` in parallel; earlier, four `researcher`s |
| Pipeline | evidence → example → chronicle → write → review → chronicle → fact-check → notes, each with a fresh context, files as hand-off |
| Writer and critic | `reviewer` writes a review, `slide-writer` revises; the script owns the loop and the round limit |
| Parallel isolated workers | `slide-writer`, `diagrammer`, and `illustrator` in three git worktrees on disjoint folders, merged by the script |

## Running it

Write `slides/outline.md` first. Then:

```
pipeline/run.sh evidence         # research/evidence.md
pipeline/run.sh example          # examples/<name>/, run for real
pipeline/run.sh chronicle        # research/build-log.md, from the runs so far
pipeline/run.sh write            # slide-writer + diagrammer + illustrator in parallel worktrees, then merge (commits)
pipeline/run.sh loop --rounds 2  # render, review, revise until PASS
pipeline/run.sh chronicle && pipeline/run.sh revise   # record the runs above, place the update in the deck
pipeline/run.sh factcheck
pipeline/run.sh notes & pipeline/run.sh qa & wait
pipeline/run.sh cost
pipeline/render.sh               # -> slides/build/deck.html
```

Or `pipeline/run.sh all --commit`. Per-stage spend is capped with `--budget USD` (default 5); a stage that hits
the cap is flagged from its result file, not its exit code (run 006 taught that).

## Requirements and rendering

Claude Code 2.1 or newer, Node 22 (Marp runs from the npx cache), Python 3, and Google Chrome (or Chromium/Edge)
for PDF export and diagram pre-rendering.

`pipeline/render.sh` turns each `diagrams/*.mmd` into a static SVG, inlines them into the deck, and runs Marp to
`slides/build/deck.html` (and `deck.pdf` with `--pdf`, per-slide PNGs with `--png`). Present from `deck.html`
offline; press `p` for presenter view with notes and a timer.

## History

Runs 001 to 014 are the first pipeline: research fan-out, generated outline (002 caught a spec contradiction),
parallel write (004, merge conflict on a shared cost log), critic rounds (006 hit its budget cap), fact-check
(009: 44 confirmed, 2 partial, 0 not found), notes, recorded demo, a three-critic round and revise. About $29 in
logged stages. The deck it produced is in git history at commit 707ad48; one slide of it is kept as a screenshot
for the talk. The roster and stages were rewritten on 2026-09-17; runs from 015 onward use the new agents.
