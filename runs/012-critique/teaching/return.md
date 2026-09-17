**Verdict: REVISE**

I wrote the full critique to `runs/012-critique/teaching/critique.md` (scores 6, 5, 4, 7, 6, 7, 5 across the seven criteria). The three most important findings:

1. **Take-home is not guaranteed to work at all (must-fix).** Sources slide 4's own note says "the repo URL goes here once it is public." Every artifact the handout points to (`runs/`, `.claude/agents/`, `pipeline/run.sh`) lives in this repo — if it isn't public by talk day, the handout's entire reproducibility promise is void regardless of how good the prose is. Compounding this, the handout admits `runs/cost-report.md` is currently incomplete and `runs/cost.tsv` has an unresolved git merge-conflict marker sitting in it — an attendee following the handout will hit a broken file, with no note saying whether that's a bug to fix or a deliberate echo of the slide-16 story.

2. **No first step and no generic recipe (must-fix, criteria 2 and 3).** The deck and handout show this repo's *instance* of each pattern (screenshots, this repo's agent files) but never give a transferable template — no subagent frontmatter skeleton, no literal headless-invocation command, no "do this Monday with your own project" sentence. An attendee leaves able to recognize the four shapes, not to build one from scratch.

3. **Two of the three required build failures never reliably surface (must-fix, criterion 5).** `talk-context.md` requires the spec contradiction, merge conflict, and budget exhaustion to be "shown, not hidden." Only the merge conflict gets a slide (16); the other two live solely in the speaker's private Q&A notes for the closing slide, so they're only heard if an attendee happens to ask "did anything go wrong?"

Each finding in the file specifies the exact fix, its word/time cost, and what existing slide content pays for it, using headroom already present under each slide's word ceiling or the script's own documented cut candidates (slides 5, 20, 25).
