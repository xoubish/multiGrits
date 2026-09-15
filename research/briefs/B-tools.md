# Topic B — How coding-agent tools and frameworks implement multi-agent work

## Key findings

1. Claude Code subagents are Markdown files with YAML frontmatter in `.claude/agents/` (project) or `~/.claude/agents/` (user); `name` and `description` are required, and optional fields are `tools`, `disallowedTools`, `model` (`sonnet`, `opus`, `haiku`, `fable`, full ID, or `inherit`), `permissionMode`, `maxTurns`, `skills`, `memory`, `background`, `effort`, `isolation: worktree`, `mcpServers`, `hooks`, `omitClaudeMd`. (Anthropic, 2026, "Create custom subagents", https://code.claude.com/docs/en/sub-agents)
2. A subagent's context starts fresh: it receives its system prompt, the delegation message, CLAUDE.md, a git status snapshot and preloaded skills, but not the parent's conversation history, previously read files, or context size; only its final message returns to the caller. (Anthropic, 2026, https://code.claude.com/docs/en/sub-agents)
3. Claude spawns subagents through the `Agent` tool; they nest up to 3 layers (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`), at most 20 run concurrently by default (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`, v2.1.217+), and they run in the background by default. (Anthropic, 2026, https://code.claude.com/docs/en/sub-agents)
4. `isolation: worktree` runs a subagent in a temporary git worktree branched from the default branch and auto-removed if unchanged (v2.1.203+); `claude --worktree <name>` does the same for a whole session under `.claude/worktrees/<name>/` on branch `worktree-<name>`; Claude Code blocks edits, commands, and git redirects that target the main checkout. (Anthropic, 2026, "Run parallel sessions with worktrees", https://code.claude.com/docs/en/worktrees)
5. Headless: `claude -p "<prompt>"` with `--output-format json|stream-json`, `--json-schema`, `--agent <name>` (whole session runs as one subagent definition), `--agents '<json>'` (define subagents inline), `--max-budget-usd` (subagent spend counts toward the cap, v2.1.217+), `--max-turns`, `--resume <session_id>`, and `--bare` (skip hooks, agents, plugins, CLAUDE.md for reproducible CI runs); the JSON result carries `total_cost_usd` and `session_id`. (Anthropic, 2026, "Run Claude Code programmatically", https://code.claude.com/docs/en/headless; "CLI reference", https://code.claude.com/docs/en/cli-reference)
6. Agent teams (a lead plus teammates with a shared task list and JSON mailboxes under `~/.claude/teams/`) are experimental, disabled by default (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`), interactive-only (not spawned under `-p`), and do not isolate teammates in worktrees; the doc says to check whether subagents do the job first. (Anthropic, 2026, "Orchestrate teams of Claude Code sessions", https://code.claude.com/docs/en/agent-teams)
7. Dynamic workflows move orchestration into a JavaScript script (`agent()`, `pipeline()`, `parallel()`) that a runtime executes outside the conversation; the doc frames the difference as "who holds the plan": Claude turn-by-turn (subagents, teams) versus the script (workflows), and makes `Date.now()`/`Math.random()` throw so a relaunched run repeats the same calls. (Anthropic, 2026, "Orchestrate subagents at scale with dynamic workflows", https://code.claude.com/docs/en/workflows)
8. The Claude Agent SDK (Python and TypeScript) exposes the same mechanism as `agents={name: AgentDefinition(description, prompt, tools, model, ...)}` plus `max_budget_usd`; subagent messages carry `parent_tool_use_id`, so a script can rebuild the delegation tree from the stream. (Anthropic, 2026, "Subagents in the SDK", https://code.claude.com/docs/en/agent-sdk/subagents)
9. OpenAI Codex CLI: subagents are TOML files in `~/.codex/agents/` or `.codex/agents/` with `name`, `description`, `developer_instructions` and optional `model`, `model_reasoning_effort`, `sandbox_mode`, `mcp_servers`; built-ins are `default`, `worker`, `explorer`; `[agents]` in `config.toml` sets `enabled`, `max_concurrent_threads_per_session`, `default_subagent_model`; you invoke by asking ("spawn one agent per point") or via AGENTS.md/skill instructions; subagents inherit the parent's sandbox and working directory. Headless is `codex exec` with `--json`, `--output-schema`, `-o`, and `codex exec resume`. (OpenAI, 2026, "Subagents", https://learn.chatgpt.com/codex/agent-configuration/subagents; "Non-interactive mode", https://learn.chatgpt.com/codex/non-interactive-mode)
10. OpenCode: agents have `mode: primary | subagent | all`, defined in `opencode.json` or Markdown under `.opencode/agents/`; built-in primaries are Build and Plan, subagents General, Explore, Scout; per-agent `model` ("provider/model-id"), `permission`, `prompt`, `temperature`, `task_permissions`; invoke with `@name` or automatically through the Task tool; unset subagent models default to the invoking primary's model. Headless is `opencode run --agent <name> --format json`. (OpenCode, 2026, "Agents", https://opencode.ai/docs/agents/; "CLI", https://opencode.ai/docs/cli/)
11. Gemini CLI: subagents live in `.gemini/agents/*.md` or `~/.gemini/agents/*.md` with `name`, `description`, `tools`, `model`, `max_turns` (default 30), `timeout_mins` (default 10), `kind: local|remote`; built-ins are `codebase_investigator`, `cli_help`, `generalist`, `browser_agent`; each "runs in its own isolated context loop" and "subagents cannot call other subagents"; no parallel execution is documented. Headless: `-p` with `--output-format text|json|stream-json` and `--approval-mode default|auto_edit|yolo|plan`. (Google, 2026, "Subagents", https://geminicli.com/docs/core/subagents/; "CLI reference", https://geminicli.com/docs/cli/cli-reference/)
12. Qwen Code: subagents in `.qwen/agents/` with fields mirroring Claude Code (`model`, `approvalMode`, `tools`, `disallowedTools`, `mcpServers`, `hooks`, `maxTurns`); "fork" subagents inherit parent history, run detached in parallel, and share the parent's prompt-cache prefix but not a worktree; an experimental Agent Team (`QWEN_CODE_ENABLE_AGENT_TEAM=1`, `/coordinate`) shares a task list and lets the leader "create one Git worktree and pin one writer teammate to it". Headless: `-p` with `--output-format stream-json`, `--max-wall-time`, `--max-tool-calls`. (Alibaba Qwen, 2026, https://qwenlm.github.io/qwen-code-docs/en/users/features/sub-agents/; https://qwenlm.github.io/qwen-code-docs/en/users/features/multi-agent-coordination/; https://qwenlm.github.io/qwen-code-docs/en/users/features/headless/)

### Frameworks (orchestration model in bold)

- **LangGraph — graph.** Nodes plus conditional edges; `Command(goto=..., update=...)` implements handoffs, `Send` does dynamic map-reduce fan-out, subgraphs give hierarchy. LangChain's current guide names five patterns: subagents (as tools), handoffs, skills, router, custom workflow; the older `langgraph-supervisor` library now says "we now recommend using the supervisor pattern directly via tools rather than this library". (LangChain, 2026, https://docs.langchain.com/oss/python/langgraph/graph-api; https://docs.langchain.com/oss/python/langchain/multi-agent; https://github.com/langchain-ai/langgraph-supervisor-py)
- **CrewAI — role crew.** `Crew(agents, tasks, process=sequential|hierarchical, manager_llm)`; each `Agent` has `role`, `goal`, `backstory`, its own `llm`, and `allow_delegation` (default `False`). Flows (`@start`, `@listen`, `@router`, `and_`/`or_`) add deterministic, event-driven orchestration around crews. (CrewAI, 2026, https://docs.crewai.com/en/concepts/crews; https://docs.crewai.com/en/concepts/agents; https://docs.crewai.com/en/concepts/flows)
- **AutoGen / AG2 — conversation.** AG2 group chat picks speakers by pattern: `AutoPattern` (LLM chooses), `RoundRobinPattern`, `RandomPattern`, `ManualPattern`, `DefaultPattern` (explicit `OnCondition` handoffs); each agent has its own `llm_config`. Microsoft's AutoGen AgentChat offers `RoundRobinGroupChat`, `SelectorGroupChat`, `Swarm`, `MagenticOneGroupChat`, `GraphFlow`, each agent with its own `model_client`. (AG2, 2026, https://docs.ag2.ai/latest/docs/user-guide/advanced-concepts/orchestration/group-chat/patterns/; Microsoft, 2026, https://microsoft.github.io/autogen/stable/user-guide/agentchat-user-guide/tutorial/teams.html)
- **OpenAI Agents SDK — handoff.** `Agent(handoffs=[...])` exposes each target as a tool named `transfer_to_<agent_name>` and the specialist "becomes the active agent"; the alternative `Agent.as_tool()` keeps a manager in control; the docs also endorse plain code orchestration ("asyncio.gather" for independent agents, "iterative loops with evaluator agents"). (OpenAI, 2026, https://openai.github.io/openai-agents-python/handoffs/; https://openai.github.io/openai-agents-python/multi_agent/)
- **Claude Agent SDK — supervisor (orchestrator + subagents).** See finding 8; the model decides when to call `Agent`, and depth, concurrency, and USD caps bound the tree. (Anthropic, 2026, https://code.claude.com/docs/en/agent-sdk/subagents)
- **Google ADK — hierarchy with deterministic workflow agents.** `SequentialAgent`, `ParallelAgent`, `LoopAgent` run `sub_agents` "without consulting an AI model"; `ParallelAgent` gives each sub-agent its own branch with "no automatic sharing of conversation history or state"; ADK 2.0 adds graph-based, dynamic (code), and collaborative (LLM coordinator) workflows. (Google, 2026, https://adk.dev/agents/workflow-agents/; https://adk.dev/agents/workflow-agents/parallel-agents/; https://adk.dev/workflows/)
- **smolagents — manager with managed agents (agents as tools).** `CodeAgent(managed_agents=[...])`; a managed agent must set `name` and `description`; every agent takes its own `model`. (Hugging Face, 2026, https://huggingface.co/docs/smolagents/en/examples/multiagents; https://huggingface.co/docs/smolagents/en/reference/agents)

### Native support for the talk's four patterns

| Tool | 1 Fan-out and merge | 2 Pipeline | 3 Writer and critic | 4 Parallel isolated workers (worktrees) |
|---|---|---|---|---|
| Claude Code | Yes: parallel `Agent` calls; Workflow `parallel()` | Yes: chained `claude -p` + `--resume`; Workflow `pipeline()` | Yes: reviewer subagent; workflows' adversarial verification | Yes: `isolation: worktree`, `--worktree`, `/batch` |
| Codex CLI | Yes: "spawn one agent per point", thread cap | Yes: `codex exec` + `resume` | Yes: custom TOML agent | Not documented |
| OpenCode | Yes: Task tool; General subagent | Yes: `opencode run --agent` | Yes: docs' `review` subagent with `edit: deny` | Not documented |
| Gemini CLI | Partial: subagents, no parallelism or nesting documented | Yes: `-p` chaining | Yes: custom subagent | No |
| Qwen Code | Yes: detached forks | Yes: `-p` chaining | Yes: custom subagent | Partial: Agent Team, one worktree for one writer |
| LangGraph | Yes: `Send` | Yes: edges | Yes: loop edges | n/a (library) |
| CrewAI | Partial: `akickoff`, Flows `and_` | Yes: `Process.sequential` | Yes: hierarchical manager "validating outcomes" | n/a |
| AG2 / AutoGen | Partial: group chat, nested chats | Yes: round-robin / sequential | Yes: two-agent chat | n/a |
| OpenAI Agents SDK | Yes: `asyncio.gather` | Yes: code chaining | Yes: evaluator loop | n/a |
| Claude Agent SDK | Yes | Yes | Yes | Partial: via filesystem agent files (see Unverified) |
| Google ADK | Yes: `ParallelAgent` | Yes: `SequentialAgent` | Yes: `LoopAgent` | n/a |
| smolagents | Partial: managed agents; parallelism not documented | Yes: code | Partial: `final_answer_checks` | n/a |

### Comparison table

| Tool | Subagent mechanism | Isolation | Model per agent | Headless / scriptable |
|---|---|---|---|---|
| Claude Code | `.claude/agents/*.md` or `--agents` JSON; `Agent` tool; depth 3, 20 concurrent | Fresh context; optional git worktree with writes to main checkout blocked | Yes: `model:`; `CLAUDE_CODE_SUBAGENT_MODEL` | `claude -p --output-format json --json-schema --max-budget-usd --resume --bare` |
| Codex CLI | `.codex/agents/*.toml`; built-ins default/worker/explorer; `[agents]` in `config.toml` | Own thread; inherits parent sandbox and cwd; no worktree documented | Yes: `model`, `default_subagent_model` | `codex exec --json --output-schema -o`; `codex exec resume` |
| OpenCode | `mode: subagent` in `opencode.json` or `.opencode/agents/*.md`; Task tool; `@name` | Own session; per-agent `permission` (e.g. `edit: deny`); no worktree documented | Yes: `model: provider/id`; default = invoking primary's model | `opencode run --agent --format json --continue` |
| Gemini CLI | `.gemini/agents/*.md`; `@agent_name`; no nesting | "Own isolated context loop"; tool allowlist | Yes: `model` or `agents.overrides` | `gemini -p --output-format json --approval-mode yolo` |
| Qwen Code | `.qwen/agents/*.md`; forks; experimental Agent Team | Own history; forks share cwd; team: one worktree, one writer | Yes: `model: inherit|fast|id` | `qwen -p --output-format stream-json --max-wall-time` |
| LangGraph | Nodes, subgraphs, `Command`, `Send` | State schema with reducers, yours to define | Yes, per node | Python/JS library |
| CrewAI | `Agent` objects in a `Crew`; `allow_delegation` | Shared crew memory | Yes: `llm` per agent | Python library; `kickoff`/`akickoff` |
| AG2 / AutoGen | Group chat patterns; `OnCondition` handoffs | Shared chat transcript | Yes: `llm_config` / `model_client` | Python library |
| OpenAI Agents SDK | `handoffs=[...]`; `as_tool()` | Conversation transfers; `input_filter` trims history | Per `Agent` (not verified on opened pages) | Python library |
| Claude Agent SDK | `agents={...: AgentDefinition}`; `Agent` tool | Fresh context; `parent_tool_use_id` in stream | Yes: `model` | Python/TS; `max_budget_usd`, env caps |
| Google ADK | `sub_agents` on `Sequential/Parallel/LoopAgent` | `ParallelAgent` branches share nothing automatically | Per agent (not verified on opened pages) | Python/Java library |
| smolagents | `managed_agents=[...]` | Manager sees only the managed agent's report | Yes: `model` | Python library |

## Numbers worth quoting

- 3 layers — default subagent nesting depth in Claude Code; 20 — default concurrent subagents. https://code.claude.com/docs/en/sub-agents
- 15,000 tokens — combined subagent `description` text that triggers a startup warning. https://code.claude.com/docs/en/sub-agents
- ~7x — token use of agent teams vs a standard session when teammates run in plan mode (vendor statement). https://code.claude.com/docs/en/costs
- ~$13 per developer per active day; $150–250 per month; 90% of users under $30/day — Anthropic's enterprise averages for Claude Code (vendor figure, not independent). https://code.claude.com/docs/en/costs
- 16 concurrent agents, 1,000 agents per run, 4,096 items per `parallel()`/`pipeline()` — dynamic workflow caps; "Large workflow" warning above 25 agents or 1.5M projected tokens. https://code.claude.com/docs/en/workflows
- 3–5 teammates and 5–6 tasks per teammate — recommended agent-team sizing. https://code.claude.com/docs/en/agent-teams
- 30 turns / 10 minutes — Gemini CLI subagent defaults for `max_turns` / `timeout_mins`. https://geminicli.com/docs/core/subagents/
- 10 minutes — how long `claude -p` waits on an idle background subagent before dropping it (`CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS`); 10 MB — stdin cap. https://code.claude.com/docs/en/headless
- 5 to 30 — worktree-isolated subagents spawned by the `/batch` skill. https://code.claude.com/docs/en/agents
- 5 min vs 1 h — default prompt-cache TTL for teammates/workflow agents vs with `subagentPromptCacheTtl: 1h`. https://code.claude.com/docs/en/agent-teams

## Suggested slide points

- "A subagent starts with an empty conversation: it gets your delegation message, CLAUDE.md and a git snapshot, not your history." (https://code.claude.com/docs/en/sub-agents)
- "One file per role, five tools, same shape: `.claude/agents/*.md`, `.codex/agents/*.toml`, `.opencode/agents/*.md`, `.gemini/agents/*.md`, `.qwen/agents/*.md` — each with name, description, tools, model." (docs cited in findings 1, 9–12)
- "`isolation: worktree`: the harness blocks any edit or git command aimed at the main checkout." (https://code.claude.com/docs/en/worktrees)
- "Script the orchestration: `claude -p ... --output-format json --max-budget-usd 5` returns `total_cost_usd`; `codex exec --json`; `opencode run --format json`." (https://code.claude.com/docs/en/headless; https://learn.chatgpt.com/codex/non-interactive-mode; https://opencode.ai/docs/cli/)
- "Agent teams: experimental, off by default, interactive-only, ~7x tokens in plan mode. Anthropic's own advice: try subagents first." (https://code.claude.com/docs/en/agent-teams; https://code.claude.com/docs/en/costs)
- "Frameworks differ in who picks the next step: graph (LangGraph, ADK), role crew (CrewAI), conversation (AG2/AutoGen), handoff (OpenAI SDK), supervisor (Claude SDK, smolagents)." (framework docs above)

## Astronomy or IPAC angle

- A per-tile or per-catalog sweep maps onto Workflow `pipeline(items, x => agent(..., {schema}))` or a shell loop over `claude -p --json-schema`: one subagent per tile, validated JSON back, merged by a deterministic script rather than by the model. (https://code.claude.com/docs/en/workflows; https://code.claude.com/docs/en/headless)
- Pipeline teams already trust deterministic DAGs; ADK's `SequentialAgent`/`ParallelAgent` and Claude Code workflows are that model with LLM nodes, where the script decides what runs next. (https://adk.dev/agents/workflow-agents/; https://code.claude.com/docs/en/workflows)
- On shared budgets, `--max-budget-usd` caps an entire subagent tree per run and `--bare` makes every machine load identical inputs, which is the reproducibility case for an archive group. (https://code.claude.com/docs/en/cli-reference; https://code.claude.com/docs/en/headless)

## Unverified

- Codex CLI worktree isolation for subagents: the subagents page says subagents inherit the parent's sandbox and working directory and never mentions worktrees; I could not confirm whether any per-agent worktree option exists. Need: Codex config reference or changelog.
- Gemini CLI concurrency: docs state isolated context and forbid nesting but say nothing about running subagents in parallel. Need: Gemini CLI source or release notes.
- OpenAI Agents SDK per-agent `model` parameter and Google ADK `LlmAgent(sub_agents=...)`, `transfer_to_agent`, `AgentTool`: I did not reach those reference pages (the ADK multi-agents URL redirected to an overview; the collaborative-workflows URL returned 404). Need: the Agent class reference pages.
- Whether `isolation: worktree` is honored for SDK `AgentDefinition` objects: it is listed for `--agents` JSON but absent from the SDK field table. Need: TypeScript SDK reference.
- Codex model names on the subagents page (`gpt-5.6`, `gpt-5.6-terra`, `gpt-5.6-luna`) and effort levels up to `ultra` are vendor naming as of 2026-09-15 and may change.
- AG2 is commonly described as the community fork of Microsoft AutoGen; none of the AG2 pages I opened state this. Need: AG2 GitHub README.
- The Codex docs domain redirected from developers.openai.com/codex to learn.chatgpt.com; treat page URLs as possibly moving again.

## Sources

https://code.claude.com/docs/en/sub-agents
https://code.claude.com/docs/en/headless
https://code.claude.com/docs/en/cli-reference
https://code.claude.com/docs/en/common-workflows
https://code.claude.com/docs/en/agent-teams
https://code.claude.com/docs/en/worktrees
https://code.claude.com/docs/en/costs
https://code.claude.com/docs/en/cross-session-messaging
https://code.claude.com/docs/en/agents
https://code.claude.com/docs/en/workflows
https://code.claude.com/docs/en/agent-sdk/subagents
https://code.claude.com/docs/en/agent-sdk/overview
https://learn.chatgpt.com/docs
https://learn.chatgpt.com/codex/agent-configuration/subagents
https://learn.chatgpt.com/codex/non-interactive-mode
https://opencode.ai/docs/agents/
https://opencode.ai/docs/cli/
https://geminicli.com/docs/
https://geminicli.com/docs/core/subagents/
https://geminicli.com/docs/cli/headless/
https://geminicli.com/docs/cli/cli-reference/
https://qwenlm.github.io/qwen-code-docs/en/
https://qwenlm.github.io/qwen-code-docs/en/users/features/sub-agents/
https://qwenlm.github.io/qwen-code-docs/en/users/features/multi-agent-coordination/
https://qwenlm.github.io/qwen-code-docs/en/users/features/headless/
https://docs.langchain.com/oss/python/langchain/multi-agent
https://docs.langchain.com/oss/python/langgraph/graph-api
https://github.com/langchain-ai/langgraph-supervisor-py
https://docs.crewai.com/en/concepts/crews
https://docs.crewai.com/en/concepts/agents
https://docs.crewai.com/en/concepts/flows
https://docs.ag2.ai/latest/docs/user-guide/advanced-concepts/orchestration/group-chat/patterns/
https://docs.ag2.ai/latest/docs/user-guide/basic-concepts/introducing-group-chat/
https://microsoft.github.io/autogen/stable/user-guide/agentchat-user-guide/tutorial/teams.html
https://openai.github.io/openai-agents-python/handoffs/
https://openai.github.io/openai-agents-python/multi_agent/
https://adk.dev/workflows/
https://adk.dev/agents/workflow-agents/
https://adk.dev/agents/workflow-agents/parallel-agents/
https://huggingface.co/docs/smolagents/en/examples/multiagents
https://huggingface.co/docs/smolagents/en/reference/agents
