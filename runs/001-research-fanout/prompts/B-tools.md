TOPIC B — How today's coding-agent tools and frameworks actually implement multi-agent work.

Output path: research/briefs/B-tools.md

For each tool, describe the concrete mechanism with a link to the official docs:
- Claude Code: subagents defined in `.claude/agents/*.md` (frontmatter fields: name, description,
  tools, model, and any others), the Agent tool, git worktree isolation for subagents, headless
  `claude -p` with `--agent`, `--agents`, `--output-format json`, `--max-budget-usd`, and any
  multi-session or team features. Note what is documented vs. what you infer.
- OpenAI Codex CLI: subagent or multi-agent features, if any, and how they are configured.
- OpenCode: primary agents vs. subagents, config format, how they are invoked.
- Gemini CLI and Qwen Code: any subagent support.
- Frameworks, one paragraph each: LangGraph, CrewAI, AutoGen/AG2, OpenAI Agents SDK (handoffs),
  Claude Agent SDK, Google ADK, smolagents. State what orchestration model each uses
  (graph, role crew, conversation, handoff, supervisor) in a few words.
- Identify which of the four patterns in talk-context.md each tool supports natively.

Deliver a comparison table in the brief: tool, subagent mechanism, isolation, model per agent, headless/scriptable.
