# Run 011 — demo-editor: recorded demo

Converted the 5-slide live demo segment of `slides/deck.md` (between "Task shape decides" and the
first Gotcha slide) into a 5-slide recorded demo built from `slides/shots/manifest.json`. Same slide
positions (11–15), same 720 s total, same 25-slide cap. Added an appendix after Sources (4 of 4),
not counted against the cap. Rewrote Segment 3 of `slides/speaker-script.md` to match, plus one
consistency fix in Segment 4. No entries were added to `pipeline/captures.json` — every screenshot
needed already existed and was already `"ok": true` in the manifest.

## The five new demo slides

| # | Title | Time budget |
|---|---|---|
| 11 | Recorded from this repo · the layout, and an agent as a file | 100 s |
| 12 | Already run · the research fan-out | 150 s |
| 13 | Already run · parallel worktrees, and the merge conflict | 160 s |
| 14 | Already run · the critic's verdict, and the writer's response | 170 s |
| 15 | Already run · fact-check, and what it cost | 140 s |
| | **Total** | **720 s** |

Honesty statement ("these are screenshots of real runs in this repo, captured by a script — nothing
here runs live") appears once, as the caption of slide 11, and again plainly in its speaker notes.
Every instruction about terminal tabs, launching `pipeline/run.sh critique`, waiting for a live
call, and the tab-3 fallback has been removed. Both existing citation tags used by the old demo
slides that still apply ([run 001] on slide 12, [pipeline/run.sh] on slide 13) were kept; no new
bracket-citation tags were introduced, so `slides/deck.md`'s Sources slides did not need editing.

## Screenshots used (all pre-existing in `slides/shots/manifest.json`)

| Slide | Screenshots |
|---|---|
| 11 | `repo-tree.png`, `agent-file.png` |
| 12 | `runs-ls.png`, `fanout-readme.png` |
| 13 | `stage-write.png`, `conflict-readme.png` |
| 14 | `critique.png`, `changes.png` |
| 15 | `factcheck.png`, `cost-report.png` |

Not used in the main 5 slides (left available, not required by the brief): `run-usage.png`,
`git-log.png`, `budget-hit.png`. All nine `agent-*.png` screenshots are used in the new appendix
(one per file in `.claude/agents/`, in pipeline order: researcher, outliner, slide-writer,
diagrammer, critic, fact-checker, notes-writer, qa-skeptic, demo-editor).

## Screenshots added to `pipeline/captures.json`

None. Every name referenced above (`repo-tree`, `agent-file`, `runs-ls`, `fanout-readme`,
`stage-write`, `conflict-readme`, `critique`, `changes`, `factcheck`, `cost-report`, and all nine
`agent-*` entries) was already present in `pipeline/captures.json` and already captured with
`"ok": true` in `slides/shots/manifest.json`.

## Appendix added

After Sources (4 of 4) in `slides/deck.md`: a divider slide "Appendix · The agents, as files" (not
presented, not counted against the 25-slide cap, marked as such in its speaker note), then one slide
per agent file, in pipeline order — researcher, outliner, slide-writer, diagrammer, critic,
fact-checker, notes-writer, qa-skeptic, demo-editor. Each shows `shots/agent-<name>.png`, the agent
name as title, its one-line role (drawn from the file's `description:` frontmatter) as caption, and
a one-sentence speaker note on model and tools (e.g. critic: "parent model, Read/Glob/Grep/Write, no
Edit — cannot touch the deck"; slide-writer: "inherit model, Read/Write/Edit/Glob/Grep").

## Every non-demo line touched

`slides/deck.md`:
1. Pattern 3 · Writer and critic slide, speaker notes — changed "This is the pattern we will run
   live in the demo." to "This is the pattern the recorded demo shows next, against this deck."
   (removes "live"; slide content, citations, and time budget unchanged.)
2. Gotcha · Cost multiplies with agent count slide, speaker notes — changed "...the README you saw
   on slide 12 says so. A fresh session, like today's demo, picks up the pin." to "...the README you
   saw on slide 12 says so. A fresh session picks up the pin; the recorded run on slide 12 predates
   that fix." (removes the implication that a live session runs "today"; the underlying technical
   claim — Sonnet pin, parent-model fallback, run 001 — is unchanged and still cites the same
   evidence already on screen in the new slide 12.)

No other slide, citation, diagram token, or body-text word count outside the demo segment was
changed. Confirmed no remaining "tab", "fallback", "live", or "demo minute 0" references anywhere in
`slides/deck.md` outside the two edits above (grepped the whole file after editing).

`slides/speaker-script.md`:
3. Segment 3 header and note — renamed "Live demo of one pattern" to "Recorded demo: the pipeline
   that built this talk"; rewrote the segment-wide note (previously about terminal wait time) to
   state plainly that nothing runs live and every image is a pre-committed screenshot. (This is
   Segment 3, in scope by instruction, listed here for completeness.)
4. Segment 4, Slide 17 — Gotcha · Cost multiplies, **Say** text — changed "...because that session
   hadn't picked up the pin — a fresh session, like today's, does." to "...because that session
   hadn't picked up the pin. A fresh session would; this run predates the fix." Mirrors the deck.md
   fix above so the spoken script doesn't imply a live session runs today. Recount: 163 words,
   exactly at the slide's existing ceiling (163) — no other wording on that slide changed.
5. Segment 2, Slide 8 — Pattern 3 · Writer and critic, **Say** text — changed "...Reviewers edit
   true things too. This is the pattern we'll run live in the demo." to "...This is the pattern the
   recorded demo shows next, against this deck." Found by a post-edit grep of the whole script for
   "live"/"tab"/"fallback"; mirrors the same fix already made on this slide in `slides/deck.md`.
   Recount: ~206 words, under the slide's existing ceiling (210).

Not changed, and considered: the closing note "Slides 22–25 (Sources 1 of 4 through 4 of 4) are
reference-only..." at the end of `slides/speaker-script.md`. It does not reference the live demo and
correctly still describes slides 22–25; the new appendix sits after slide 25 and is explicitly
unpresented, so no update was needed there.

## Clock check

Segment 3 still runs 10:00–22:00 (720 s), unchanged. Per-slide start times: 11 at 10:00 (+100 s),
12 at 11:40 (+150 s), 13 at 14:10 (+160 s), 14 at 16:50 (+170 s), 15 at 19:40 (+140 s), ending 22:00,
handing off to Segment 4 exactly as before. Word ceilings recomputed at 140 wpm from each slide's new
time budget (100→233, 150→350, 160→373, 170→396, 140→326 words, floored); every **Say** block is
comfortably under its ceiling, leaving room to read real numbers and findings off the screenshots
rather than recite a fully pre-written script.
