# Evidence — one source per claim in `slides/outline.md`

Method: `research/briefs/*.md` (run 001) and `runs/009-factcheck/factcheck.md` first; web search and the
primary source only when nothing there fit. Section C (the meta-example) has no `research/build-log.md` yet
(the `chronicle` stage runs after this one), so those claims are checked against the actual run directories
and agent files they describe — that is the primary source the chronicler will summarize.

---

### "One agent's window fills and its quality degrades before it hits the token limit (lost-in-the-middle, RULER)"
Slide: 5
Say: "accuracy drops more than 20 points when the answer sits in the middle of the context, and claimed context windows are often only half as good as advertised"
Exact: GPT-3.5-Turbo 20-document QA falls from ~75.8% (answer at start) to ~53.8% (answer mid-context), below its 56.1% closed-book score (Liu et al. 2023); GPT-4 claims 128K tokens, effective ~64K on RULER's threshold (Hsieh et al. 2024).
Source: Liu et al. 2023, "Lost in the Middle," https://arxiv.org/abs/2307.03172; Hsieh et al. 2024, "RULER," https://arxiv.org/abs/2404.06654. Confirmed in `runs/009-factcheck/factcheck.md` (slide 3 rows).
Caveat: two papers, two different models/tests; cite both, don't merge the numbers.

### "Anthropic's 'Building effective agents' separates workflows... and lists five workflow patterns: prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer"
Slide: 6
Say: "Anthropic's own taxonomy names five workflow patterns"
Exact: Prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer; "we recommend finding the simplest solution possible."
Source: Anthropic, Dec 2024, "Building effective agents," https://www.anthropic.com/research/building-effective-agents. Confirmed in `runs/009-factcheck/factcheck.md` (slide 7 row) and `research/briefs/A-literature.md` #16.
Caveat: this is Anthropic's taxonomy, named as such on the slide, not a field-wide consensus.

### "One is today's default (Claude Code, Codex, Cursor run one agent that spawns a subagent occasionally)"
Slide: 11
Say: "one agent is the default; Claude Code runs one main conversation and spawns subagents like Explore only when it decides to"
Exact: "Claude Code runs one main conversation agent by default... built-in subagents Claude automatically uses when appropriate," e.g. Explore for read-only codebase search.
Source: Anthropic, 2026, "Subagents," https://code.claude.com/docs/en/sub-agents.
Caveat: framework-doc claim for Claude Code only; Codex/Cursor behavior is asserted by analogy in the outline, not independently sourced here — flag if kept for all three tools.

### "Working systems use one orchestrator and two to five workers (Anthropic's research system, MetaGPT's five roles, ChatDev's seven)"
Slide: 11
Say: "an orchestrator with two to five workers: Anthropic's own research system, MetaGPT's five roles, ChatDev's seven"
Exact: MetaGPT assigns five fixed roles (Product Manager, Architect, Project Manager, Engineer, QA Engineer); ChatDev assigns seven roles (CEO, CPO, CTO, Programmer, Reviewer, Designer, Tester); Anthropic's research system is one Opus 4 lead plus Sonnet 4 subagents.
Source: Hong et al. 2024 (MetaGPT), https://arxiv.org/abs/2308.00352; Qian et al. 2024 (ChatDev), https://arxiv.org/abs/2307.07924; Anthropic, Jun 2025, https://www.anthropic.com/engineering/multi-agent-research-system. First two confirmed in `research/briefs/A-literature.md` #1–2; ChatDev's seven named roles confirmed by web search of the paper text (not in the brief, which only gives its accuracy numbers).
Caveat: each number is its own paper/system — this is three separate scale points, not a survey of practitioners.

### "Past a thousand exists in research (MacNet, Project Sid) and nobody uses it for work"
Slide: 11
Say: "over a thousand agents has been done in research"
Exact: MacNet "effectively supports collaboration among over a thousand agents." Project Sid ran simulations from "10 to 1000+" AI agents.
Source: Qian et al. 2024, "Scaling Large Language Model-based Multi-Agent Collaboration" (MacNet), https://arxiv.org/abs/2406.07155; Altera.AL, 2024, "Project Sid," https://arxiv.org/abs/2411.00114.
Caveat: not in the existing briefs — found via web search, arXiv abstracts opened directly. "Nobody uses it for work" is the speaker's own assessment, not sourced (correctly left as opinion).

### "There is no published histogram of practitioner usage, say so"
Slide: 11
Say: (a caveat, not a number)
Exact: no source claims otherwise.
Source: n/a — this is the correct move per the agent instructions; do not manufacture one.
Caveat: none.

### "Kim et al. 2026... centralized multi-agent improved a decomposable task by about 80% and every multi-agent variant made a sequential planning task 39 to 70% worse, in the same experiment"
Slide: 21
Say: "about 80 percent better on a decomposable task, and 39 to 70 percent worse on a sequential one"
Exact: +80.8% on decomposable financial reasoning (centralized); every multi-agent variant degraded sequential planning by 39–70% (Hybrid −39.0%, Decentralized −41.4%, Centralized −50.4%, Independent −70.0%), across 260 configurations, 6 benchmarks, 3 model families.
Source: Kim et al. 2025/2026, "Towards a Science of Scaling Agent Systems," https://arxiv.org/abs/2512.08296. Confirmed in `runs/009-factcheck/factcheck.md` (slides 7, 10, 18) and `research/briefs/A-literature.md`/`C-context-cost.md`.
Caveat: none.

### "Anthropic's research system, lead plus subagents, about 90% better than a single agent on breadth research, at about 15 times the tokens"
Slide: 22
Say: "about 90 percent better, at about 15 times the tokens"
Exact: "outperformed single-agent Claude Opus 4 by 90.2%"; "multi-agent systems use about 15× more tokens than chats" (agents alone ~4x).
Source: Anthropic, Jun 2025, "How we built our multi-agent research system," https://www.anthropic.com/engineering/multi-agent-research-system. Confirmed in `runs/009-factcheck/factcheck.md` (slides 6, 17) and both `research/briefs/A-literature.md` #8 and `C-context-cost.md` #9–10.
Caveat: vendor claim, internal eval (BrowseComp-style breadth research), not independently replicated; token count alone explained 80% of the variance per the same post.

### "Tran & Kiela 2026, at an equal thinking budget a single agent matched or beat five multi-agent designs"
Slide: 22
Say: "at the same thinking budget, one agent matched or beat five different multi-agent designs"
Exact: at a 5,000-token budget, single-agent 0.427 vs sequential multi-agent 0.386 (aggregate, 3 model families); multi-agent won only when up to 70% of context was masked/corrupted.
Source: Dat Tran and Douwe Kiela (April 2026), "Single-Agent LLMs Outperform Multi-Agent Systems on Multi-Hop Reasoning Under Equal Thinking Token Budgets", arXiv 2604.02460, https://arxiv.org/abs/2604.02460 (title fetched from the arXiv abstract page 2026-09-17 by the orchestrator, after the reviewer in run 019 flagged it missing). Confirmed in `runs/009-factcheck/factcheck.md` (slide 4) and `research/briefs/A-literature.md` #11.
Caveat: none.

### "Kapoor et al. 2024, one agent framework cost over 50 times a simple baseline at similar accuracy"
Slide: 22
Say: "one agent framework cost over 50 times as much as a simple baseline for about the same accuracy"
Exact: LATS cost "over 50 times more" than the paper's "Warming" baseline on HumanEval; Warming's accuracy (93.2%) was actually higher than LATS's (88.0%).
Source: Kapoor et al. 2024, "AI Agents That Matter," https://arxiv.org/abs/2407.01502.
Caveat: `runs/009-factcheck/factcheck.md` scored this PARTIAL: the cheap baseline is named "Warming," not "retry," and it beat the complex agent's accuracy rather than merely matching it — say "matched or beat," not "similar," if precision matters.

### "MAST (Cemri et al. 2025): 1,600 traces, 14 failure modes; most are specification and coordination, not model errors"
Slide: 23
Say: "sixteen hundred traces, fourteen failure modes, most of them specification and coordination problems, not model errors"
Exact: 1,600+ traces, 7 frameworks, 14 failure modes in 3 categories: system design 44.2%, inter-agent misalignment 32.3%, task verification 23.5% (κ=0.88).
Source: Cemri et al. 2025, "Why Do Multi-Agent LLM Systems Fail?" (MAST), https://arxiv.org/abs/2503.13657. Confirmed in `runs/009-factcheck/factcheck.md` (slide 8, 20) and `research/briefs/A-literature.md` #14.
Caveat: none.

### "Multi-agent runs 3 to 15 times a single chat's tokens (Anthropic's own figures)"
Slide: 26
Say: "three to fifteen times the tokens of a single chat"
Exact: "multi-agent systems use about 15× more tokens than chats" (Jun 2025 post); "multi-agent implementations typically use 3-10x more tokens" (Jan 2026 post).
Source: Anthropic, Jun 2025, https://www.anthropic.com/engineering/multi-agent-research-system; Anthropic (Phillips et al.), Jan 2026, https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them. Both confirmed in `runs/009-factcheck/factcheck.md` (slide 17) and `research/briefs/C-context-cost.md` #10–11.
Caveat: vendor figures, two different posts giving two different ranges (15x vs 3-10x) — cite both, the "3 to 15" on the slide spans them honestly.

### "Cheap or local models on subagents, frontier model on the orchestrator" is documented tool behavior
Slide: 6 (recurring point), 26
Say: "Claude Code lets you put a cheaper model on a subagent and the frontier model on the orchestrator"
Exact: Claude Code subagent frontmatter takes a `model` field (`haiku`, `sonnet`, `opus`, `inherit`); docs say "Control costs by routing tasks to faster, cheaper models like Haiku"; the built-in Explore agent runs on Haiku.
Source: Anthropic, 2026, "Create custom subagents," https://code.claude.com/docs/en/sub-agents. Confirmed in `runs/009-factcheck/factcheck.md` (slide 17) and `research/briefs/B-tools.md` #1, `C-context-cost.md` #16.
Caveat: none.

### "Two agents editing one file is the classic failure. Isolation via worktrees fixes it" / Pattern 4 mechanics
Slide: 10
Say: "isolation via git worktrees is how you stop two agents from clobbering the same file"
Exact: `isolation: worktree` runs a subagent in a temporary git worktree; Claude Code "blocks an Edit, Write... that targets a path in the main checkout."
Source: Anthropic, 2026, "Run parallel sessions with worktrees," https://code.claude.com/docs/en/worktrees. Confirmed in `runs/009-factcheck/factcheck.md` (slide 9) and `research/briefs/B-tools.md` #4.
Caveat: tool-behavior claim, framework docs, not independently tested outside Claude Code.

### "Attempt one, from scratch. Eleven agents..." and the three failures (spec contradiction, merge conflict, budget cap)
Slide: 14
Say: "eleven agent roles; a spec contradiction the outliner caught, a merge conflict on a shared cost log, and a revision that hit its budget cap"
Exact: 11 distinct agent files used in the first pipeline: researcher (x4 parallel spawns, 1 file), outliner, slide-writer, diagrammer, three critics (content/design/teaching), fact-checker, notes-writer, qa-skeptic, demo-editor. Spec contradiction: the outliner's segment-time math didn't match `talk-context.md` prose (run 002). Merge conflict: `runs/cost.tsv` was appended to by both worktrees in the same commit and conflicted (run 004). Budget cap: run 006-revise hit `terminal_reason: budget_exhausted` at the $3 default (`result.json`).
Source: `runs/002-outline/README.md`; `runs/004-write/README.md`; `runs/004-write/README.md` ("Related: run 006 hit the budget cap"). Repo files, read directly, since `research/build-log.md` does not exist yet (the `chronicle` stage runs after this one).
Caveat: this is a project record, not a literature claim — sourced to the actual run directories, which is what the chronicler will later summarize into `research/build-log.md`.

### "Every constraint was met: citations, word counts, timing to the second. It was a wall of cited percentages"
Slide: 15
Say: "every measurable constraint passed, and the deck still wasn't presentable"
Exact: `runs/009-factcheck/factcheck.md` tallies 44 CONFIRMED, 2 PARTIAL, 0 NOT FOUND — the old deck's citations checked out; `.claude/agents/reviewer.md` (the retired critics' replacement) states the three old critics scored "citations, words per second, and seconds per slide" and "the deck they passed was unpresentable."
Source: `runs/009-factcheck/factcheck.md` tally line; `.claude/agents/reviewer.md`.
Caveat: "unpresentable" is the speaker's judgment, correctly not something to source further.

### "`.claude/agents/reviewer.md` verbatim... frontmatter with name, description, tools, model"
Slide: 17
Say: (a verbatim file excerpt, not a claim needing a citation beyond the file itself)
Exact: frontmatter keys present: `name`, `description`, `tools`, `model`.
Source: `.claude/agents/reviewer.md`, this repo.
Caveat: none — primary source is the file itself, copied exactly per style rules.

### "The `claude -p` line from `pipeline/run.sh` verbatim, then the stage order"
Slide: 18
Say: (a verbatim command and stage list)
Exact: `env -u CLAUDECODE claude -p --agent "$agent" --output-format json --permission-mode acceptEdits --allowedTools "$tools" --max-budget-usd "$BUDGET" --no-session-persistence "$(cat "$run_dir/prompt.md")"`; stage order: evidence, example, chronicle, write (worktrees), review loop, chronicle, factcheck, notes & qa in parallel, cost.
Source: `pipeline/run.sh`, this repo (lines ~71–77 for the command, ~176–200 for stage order).
Caveat: none — primary source is the script itself.

### "One read-only subagent... returns a table under 2,000 tokens" / cost and behavior of the Monday example
Slide: 24
Say: (depends on `examples/*/RESULT.md`, not yet built at this stage)
Exact: not yet available.
Source: pending — the `example` pipeline stage runs after this one and will write `examples/*/RESULT.md`.
Caveat: put under Unsupported below until that stage runs; do not invent a number now.

---

## Unsupported

- **Codex and Cursor also default to one agent that occasionally spawns a subagent (slide 11).** Confirmed for Claude Code (`https://code.claude.com/docs/en/sub-agents`); `research/briefs/B-tools.md` documents Codex CLI and OpenCode subagent mechanics but does not state their *default* behavior is "one agent, occasional spawn." Tried: re-read brief B's findings 9–10 (describes how to configure subagents, not default usage rate); did not find a Cursor-specific doc in the briefs. If the slide names all three tools, either narrow the citation to Claude Code or add per-tool sourcing.
- **"One is today's default" as a claim about practitioner usage in general.** The outline itself flags this correctly at slide 11 ("no published histogram of practitioner usage, say so") — noting here so it isn't accidentally hardened into a stat in the slide draft.
- **Slide 24, the Monday example's actual token count, cost, and runtime.** These come from `examples/*/RESULT.md`, produced by the `example` pipeline stage, which has not run as of this evidence pass. Tried: `Glob examples/**/RESULT.md` — no files exist yet. Do not fill in a plausible number; wait for that stage.
- **Slides 13–20 numbers not yet cross-checked against `research/build-log.md`** (entries 19–20, "each run from 015 onward," "both attempts in dollars"): that file does not exist yet (chronicler runs after this stage). This evidence file sourced what it could directly from `runs/*/README.md`, `result.json`, and `runs/cost-report.md`; the chronicler should reconcile against these same primary files, not re-derive numbers from memory.


## Added by the orchestrator, 2026-09-18, for entry 5 (verified by fetching each abstract or page)

### "Windows grew from about 2,000 tokens to one million in six years"
Exact: GPT-3 context 2,048 tokens (Brown et al. 2020, https://arxiv.org/abs/2005.14165). Gemini 1.5 abstract: "near-perfect retrieval (>99%) up to at least 10M tokens, a generational leap over existing models such as Claude 3.0 (200k) and GPT-4 Turbo (128k)" (https://arxiv.org/abs/2403.05530). Anthropic models overview, fetched 2026-09-18: Fable 5.1, Opus 5, Sonnet 5 context window 1M tokens, Haiku 4.5 200K, max output 128K (https://platform.claude.com/docs/en/about-claude/models).

### "Models use only 10 to 20 percent of their context"
Exact: "popular LLMs effectively utilize only 10-20% of the context and their performance declines sharply with increased reasoning complexity" (Kuratov et al. 2024, BABILong, https://arxiv.org/abs/2406.10149).

### "11 of 13 long-context models fall below half their short-context accuracy by 32K"
Exact: "at 32K tokens, 11 models drop below 50% of their strong short-length baselines"; GPT-4o "from an almost-perfect baseline of 99.3% to 69.7%"; 13 models evaluated, all claiming at least 128K (Modarressi et al. 2025, NoLiMa, ICML 2025, https://arxiv.org/abs/2502.05167).

### "Given enough budget, a single long-context model beats retrieval"
Exact: "when resourced sufficiently, LC consistently outperforms RAG in terms of average performance," while RAG costs significantly less; Self-Route hybrid proposed (Li et al. 2024, EMNLP 2024 industry track, https://arxiv.org/abs/2407.16833).

### "A token is about 0.55 to 0.75 of a word"
Exact: Anthropic models overview, fetched 2026-09-18: "1M tokens is roughly 555k words or 2.5M Unicode characters on the current tokenizer (introduced with Claude Opus 4.7); models before it fit about 750k words in 1M tokens. 200k tokens is roughly 150k words." (https://platform.claude.com/docs/en/about-claude/models)

### "Human memory shows the same position curve, but the similarity is shallow"
Human side: listeners stopped mid-passage repeat the current clause nearly verbatim and earlier material only as paraphrase (Jarvella 1971, J. Verbal Learning and Verbal Behavior 10:409-416); after about 80 syllables of further speech, wording changes go undetected while meaning changes are still noticed (Sachs 1967, Perception & Psychophysics 2:437-442). LLM side: primacy and recency effects across models and tasks, the same U-shaped curve as human list recall (Guo and Vosoughi 2025, Findings of ACL, https://arxiv.org/abs/2406.15981). Caution: n-back studies find apparent LLM "capacity limits" partly reflect losing the task rule (https://arxiv.org/abs/2412.18120). Orchestrator read abstracts only, 2026-09-18; fact-checker to verify.

### "The literature uses related terms; the three-way split is this talk's own"
Tran et al. 2025, Multi-Agent Collaboration Mechanisms: A Survey of LLMs (https://arxiv.org/abs/2501.06322) organizes systems by actors, types, structures (peer-to-peer, centralized, distributed), strategies, and coordination protocols; Kim et al. 2026 (https://arxiv.org/abs/2512.08296) compares independent, centralized, decentralized, and hybrid coordination architectures; Anthropic 2024 "Building effective agents" names orchestrator-workers; Claude Code docs use `isolation: worktree` and describe fresh subagent context (https://code.claude.com/docs/en/sub-agents). Orchestrator read the survey abstract and the research brief A summary only, 2026-09-18.

### "How many agents" landscape (slide, 2026-09-19)
1: Claude Code runs one main conversation and spawns built-in subagents such as Explore when appropriate (https://code.claude.com/docs/en/sub-agents). 2-7: Anthropic research system, one Opus 4 lead plus Sonnet 4 subagents (https://www.anthropic.com/engineering/multi-agent-research-system); MetaGPT five roles (https://arxiv.org/abs/2308.00352); ChatDev seven roles (https://arxiv.org/abs/2307.07924); agent-teams docs recommend 3-5 teammates (https://code.claude.com/docs/en/agent-teams, per research/briefs/B-tools.md). Tens: sampling-and-voting, Llama2-13B x15 matches Llama2-70B, GPT-3.5 x40 (0.85) still below one GPT-4 call (0.88), gains shrink with difficulty (Li et al. 2024, TMLR, https://arxiv.org/abs/2402.05120, per briefs/A-literature.md); diminishing returns once the single agent is strong (Kim et al. 2026). 1,000+: MacNet supports collaboration among over a thousand agents (https://arxiv.org/abs/2406.07155); Project Sid 10 to 1000+ agents (https://arxiv.org/abs/2411.00114). "Nobody uses this for work" is the speaker's assessment; no published survey found.
