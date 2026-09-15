Written to `runs/005-critique/critique.md`. No other files touched.

**Verdict: REVISE**

Scores: Overlap 9 · Time 7 · Citations 8 · Plain language 7 · Thesis 8 · **Demo 6** · Hand-off 9

**Three most important findings (all must-fix):**

1. **Slide 14 — the live critic call won't fit its window.** It's budgeted "one to three minutes" inside 240 s that also has to cover explaining the critic and reading findings aloud; a critic that reads nine files and writes a scored report (this run) routinely takes longer, so the audience may never see the result. Fix: kick off `pipeline/run.sh critique` in the background at demo 0:00 on slide 11, walk slides 12–13 while it runs, return at 6:00 to the finished file, and put a hard cutoff in the notes ("no critique.md by 9:00 → fallback").

2. **Slide 14 — the fallback names no file.** "Open the critique.md from an earlier dry run in runs/" is not concrete, unlike slide 11's fallback which names specific directories. Fix: name `runs/005-critique/critique.md` and have it already open in the second terminal tab.

3. **Slide 9 notes — uncited competitor claim that also brushes a non-goal.** "Only Claude Code documents this; Codex, OpenCode, and Gemini do not" is a negative claim about other CLIs with no source, likely to be stale by the talk date, and it drifts into Ricky's Day 1 tool-comparison territory. Fix: cut the sentence, or cite `research/brief.md` with the check date under an "Unverified" heading on Sources 3.

Other must-fixes: slide 8 stacks four claims from four sources (one idea per slide); slide 19 body uses `Date.now()`/`Math.random()` JavaScript jargon for an astronomer audience; `fan-out.mmd` routes summaries around the Orchestrator, contradicting the "centralize the merge" point on slides 6 and 18. Eighteen nice-to-haves follow in the file, including pinning the MAST paper version (its percentages changed between arXiv versions) and confirming the `{{diagram:…}}` placeholders actually get rendered, since Marp doesn't do Mermaid natively.

One housekeeping note: several claude.ai MCP connectors (Asana, Atlassian, Box, Canva, Figma, HubSpot, Intercom, Linear, Notion, monday.com) flagged that they need authorization in your claude.ai connector settings. None were needed for this critique.
