#!/usr/bin/env bash
# Render slides/deck.md to slides/build/deck.html (and optionally PDF) with Marp via npx.
# Mermaid diagrams render in the browser from the inlined <pre class="mermaid"> blocks, so present
# from deck.html in a browser with network access. For PDF, pre-render .mmd to SVG first (see README).
set -euo pipefail
cd "$(dirname "$0")/.."
python3 pipeline/inline_diagrams.py || echo "continuing with missing diagrams" >&2
# Prefer an installed or npx-cached marp; `npx -y pkg@4` re-resolves the version against the registry on every
# call and hung for minutes once during the build. Fall back to npx only when nothing is cached.
if command -v marp >/dev/null 2>&1; then MARP_BIN=(marp)
elif ls "$HOME"/.npm/_npx/*/node_modules/.bin/marp >/dev/null 2>&1; then MARP_BIN=("$(ls "$HOME"/.npm/_npx/*/node_modules/.bin/marp | head -1)")
else MARP_BIN=(npx -y @marp-team/marp-cli@4); fi
# Hard 180 s ceiling per call: two HTML conversions stalled for minutes once during the build; the same command
# then completed in 0.3 s. Better a loud failure than a silent hang before a talk.
# --no-stdin: without it Marp waits forever for piped input whenever stdin is not a terminal (cron, CI, backgrounded runs).
run_marp() { perl -e 'alarm 180; exec @ARGV' -- "${MARP_BIN[@]}" --no-stdin "$@"; }
run_marp --html --allow-local-files slides/build/deck.md -o slides/build/deck.html
[[ "${1:-}" == "--pdf" ]] && run_marp --html --allow-local-files slides/build/deck.md -o slides/build/deck.pdf
[[ "${1:-}" == "--png" ]] && mkdir -p slides/build/png && run_marp --html --allow-local-files slides/build/deck.md --images png --image-scale 1 -o slides/build/png/deck.png
echo "open slides/build/deck.html"
