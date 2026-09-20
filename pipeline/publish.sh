#!/usr/bin/env bash
# Build docs/ for GitHub Pages: the deck with speaker notes stripped, plus its assets and the PDF.
#
# The hosted copy is NOT the one you present from. Present from slides/build/deck.html, which keeps
# the notes so presenter view (press p) works. This script exists so the public copy does not ship
# unresolved to-dos in its HTML source. The notes remain readable in slides/deck.md on GitHub.
#
# Pages setting this expects: Settings -> Pages -> Deploy from a branch -> main / docs.
set -euo pipefail
cd "$(dirname "$0")/.."

bash pipeline/render.sh          # refresh slides/build/deck.md and deck.html

# Strip speaker notes. Marp directives (<!-- _class: ... -->) are comments too and must survive.
python3 - <<'PY'
import re, pathlib
src = pathlib.Path("slides/build/deck.md").read_text()
DIRECTIVE = re.compile(r'^\s*_?(class|paginate|footer|header|backgroundColor|color|theme|style|headingDivider|transition)\s*:')
kept = removed = 0
def strip(m):
    global kept, removed
    if DIRECTIVE.match(m.group(1)):
        kept += 1; return m.group(0)
    removed += 1; return ""
out = re.sub(r'<!--(.*?)-->', strip, src, flags=re.S)
out = re.sub(r'\n{3,}', '\n\n', out)
pathlib.Path("slides/build/deck-public.md").write_text(out)
print(f"  notes stripped: {removed} removed, {kept} Marp directives kept")
PY

if command -v marp >/dev/null 2>&1; then MARP_BIN=(marp)
elif ls "$HOME"/.npm/_npx/*/node_modules/.bin/marp >/dev/null 2>&1; then MARP_BIN=("$(ls "$HOME"/.npm/_npx/*/node_modules/.bin/marp | head -1)")
else MARP_BIN=(npx -y @marp-team/marp-cli@4); fi
run_marp() { perl -e 'alarm 180; exec @ARGV' -- "${MARP_BIN[@]}" --no-stdin "$@"; }

mkdir -p docs
run_marp --html --allow-local-files slides/build/deck-public.md -o docs/index.html
run_marp --html --allow-local-files slides/build/deck-public.md -o docs/deck.pdf

# Assets: Marp writes paths relative to the output file, which sat one level deeper in slides/build/.
# In docs/ they are siblings, so drop the ../ prefix, then copy them in.
python3 - <<'PY'
import pathlib, re
p = pathlib.Path("docs/index.html"); h = p.read_text()
h, n = re.subn(r'\.\./(illustrations|shots)/', r'\1/', h)
p.write_text(h)
print(f"  asset paths rewritten: {n}")
PY

rm -rf docs/illustrations docs/shots
touch docs/.nojekyll

# Copy exactly the assets the page references, so docs/ holds no images the site never serves,
# then confirm nothing it asks for is missing.
python3 - <<'PY'
import pathlib, re, shutil, sys
h = pathlib.Path("docs/index.html").read_text()
refs = sorted({s for s in re.findall(r'(?:src|href)="([^"]+)"', h)
               if not s.startswith(('data:', '#', 'http'))})
missing = []
for r in refs:
    src = pathlib.Path("slides") / r
    if not src.exists():
        missing.append(r); continue
    dst = pathlib.Path("docs") / r
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)
if missing:
    sys.exit("  MISSING source for: " + ", ".join(missing))
unused = sorted(set(p.name for p in pathlib.Path("slides/illustrations").glob("*.svg"))
                - set(pathlib.Path(r).name for r in refs))
print(f"  {len(refs)} referenced assets copied into docs/")
if unused:
    print(f"  not copied (drawn for cut slides, still in slides/illustrations/): {', '.join(unused)}")
PY

echo "docs/ built: $(du -sh docs | cut -f1). Preview: open docs/index.html"
