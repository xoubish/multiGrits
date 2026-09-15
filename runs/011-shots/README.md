# Run 011 — shots (recorded demo): capture.py, then the demo-editor agent on Sonnet

44 turns, $1.96, 13 minutes. The agent replaced the five live-demo slides with five recorded-demo slides, added a
ten-slide appendix with every agent file, rewrote Segment 3 of the speaker script, and fixed three stray
live-demo references. Its return and `changes.md` are accurate.

## What the human changed afterwards, and why

The agent put two screenshots side by side on each demo slide. Rendered, they stacked vertically and the terminal
text shrank to about 6 px: unreadable, and the second image fell off the slide. Terminal screenshots need the
full slide width. The orchestrator split the five slides into ten, one screenshot each (same 720 s, same
narration split across pairs), added a compact `shot` slide style, renumbered cross-references, rewrote the
script's Segment 3 to match, and recaptured the shots at a larger font with fewer lines each. The spec now says
one screenshot per slide and allows 30 presented slides; the agent's instructions say the same, so the next run
produces this layout directly.

Lesson for the deck: agents cannot see rendered output unless you give them a way to look. A layout rule the
agent cannot check must live in the spec, not be left to judgment.
