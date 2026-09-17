# Illustrations

Five flat SVGs, one style: navy `#1e3a5f` lines and figures, light grey `#e8edf2` fills, transparent background,
`viewBox="0 0 800 450"`, no text, no gradients/filters/masks/fonts. They scale to half a slide beside text
(`w:520`) or to a full slide (`bg right` or full width). Entries that carry a `{{diagram:...}}` token or a code
block were skipped on purpose; these are for moments, not mechanisms.

| Slug | Outline entry | What it shows | Suggested Marp line and placement |
|---|---|---|---|
| `title` | 1. Title | A person flanked by three agent windows passing work along a hand-off chain, with a tripod telescope aimed at a star on the left. | `![bg right:45%](illustrations/title.svg)` — right half of the title slide, title and name on the left. |
| `teams` | 4. Why do people work in teams? | One figure buckling under a tottering stack of FITS cards next to three figures each holding a small stack under one shared clock: time and attention split, knowledge not added. | `![w:520](illustrations/teams.svg)` — right of the three-reasons text. |
| `two-terminals` | 12. You already do this | A person from behind at a desk between two terminals, arms on both keyboards, attention swivelling from one screen to the other, coffee within reach. | `![w:520](illustrations/two-terminals.svg)` — right of the text; can also run full width above one sentence. |
| `merge-conflict` | 14. Attempt one, from scratch (the merge-conflict failure) | Two agent windows both writing into the same single file, whose lines overlap and whose page has cracked down the middle. | `![w:460](illustrations/merge-conflict.svg)` — right of the three-failures list, or on the split slide that names the shared-cost-log conflict. |
| `close` | 27. Close | One person hands one small card to one small read-only agent (padlock), and a short summary card comes back on the return arrow; one star and a crescent moon overhead. | `![bg right:45%](illustrations/close.svg)` — right half of the close, the Monday first step and the hand-off to BJ on the left. |

Placement notes for the slide-writer and reviewer:

- `bg right:45%` keeps the body under 60 words readable; if a slide needs the full width for text, drop to `![w:420]` and float it right.
- `merge-conflict` also fits entry 23 (How it fails) if entry 14 splits into two slides and the failures land on
  the second; use it once, not twice.
- None of the images carry words, so no alt text is needed for meaning; the sentence on the slide is the caption.
