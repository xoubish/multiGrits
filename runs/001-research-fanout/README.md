# Run 001 — research fan-out (interactive, pattern 1: fan-out and merge)

Date: 2026-09-15. Orchestrator: Claude Code interactive session (model: Fable 5.1), driven by Shooby.

The orchestrator wrote `talk-context.md` and the four topic prompts in `prompts/`, then launched four
`general-purpose` subagents in one message so they ran in parallel, each told to read the shared role file
and its own topic file. Each researcher wrote one brief to `research/briefs/` and returned a summary of at
most 200 words, saved verbatim in `returns/`. The orchestrator then merged the four briefs into
`research/brief.md` by hand, which is the merge half of the pattern.

Note for the talk: this run used the parent model for the researchers because the custom `researcher`
agent (which pins `model: sonnet`) is only discovered by a fresh session. In the live demo, a fresh session
will pick up `.claude/agents/researcher.md` and the researchers will run on Sonnet.

## Outcome

| Researcher | Brief words | URLs opened | Tool calls | Tokens (subagent) | Wall time |
|---|---|---|---|---|---|
| A literature | ~1,800 | 43 | 65 | ~118k | 9.8 min |
| B tools | ~2,500 incl. tables | 41 | 63 | ~218k | 9.2 min |
| C context and cost | ~1,260 | 28 | 52 | ~117k | 7.8 min |
| D astronomy | ~2,200 | 45 | 90 | ~149k | 10.9 min |

Totals: 270 tool calls, ~602k subagent tokens, 10.9 minutes wall-clock because the four ran in parallel
(about 38 minutes if run one after another). Researchers ran on the parent model (Fable 5.1); see note above.

Merged by the orchestrator into `research/brief.md` (~2,100 words), organized by what the outliner needs:
thesis evidence, the against case, per-pattern evidence, gotchas, tool mechanics, astronomy, a numbers table,
conflicts for the fact-checker, and a consolidated Unverified list.

Observations worth a slide:
- Four researchers returned ~7,100 words of briefs but only ~800 words of summaries to the orchestrator.
  The orchestrator read the briefs from disk on its own schedule. That is the compression pattern working.
- Two researchers cited the same Anthropic post under two different URLs. The merge caught it; the
  fact-checker will settle it. Independent agents disagree on details, so the merge must be centralized.
- The instructions said "600 to 1200 words". B wrote ~1,670 words of prose and said why. Agents drift on
  soft limits; hard schemas (`--json-schema`) hold better.
