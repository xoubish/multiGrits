(Subagent report, claude-code-guide, 27 tool uses, ~3.5 min)

1. Frontmatter keys that exist: name, description, tools, disallowedTools, model (haiku/opus/sonnet/inherit/full id),
   permissionMode (default/auto/plan/acceptEdits/dontAsk/bypassPermissions), memory (user/project/local), skills,
   isolation (worktree), maxTurns, background, effort (low..max), hooks. Made up: color.
2. `claude -p --agent <name>` auto-discovers .claude/agents/ (highest priority); model and tools apply in headless mode.
3. JSON: result, total_cost_usd, session_id, num_turns, duration_ms, usage.input_tokens, usage.output_tokens.
4. Worktree: `isolation: worktree`; auto-removed when no changes, otherwise persists until cleanup sweep (cleanupPeriodDays, default 30).
5. Budget: exit code 2 = cost ceiling hit; JSON has error_max_budget_usd; mid-turn behavior undocumented.
