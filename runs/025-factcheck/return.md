I've written `runs/025-factcheck/factcheck.md`. Summary:

**Tally: CONFIRMED: 41 · PARTIAL: 0 · NOT FOUND: 0 · CONTRADICTED: 1** (plus one repo-internal claim not independently verifiable with available tools)

**The CONTRADICTED row:**

| Slide | Claim | URL | Status | Note |
|---|---|---|---|---|
| 52 ("Cost, and when it is worth it (2)") | "Claude Code's subagent frontmatter takes a `model` field, and its Explore agent already runs on Haiku" | code.claude.com/docs/en/sub-agents | **CONTRADICTED** | Current docs state that as of v2.1.198, the built-in Explore subagent inherits the main conversation's model instead of always running on Haiku (capped at Opus). It only runs on Haiku today if you define a custom `Explore` subagent pinned to `model: haiku`. The deck's cite line is now factually wrong about current tool behavior. |

**Not independently verifiable (flagged, not counted as CONTRADICTED):**

| Slide | Claim | Source | Status | Note |
|---|---|---|---|---|
| Sources (2) | Old deck is "at commit `707ad48`" | git history, this repo | NOT INDEPENDENTLY VERIFIABLE | No Bash/git tool available to this fact-check pass to confirm the commit exists. Internally consistent (README.md states the same hash) but that's corroboration, not independent verification. Recommend running `git log` by hand once before the talk. |

Everything else — all arXiv papers (Liu, Hsieh, Anthropic building-effective-agents, MetaGPT's five roles, ChatDev's seven roles, MacNet, Project Sid, Kim et al., Tran & Kiela, Kapoor et al., Cemri/MAST, both Anthropic token-multiple posts, the worktrees docs) — resolved and matched the notes' figures, several cross-checked against the prior repo fact-check (`runs/009-factcheck/factcheck.md`) where the abstract alone didn't carry a body-table number. All internal repo claims (costs, turn counts, wall times, run outcomes, file contents, agent roster, outline text, `run.sh` command, `reviewer.md` text, the exoplanet-lookup example's real result) were checked directly against files in `runs/`, `examples/`, `.claude/agents/`, `README.md`, and `research/build-log.md`, and all matched exactly.
