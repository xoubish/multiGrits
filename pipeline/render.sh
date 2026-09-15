#!/usr/bin/env bash
# Render slides/deck.md to slides/build/deck.html (and optionally PDF) with Marp via npx.
# Mermaid diagrams render in the browser from the inlined <pre class="mermaid"> blocks, so present
# from deck.html in a browser with network access. For PDF, pre-render .mmd to SVG first (see README).
set -euo pipefail
cd "$(dirname "$0")/.."
python3 pipeline/inline_diagrams.py || echo "continuing with missing diagrams" >&2
npx -y @marp-team/marp-cli@4 --html --allow-local-files slides/build/deck.md -o slides/build/deck.html
[[ "${1:-}" == "--pdf" ]] && npx -y @marp-team/marp-cli@4 --html --allow-local-files slides/build/deck.md -o slides/build/deck.pdf
echo "open slides/build/deck.html"
