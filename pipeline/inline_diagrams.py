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

def sub(m):
    name = m.group(1).strip()
    f = pathlib.Path("diagrams") / f"{name}.mmd"
    if not f.exists():
        missing.append(name)
        return f"> diagram `{name}` missing"
    return '<pre class="mermaid">\n' + f.read_text().strip() + "\n</pre>"

text = re.sub(r"\{\{diagram:([\w-]+)\}\}", sub, text)
loader = """
<script type="module">
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
mermaid.initialize({ startOnLoad: true, theme: 'neutral', securityLevel: 'loose', flowchart: { nodeSpacing: 30, rankSpacing: 45, padding: 8 }, themeVariables: { fontSize: '22px' } });
</script>
<style>pre.mermaid{background:none;border:none;text-align:center;margin:0.2em 0} pre.mermaid svg{max-height:44vh;max-width:100%;height:auto}</style>
"""
dst.write_text(text.rstrip() + "\n\n" + loader)
print(f"wrote {dst}" + (f"; MISSING diagrams: {', '.join(missing)}" if missing else ""))
sys.exit(1 if missing else 0)
