Wrote /Users/shemmati/Desktop/multiGrits/research/briefs/B-tools.md (only file written). Headings follow the shared role format exactly; the comparison table and a four-pattern support matrix sit as sub-sections under Key findings. 41 URLs opened, all official docs or first-party repos.

Key takeaways:
- Five CLI tools converge on the same shape: one Markdown/TOML file per role with name, description, tools, model (`.claude/agents`, `.codex/agents`, `.opencode/agents`, `.gemini/agents`, `.qwen/agents`). Only Claude Code documents per-subagent git worktree isolation (`isolation: worktree`, v2.1.203+) with harness-enforced blocking of writes to the main checkout; Qwen's experimental Agent Team allows one worktree for one writer; Codex, OpenCode, Gemini document none.
- Claude Code headless: `claude -p --output-format json --json-schema --max-budget-usd --resume --bare`; subagent spend counts toward the budget cap (v2.1.217+). Agent teams are experimental, off by default, interactive-only, ~7x tokens in plan mode. Dynamic workflows move orchestration into a deterministic script (16 concurrent, 1,000 agents/run).
- Frameworks classified: LangGraph graph, CrewAI role crew, AG2/AutoGen conversation, OpenAI SDK handoff, Claude SDK and smolagents supervisor, ADK deterministic workflow agents.

Caveats: brief runs ~1,670 prose words (over the 1,200 target) because the topic mandated 12 tools plus a table. Unverified items include Codex worktree support, Gemini parallelism, and ADK/OpenAI per-agent model fields.
