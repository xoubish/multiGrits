# Reading notes: two surveys added 2026-09-19

Read by the orchestrator on the speaker's instruction. Sections read in full are listed; the rest of each paper was
skimmed from its table of contents. Quotes are verbatim from the PDF text; page numbers are PDF pages.

## Hu et al. (2026), Memory in the Age of AI Agents: A Survey. arXiv 2512.13564v2, 107 pp.
Read: §2.1-2.3 (formalization, memory vs LLM memory / RAG / context engineering, pp.6-12), §3.1 (token-level memory,
pp.13-21), §4.3 (working memory, pp.42-46), §5.1.1 (semantic summarization, pp.48-50), §5.2.3 (forgetting, pp.58-59),
§6.2 (frameworks, p.68), §7.1, §7.5 (shared memory in multi-agent systems, p.73), §7.8 (human-cognitive connections,
p.76), §8 (conclusion).

Quotable, with slide it bears on:
- Slide 6 (window as passive buffer): "the standard context window functions primarily as a passive, read-only buffer.
  Although the model can consume the window's contents during inference, it lacks explicit mechanisms to select,
  sustain, or transform the current workspace dynamically. Recent behavioral evidence suggests that current models do
  not exhibit human-like working memory characteristics (Huang et al., 2025a)." (p.42)
- Slide 6/7 (bigger windows do not fix it): "Even with extended context windows, the accumulation of history inevitably
  saturates attention budgets, increases latency, and induces goal drift (Lu et al., 2025b)." (p.45) "the primary
  bottleneck shifts from instantaneous context capacity to the continuous maintenance of task state" (p.45).
- Slide 6 (compaction is lossy summarization): semantic summarization "operates as a lossy compression mechanism...
  it prioritizes global semantic coherence over local factual precision... the trade-off is resolution loss: specific
  details or subtle cues may be smoothed out, limiting their utility in evidence-critical tasks." (p.50) Incremental
  merging of new chunks into an existing summary (MemGPT, Mem0 style) "was constrained by the model's limited capacity,
  often resulting in inconsistency or semantic drift." (p.50)
- Slide 6 (published name for subagent-with-summary): "Hierarchical folding decomposes the task trajectory based on
  subgoals, maintaining fine-grained traces only while a subtask is active, and folding the completed sub-trajectory
  into a concise summary upon completion." (HiAgent, Context-Folding, AgentFold; p.45) "Cognitive planning": an
  externalized plan as the core of working memory (p.45), i.e. the plan-file hand-off.
- Slide 7 (human analogy, 2026 source): agent memory design "mirrors the Atkinson-Shiffrin multi-store model... a
  fundamental divergence remains in the dynamics of retrieval and maintenance. Human memory operates as a constructive
  process, where the brain actively reconstructs past events... rather than replaying exact recordings (Schacter and
  Addis, 2007). In contrast, the majority of existing agent memory systems rely on verbatim retrieval... treating memory
  as a repository of immutable tokens" (p.76).
- Slide 9 (isolation formalized): each agent observes o_t^i = O_i(s_t, h_t^i, Q) "where h_t^i denotes the portion of
  the interaction history visible to agent i. This history may include previous messages, intermediate tool outputs,
  partial reasoning traces, shared workspace states, or other agents' contributions, depending on the system design."
  (p.6)
- Slide 11 (isolation trade-off, and a name for the run-004 failure): early multi-agent systems "relied on isolated local
  memories coupled with explicit message passing... While this design avoided direct interference between agents, it
  often suffered from redundancy, fragmented context, and high communication overhead"; later "centralized shared memory
  structures, such as global vector stores, blackboard systems, or shared documents (Hong et al., 2024)... naive global
  sharing also exposed new challenges, including memory clutter, write contention, and the lack of role- or
  permission-aware access control." (p.73) Hybrid: "sub-agents maintain their own role-specific private memories while
  collaboratively reading and writing to a shared memory" (Intrinsic Memory Agents, p.20).
- Slide 6 aside: the survey distinguishes context engineering ("treats the context window as a constrained computational
  resource", p.11) from agent memory; "the rolling summary technique serves as a shared foundational primitive" (p.12).

## Gao et al. (2026), A Survey of Self-Evolving Agents. arXiv 2507.21046v4, TMLR 01/2026, 77 pp.
Read: §1-2 (definitions, pp.1-9), §3.4 (architecture: single- and multi-agent system optimization, pp.14-16), §5.3.2
(multi-agent evolution, pp.26-27), §6 evaluation (pp.41-42), Table 11 (p.47), §8.3-8.4 and §9 (safety guardrails,
multi-agent ecosystems, conclusion, pp.51-53).

Quotable, with slide it bears on:
- Slide 9 (the axes have a published counterpart): an agent system is Π = (Γ, {ψ_i}, {C_i}, {W_i}): "The architecture Γ
  determines the control flow of the agent system or collaborative structures between multiple agents. It is typically
  represented as a sequence of nodes... organized by graph or code structures. Each node N_i consists of... ψ_i: the
  underlying LLM... C_i: the context information, e.g., prompt P_i and memory M_i... W_i: the set of available
  tools/APIs." (p.6) Topology is the paper's own word: "How agents are organized and communicate within a system (its
  topology) fundamentally determines its capacity for solving complex problems." (p.15)
- Slide 10 (who orchestrates, the research frontier): workflow design "as a search and optimization problem" (ADAS;
  AFlow with MCTS over reusable operators), "proving that automatically discovered workflows could outperform
  human-designed ones" (p.15); query-specific workflow generation (MaAS, ScoreFlow, FlowReasoner); "Puppeteer... a
  centralized orchestrator that evolves its decision policy through reinforcement learning, dynamically selecting which
  agents to activate at each step while balancing task performance with computational cost" (p.27). Caveat: "A key
  challenge for all search and learning methods is the computational cost of evaluating each potential workflow" (p.16).
- Slide 4 (heterogeneous models add expertise): EvoFlow "construct[s] heterogeneous workflows by selecting the most
  suitable LLM for each task from a diverse pool" (p.15).
- Slide 13 (more agents, a documented cost): "agents often risk becoming overly reliant on group consensus, thereby
  diminishing their independent reasoning capabilities" (Chen et al., 2025d; Sun et al., 2025a; p.52-53). Also:
  "existing benchmarks for multi-agent evaluation are predominantly static... and therefore fail to capture the long-term
  adaptability" (p.53); Table 11: "Latency, cost, and safety metrics are not consistently reported, limiting full
  apples-to-apples comparisons" (p.47).
- Close / receipts / hand-off to sandboxing: compliance checklist (Table 12, p.52): "Strict Sandboxing: All tools and
  agent-generated code execute in an isolated environment with no default access to host files, network, or sensitive
  processes"; "Immutable Audit Trail: All self-modifications... are logged with details on the trigger, changes made,
  and outcome"; "Version Control for Safe States"; "Human-in-the-Loop for Critical Actions... gated by a mandatory human
  approval step." Also "population-based and self-play evolution... typically incur higher computational cost and lower
  interpretability compared with single-agent paradigms" (p.27).

## Not relevant to this talk (read and set aside)
Self-modification of model weights, parametric and latent memory, RL-trained memory policies, memory for world models,
multimodal memory, benchmark catalogues. The talk is about orchestrating fixed agents, not agents that learn.
