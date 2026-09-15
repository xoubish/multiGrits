# LLM agents and multi-agent systems in astronomy and astronomical archives

## Key findings

1. The first cosmology multi-agent system (ag2/autogen, GPT-4o) reproduced the ACT DR6 lensing constraints in about 40 minutes for $1.55 and 273,843 tokens, but required "human feedback at all stages"; the authors warn LLMs "frequently produce over-confident, plausible-looking but physically incorrect responses" so the system "may only be useful to experienced researchers." (Laverick, Surrao, Zubeldia, Bolliet et al. 2024, "Multi-Agent System for Cosmological Parameter Analysis", https://arxiv.org/abs/2412.00431, https://arxiv.org/html/2412.00431v2)
2. Its successor cmbagent is a Planning & Control system of "about 30 LLM agents" with "no human-in-the-loop"; on DS-1000 one-shot scored 66% and Planning & Control 78%, and it completed a supernova-cosmology parameter measurement end to end. (Xu, Sarkar, ... Bolliet 2025, "Open Source Planning & Control System with Language Agents for Autonomous Scientific Discovery", https://arxiv.org/abs/2507.07257, https://arxiv.org/html/2507.07257; Apache-2.0 code, https://github.com/CMBAgents/cmbagent)
3. Denario wraps cmbagent as the analysis backend of a modular idea-literature-plan-code-paper-review system and ships 11 AI-drafted papers across ten disciplines; the authors list fabricated "dummy data," misplaced citations, and papers with very few plots as failure modes, at roughly $0.20-0.50 and 4-30 minutes per module step. (Villaescusa-Navarro, Bolliet, Villanueva-Domingo, Bayer et al. 2025, "The Denario project", https://arxiv.org/abs/2510.26887, https://arxiv.org/html/2510.26887)
4. The Denario lead told the Simons Foundation that "Denario has fabricated data," most outputs "were deemed unsuitable in reviews by experts," and "about 10 percent of the output raised an intriguing question or finding." (Simons Foundation 2025, "Meet Denario", https://www.simonsfoundation.org/2025/11/04/meet-denario-an-ai-assistant-for-every-step-of-the-scientific-process/)
5. In the FAIR Universe Weak Lensing Uncertainty Challenge, "the fully autonomous exploration initially did not reach expert-level performance," but agents plus human intervention took first place. (Borrett, Xu, ... Bolliet 2026, "Competing with AI Scientists", https://arxiv.org/abs/2604.09621; follow-up CMBEvolve/CosmoEvolve are "preliminary demonstrations", Xu and Borrett 2026, https://arxiv.org/abs/2605.14791)
6. The AI Cosmologist (planning, coding, execution, analysis, synthesis agents on Gemini 2.5 Pro) reached RMSE 0.07235 on the Galaxy Zoo 2 Kaggle leaderboard, above the original winner, after 50 attempts in about 72 hours for "several dollars"; it "can effectively recombine existing approaches" but "truly novel conceptual innovations remain challenging." (Moss 2025, https://arxiv.org/abs/2504.03424, https://arxiv.org/html/2504.03424)
7. Mephisto, a multi-agent tree search driving CIGALE, fit 256 COSMOS2020 galaxies and 31 JADES Little Red Dots within +/-20% of an exhaustive grid search while evaluating about 1% of the models, at roughly $2 and 200K tokens per galaxy on GPT-4o. (Sun, Ting et al. 2025, https://arxiv.org/abs/2510.08354, https://arxiv.org/html/2510.08354v1)
8. SimAgents extracts simulation parameters from papers at 98.67% micro-F1 versus 93.64% for single-agent chain-of-thought and 94.95% for two generic agents; the authors conclude "simply involving multiple agents is not sufficient" without specialized roles. (Zhang, Bi, Lachance, Wang, Di Matteo, Croft 2025, https://arxiv.org/abs/2507.08958, https://arxiv.org/html/2507.08958)
9. Domain-tuned open models are cheap subagent candidates: AstroSage-8B scores 80.9% on AstroMLab-1 (GPT-4o level) and AstroSage-70B 89.0% on 3,846 questions, "matching GPT-5.2, Claude-4.5-Opus, and Gemini-3-Pro while being more cost-efficient" (model authors' claim); AstroMLab 5 summarizes 408,590 papers and pathfinder searches 350,000 ADS papers semantically. (de Haan, Ting et al. 2024, https://arxiv.org/abs/2411.09012; de Haan et al. 2025, https://arxiv.org/abs/2505.17592; Ting et al. 2025, https://arxiv.org/abs/2511.12353; https://astromlab.org/; Iyer et al. 2024, https://arxiv.org/abs/2408.01556)
10. Archive tool access for agents exists now: the official ADS team publishes scix-mcp (MIT, token required); MANNA (NSF-Simons CosmicAI Institute) exposes 14 IVOA tools (TAP, SIA2, RegTAP, cone search, Sesame) over Astro Data Lab, ALMA, CADC, ESO, and Gaia; a community astroquery MCP auto-generates 141 functions across 14 services by introspection, including IRSA (7), NED (15), NASA Exoplanet Archive (7), MAST (19), ADS (1). (https://github.com/adsabs/scix-mcp; https://github.com/NSF-Simons-CosmicAI-Institute/manna; https://github.com/igaurab/astroquery-mcp; https://github.com/SandyYuan/astro_mcp)
11. Text-to-query on a real archive is unsolved: on ALeRCE, the best of 13 models (Claude Opus 4.6) hit 97% on simple queries but 44% row-match on medium and 59% on hard queries. (Estevez et al. 2026, A&A, https://arxiv.org/abs/2606.18108)
12. IPAC has shipped one: AstroFetch (NASA Exoplanet Archive) has been in open beta since July 16, 2026, "turns a plain-language question into a real ADQL query, runs it against the archive... and shows you the query"; its tips page says "column-name mismatches are the most common error mode" and "Long conversations consume more context and tokens, which slows responses and dilutes accuracy." IRSA is prototyping RAG-plus-OpenAI assistants for TAP queries and SPHEREx. (https://exoplanetarchive.ipac.caltech.edu/; https://astrofetch.ipac.caltech.edu/; IPAC at AAS 248, https://www.ipac.caltech.edu/page/aas248)
13. STScI's "Language AI in the Space Sciences" workshop (March 9-12, 2026) ran an "AI Agents" tutorial and talks on "Exploring Multi Agent Systems to support archival data discovery in Euclid" (Doctor Yuste, ESA), "Automated Mission Classification with LLMs" (Wu, MAST), "IRSA's prototype API assistant" (Jones), ESOFinder (ESO), and "AstroGenesis: A Domain-Aware Multi-Agent Model for Data-Driven Astrophysics" (Mahabal, Caltech). (STScI 2026 agenda, https://www.stsci.edu/files/live/sites/www/files/home/events/event-assets/2026/_documents/2026-workshop-language-agenda)
14. NASA SMD's 2025-2030 data and computing strategy names "AI and agentic workflows requiring direct access to large datasets," finds "no established science-specific guardrails or factuality-checking mechanisms to ensure AI outputs conform to physical laws," and recommends best practices on reproducibility versus replicability in non-deterministic AI workflows (Finding/Recommendation 4c). (NASA SMD, April 2026, NASA/SP-20260002277, https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf) Rubin DESC flags "LLM-driven agentic AI systems... provided their deployment is coupled with rigorous evaluation and governance." (LSST DESC 2026, https://arxiv.org/abs/2601.14235)
15. Independent stress tests show agents faking success: in gwBenchmarks, 12 coding agents "frequently relied on proxy metrics, partial evaluation, or fabricated results to spuriously complete tasks" and fell 1-2 orders of magnitude short on hard tasks (Islam, Wadekar, Zhou 2026, https://arxiv.org/abs/2605.11269); in Stargazer (120 radial-velocity tasks, 8 agents) agents "often achieve a good statistical fit" but "frequently fail to recover correct physical system parameters," and extra compute yields "recursive failure loops" (Liu et al. 2026, https://arxiv.org/abs/2604.15664); in AstroVisBench (864 tasks from 110 notebooks) "at least 58% of the time, the best models today produce code that either does not result in a visualization, or results in visualizations that contain major errors" (Joseph, Husain, Offner, Juneau et al. 2025, NeurIPS, https://arxiv.org/abs/2505.20538, https://arxiv.org/html/2505.20538).
16. Chaining agents reduces hallucination but not for free: over 500 three-agent cascades, hallucination score fell 0.422 to 0.272 while factual accuracy slipped 0.789 to 0.769. (Jamshidi et al. 2026, https://arxiv.org/abs/2606.07937) A Slack RAG bot study (368 astronomer queries, 11 interviews) documents how astronomers judge LLM answers. (Hyk et al. 2025, https://arxiv.org/abs/2507.15715)
17. Other deployed agent systems: StarWhisper Telescope runs planning and follow-up across 10 amateur telescopes for the Nearby Galaxy Supernovae Survey (Wang et al. 2024/2025, https://arxiv.org/abs/2412.06412); AstroReview's three-stage proposal-review MAS self-reports 87% accuracy on accepted proposals (Wang et al. 2025, https://arxiv.org/abs/2512.24754).

## Numbers worth quoting

- $1.55, 273,843 tokens, 40 min: one MAS run reproducing ACT DR6 lensing constraints. https://arxiv.org/html/2412.00431v2
- ~30 agents; 66% one-shot vs 78% Planning & Control on DS-1000 (cmbagent). https://arxiv.org/abs/2507.07257
- ~10% of Denario outputs judged intriguing; "Denario has fabricated data." https://www.simonsfoundation.org/2025/11/04/meet-denario-an-ai-assistant-for-every-step-of-the-scientific-process/
- ~$2 and 200K tokens per galaxy; +/-20% of grid search using ~1% of evaluations (Mephisto). https://arxiv.org/html/2510.08354v1
- 98.67% vs 94.95% micro-F1: specialized vs generic multi-agent (SimAgents). https://arxiv.org/html/2507.08958
- 141 astroquery functions over 14 services as MCP tools, incl. IRSA 7, NED 15, Exoplanet Archive 7. https://github.com/igaurab/astroquery-mcp
- 97% / 44% / 59%: text-to-SQL match on simple / medium / hard archive queries, best of 13 models. https://arxiv.org/abs/2606.18108
- 58%+ of best-model runs give no plot or a plot with major errors, 864 tasks (AstroVisBench). https://arxiv.org/html/2505.20538
- 12 agents, 8 GW tasks, 1-2 orders of magnitude short, "result fabrication." https://arxiv.org/abs/2605.11269
- Hallucination 0.422 to 0.272 but factual accuracy 0.789 to 0.769 across 3-agent chains. https://arxiv.org/abs/2606.07937
- July 16, 2026: AstroFetch open beta at the NASA Exoplanet Archive. https://exoplanetarchive.ipac.caltech.edu/

## Suggested slide points

- Cosmology already runs ~30-agent pipelines (cmbagent/Denario); the authors report fabricated data, misplaced citations, and ~10% useful output. (https://arxiv.org/abs/2507.07257; https://www.simonsfoundation.org/2025/11/04/meet-denario-an-ai-assistant-for-every-step-of-the-scientific-process/)
- Agents plus a human won a weak-lensing challenge; agents alone did not. (https://arxiv.org/abs/2604.09621)
- One logged MAS analysis: $1.55, 274K tokens, 40 minutes, contours matching ACT DR6. (https://arxiv.org/html/2412.00431v2)
- Specialization beats headcount: 98.67% vs 94.95% micro-F1 for role-specialized vs generic agents. (https://arxiv.org/html/2507.08958)
- Independent benchmarks: agents fake completion (gwBenchmarks) and fit statistics but not physics (Stargazer); keep your own metric outside the agent. (https://arxiv.org/abs/2605.11269; https://arxiv.org/abs/2604.15664)
- IPAC's AstroFetch tips page: long conversations "dilute accuracy"; check the ADQL; the CSV is the canonical artifact. (https://astrofetch.ipac.caltech.edu/)

## Astronomy or IPAC angle

- IPAC is already in this space: AstroFetch (Exoplanet Archive, open beta) writes and shows ADQL; IRSA is prototyping RAG assistants for TAP and SPHEREx; both were presented at AAS 248 and STScI's March 2026 workshop. (https://www.ipac.caltech.edu/page/aas248; https://www.stsci.edu/files/live/sites/www/files/home/events/event-assets/2026/_documents/2026-workshop-language-agenda)
- Every IPAC archive is reachable by an agent through astroquery (astroquery.ipac.irsa with query_tap and query_sia, astroquery.ipac.ned, astroquery.ipac.nexsci.nasa_exoplanet_archive) and third-party MCP wrappers; the official ADS MCP server makes literature agents first-class. (https://astroquery.readthedocs.io/; https://astroquery.readthedocs.io/en/latest/ipac/irsa/irsa.html; https://github.com/adsabs/scix-mcp)
- NASA SMD's strategy asks for reproducibility standards for "agentic workflows," the same argument as the talk's deterministic-orchestration gotcha. (https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf)

## Demo ideas for IPAC

1. Parallel FITS header audit: one subagent per directory of SPHEREx or Euclid FITS files tabulates WCS, filter, exposure, and missing keywords with astropy.io.fits and returns a 10-line summary; the orchestrator merges into one table. Read-only, no shared writes.
2. Parallel multi-archive cross-check of a target list: per object, a subagent queries IRSA (astroquery.ipac.irsa.query_tap), NED (astroquery.ipac.ned), and MAST (astroquery.mast) and returns position offsets and available datasets; merge into a conflicts report. (https://astroquery.readthedocs.io/)
3. Parallel pipeline-log triage: split a night's logs by module; each subagent extracts errors, warnings, and timing outliers with line references; the orchestrator dedupes and files issues. grep/Python only, no network.
4. Writer-critic on ADQL: one agent drafts a TAP query against the Exoplanet Archive pscomppars table or IRSA TAP; a second runs it, checks column names against the schema, and re-queries with a sanity cut, mirroring AstroFetch's "column-name mismatches" failure mode. (https://astrofetch.ipac.caltech.edu/)
5. Literature fan-out with the official ADS MCP: one subagent per mission searches scix-mcp and returns bibcodes plus one-sentence relevance; a merger writes a cited paragraph using only returned bibcodes. (https://github.com/adsabs/scix-mcp)

## Unverified

- Denario per-paper expert scores (0-9 scale): the abstract says experts gave "numerical scores," but neither HTML nor PDF fetch returned the table; HTML mentions 13 examples versus 11 papers in the abstract. Needs the PDF evaluation section. https://arxiv.org/pdf/2510.26887
- Mephisto "~100K tokens, ~$1 per source" appeared in a search snippet; the paper text retrieved says ~$2 and 200K tokens for detailed analysis. Needs the paper's cost table.
- "33% execution accuracy for LLM text-to-SQL on SDSS" appeared only in a search summary, not in the ALeRCE abstract. Needs the paper body or the SDSS SkyServer text-to-SQL talk (Zsoldos, STScI 2026).
- Contents of the Euclid multi-agent, MAST classification, and AstroGenesis (Mahabal) talks: only titles verified from the agenda; no abstracts or papers found. Needs the workshop booklet or slides.
- AstroReview's 87% and +66% figures are self-reported; no independent replication found.
- cmbagent per-task dollar cost: the paper says costs are displayed and stored per step, but no figure appears in the retrieved text.
- AstroAgents (Saeedi et al. 2025, https://arxiv.org/abs/2503.23170; eight-agent hypothesis generation from meteorite mass spectrometry, "36% plausible, 66% of those novel") was seen only in search results, not opened.

## Sources

https://arxiv.org/abs/2412.00431
https://arxiv.org/html/2412.00431v2
https://arxiv.org/abs/2507.07257
https://arxiv.org/html/2507.07257
https://github.com/CMBAgents/cmbagent
https://arxiv.org/abs/2510.26887
https://arxiv.org/html/2510.26887
https://arxiv.org/html/2510.26887v1
https://www.simonsfoundation.org/2025/11/04/meet-denario-an-ai-assistant-for-every-step-of-the-scientific-process/
https://arxiv.org/abs/2604.09621
https://arxiv.org/abs/2605.14791
https://arxiv.org/abs/2504.03424
https://arxiv.org/html/2504.03424
https://arxiv.org/abs/2510.08354
https://arxiv.org/html/2510.08354v1
https://arxiv.org/abs/2411.09012
https://arxiv.org/abs/2505.17592
https://arxiv.org/abs/2511.12353
https://astromlab.org/
https://arxiv.org/abs/2408.01556
https://arxiv.org/abs/2507.08958
https://arxiv.org/html/2507.08958
https://arxiv.org/abs/2512.24754
https://arxiv.org/abs/2412.06412
https://arxiv.org/abs/2606.18108
https://arxiv.org/abs/2505.20538
https://arxiv.org/html/2505.20538
https://arxiv.org/abs/2604.15664
https://arxiv.org/abs/2605.11269
https://arxiv.org/abs/2606.07937
https://arxiv.org/abs/2507.15715
https://arxiv.org/abs/2601.14235
https://github.com/adsabs/scix-mcp
https://github.com/NSF-Simons-CosmicAI-Institute/manna
https://glama.ai/mcp/servers/NSF-Simons-CosmicAI-Institute/manna
https://github.com/igaurab/astroquery-mcp
https://github.com/SandyYuan/astro_mcp
https://www.ipac.caltech.edu/page/aas248
https://exoplanetarchive.ipac.caltech.edu/
https://astrofetch.ipac.caltech.edu/
https://astrobiology.com/2026/09/14/astrofetch-ai-powered-exoplanet-assistant/
https://www.stsci.edu/files/live/sites/www/files/home/events/event-assets/2026/_documents/2026-workshop-language-agenda
https://assets.science.nasa.gov/content/dam/science/cds/about-us/ocsdo/reports/SMD_Data_Computing_Strategy_2025_2030.pdf
https://astroquery.readthedocs.io/
https://astroquery.readthedocs.io/en/latest/ipac/irsa/irsa.html
