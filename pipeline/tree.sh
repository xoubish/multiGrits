#!/usr/bin/env bash
# Repo layout, two levels deep, without build output, caches, or git internals. Used for the demo screenshot.
cd "$(dirname "$0")/.."
find . -maxdepth "${1:-2}" \
  -not -path '*/.git*' -not -path './slides/build*' -not -path './diagrams/build*' -not -path './node_modules*' \
  -not -path './.worktrees*' -not -path '*/__pycache__*' -not -path './runs/0*' -not -name '.DS_Store' -not -name '.gitignore' \
  | sort | sed -e 's|^\./||' -e 's|[^/]*/|   |g'
echo "   0NN-<stage>/   (one directory per pipeline stage; next slide)"
