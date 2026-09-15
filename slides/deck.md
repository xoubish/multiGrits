---
marp: true
theme: default
paginate: true
style: |
  section { font-size: 28px; }
  h1 { font-size: 44px; }
  footer { font-size: 16px; color: #888; }
footer: "Multi-agent workflows · GRITS AI workshop · IPAC"
---

# Multi-agent workflows

**Shooby Hemmati · IPAC**
GRITS AI workshop, Day 2

<!-- SKELETON. The slide-writer agent replaces this file in pipeline stage 3. -->

---

# This deck was built by the pipeline you are about to see

{{diagram:meta-pipeline}}

<!-- Framing slide: four researchers, an outliner, a writer and a diagrammer in parallel worktrees, a critic loop, a fact-checker. The logs are in the repo. -->

---

# Why go multi-agent? Context, not intelligence.

- One agent's window fills up. Quality degrades.
- Delegate to keep the main thread clean.
- Parallelism and specialization come second.
- Most tasks do not need this.

<!-- Placeholder. Evidence and citations arrive from research/brief.md. -->

---

# Pattern 1 · Fan-out and merge

{{diagram:fan-out}}

---

# Pattern 2 · Pipeline

{{diagram:pipeline}}

---

# Pattern 3 · Writer and critic

{{diagram:writer-critic}}

---

# Pattern 4 · Parallel isolated workers

{{diagram:parallel-workers}}

---

# Sources

- Placeholder. Full URLs are added by the slide-writer and verified by the fact-checker.
