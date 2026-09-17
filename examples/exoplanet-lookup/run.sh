#!/usr/bin/env bash
# Headless call to the exoplanet-lookup subagent. Run from this directory:
#   bash run.sh
set -euo pipefail
cd "$(dirname "$0")"

mkdir -p runs
OUT="runs/$(date +%Y%m%d-%H%M%S).json"

env -u CLAUDECODE claude -p \
  --agent exoplanet-lookup \
  --allowedTools "Read,Bash" \
  --max-budget-usd 1 \
  --output-format json \
  "Look up the exoplanets listed one per line in targets.txt (path: $(pwd)/targets.txt) in the NASA Exoplanet Archive and return the table." \
  > "$OUT"

echo "wrote $OUT"
