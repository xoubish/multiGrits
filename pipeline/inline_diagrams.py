#!/usr/bin/env python3
"""Inline diagrams/*.mmd into the deck at {{diagram:name}} tokens and append the Mermaid loader.

Writes slides/build/deck.md. Run by pipeline/render.sh. Keeping diagrams as separate files is what
lets the diagrammer and slide-writer work in parallel without touching the same file.
"""
import re, pathlib, sys

src = pathlib.Path("slides/deck.md")
dst = pathlib.Path("slides/build/deck.md")
dst.parent.mkdir(parents=True, exist_ok=True)
text = src.read_text()
missing = []

live_used = False

def sub(m):
    global live_used
    name = m.group(1).strip()
    svg = pathlib.Path("diagrams/build") / f"{name}.svg"
    if svg.exists():  # pre-rendered by render_diagrams.py: static, offline, Safari-safe
        return '<div class="diagram">\n' + svg.read_text().strip() + "\n</div>"
    f = pathlib.Path("diagrams") / f"{name}.mmd"
    if not f.exists():
        missing.append(name)
        return f"> diagram `{name}` missing"
    live_used = True
    return '<pre class="mermaid">\n' + f.read_text().strip() + "\n</pre>"

text = re.sub(r"\{\{diagram:([\w-]+)\}\}", sub, text)
text = text.replace("](shots/", "](../shots/")  # screenshots: slides/shots/ seen from slides/build/deck.md
text = text.replace("](illustrations/", "](../illustrations/")  # SVGs from the illustrator, same layout
loader = """
<style>.diagram{text-align:center;margin:0.2em 0} .diagram svg{max-height:44vh;max-width:100%;height:auto}</style>
""" + ("" if not live_used else """
<script type="module">
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
mermaid.initialize({ startOnLoad: true, theme: 'neutral', securityLevel: 'loose', flowchart: { nodeSpacing: 30, rankSpacing: 45, padding: 8 }, themeVariables: { fontSize: '22px' } });
</script>
<style>pre.mermaid{background:none;border:none;text-align:center;margin:0.2em 0} pre.mermaid svg{max-height:44vh;max-width:100%;height:auto}</style>
""")
dst.write_text(text.rstrip() + "\n\n" + loader)
print(f"wrote {dst}" + ("; live Mermaid loader needed (no pre-rendered SVG for some diagrams)" if live_used else "; all diagrams pre-rendered, no network needed") + (f"; MISSING diagrams: {', '.join(missing)}" if missing else ""))
sys.exit(1 if missing else 0)
