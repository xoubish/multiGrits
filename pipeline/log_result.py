#!/usr/bin/env python3
"""Extract the agent's return text and a cost row from a `claude -p --output-format json` result.

Usage: log_result.py <run_dir> <agent> <wall_seconds>
Writes <run_dir>/return.md and appends a row to runs/cost.tsv.
Field names are read defensively: the headless JSON shape has changed between Claude Code versions.
"""
import json, sys, pathlib, datetime

run_dir, agent, wall = pathlib.Path(sys.argv[1]), sys.argv[2], sys.argv[3]
raw = (run_dir / "result.json").read_text() if (run_dir / "result.json").exists() else ""
try:
    data = json.loads(raw) if raw.strip() else {}
except json.JSONDecodeError:
    data = {"result": raw}
if isinstance(data, list):  # stream-json fallback: take the final result event
    data = next((d for d in reversed(data) if isinstance(d, dict) and d.get("type") == "result"), {})

(run_dir / "return.md").write_text(str(data.get("result", "")).strip() + "\n")

usage = data.get("usage") or {}
models = ",".join(sorted((data.get("modelUsage") or {}).keys())) or "?"
row = [
    datetime.datetime.now().isoformat(timespec="seconds"),
    str(run_dir), agent, models,
    str(data.get("num_turns", "")),
    str(usage.get("input_tokens", "")),
    str(usage.get("cache_read_input_tokens", "")),
    str(usage.get("cache_creation_input_tokens", "")),
    str(usage.get("output_tokens", "")),
    str(data.get("total_cost_usd", "")),
    str(data.get("duration_ms", "")),
    wall,
    str(data.get("is_error", "")),
]
# One row per run directory. Parallel worktrees appending to a single shared runs/cost.tsv produced a
# merge conflict in run 004 (the "two agents, one file" failure). cost_report.py now regenerates the
# shared table from every result.json instead.
(run_dir / "cost-row.tsv").write_text(
    "time\trun_dir\tagent\tmodels\tturns\tinput\tcache_read\tcache_write\toutput\tusd\tduration_ms\twall_s\tis_error\n"
    + "\t".join(row) + "\n")
if data.get("terminal_reason") == "budget_exhausted" or data.get("subtype") == "error_max_budget_usd":
    print(f"[log_result] WARNING: {run_dir} hit the --max-budget-usd ceiling (${data.get('total_cost_usd', 0):.2f}); output may be partial. Re-run the stage with a higher --budget.")
print(f"[log_result] {run_dir}: turns={row[4]} in={row[5]} out={row[8]} usd={row[9]} models={models}")
