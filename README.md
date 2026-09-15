# multiGrits

Material for the **Multi-agent workflows** session at the GRITS AI workshop (IPAC, Day 2, 11:15–11:45).

The talk's demo is this repo: the deck is built by a multi-agent pipeline, and the pipeline's logs are
what the audience sees. Every pattern the talk teaches is used at least once to build the talk.

## Layout

```
talk-context.md        single source of truth: audience, schedule, non-goals, thesis, style rules
.claude/agents/        eight subagent definitions (researcher, outliner, slide-writer, diagrammer,
                       critic, fact-checker, qa-skeptic, notes-writer), each with its own model and tools
pipeline/run.sh        deterministic orchestration: stages, the critic loop, worktree isolation
pipeline/prompts/      the prompt template for each stage
pipeline/render.sh     Marp render with Mermaid diagrams inlined
pipeline/cost_report.py  per-stage, per-model cost table from the run logs
research/briefs/       one cited brief per researcher; research/brief.md is the orchestrator's merge
slides/                outline.md, deck.md (Marp), speaker-script.md
diagrams/              one Mermaid file per pattern, inlined into the deck at build time
handout/               handout.md, qa.md
runs/                  one directory per stage: exact prompt, full JSON result, return text, outputs
```

## How the pipeline maps to the four patterns

| Pattern | Where it is used |
|---|---|
| Fan-out and merge | four `researcher` subagents in parallel, merged into `research/brief.md` |
| Pipeline | outliner, then writers, then critic, then fact-checker, each with a fresh context |
| Writer and critic | `critic` scores the deck; `slide-writer` revises; the shell script owns the loop |
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

## Demo plan for the 12-minute segment

| Minutes | On screen |
|---|---|
| 2 | The repo: `.claude/agents/`, `pipeline/run.sh`, `runs/` |
| 3 | `runs/001-research-fanout/`: four prompts, four returns, the merged brief |
| 5 | Live: `pipeline/run.sh critique` or `factcheck` against the deck being presented |
| 2 | One real failure from the build, from `runs/` |

Fallback: a screen recording of the full `run.sh all`, kept outside the repo.

## Requirements

Claude Code 2.1 or newer, Node 22 (Marp runs via `npx`, nothing to install), Python 3. PDF export
needs the Mermaid diagrams pre-rendered to SVG; `npx -y @mermaid-js/mermaid-cli mmdc -i diagrams/x.mmd -o diagrams/x.svg`
does that but downloads a headless Chromium on first use.

## Status (2026-09-15)

Done: scaffold, docs verification (run 000), research fan-out of four parallel researchers (run 001, ~602k
tokens, 10.9 min wall-clock), orchestrator merge into `research/brief.md`, outline stage run twice (002 found
a contradiction in the spec, 003 after the fix). Nothing is committed yet.

Next: commit, then `pipeline/run.sh write` (needs a clean tree because it merges worktree branches), then
`pipeline/run.sh loop`, `factcheck`, `notes & qa`, `cost`, `render.sh`.
