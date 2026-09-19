# Illustrations

Eleven flat SVGs, one style: navy `#1e3a5f` lines and figures, light grey `#e8edf2` fills, transparent background,
`viewBox="0 0 800 450"`, no text, no gradients/filters/masks/fonts. They scale to half a slide beside text
(`w:520`) or to a full slide (`bg right` or full width). Entries that carry a `{{diagram:...}}` token or a code
block were skipped on purpose; these are for moments, not mechanisms.

| Slug | Outline entry | What it shows | Suggested Marp line and placement |
|---|---|---|---|
| `title` | 1. Title (no longer used on the title slide; `agents` took its place on 2026-09-18) | A person flanked by three agent windows passing work along a hand-off chain, with a tripod telescope aimed at a star on the left. | `![bg right:45%](illustrations/title.svg)` — right half of the title slide, title and name on the left. |
| `teams` | 4. Why do people work in teams? | One figure buckling under a tottering stack of FITS cards next to three figures each holding a small stack under one shared clock: time and attention split, knowledge not added. | `![w:520](illustrations/teams.svg)` — right of the three-reasons text. |
| `agents` | 4. Which of those reasons hold for agents? (second slide of entry 4) | The robot counterpart of `teams`: one agent whose window is overloaded by a tottering stack, sparks at its head, next to three agents with fresh window-frame heads each holding a small stack under one shared clock. Added by the orchestrator 2026-09-18. | `![w:520](illustrations/agents.svg)` in a `cols` layout, text left. |
| `context-usage` | 5. What fills a context window | A chart redrawn from the Claude Code /context panel of the build session (613.1k of 1.0M tokens; messages 580.4k): stacked bar plus category table. Carries text, unlike the other illustrations, because it is a chart. Added by the orchestrator 2026-09-18. | `![w:560](illustrations/context-usage.svg)` in a `cols-even` layout. |
| `orchestra` | 6. Elements of a multi-agent system | A conductor robot on a podium, baton raised, reading a score from a stand, facing five robot musicians with violin, trumpet, cello, drum, and flute. The score stands for the script that owns the order. Added by the orchestrator 2026-09-18. | `![w:520](illustrations/orchestra.svg)` in a `cols` layout, text left. |
| `orchestrator` | 6. Axis 1, who orchestrates | One robot behind a desk, arms reaching to two open laptops, one on each side: the orchestrator directing two workers. Added by the orchestrator 2026-09-18. | `![w:520](illustrations/orchestrator.svg)` in a `cols` layout, text left. |
| `pattern-fan-out`, `pattern-pipeline`, `pattern-writer-critic`, `pattern-isolated` | 6 (topology, 2x2 grid) and 7 to 10 (one each, full size) | The four patterns as labelled box-and-arrow figures in the deck style, replacing the Mermaid renders on the slides; the Mermaid sources remain in `diagrams/`. Added by the orchestrator 2026-09-18. | `![](illustrations/pattern-*.svg)` inside `.grid2`; `![w:560]` on the pattern slides. |
| `meta-pipeline` | 13a. This deck was built by a workflow in this repo | The script as a dark bar owning five stage groups, each listing its agents, with the shape named underneath: chain, fan-out, loop, chain, fan-out. Hand-drawn 2026-09-19 to replace the Mermaid render, which was a flat strip that hid the structure. | `![w:1000](illustrations/meta-pipeline.svg)` full width under the text. |
| `surprised` | 13a, bottom-right corner | A small robot in the house style with wide eyes, an open mouth, a sprung antenna, raised hands and surprise strokes. An accent, not a mechanism; placed with the `.corner` class. Drawn 2026-09-19. | `![w:200](illustrations/surprised.svg)` inside `<div class="corner">`. |
| `two-terminals` | 12. You already do this | A person from behind at a desk between two terminals, arms on both keyboards, attention swivelling from one screen to the other, coffee within reach. | `![w:520](illustrations/two-terminals.svg)` — right of the text; can also run full width above one sentence. |
| `merge-conflict` | 14. Attempt one, from scratch (the merge-conflict failure) | Two agent windows both writing into the same single file, whose lines overlap and whose page has cracked down the middle. | `![w:460](illustrations/merge-conflict.svg)` — right of the three-failures list, or on the split slide that names the shared-cost-log conflict. |
| `close` | 27. Close | One person hands one small card to one small read-only agent (padlock), and a short summary card comes back on the return arrow; one star and a crescent moon overhead. | `![bg right:45%](illustrations/close.svg)` — right half of the close, the Monday first step and the hand-off to BJ on the left. |

Placement notes for the slide-writer and reviewer:

- `bg right:45%` keeps the body under 60 words readable; if a slide needs the full width for text, drop to `![w:420]` and float it right.
- `merge-conflict` also fits entry 23 (How it fails) if entry 14 splits into two slides and the failures land on
  the second; use it once, not twice.
- None of the images carry words, so no alt text is needed for meaning; the sentence on the slide is the caption.
