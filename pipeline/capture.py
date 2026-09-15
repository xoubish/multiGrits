#!/usr/bin/env python3
"""Capture terminal-style screenshots of read-only commands for the recorded demo. Deterministic; no LLM.

Reads pipeline/captures.json (name, title, command, max_lines), runs each command from the repo root, renders
stdout+stderr in a terminal-styled HTML window, and screenshots it with the installed Chrome into
slides/shots/<name>.png at 2x resolution. Writes slides/shots/manifest.json for the demo-editor agent.
Commands should be read-only (ls, cat, sed, git log). Non-zero exit codes are fine; output is still captured.
"""
import html, json, pathlib, re, shutil, subprocess, sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
OUT = ROOT / "slides" / "shots"; OUT.mkdir(parents=True, exist_ok=True)
CHROME = next((c for c in [
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    "/Applications/Chromium.app/Contents/MacOS/Chromium",
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
    shutil.which("google-chrome"), shutil.which("chromium"), shutil.which("chromium-browser"),
] if c and pathlib.Path(c).exists()), None)
if not CHROME:
    print("[capture] no Chrome/Chromium found; cannot render screenshots"); sys.exit(1)
ANSI = re.compile(r"\x1b\[[0-9;]*[A-Za-z]")
PAGE = """<!doctype html><html><head><meta charset="utf-8"><style>
html,body{{margin:0;background:#1e1e1e}}
.bar{{height:44px;background:#2d2d2d;display:flex;align-items:center;padding:0 14px;gap:8px;
  font:13px -apple-system,Helvetica,Arial,sans-serif;color:#9a9a9a}}
.dot{{width:12px;height:12px;border-radius:50%}} .t{{margin-left:10px}}
.body{{padding:14px 20px 18px;font:16px/24px "SF Mono",Menlo,Consolas,monospace;color:#d4d4d4;
  white-space:pre-wrap;word-break:break-all}}
.p{{color:#7ee787}} .c{{color:#f0f6fc;font-weight:600}}
</style></head><body>
<div class="bar"><span class="dot" style="background:#ff5f57"></span><span class="dot" style="background:#febc2e"></span>
<span class="dot" style="background:#28c840"></span><span class="t">{title}</span></div>
<div class="body"><span class="p">shooby@ipac multiGrits %</span> <span class="c">{command}</span>
{output}</div></body></html>"""

shots = json.loads((ROOT / "pipeline" / "captures.json").read_text())
manifest = []
for s in shots:
    r = subprocess.run(s["command"], shell=True, cwd=ROOT, capture_output=True, text=True, timeout=120)
    text = r.stdout + (("\n" + r.stderr) if r.stderr.strip() else "")
    lines = ANSI.sub("", text).rstrip("\n").splitlines()
    max_lines = s.get("max_lines", 34)
    if len(lines) > max_lines:
        lines = lines[:max_lines] + [f"… ({len(lines) - max_lines} more lines)"]
    page = OUT / f"{s['name']}.html"
    page.write_text(PAGE.format(title=html.escape(s.get("title", "Terminal")),
                                command=html.escape(s["command"]), output=html.escape("\n".join(lines))))
    cols = 118  # characters per line at 16 px monospace in a 1200 px window with 20 px padding
    wrapped = sum(max(1, -(-len(l) // cols)) for l in lines) + max(1, -(-(len(s["command"]) + 30) // cols))
    height = min(1350, 44 + 32 + 24 * wrapped + 18)
    png = OUT / f"{s['name']}.png"
    subprocess.run([CHROME, "--headless=new", "--disable-gpu", "--no-sandbox", "--hide-scrollbars",
                    f"--window-size=1200,{height}", "--force-device-scale-factor=2",
                    f"--screenshot={png}", page.resolve().as_uri()], capture_output=True, timeout=60)
    page.unlink()
    ok = png.exists() and png.stat().st_size > 0
    manifest.append({"name": s["name"], "title": s.get("title", ""), "command": s["command"],
                     "png": f"slides/shots/{png.name}", "lines": len(lines), "height_px": height, "ok": ok,
                     "markdown": f"![h:470]({'shots/' + png.name})"})
    print(f"[capture] {'ok ' if ok else 'FAIL'} {png.name:28s} {len(lines):3d} lines  {s['command'][:70]}")
(OUT / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
print(f"[capture] {sum(m['ok'] for m in manifest)}/{len(manifest)} screenshots in {OUT.relative_to(ROOT)}; manifest.json written")
