# Archive

Material from earlier versions of this repo, kept so the build history is readable rather than
buried in `git log`. Nothing here is read by the pipeline. If you are trying to understand how
the talk was made, start at the root [README](../README.md) and
[`research/build-log.md`](../research/build-log.md); come here only for the primary sources.

| File | What it was | Why it was retired |
|---|---|---|
| `first-pipeline-brief.md` | The orchestrator's merge of four parallel `researcher` briefs, written 2026-09-15 by the first pipeline's push-mode research fan-out. 123 lines, every claim carrying a URL. | The four researchers produced about 7,100 words, most of which no slide ever used. They were replaced on 2026-09-17 by one pull-mode `evidence-finder` that starts from the claims the outline actually makes. The four source briefs are still live at [`research/briefs/`](../research/briefs/), because `evidence-finder` reuses them before searching the web. |

## What is *not* archived, and why

Three things look retired but are not:

- **`runs/000-014`** are the first pipeline's logs, and they stay in [`runs/`](../runs/) alongside
  `015-030`. They are the evidence behind the failure story the talk tells (the spec contradiction in
  `002`, the worktree merge conflict in `004`, the budget cap in `006`), and the run numbers are cited
  by `research/build-log.md`. Splitting the numbering would break that.
- **[`diagrams/`](../diagrams/)** holds five Mermaid sources that the current deck does not use — the
  slides moved to hand-drawn SVGs in `slides/illustrations/` on 2026-09-18/19. The `diagrammer` agent
  and the render pipeline still write and inline them, so they stay wired up.
- **Unused images in `slides/shots/` and `slides/illustrations/`** (`first-deck-gotcha`,
  `first-deck-demo`, `merge-conflict`, `one-agent-shooing`, `close`, `pattern-isolated`, `title`) are
  not orphans. They belong to slides that were cut from the deck while it was shortened from 58 slides
  to 30, and `slides/illustrations/README.md` still records the outline entry each one was drawn for.
