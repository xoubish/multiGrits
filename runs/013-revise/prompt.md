Read `talk-context.md` and `slides/deck.md`, then every critique under `runs/012-critique`: it is a run directory
with one subdirectory per critic (`content/`, `design/`, `teaching/`), each holding a `critique.md`. (An older
run may hold a single `critique.md` directly.)

Apply every must-fix finding from all critics. Use judgment on nice-to-have findings. Where two critics
conflict, talk-context.md decides; where a teaching fix adds material, take the time from where that critic said.
Design fixes go in the deck's frontmatter `style:` block or in slide markdown; keep system fonts and offline
rendering. Keep every constraint in talk-context.md (30 presented slides, words per slide, citations, diagram
tokens, one screenshot per screenshot slide). Edit `slides/deck.md` in place. If you change slide count or order,
update `slides/speaker-script.md` headers and clocks to match.

Write `runs/013-revise/changes.md`: one line per finding, grouped by critic, saying what you changed or why you declined.
Return a summary of at most 120 words.
