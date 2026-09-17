# multiGrits

Material for the **Multi-agent workflows** session at the GRITS AI workshop (IPAC, Day 2, 11:15–11:45).

The talk's demo is this repo: the deck is built by a multi-agent pipeline, and the pipeline's logs are
what the audience sees. Every pattern the talk teaches is used at least once to build the talk.

## Layout

```
talk-context.md        single source of truth: audience, schedule, non-goals, thesis, style rules
.claude/agents/        eleven subagent definitions (researcher, outliner, slide-writer, diagrammer, critic,
                       design-critic, teaching-critic, fact-checker, qa-skeptic, notes-writer, demo-editor)
pipeline/run.sh        deterministic orchestration: stages, the critic loop, worktree isolation
pipeline/prompts/      the prompt template for each stage
pipeline/render.sh     Marp render with diagrams pre-rendered to SVG and screenshots inlined
pipeline/capture.py    terminal-style screenshots of read-only commands (pipeline/captures.json) -> slides/shots/
pipeline/tree.sh       repo layout listing used by one of the screenshots
pipeline/cost_report.py  per-stage, per-model cost table from the run logs
research/briefs/       one cited brief per researcher; research/brief.md is the orchestrator's merge
slides/                outline.md, deck.md (Marp), speaker-script.md, shots/ (demo screenshots)
diagrams/              one Mermaid file per pattern, inlined into the deck at build time
handout/               handout.md, qa.md
runs/                  one directory per stage: exact prompt, full JSON result, return text, outputs
```

## How the pipeline maps to the four patterns

| Pattern | Where it is used |
|---|---|
| Fan-out and merge | four `researcher` subagents in parallel, merged into `research/brief.md` |
| Pipeline | outliner, then writers, then critic, then fact-checker, each with a fresh context |
| Writer and critic | three critics in parallel (`critic` for content, `design-critic` on the rendered PNGs, `teaching-critic` against the learning objectives); `slide-writer` revises from all three; the script owns the loop |
| Parallel isolated workers | `slide-writer` and `diagrammer` in two git worktrees, merged by the script |

## Running it

Stage 1, the research fan-out, is run interactively in Claude Code so the audience sees subagents spawn:

```
claude
> Read talk-context.md. Launch four researcher agents in parallel, one per prompt in
> runs/001-research-fanout/prompts/, then merge their briefs into research/brief.md.
```

Stages 2 onward run headlessly from the script. Each stage is one `claude -p --agent <name>` call.

```
pipeline/run.sh outline
pipeline/run.sh write            # slide-writer + diagrammer in parallel worktrees, then merge (commits)
pipeline/run.sh loop --rounds 2  # critique -> revise until PASS
pipeline/run.sh factcheck
pipeline/run.sh notes & pipeline/run.sh qa & wait
pipeline/run.sh cost
pipeline/render.sh               # -> slides/build/deck.html
```

Or `pipeline/run.sh all --commit`. Per-stage spend is capped with `--budget USD` (default 3); a stage that hits
the cap exits with code 2 and the script logs it.

Two ways to isolate parallel workers, both shown in the talk: the script creates git worktrees itself in the
`write` stage, and in an interactive session the Agent tool accepts `isolation: "worktree"` (or a subagent's
frontmatter can declare `isolation: worktree`) so Claude Code creates and cleans up the worktree for you.

## Demo mode: recorded, nothing runs on stage

The 12-minute demo segment is five slides of terminal screenshots taken from this repo's real runs. Nothing is
executed during the talk, so there is no network, timing, or budget risk on stage.

- `pipeline/capture.py` runs every read-only command in `pipeline/captures.json` (agent files, the repo tree, run
  logs, `git log`, the critique, the fact-check tally, the cost report) and renders each as a terminal-window PNG
  in `slides/shots/` using the installed Chrome. Deterministic; re-run it after any pipeline stage to refresh.
- `pipeline/run.sh shots` runs that capture, then the `demo-editor` agent rewrites the five demo slides around
  the screenshots, adds an appendix with one slide per agent file, updates the speaker script, and captures again.
- The slides say plainly that these are captures. The three real failures from the build are shown on purpose.

To go back to a live demo, restore the earlier deck from `runs/0NN-shots/deck-before.md` or from git history.

## Requirements and rendering

Claude Code 2.1 or newer, Node 22 (Marp runs from the npx cache, nothing to install), Python 3, and Google Chrome
(or Chromium/Edge) for PDF export and diagram pre-rendering.

`pipeline/render.sh` does three things: `render_diagrams.py` turns each `diagrams/*.mmd` into a static SVG with
plain text labels using the installed Chrome and a cached copy of Mermaid; `inline_diagrams.py` embeds those SVGs
into the deck (falling back to a live Mermaid loader only if no SVG exists); Marp converts to `slides/build/deck.html`
and, with `--pdf`, `deck.pdf`. Present from `deck.html` in any browser, offline. Press `p` for presenter view with
speaker notes and a timer.

Why pre-render: Mermaid's live renderer draws labels as HTML inside SVG, which Safari clips, and it needs network
at talk time. Static SVGs render identically in Safari, Chrome, and PDF. Marp is called with `--no-stdin` because
it otherwise waits forever for piped input when stdin is not a terminal (CI, cron, backgrounded runs).

## Status (2026-09-17)

Two critics added on request: `design-critic` (reviews the rendered PNGs) and `teaching-critic` (scores against the
learning objectives now in `talk-context.md`). The critique stage runs all three critics in parallel; PASS requires
all three. First three-critic round (012) returned REVISE from all three; the writer applied 30 findings (013). The
orchestrator applied the out-of-scope items by hand (diagrams, captures, appendix slides, outline note) and re-ran the
notes stage so the handout no longer describes a fixed bug. See `runs/012-critique/README.md`.

Earlier: research fan-out (001), outline (002 spec contradiction, 003 clean), parallel write (004, merge conflict on
a shared cost log, fixed), critic rounds (005 to 008; 006 hit the budget cap), fact-check (009: 44 confirmed, 2
partial, 0 not found), notes and Q&A (010), recorded demo (011). Deck: 30 presented slides plus an appendix of
agent files, renders to HTML and PDF offline.

Remaining before the talk: decide whether the repo is public (the Sources slide and handout point into it);
rehearse from `slides/speaker-script.md`; commit.
