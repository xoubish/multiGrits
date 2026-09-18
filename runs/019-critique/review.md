Verdict: REVISE

Reviewer, run 019. Read talk-context.md, slides/outline.md, slides/deck.md with notes, research/build-log.md,
slides/illustrations/README.md, and looked at all 54 rendered slides.

## 1. Do I know what this is about by slide 3, and do I care?

Yes. Slide 2 states the one question ("when is a second one worth having?") and slide 3 supplies the hook in the
speaker's own voice ("best collaborator I have had... so why not a dozen?"). Slides 4–6 answer it with the thesis.
The opening is spoken prose, not bullets, and it reads aloud well. Nothing to fix here.

## 2. Which slides could go without anyone noticing?

Slide 49 (Difficult example) restates slide 20 ("ten agents, a script that owns order, loop, and isolation") and
its "when to bother" checklist is repeated almost word for word on slide 51. Slide 39 (task shape decides) is a
restatement of slide 38 plus one unsupported sentence. Slide 10 (three axes) could be folded into slide 9. All
three are outline entries, so I raise them under "For the speaker" rather than as slide fixes. Within the
slide-writer's control: slides 34–35 (attempt two step by step) are the outline's own first cut candidate and
slide 35's second paragraph is a placeholder ("Run 018 onward...") until the second chronicle pass lands.

## 3. Can I read every slide from the back, and does it read aloud?

Body text at 26px reads fine and the sentences are genuinely spoken prose; the speaker can read every body slide
verbatim. Four slides fail the back-of-room test on the image, not the text:

- **Slide 30** and **slide 45**: the frontmatter code blocks have been auto-shrunk to roughly 7px because the
  `description:` line is one unbroken 200-character line. Nobody past the second row can read the one thing the
  slide exists to show.
- **Slide 12**: the pipeline diagram is a five-node left-to-right chain squeezed into the narrow column; node labels
  are about 8px.
- **Slide 20**: the meta-pipeline diagram is a microscopic strip; it is decoration, not a diagram.

Citation lines (`.cite`) are 20px grey. They are not read aloud, but the rubric says nothing under about 24px and
slides 38, 40 and 50 lean on them heavily. Nice-to-have: bump to 22–24px and split slide 38 if it overflows. No
slide is over the word cap by enough to matter; slide 22 is the densest and still reads as one breath.

## 3b. Are citations complete on the slide?

All complete (authors, year, title, venue/arXiv, finding with number) except **slide 41**: Tran and Kiela (April
2026), arXiv 2604.02460 has no title; the note admits research/evidence.md lacks it. Slide 43's cite line
(Cemri et al.) is a bare tag, but the finding and numbers sit in the body immediately above, so it passes. The
Sources slides (53–54) correctly carry URLs only; slide 54 also lacks the Tran & Kiela title.

## 4. Could I do this after 30 minutes? Does it match the build log?

Yes, this is the strongest part of the deck. Slide 21 gives the layout, slides 30–31 one agent file, slide 32
the exact headless command, slide 33 the stage order with each stage mapped to a pattern, slides 45–48 a
second, smaller agent file plus its command plus its real result, and slide 37 what a run directory contains.
Missing: the outline entry format (talk-context says one outline entry as text; build-log section 4 has it
verbatim and no slide shows it). That is a gap in the replication story; nice-to-have to add one line to slide 28.

Build-log check, slide by slide: slide 22 ($29.22, 1,222 turns, eleven roles), 23 (27+3 / 25+5 / 1500 s, run 003),
24 (log_result.py, runs/cost.tsv, cost-row.tsv), 25 ($3, 34 turns, exit 1 not 2, 20 of 24, $5), 26 (44/2/0),
29 (retired/added lists), 30–31 (reviewer.md lines), 32 (claude -p line), 33 (stage order), 34 (13 of 16, 4
unsupported, 37 turns, $0.7286, 171 s; 28 turns, $0.3209, 207 s), 36 ($29.22 / 1,222 / 578,569 / 6,169;
$1.0495 / 65 turns; $30.27), 48 ($0.0751, 82.5 s, 8 turns, ~250 tokens, 7,321) all match research/build-log.md
exactly. No must-fix from divergence.

## 5. Does the speaker admit something did not work?

Yes, at length and in the right place: slides 23–27 (three named failures with run numbers, then "it was a wall of
cited percentages" and "nobody scored whether it was a talk"), and again on slide 48 (the token cap only applied
to the table, not the 7,321 tokens the agent actually emitted). Slide 44 points back at the cost log. Good.

## 6. Does it look like one deck? Illustrations?

Typography and palette are consistent throughout. The slides that look out of place are 20, 30 and 45, for the
shrink problems above; slide 20's strip-diagram is the worst offender.

slides/illustrations/README.md lists five SVGs (`title`, `teams`, `two-terminals`, `merge-conflict`, `close`)
with suggested Marp lines for slides 1, 4, 19, 24 and 52. **None of the five is placed in deck.md**; there is no
`illustrations/` reference anywhere in the deck. Unplaced is a must-fix. Placing them will also break up the
long run of text-only slides in segments A, D and E, which is the deck's one visual weakness.

## 7. Overlap with neighbours or unsupported claims?

No overlap: slide 2 defers to Jessica and Ricky by name, slide 51 defers pricing to Nick and says only "cheap or
local models on subagents", slide 52 hands sandboxing to BJ in one line. Slide 15 discusses worktree isolation,
which is about file isolation, not permissions, so it stays clear of BJ.

Unsupported: slide 39's "the returns diminish once the single agent is already strong" has no number or quote in
research/evidence.md (the note says so). Slide 16's "I believe Codex and Cursor behave the same way" is hedged on
the slide itself, which is acceptable.

## Findings

| Slide | Problem | Fix | Severity |
|---|---|---|---|
| 1, 4, 19, 24, 52 | None of the five illustrations in slides/illustrations/ is placed in the deck. | Add the Marp lines from illustrations/README.md: `![bg right:45%](illustrations/title.svg)` on 1, `![w:520](illustrations/teams.svg)` beside the text on 4, `two-terminals` on 19, `merge-conflict` on 24, `close` as `bg right:45%` on 52. | must-fix |
| 30, 45 | The frontmatter code block renders at ~7px because the single-line `description:` forces Marp to shrink the whole block. | Break the description onto three or four lines with a visible continuation marker (or show `description: <trimmed, one sentence>` with a note that the full line is in the repo), so the block renders at the 19px the theme sets. | must-fix |
| 12, 20 | The pipeline and meta-pipeline diagrams are left-to-right chains squeezed into the narrow column; labels are unreadable. | Render both `TD` (top-down) or move them full-width below one sentence of text; drop the `.cols` grid on these two slides. | must-fix |
| 41 (and 54) | Tran and Kiela (April 2026) citation has no title. | Fact-checker or evidence-finder supplies the arXiv 2604.02460 title; add it to both slides. | must-fix |
| all `.cite` | Citation lines are 20px grey, under the 24px floor. | Raise `.cite` to 22–24px; split slide 38 into finding / conditions if it overflows. | nice-to-have |
| 11, 13 | Diagram labels are ~11px in the 2fr column. | Widen the column to 1fr/1fr for the four pattern slides. | nice-to-have |
| 28 | The replication recipe never shows one outline entry as text. | Add the one-line entry 1 from build-log section 4 as a code block. | nice-to-have |
| 35 | Second paragraph is a placeholder until the second chronicle pass. | Leave for the post-chronicle revise stage, as the note already says. | nice-to-have |

## For the speaker

Structural; not counted in the verdict.

- Entry 21 (slide 39): "diminishing returns once the single agent is already strong" has no supporting number in
  research/evidence.md. Either point the evidence-finder at the Kim et al. result you have in mind, or drop the
  sentence; as written it is the only unsupported assertion in segment D.
- Entry 25 (slide 49) repeats entry 13's description of the pipeline and entry 26's checklist. Consider folding
  it into entry 26 and giving the 60 s to entry 24, which is the take-home.
- Entry 11 (slide 16) names Codex and Cursor; the evidence supports Claude Code only. The slide hedges honestly,
  but a hedge read aloud costs time; consider naming only Claude Code.
- Entry 24 says "under 2,000 tokens"; the agent file as built says 600. The slide follows the file. Update the
  outline or accept the difference.
- Entry 6, second slide (slide 10) is thin on its own; it could be one spoken sentence on slide 9.
