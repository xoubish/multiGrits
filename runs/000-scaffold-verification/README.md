# Run 000 — scaffold verification (interactive, claude-code-guide subagent)

Before writing `.claude/agents/*.md` and `pipeline/run.sh`, the orchestrator delegated one question to a
docs-reading subagent: which subagent frontmatter keys and headless flags actually exist in Claude Code 2.1.270.
This is the "writer and critic" pattern applied to the scaffold itself: I drafted from memory, a second
agent with web access checked it against the docs.

Verified (docs: https://code.claude.com/docs/en/sub-agents.md, https://code.claude.com/docs/en/headless):
- Frontmatter keys: `name`, `description`, `tools` (comma-separated), `disallowedTools`, `model`
  (`haiku` | `sonnet` | `opus` | `inherit` | full id), `permissionMode`, `memory`, `skills`,
  `isolation: worktree`, `maxTurns`, `background`, `effort`, `hooks`. `color` is NOT documented.
- `claude -p --agent <name>` picks up project agents from `.claude/agents/`; the agent's `model` and `tools` apply.
- `--output-format json` fields: `result`, `total_cost_usd`, `session_id`, `num_turns`, `duration_ms`,
  `usage.input_tokens`, `usage.output_tokens`, plus `modelUsage` per model.
- `isolation: worktree` on a subagent gives it its own git worktree; clean worktrees are removed automatically,
  worktrees with changes persist until the periodic cleanup sweep.
- `--max-budget-usd`: exit code 2 when the ceiling is hit; JSON includes `error_max_budget_usd`.
  Whether it stops mid-turn is undocumented.

Decision: the script manages worktrees itself in the `write` stage rather than relying on `isolation: worktree`,
because the headless main thread is not a subagent. The interactive alternative (Agent tool with
`isolation: "worktree"`) is documented in README.md.

## Smoke test (2026-09-15, scratchpad, not a pipeline stage)

`claude -p --agent outliner --output-format json "Reply with exactly: OK from outliner."`

- Exit 0, one turn, result text correct. `modelUsage` shows `claude-sonnet-5` did the work, confirming the
  agent file's `model: sonnet` was honored in headless mode (a small haiku call appears alongside; that is
  Claude Code's own helper traffic, not the agent).
- Cost: $0.019 for 9 output tokens. The system prompt is ~4,400 cache-creation tokens. Every agent
  invocation pays this fixed overhead before doing any work. Slide point: agents have a per-spawn tax, so
  do not fan out for trivially small tasks.
- Field names confirmed for `cost_report.py`: `total_cost_usd`, `num_turns`, `duration_ms`,
  `usage.input_tokens`, `usage.output_tokens`, `usage.cache_creation_input_tokens`,
  `modelUsage.<model>.{inputTokens,outputTokens,costUSD}`.
