# Competitive Gaps: Has Anyone Already Tried This?

Compiled 2026-10-20. Sources are dated where the source shows a date; "undated" means no date was visible in the search snippet.

**Coverage and limits (read first):** This is a shallow pass, not a full landscape. I ran 15 web searches (WebSearch tool) and fetched 0 full pages. Exa and GitKraken MCP servers failed to connect in this session (plugin:exa ERR_PROXY_TUNNEL; plugin:gitkraken connection closed), so no Exa search was run. I did not access Crunchbase, Dealroom, Tracxn, Product Hunt, the YC company directory, CB Insights post-mortems, or Thai/SEA startup databases directly. All funding and company facts below come from secondary news or aggregator snippets, and most are unverified against primary sources. Treat each verdict as a hypothesis to test, not a finding. Each area got 1 to 3 searches, so no "unserved" verdict below rests on a thorough check.

## Key Question 1: Which areas have well-funded incumbents or many recent startups?

### Takeaway
The crowded areas in this pass are AI-for-accounting (agent platforms for accounting firms), US health-payer/provider prior authorization automation, and generic SaaS. Construction permitting and AI compliance is funded and active in the US and Japan, with several rounds in 2026. Thai/SEA consumer marketplaces are dominated by regional incumbents (Grab, Shopee, GoTo) and have seen exits.

### Verdict table (all areas covered; see per-area notes below)

| # | Area | Verdict | Confidence in verdict |
|---|------|---------|----------------------|
| 1 | Software: generic SaaS | (a) crowded | Medium (aggregate data, one source with a commercial interest) |
| 2 | Marketplaces: SEA delivery and quick commerce | (d) poor economics; incumbents dominant | Medium (multiple exits reported, dates partly unclear) |
| 3 | Fintech: SEA cross-border and licensing | (d) regulatory fragmentation; Thai consumer fintech unchecked | Low |
| 4 | Health: prior authorization and payer/provider admin | (a) crowded in US; failed incumbent (Olive AI) | Medium |
| 5 | Climate tech: climate AI, offshore wind, battery | (d) capital intensity and policy dependence | Medium |
| 6 | Energy: EV charging and residential energy | (d) capital intensity; residential not checked | Low |
| 7 | Logistics: freight brokerage and tech marketplace | (d) poor unit economics, cyclical | Medium (one major failure, Convoy) |
| 8 | Education: edtech | (a) crowded and failing; no clear gap found | Medium |
| 9 | Government/compliance: construction permitting and AI compliance | (b) partially served; SEA gap unchecked | Medium |
| 10 | Agriculture: agtech | (d) cost and adoption mismatch | Medium |
| 11 | AI-enabled services: AI accounting and "AI-washed" services | (a) crowded at the agent-platform layer; AI-washing failure | Medium |
| 12 | AI-enabled services: AI-native compliance and other YC wishlist items | Not verified as a gap; see Q4 | Low |

### Cited Findings: area by area

**1. Software: generic SaaS (verdict a)**
- SimpleClosure's H1 2026 shutdown report says SaaS startups are closing at the fastest pace of any category, and says venture investment reached a record $412.7B in H1 2026 while shutdown volume also hit a period high. Source: [SimpleClosure H1 2026 report, via 01net](https://www.01net.it/simpleclosure-releases-h1-2026-shutdown-report-with-saas-startups-closing-at-the-fastest-pace/) (2026). Note: SimpleClosure sells shutdown services, so its numbers have a commercial interest. The $412.7B figure comes from a secondary read of the same report.
- A MEAN CEO roundup (June 2026) cites a 2024 to 2025 review that tied 42% of failures to building something the market did not need. Source: [MEAN CEO post-mortem roundup, June 2026](https://blog.mean.ceo/startup-post-mortems-news-june-2026/). Unverified: the 42% figure was not checked against the original review.
- Post-mortem example: Dark Inc. (Paul Biggar) shut down in June 2025 after a product with no traction failed to attract new investment, and the Darklang product was sold to its employees. Source: [Simon Willison's blog, 2025-06-16, linking Biggar's post](https://feeds.simonwillison.net/2025/Jun/16/paul-biggar/).
- Y Combinator's Fall 2026 Request for Startups includes "A Cloud for Small Software" and "Self-Maintaining APIs." Source: [Superframeworks summary of YC Fall 2026 RFS](https://superframeworks.com/articles/yc-fall-2026-rfs-indie-hacker-plays) (undated summary). An RFS signals investor interest, not a gap.

**2. Marketplaces: SEA delivery and quick commerce (verdict d)**
- Delivery Hero said foodpanda would stop food and grocery delivery in Thailand on 23 May 2025 as part of narrowing its footprint. Source: [TechNode, 2025-04-24](https://technode.global/2025/04/24/delivery-hero-continues-geostrategy-optimization-and-exits-thailand). Cause given: geographic portfolio narrowing, not product failure.
- Indonesia quick commerce exits: Tokopedia Now is closing (year not confirmed in snippet; [DealStreetAsia](https://media.dealstreetasia.com/stories/goto-tokopedia-now-403824)). Radius (tier 2 and 3 cities) left the sector due to heavy costs (undated; [DealStreetAsia](https://www.dealstreetasia.com/?p=321968)). Bananas e-grocery closed after failing to find product-market fit and weak unit economics (undated; same search result set). Grab ended quick commerce in Bandung (year not given).
- Counter-trend: Shopee launched one-hour essentials delivery in Indonesia ([DealStreetAsia, undated](https://www.dealstreetasia.com/stories/shopee-quick-commerce-goto-express-487985)). Incumbents are still expanding here.
- HappyFresh closed its Thai operation citing economic conditions. The Bangkok Post item appears older than 2025 (undated; [Bangkok Post](https://www.bangkokpost.com/business/general/2398308)).

**3. Fintech: SEA cross-border and licensing (verdict d, Thai consumer fintech unchecked)**
- Bank of Thailand's sandbox framework (updated June 2024) has three sandbox types: Regulatory, Own, and Enhanced Regulatory. Source: [Tilleke & Gibbins](https://www.tilleke.com/insights/fintech-insights-the-bank-of-thailands-sandbox-framework-for-fintech-innovation/3/) (2024 framework; page undated).
- A mid-2026 commentary says ASEAN fintech growth is uneven, with regulatory fragmentation and concentrated funding limiting scale, and that a company in Thailand faces a different compliance stack in Indonesia, Vietnam and the Philippines. Cross-border payment links remain hard to scale; the Nexus framework is described as more promising but unresolved for wholesale use. Source: [e27, 2026-02-09 (article on startups vs regulators)](https://e27.co/startups-vs-regulators-how-new-rules-are-reshaping-digital-finance-20260209), with the mid-2026 commentary being a separate, undated item in the same search set. The exact quote attribution was not confirmed.
- Vietnam Decree 94/2025 created a banking-sector fintech sandbox covering credit scoring, Open API data sharing, and P2P lending (2025). Source: [SBV, undated](https://sbv.gov.vn/en/w/sbv353990-1).
- Robinhood said in December 2025 it would enter Indonesia by acquiring a licensed brokerage and a digital asset trader. Source: search summary only, no URL confirmed. This shows incumbents buying licenses rather than startups building from scratch.
- Thai startup ecosystem (secondary, unverified): Tracxn data cited in an August 2026 roundup gives 15,891 Thai startups, 1,294 funded, about $11.4B raised in total ([Thailand startup roundup, August 2026](https://blog.mean.ceo/?p=10028)). A July 2026 roundup gives a slightly different funded count (more than 1,270). A pitch-deck guide reports $139M across 7 equity rounds in 2026 through May ([abovea.tech, undated](https://abovea.tech/pitch-deck-checklist-thai-startups-2026/)). I did not find the primary Tracxn or Dealroom reports. Treat these numbers as low confidence.
- Data protection: Thailand's data protection regulator announced eight administrative fines across five cases in August 2025. Source: secondary search summary only; no primary URL confirmed.

**4. Health: prior authorization and payer/provider admin (verdict a in US)**
- Anterior raised $40M in February 2026 to automate prior authorization for health plans, per Axios Pro. Source: [Axios Pro, 2026-02-12](https://www.axios.com/pro/health-tech-deals/2026/02/12/exclusive-anterior-raises-40m-for-health-plan-ai). The round is reported by Axios from the CEO; not independently verified.
- Ethermed raised an $8.5M Series A in April 2026 for AI prior authorization, with total funding above $15M and nine customers across providers and payers. Source: [Ethermed announcement via City Biz](https://www.citybiz.co/article/834663/ethermed-raises-8-5m-to-ease-healthcare-paperwork/) (April 2026 per the aggregator). Company location not confirmed.
- Humata Health raised $25M in June 2024. Source: [HIT Consultant, 2024-06-20](https://hitconsultant.net/2024/06/20/humata-secures-25m-for-ai-powered-prior-authorization/). Humata also acquired Olive's prior-authorization unit (see Q2).

**5. Climate tech (verdict d)**
- ClimateAi (San Francisco) wound down in 2026 after about eight years and roughly $38M in funding, citing "geopolitical and climate headwinds." Source: [Dealroom news, 144261](https://dealroom.co/news/144261-climateai-shuts-down-after-raising-38m-in-funding/) and [Agroempresario](https://agroempresario.com/publicacion/120399/climateai-shuts-down-after-raising-38-million-in-funding/) (2026, undated day). Sale or merger status not confirmed.
- Ascend Elements (US battery materials) filed for Chapter 11 in April 2026 after being named one of the world's most innovative companies in 2024. Source: search summary only; a related WBUR item is at [WBUR, 2026-10-01 link](https://www.wbur.org/news/2026/10/01/tech-business-bankruptcy-climate) but its content was not read. Bankruptcy, not a clean shutdown.
- Beam (UK, offshore-wind robotics) entered administration in 2025, months after expansion plans. Sifted understood it was seeking more than £100M in late 2024. Source: [Sifted](https://sifted.eu/articles/beam-robotics-shuts-down) (2025).
- Maya Climate (Berlin) announced a wind-down by end of 2025. Reasons paywalled. Source: [Carbon Pulse](https://carbon-pulse.com/398221/) (2025).

**6. Energy: EV charging and residential energy (verdict d, residential unchecked)**
- Canoo (US EV maker, not charging) filed for bankruptcy in January 2025 and ceased operations after failing to raise more capital. Source: [TechCrunch, 2025-01-17](https://techcrunch.com/2025/01/17/ev-startup-canoo-files-for-bankruptcy-and-ceases-operations). Canoo's SPAC-era history is noted in press coverage.
- Northvolt filed for bankruptcy in Sweden in March 2025 after failing to secure a viable financial future, with weaker EV demand cited. Source: [TXF News](https://www.txfnews.com/news/69459/Northvolt-files-for-bankruptcy-in-Sweden) (2025).
- ZPN Energy (UK EV charging and battery) entered administration. Reasons and date not visible in the snippet. Source: [Vision Mobility](https://vision-mobility.de/en/news/enercharge-files-for-bankruptcy-325009.html) (undated; EnerCharge, a different company, appears in the same result, so verify before citing).
- Charge Enterprises (US EV charging) bankruptcy: its former chairman and an investment adviser were named in press coverage; a June 2026 Law360 item reports a judge trimmed a class action alleging executives hid a liquidity crisis. Source: [Law360](https://www.law360.com/articles/2493450) (2026 report on a bankruptcy that appears older). Filing date unclear.
- I found no 2025 or 2026 bankruptcy of a residential energy startup (home battery, solar, home charger) in this pass. That was not checked directly.

**7. Logistics: freight brokerage and tech marketplace (verdict d)**
- Convoy (Bezos-backed) shut down in October 2023 with no buyer. CEO Dan Lewis blamed a freight recession and a tighter capital market that hit both the company and its likely acquirer. He said Convoy reached the "1/2 yard line" on two M&A deals before shutdown. Source: [CNBC, 2023-10-19](https://www.cnbc.com/2023/10/19/bezos-backed-freight-firm-convoy-shuts-down-read-ceo-memo-here.html) and [Bloomberg, 2023-10-19](https://www.bloomberg.com/news/articles/2023-10-19/bezos-backed-startup-convoy-closes-operations-with-no-buyer).
- FreightWaves analysis argued that the business case for replacing human brokers with software was never certain and that pandemic-era pricing was a tailwind, not durable. Source: [FreightWaves, Convoy shutdown analysis](https://www.freightwaves.com/news/convoy-shutdown-trucking-startup) (2023; opinion). Treat as interpretation.

**8. Education: edtech (verdict a, crowded and failing)**
- Ankur Warikoo's five-year-old online learning platform (India) is closing, and the founder cites AI as a major factor even though the platform reported Rs 100 crore revenue and Rs 25 crore profit. Source: [CompleteAI Training](https://completeaitraining.com/news/ankur-warikoo-shuts-profitable-online-learning-platform/) (announced May 15; year as reported by source is 2026, not independently confirmed).
- Edukoya (Nigeria) wound down after about $3.5M in funding, citing connectivity, device access and market readiness. Source: [Launchbase Africa, 2025-02-27](https://launchbaseafrica.com/2025/02/27/what-went-wrong-at-edukoya-nigerian-edtech-closure-raises-market-questions-and-financial-red-flags/) (2025).
- Zenius (Indonesia) temporarily halted operations in January 2024 after about 20 years. Source: [Jakarta Globe](https://jakartaglobe.id/tech/after-20-years-edutech-startup-zenius-temporarily-halts-operation) (2024).
- Talrop (India) and Udayy (India) closures appear in results; the Talrop source is a low-authority failure-scoring site, and Udayy's date is unclear.

**9. Government and compliance: construction permitting and AI compliance (verdict b, partially served)**
- Dili (AI compliance for infrastructure projects, tied to federal funding) raised a $15M Series A led by Khosla Ventures, bringing total capital to $21.7M. Source: [TechCrunch, 2026-07-30](https://techcrunch.com/2026/07/30/dili-raises-15-million-to-bring-ai-compliance-to-the-infrastructure-boom/).
- MIGN (Japan) raised about $1.5M (¥230M) in a pre-Series A in April 2026. Its platform checks architectural drawings against building standards. Source: [AIWorld.eu](https://aiworld.eu/story/mign-building-vertical-agentic-ai-for-construction-compliance) (April 2026 per source).
- PermitFlow raised a $54M Series B led by Accel, reported by Business Wire and Foundamental (late 2025). Source: [Foundamental](https://www.foundamental.com/perspectives/permitflow-raises-54m-in-series-b-to-automate-construction-permitting). A job-board claim of a March 2026 raise is not confirmed by other sources and was discarded.
- Permit Beacon (Tampa) seed of $300K, March 2026 per an aggregator ([VC Backed](https://www.vcbacked.co/company/permit-beacon); low confidence).
- CodeComply.Ai (Miami) raised a $2M seed led by Govo Venture Partners. Date not confirmed. Source: [Refresh Miami](https://refreshmiami.com/news/with-2m-in-tow-ai-startup-codecomply-ai-aims-to-accelerate-construction-approvals-and-reshape-compliance-checks/).
- Public buyers are active: Harris County, Texas earmarked more than $750K in its 2027 budget for an AI plan-review system from Archistar. Source: search summary only, no URL confirmed (undated).
- HUD funding for automated permitting systems had a July 13, 2026 application deadline. Source: [Claritis CivCheck](https://www.claritisoftware.com/civcheck-hud-grant) (2026 deadline).

**10. Agriculture: agtech (verdict d)**
- Univ. of Nebraska-Lincoln analysis (Chandra and Lal) attributes 2025 agtech failures to cost and adoption mismatches rather than broken technology. Shutdown counts from its dataset: vertical farming 6, insect and alternative protein 3, digital advisory and marketplaces 3, sensors and IoT 3, robotics 2, ag-biotech 1. Source: [AgTech Navigator, 2026-01-28](https://www.agtechnavigator.com/Article/2026/01/28/why-agtech-start-ups-failed-last-year-and-a-playbook-for-2026) (the paper itself was not fetched).
- Bowery Farming is ceasing operations after raising more than $700M, per PitchBook as cited by TechCrunch. Source: [TechCrunch](https://techcrunch.com/?p=2910520) (closure date not in snippet).
- Indian agritech investment fell from $802M in 2022 to $96M in H1 2025. BharatAgri shut down after failing to raise a new round. Source: [Entrackr](https://entrackr.com/exclusive/exclusive-bharatagri-shuts-down-operations-amid-funding-crunch-10646984) (2025 per snippet).
- Gro Intelligence collapsed; reporting cites an SEC examination of investor communications (as reported, not confirmed by primary filing). Source: [Techpoint Africa](https://techpoint.africa/news/kenya-gro-intelligence-shuts-down/) (date not in snippet).
- Investor Adam Bergman (EcoTech Capital) expects a record number of agtech bankruptcies, restructurings and fire sales in 2026. Source: [Agroempresario](https://agroempresario.com/publicacion/116768/why-agtech-startups-could-collapse-in-record-numbers-in-2026/) (2026 forecast, opinion).

**11. AI-enabled services: AI accounting and "AI-washed" services (verdict a at agent-platform layer)**
- Basis (AI agents for accounting firms) raised $100M in Series B led by Accel at a $1.15B valuation, announced 24 February 2026. Its platform is used by about 30% of the top 25 US accounting firms (company claim). Source: [CPA Practice Advisor, 2026-02-24](https://www.cpapracticeadvisor.com/2026/02/24/basis-raises-100-million-to-deploy-ai-agents-for-accounting-firms/178759/). Earlier $34M Series A led by Khosla Ventures (date not confirmed; [Accounting Today](https://accountingtoday.com/news/major-ai-players-back-basis-with-34-million-series-a)).
- Modus (AI agents for audit workflows) raised $5M seed and $80M Series A led by Lightspeed; dates unverified. Source: [Ben's Bites](https://news.bensbites.co/posts/63315-modus-which-builds-ai-agents-for-audit-workflows-and-invests-in-established-accounting-firms-raised-a-5m-seed-and-an-80m-series-a-led-by-lightspeed).
- Maxima (agentic AI for accounting) announced $41M Seed and Series A (Redpoint, Kleiner Perkins, Audacious). Source: [Crowdfund Insider](https://www.crowdfundinsider.com/tag/maxima/) (undated).
- Builder.ai (formerly Engineer.ai) collapsed. Reporting attributes this to misleading AI claims (a 2019 WSJ report said the work was largely done by around 700 engineers in India), questioned financial reporting (Bloomberg, March 2025, alleged inflated revenue; VerSe called the allegations false), loss of lender and partner support, and UK insolvency around May 2025. Sources: [Rest of World, 2025](https://restofworld.org/2025/builderai-ai-explainer-bankrupt/); [Startups.co.uk](https://startups.co.uk/news/builder-ai-collapse/). Regulatory probes mentioned in one Substack post were not confirmed.

## Key Question 2: Which areas have seen failures, and what caused them?

### Takeaway
Failure causes cluster in four groups: (1) poor unit economics or cyclical demand (Convoy, SEA grocery, agtech); (2) capital intensity and policy dependence (climate, EV, batteries); (3) AI-related overclaiming or obsolescence (Builder.ai, Warikoo, Talrop); (4) integration complexity and overexpansion (Olive AI). Post-mortem quality is mostly news and opinion, not audited analysis.

### Cited Findings
- Olive AI (healthcare automation, US): CEO attributed strain to rapid expansion and lack of focus; overpromising (claimed to cut customers' admin costs by 5x); customer trust problems; a 450-person layoff in July 2022 and 200 more in February; the company sold its clearinghouse and patient-access units to Waystar and its prior-authorization unit to Humata Health, and wound down the rest. Sources: [Fierce Healthcare](https://www.fiercehealthcare.com/health-tech/once-high-flying-unicorn-olive-ai-sells-two-key-businesses-winds-down-operations) (sale date not visible in snippet); [Substack analysis, sergeiai](https://sergeiai.substack.com/p/the-death-of-olive-ai) (undated). One profile site claims a Chapter 11 filing; this is not confirmed by other sources and was discarded. Integration complexity (per-hospital workflows, EHR systems) is an interpretation from a low-authority source (ideaproof.io).
- Convoy: see area 7.
- Builder.ai: see area 11. Failure source is largely fraud allegations and AI-washing, not market demand.
- ClimateAi, Beam, Maya Climate: see area 5. Common reasons reported: funding shortfall, weak fundraising after strong plans, and macro headwinds.
- Edtech: see area 8. Common reasons: AI-driven course obsolescence, device and connectivity gaps, and a funding drought (Unacademy's founder reportedly warned funding will stay scarce for 12 to 18 months; search summary only, no URL confirmed).
- Agtech: see area 10. Cost and adoption mismatch is the main cause in the academic dataset.
- SEA quick commerce: see area 2. Reasons cited: high costs, unit economics, failure to find product-market fit. Bananas: "failing to find product market fit and weak unit economics."
- SaaS: see area 1. H1 2026 shutdown data says SaaS closed fastest.

### Inferences
- The failures are mostly poor economics or capital intensity, not technology that could not work. This suggests that a new startup in these areas must show a unit economics case, not just a technical one.
- AI-related overclaiming is a recurring failure mode (Builder.ai) and should be a caution for any "AI-enabled service" that is partly manual.

### Gaps
- No audited post-mortem was found for Convoy, Olive AI, or Bananas. All reasons come from news coverage or founder statements.
- CB Insights post-mortem list and failure-analysis blogs were not directly checked.

## Key Question 3: Which problems are unserved because of regulation, data access, or technical limits that may be changing in 2026?

### Takeaway
The clearest structural blockers are: cross-border payments and licensing fragmentation across ASEAN (regulatory, slowly changing via sandboxes and frameworks like Nexus); prior-authorization data access and payer rules (partially changing with AI tools); and permitting and building codes in local jurisdictions (changing through AI plan-review and federal grants, but still fragmented).

### Cited Findings
- ASEAN cross-border payments: Nexus is described as promising but unresolved for wholesale use. Fragmented compliance stacks across Thailand, Indonesia, Vietnam, Philippines. Source: [e27, 2026-02-09](https://e27.co/startups-vs-regulators-how-new-rules-are-reshaping-digital-finance-20260209) and an undated mid-2026 commentary in the same search set.
- Thailand BOT sandbox (three types, updated 2024) and Vietnam Decree 94/2025 (banking-sector fintech sandbox covering credit scoring, Open API, P2P) indicate regulators are opening testing paths, which may lower entry barriers in 2026. Sources: [Tilleke & Gibbins](https://www.tilleke.com/insights/fintech-insights-the-bank-of-thailands-sandbox-framework-for-fintech-innovation/3/); [SBV](https://sbv.gov.vn/en/w/sbv353990-1).
- Data protection enforcement in Thailand is active (eight fines across five cases, August 2025). Source: [Thailand Business News](https://www.thailand-business-news.com/?p=314522). This raises the compliance cost of consumer data products.
- US prior authorization: Anterior, Ethermed, and Humata are all building AI-driven PA tools, which suggests the data access and payer-rule barrier is being addressed by funded startups (see area 4).
- Construction permitting: HUD's automated permitting program (application deadline July 13, 2026) and Harris County's AI plan-review budget signal public-sector demand for automated review. Sources: [Claritis](https://www.claritisoftware.com/civcheck-hud-grant); the Harris County item is from a search summary with no URL confirmed.

### Inferences
- Regulatory-blocked areas (cross-border payments, cross-jurisdiction permitting) are the most likely to remain open for a while, but they also have the highest compliance cost and the most funded local competitors.
- The 2026 change is mostly sandboxes and AI-driven review, not repealed rules. Whether that opens a gap depends on the specific country's license regime, which I did not check.

### Gaps
- I did not verify any 2026 change in Bank Indonesia or Bank of Thailand licensing rules beyond the 2024 sandbox framework.
- Permit rules for Thailand or SEA cities were not checked. Thai municipal permitting is a candidate gap but unverified.
- Energy regulation (residential solar, home batteries, grid interconnection) was not searched.

## Key Question 4: Which gaps are genuinely open versus only appearing open because searches are shallow?

### Takeaway
No area in this pass can be declared unserved with confidence. Each area got 1 to 3 searches, no primary databases were checked, and no full pages were fetched. The strongest candidates for further checking are areas where the search returned few results rather than many. These are hypotheses only.

### Cited Findings (what the shallow pass did and did not show)
- Crunchbase, Dealroom, Tracxn: only secondary references found (see area 3 for Thailand totals). Primary pages were not accessed.
- Product Hunt and YC company directory: not searched directly. The YC Fall 2026 RFS list was found via secondary summaries (season label disagrees across sources; check [ycombinator.com/rfs](https://www.ycombinator.com/rfs) directly). Items include AI-native compliance infrastructure, AI for the aging population, proving humanity, self-maintaining APIs, and AI-powered consumer products for one billion people. Sources: [Superframeworks, Fall 2026 RFS](https://superframeworks.com/articles/yc-fall-2026-rfs-indie-hacker-plays); [IBTimes SG](https://www.ibtimes.sg/A000Ncu).
- Post-mortem sources: MEAN CEO monthly roundups (June and July 2026) and SimpleClosure H1 2026 report. Both are secondary. A CB Insights post-mortem list was not checked.
- Startups in Thailand: Tracxn totals via roundup (Aug 2026, low confidence). Thai news (Bangkok Post, Thailand Business News) returned only a few items.

### Verdicts by confidence
- **Most likely genuinely crowded (a):** AI accounting agent platforms (Basis, Modus, Maxima); US prior authorization (Anterior, Ethermed, Humata, Olive's successors); generic SaaS.
- **Crowded and failing (a with failures):** edtech (AI obsolescence and funding drought).
- **Structurally hard (d):** SEA delivery and quick commerce (incumbents plus poor unit economics); freight brokerage (cyclical, Convoy); agtech (cost and adoption); climate hardware (capital intensity); EV and battery (capital intensity, SPAC-era governance); SEA cross-border payments (licensing fragmentation).
- **Partially served with a gap (b):** construction permitting and AI compliance. The US and Japan have funded players; Thai and SEA municipal permitting was not checked. This is the most promising area to examine next, but it is still a hypothesis.
- **Not checked, so no verdict:** residential energy (home batteries, solar, home chargers), Thai consumer fintech (lending, payments), Thai healthcare admin beyond the US, Thai logistics beyond quick commerce, and the YC wishlist items (AI for the aging population, AI-native compliance).

### Inferences
- The clearest unserved-looking candidates are permitting and compliance in SEA (not verified) and residential energy in SEA (not checked). Both need a fresh search before any claim of "unserved."
- Areas with 3 or more funded companies and several 2026 rounds (accounting, prior auth, permitting in US) are not open to a new entrant on the same wedge.

### Gaps
- No direct search on Thai municipal permitting, Thai residential solar, or Thai hospital prior-auth tooling.
- No check of pricing or feature pages for any incumbent. Incumbent capabilities are inferred from press releases only.
- No primary post-mortems were fetched. The failure causes are from news and opinion.
- Several funding amounts are from aggregators or secondary posts and are flagged in the text. Dates for Tokopedia Now, Radius, Bananas, Grab Bandung, HappyFresh, Udayy, and Gro Intelligence closures were not confirmed.
- The Exa MCP server was unavailable for this session. A rerun with Exa or Firecrawl deep search, plus direct Crunchbase, Dealroom, and Tracxn queries, is the next step before any verdict is treated as final.
