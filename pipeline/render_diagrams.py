#!/usr/bin/env python3
"""Pre-render diagrams/*.mmd to static SVG with the installed Chrome and Mermaid.

Why: the live Mermaid loader draws labels with HTML <foreignObject>, which Safari clips, and it needs network
at presentation time. A static SVG with plain <text> labels renders identically in Safari, Chrome, and PDF,
offline. Output goes to diagrams/build/ (gitignored); inline_diagrams.py picks these up when present and falls
back to the live loader otherwise. Exit 0 in every case so render.sh never stops here.
"""
import html, pathlib, re, shutil, subprocess, sys, urllib.request

CHROME = next((c for c in [
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    "/Applications/Chromium.app/Contents/MacOS/Chromium",
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
    shutil.which("google-chrome"), shutil.which("chromium"), shutil.which("chromium-browser"),
] if c and pathlib.Path(c).exists()), None)
MERMAID_URL = "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"
OUT = pathlib.Path("diagrams/build"); OUT.mkdir(parents=True, exist_ok=True)

if not CHROME:
    print("[render_diagrams] no Chrome/Chromium found; the deck will use the live Mermaid loader"); sys.exit(0)
js = OUT / "mermaid.min.js"
if not js.exists():
    try:
        urllib.request.urlretrieve(MERMAID_URL, js); print(f"[render_diagrams] cached {js}")
    except Exception as e:
        print(f"[render_diagrams] could not download mermaid ({e}); using the live loader"); sys.exit(0)

PAGE = """<!doctype html><html><head><meta charset="utf-8"><script src="mermaid.min.js"></script></head>
<body><pre class="mermaid">{code}</pre>
<script>mermaid.initialize({{startOnLoad:true, theme:'neutral', securityLevel:'loose',
  flowchart:{{htmlLabels:false, nodeSpacing:30, rankSpacing:45, padding:8}}, themeVariables:{{fontSize:'20px'}}}});</script>
</body></html>"""

ok = 0
for mmd in sorted(pathlib.Path("diagrams").glob("*.mmd")):
    page = OUT / f"{mmd.stem}.html"
    page.write_text(PAGE.format(code=html.escape(mmd.read_text(), quote=False)))
    try:
        dom = subprocess.run([CHROME, "--headless=new", "--disable-gpu", "--no-sandbox", "--hide-scrollbars",
                              "--virtual-time-budget=10000", "--dump-dom", page.resolve().as_uri()],
                             capture_output=True, text=True, timeout=60).stdout
    except subprocess.TimeoutExpired:
        print(f"[render_diagrams] {mmd.name}: Chrome timed out"); continue
    m = re.search(r"<svg[^>]*\sid=\"[^\"]*\"[\s\S]*?</svg>", dom)
    if not m or "syntax error" in dom.lower():
        print(f"[render_diagrams] {mmd.name}: no SVG produced (Mermaid syntax error?)"); continue
    svg = m.group(0)
    svg = re.sub(r'\s(width|height)="[^"]*"', "", svg, count=2)           # keep viewBox, drop fixed size
    svg = re.sub(r'\sstyle="[^"]*"', "", svg, count=1)
    svg = svg.replace("<svg", '<svg style="max-width:100%;max-height:44vh;height:auto;display:block;margin:0 auto" role="img"', 1)
    (OUT / f"{mmd.stem}.svg").write_text(svg); page.unlink(); ok += 1
print(f"[render_diagrams] {ok} SVG(s) written to {OUT}")
