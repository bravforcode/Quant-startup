# Scraper-maintenance demand, scraper pricing, and legal constraints (TH / EU / US)

Scope: evidence brief for p04. All "checked" dates are 2026-10-19 (shell clock 12:01 UTC; Firecrawl and WebFetch reads in the same session). Labels: FACT = read or observed in a source this session; OPINION = author judgment; UNVERIFIED = could not verify, or stated from memory and not checked here. Search-snippet-only claims are marked as such. Nothing here is legal advice; items marked "lawyer" need a qualified lawyer.

Tool-use note: roughly 20 calls were made, over the usual budget, to get the pricing pages and the ToS text. Several sources failed (listed under Gaps).

## Key Question 1: Do agencies or data teams pay for scraper maintenance? (public job posts)

### Takeaway
In this session's sample, one relevant public Upwork post (1 of 2 results) showed a buyer-stated budget ($5,000 est.; Phase 1 range $2,500–$7,500) and describes ongoing maintenance cost as a pain. No hire, paid amount, or retainer was visible for any sampled post. The buyer was a real-estate data business, not a marketing agency. Freelancer.com and Fastwork gave no usable listing evidence. The sample is far too small to estimate frequency.

### Cited Findings
- Upwork search for "scraper maintenance", sorted by newest, returned "2 jobs found" on one results page. Posting ages are relative labels ("Posted 3 weeks ago", "Posted 4 weeks ago"), so exact dates are not known; approximately 2026-09-21 to 2026-09-28 (derived, UNVERIFIED exact). — [Upwork search](https://www.upwork.com/nx/search/jobs/?q=scraper%20maintenance&sort=recency) · checked 2026-10-19 · FACT (count), UNVERIFIED (exact dates)
- Relevant post, "Senior Data Engineer / Full-Stack Developer Needed — Rebuild Existing Real-Estate Data Platform": fixed price, Expert level, "Est. budget: $5,000.00". The body states an expected Phase 1 budget of $2,500–$7,500 and says the existing UiPath/browser-automation prototype "has become expensive and difficult to maintain when source websites change." Phase 1 (discovery) only; a later build is contingent. — [Upwork job](https://www.upwork.com/jobs/Senior-Data-Engineer-Full-Stack-Developer-Needed-Rebuild-Existing-Real-Estate-Data-Platform_~022102455933091238341/) · checked 2026-10-19 · FACT (posted text; the budget is buyer-stated, not paid)
- The same post says the buyer will not accept proposals whose approach is "primarily 'I'll scrape it with Selenium'" and wants code and infrastructure owned by the client. — same job URL · checked 2026-10-19 · FACT (posted text)
- Other result, a Lovable golf-app MVP production build: not scraper work; excluded from the scraping-demand count. — [Upwork job](https://www.upwork.com/jobs/Senior-Full-Stack-Developer-Mobile-App-Team-Take-Existing-Golf-MVP-Production_~022106055706765299533/?referrer_url_path=/nx/search/jobs/) · checked 2026-10-19 · FACT
- The results page's client-history filter shows "No hires (2)". My reading is that both listed clients have no hire history on Upwork. — [Upwork search](https://www.upwork.com/nx/search/jobs/?q=scraper%20maintenance&sort=recency) · checked 2026-10-19 · UNVERIFIED (interpretation of the filter count)
- Freelancer.com page for "scraper-maintenance" returned HTTP 200 with about 323,900 characters of markdown. A keyword pass (scrap / crawl / extract / maintain) over the saved text matched only one line, a category-navigation line. No scraper-titled listing was identified. I did not read the full page and did not extract listing counts or budgets. — [Freelancer search](https://www.freelancer.com/job-search/scraper-maintenance/) · checked 2026-10-19 · FACT (method result); inconclusive
- Fastwork: the URL I tried, https://www.fastwork.co/search/web-scraping, redirected to https://fastwork.co/search/web-scraping and returned HTTP 404 ("ไม่พบหน้าที่คุณต้องการ"). No Fastwork listing data obtained. — [Fastwork](https://fastwork.co/search/web-scraping) · checked 2026-10-19 · FACT (404)

### Inferences
- The one buyer post supports that maintenance pain exists at the level of a buyer's narrative. It does not show that agencies pay for it.
- Its structure (paid discovery/audit first, build later, explicit ownership demands) may be a useful pattern to test in more posts. OPINION, based on one post.
- Any demand claim for "small marketing agencies" needs a different sample: this one post is from a data business.

### Gaps
- Not searched: "fix scraper", "scraper broken", "maintain scraper", "scraper repair" variants; second and later result pages; Upwork client-hire histories per post.
- Freelancer.com: listing count, budgets, and bid counts not extracted; the saved page needs a structured parse, not keyword grep.
- Fastwork: the correct search URL was not found; a site search (for example, firecrawl_search with site:fastwork.co) was not run.
- Thai job boards (for example, JobThai) not searched.
- No recurring-retainer or invoice evidence found; no evidence specific to marketing agencies found.

## Key Question 2: Current public pricing, plan tiers, and free tiers (checked 2026-10-19)

### Takeaway
Entry points for a small team, as of 2026-10-19: Octoparse Standard at $69/mo billed annually ($83 monthly), Apify Starter at $19/mo plus usage, and Zyte pay-as-you-go from $0.13 per 1,000 HTTP requests with a $5 trial credit and $100/mo minimum tiers available. Bright Data per-product prices were not verified. The four vendors bill in different units (compute units, requests by target difficulty, subscription task quotas), so they cannot be compared directly without a test run per target site.

### Cited Findings

Apify — [Apify pricing](https://apify.com/pricing) · checked 2026-10-19 · monthly-billing prices shown
- Free: $0/mo; $5/mo prepaid platform usage; $0.20 per compute unit (CU); 16 GB Actor RAM; max 5 concurrent runs; 5 datacenter IPs included; no credit card. When free-plan usage runs out, access is blocked until the next monthly cycle. — FACT
- Starter: $19/mo + pay-as-you-go; $19 prepaid usage; $0.20/CU; 64 GB RAM; 32 concurrent runs; residential proxy $8/GB. — FACT
- Scale: $199/mo + PAYG; $0.16/CU; 256 GB RAM; 128 concurrent; residential proxy $7.5/GB. — FACT
- Business: $999/mo + PAYG; $0.13/CU; 512 GB RAM; 256 concurrent; residential proxy $7/GB. — FACT
- Unused prepaid usage does not roll over; it expires at the end of the billing cycle. — FACT
- Annual billing toggle shows −10%. Startup discount on Scale is 30% (vendor statement). — FACT (vendor claim)
- Apify's FAQ says the easiest way to learn an Actor's usage is a test run. — FACT

Bright Data — [Bright Data pricing hub](https://brightdata.com/pricing) · checked 2026-10-19 (page metadata: modified 2026-08-23)
- The hub lists eight product lines (Proxy Network, Web Scraper API, Scraper Studio, Scraping Browser, SERP API, Web Unlocker, Datasets, Bright Insights), each linking to its own pricing page. It shows "Free tier pricing available" for Scraper Studio, and no per-product price numbers. — FACT
- Per-product page https://brightdata.com/pricing/web-scraper failed to load in this session ("All scraping engines failed"). Bright Data prices and free-tier limits: UNVERIFIED.
- Vendor claims on the hub ("Trusted by 50,000+ customers", "400M+ monthly Residential IPs"): not verified; not used as demand evidence. — UNVERIFIED

Zyte — [Zyte pricing](https://www.zyte.com/pricing/) · checked 2026-10-19
- Headline: "From $0.06 per 1,000 successful responses" (Zyte API). — FACT
- Trial: $5 free credit, 30 days, no commitment. — FACT
- Pay as you go (no minimum), per 1,000 requests by target tier. HTTP response body: $0.13 (Simple), $0.23, $0.44, $0.70, $1.27 (Advanced). Browser-rendered: $1.01 to $16.08 across the five tiers. The tier depends on the target site; the page says to enter a URL for that site's price. — FACT
- Monthly minimum commitments: $100/mo (HTTP $0.10–$0.95; browser $0.75–$12.00); $200/mo (HTTP $0.08–$0.76; browser $0.60–$9.60); $500/mo (HTTP $0.06–$0.61; browser $0.48–$7.68); Enterprise is custom. — FACT
- Page states "No overage penalties" and that "some advanced features may incur additional usage-based costs." — FACT (vendor statement)
- Zyte Data and Scrapy Cloud tabs exist; their prices were not captured. — FACT (gap)

Octoparse — [Octoparse pricing](https://www.octoparse.com/pricing) · checked 2026-10-19 (US$)
- Free: $0, "free forever"; 10 tasks; 1 device; local extraction only; up to 10K rows per export and 50K rows/month; 2 concurrent local runs; no credit card (per FAQ). — FACT
- Standard: $83/mo billed monthly; $69/mo billed annually ($829/yr). 100 tasks; up to 3 concurrent cloud processes; 500+ templates; IP rotation; residential proxies; automatic CAPTCHA solving; unlimited export; scheduling; Data Export API. — FACT
- Professional: $299/mo monthly; $249/mo annually ($2,999/yr). 250 tasks; up to 20 concurrent cloud processes; cloud task monitoring; export to Google Sheets, Drive, Dropbox, S3; Advanced API; priority support. — FACT
- Enterprise: custom; 750+ tasks; 40+ concurrent cloud processes. — FACT
- Add-ons: residential proxies $3/GB; pay-per-result templates $0.001–3 per 1,000 results; CAPTCHA solving $1–1.5 per 1,000; Crawler Setup from $399; Data Service from $599 (quote-based). — FACT
- 5-day money-back guarantee on paid plans; 30% startup discount for one year (vendor statement). — FACT
- The "billed quarterly" column on the comparison table ($239 / $779) has an ambiguous unit and was not used. — UNVERIFIED

### Inferences
- Costs are not comparable across vendors until a test run per target site is done: Apify charges by CU, proxies, and storage; Zyte by request and target difficulty; Octoparse by subscription quota and add-ons. OPINION, supported by Apify's own FAQ.
- The Octoparse Standard tier's 100-task quota and 3 concurrent cloud processes are the binding limits for a small agency with many client sites. OPINION.

### Gaps
- Bright Data per-product pricing, free-tier limits, and minimums: not verified (scrape failed).
- Zyte Scrapy Cloud pricing: not captured.
- Apify Store Actor prices: vary per Actor; not sampled.
- Only one-day snapshot (2026-10-19). No historical price changes checked.

## Key Question 3: Legal and ToS constraints on scraping public data (Thailand PDPA; ToS examples; EU/US context)

### Takeaway
Thai PDPA snippet-level summaries say that collecting personal data from a source other than the individual triggers a notice duty (within 30 days, per the summaries) and a necessity limit, subject to listed exceptions. No PDPC guidance specific to scraping or "publicly available" data was found in one search. The statute text was not opened. The Amazon Conditions of Use bar robots and data extraction and require AI agents to identify themselves. The LinkedIn terms could not be retrieved. US case law (hiQ v. LinkedIn) is summarized as reported by secondary sources and needs lawyer confirmation.

### Cited Findings

Thailand PDPA
- PDPC guidance on scraping or "publicly available" personal data: none found in one general search. The results covered general PDPC guideline work only. — WebSearch, query "Thailand PDPA publicly available personal data collection web scraping PDPC guidance", checked 2026-10-19 · FACT (search result); gap
- Indirect collection: a controller generally may not collect personal data from a source other than the data subject, except in listed cases; where it does, privacy information must be provided within a reasonable period, no more than 30 days (per summaries). — [LawPlus summary (PDF)](https://www.lawplusltd.com/wp-content/uploads/kalins-pdf/singles/personal-data-protection-law-of-thailand-limitations-to-collection-use-and-disclosure.pdf); [PwC Thailand legal insight 06 (2021, PDF)](https://pwc.com/th/en/pwc-tax-insights/2021/legal/eng/2021-pwc-legal-insight-06.pdf) · checked 2026-10-19 · UNVERIFIED against the Royal Gazette text (snippet-level only; neither PDF was opened)
- Exceptions listed in the LawPlus snippet include: preventing harm to life; performing a contract with the data subject; the controller's legitimate interests; compliance with law or legal claims; important public policy. — same LawPlus link · checked 2026-10-19 · UNVERIFIED (snippet)
- Collection is limited to what is necessary for the intended lawful purpose. — same LawPlus link · checked 2026-10-19 · UNVERIFIED (snippet)
- PDPC guidelines on notifying the purpose and details of collection (adopted; dated September 2022 in summaries): notice at collection, or within 30 days if the data came from another source. — [Digital Policy Alert entry](https://digitalpolicyalert.org/event/21884-adopted-pdpc-guidelines-for-notifying-the-purpose-and-details-of-collecting-personal-data-from-data-subjects-according-to-the-personal-data-protection-act-be-2562) · checked 2026-10-19 · UNVERIFIED (metadata and snippet only; PDPC original not opened)
- Draft PDPC guidelines: Tilleke reports a two-day PDPC public hearing on 1–2 April 2026, after a March 2026 questionnaire. The forthcoming guidelines are non-binding but are expected to shape compliance and enforcement. — [Tilleke, April 2026 note](https://www.tilleke.com/?p=780653) · checked 2026-10-19 · FACT (snippet; article not opened)
- The official portals pdpc.or.th and ratchakitcha.soc.go.th were not fetched in this session. — gap

Amazon Conditions of Use (ToS example 1)
- License scope excludes "any collection and use of any product listings, descriptions, or prices" and "any use of data mining, robots, or similar data gathering and extraction tools." — [Amazon Conditions of Use](https://www.amazon.com/gp/help/customer/display.html?nodeId=GLSBYFE9MGKKQXXM) · last updated 2026-08-14 per page; checked 2026-10-19 · FACT (verbatim)
- Agent Terms in the same document: any "Agent" must identify itself in the user-agent string ("Agent/[agent name]"), must not mimic human interaction patterns, must not complete or circumvent CAPTCHAs, and must not circumvent blocking measures. Amazon may limit Agent access. — same link · checked 2026-10-19 · FACT (verbatim). Whether an ordinary scheduled scraper is an "Agent" is a legal question. lawyer
- Disputes go to binding JAMS arbitration under Washington law, with a class waiver and a mass-arbitration procedure. — same link · checked 2026-10-19 · FACT

LinkedIn User Agreement (ToS example 2)
- Not retrieved. WebFetch failed (getaddrinfo ENOTFOUND www.linkedin.com); Firecrawl scrape failed (all engines). The LinkedIn clause text is UNVERIFIED in this brief. — https://www.linkedin.com/legal/user-agreement · checked 2026-10-19 · gap

US context (secondary sources only; lawyer confirmation needed)
- hiQ Labs v. LinkedIn: the Ninth Circuit (April 2022) kept the injunction barring LinkedIn from blocking hiQ, reasoning that the CFAA's "without authorization" language did not fit public websites; breach of a user agreement alone was said to be insufficient for CFAA liability. — [Morgan Lewis, Dec 2022](https://www.morganlewis.com/blogs/sourcingatmorganlewis/2022/12/linkedin-v-hiq-landmark-data-scraping-suit-provides-guidance-to-data-scrapers-and-web-operators); [ZwillGen](https://www.zwillgen.com/alternative-data/hiq-v-linkedin-wrapped-up-web-scraping-lessons-learned/) · checked 2026-10-19 · FACT as reported by secondary sources (search snippets; articles not opened)
- Preliminary injunction dissolved August 2022. Settlement December 2022: $500,000 judgment against hiQ, California tort liability, injunctive relief, and deletion of scraped source code, data, and algorithms. The agreed judgment has no precedential value. — [IAPP](https://iapp.org/news/b/linkedin-prevails-in-six-year-lawsuit-against-data-scraper); Morgan Lewis; ZwillGen · checked 2026-10-19 · FACT as reported (snippet level)
- Later developments: none found in one search beyond the settlement. Van Buren v. United States (2021) narrowed the CFAA's "exceeds authorized access" prong; this is from memory and was not checked in this session. — UNVERIFIED. lawyer
- EU context (from memory; not researched in this session): GDPR treats publicly available personal data as personal data; indirect collection carries information duties; the EU database right and CJEU case law (for example Ryanair v PR Aviation, 2015) bear on scraping of databases and contract terms. — UNVERIFIED. lawyer

### Inferences (OPINION)
- Scraping a price or product listing carries less personal-data exposure than scraping profiles or contact details. Scraping for marketing contact lists raises PDPA notice issues even when the pages are public. Lawyer.
- Amazon's terms prohibit this type of collection outright in its license scope. A maintained scraper for Amazon data therefore carries contract and access-control risk independent of any privacy analysis. Lawyer.
- The ToS and hiQ outcomes depend on jurisdiction, contract formation, and access controls. None of this brief's sources is a legal opinion.

### Gaps
- PDPA statute text (Royal Gazette) and PDPC primary guidance: not fetched. Search for "publicly available" exemption text: not done. Section 4 scope exemptions and sensitive-data rules (Section 26) are not verified here; UNVERIFIED from memory. Thai Computer Crime Act: not researched.
- LinkedIn and a third ToS example: not retrieved.
- EU and US primary sources: not retrieved; EU content is from memory.
- Lawyer confirmation needed for all Section 3 conclusions.

## Key Question 4: Evidence grades for demand items

### Takeaway
No S-grade (verifiable money paid by the buyer) or A-grade (verifiable past behavior with a number) item was found in this session. The best item is C-grade: a buyer-stated budget in one open Upwork post with no visible hire. One B-grade narrative item (the same post's maintenance-cost claim). Nothing supports a frequency or market-size estimate.

### Cited Findings
| # | Demand item | Source | Grade | Basis |
|---|---|---|---|---|
| 1 | Real-estate rebuild post: Est. budget $5,000; Phase 1 $2,500–$7,500 | [Upwork job](https://www.upwork.com/jobs/Senior-Data-Engineer-Full-Stack-Developer-Needed-Rebuild-Existing-Real-Estate-Data-Platform_~022102455933091238341/) | C | Stated budget in an open posting; no hire, contract, or payment shown. Not A: no hire or paid amount. · checked 2026-10-19 |
| 2 | Same post: existing maintenance is "expensive and difficult" when sites change | same | B | Narrative past behavior; no number; the buyer's own situation, not a paid vendor relationship. · checked 2026-10-19 |
| 3 | Golf MVP production-build post | [Upwork job](https://www.upwork.com/jobs/Senior-Full-Stack-Developer-Mobile-App-Team-Take-Existing-Golf-MVP-Production_~022106055706765299533/?referrer_url_path=/nx/search/jobs/) | excluded | Not scraper work. · checked 2026-10-19 |
| 4 | Freelancer.com scraper-maintenance results | [Freelancer search](https://www.freelancer.com/job-search/scraper-maintenance/) | no grade | No scraper-titled listing identified in saved text. · checked 2026-10-19 |
| 5 | Fastwork scraping services | [Fastwork](https://fastwork.co/search/web-scraping) | no grade | 404; no data. · checked 2026-10-19 |
| 6 | Vendor pricing pages (Apify, Bright Data, Zyte, Octoparse) | Section KQ2 links | not demand evidence | List prices, not buyer spend. · checked 2026-10-19 |
| 7 | Vendor claims ("Trusted by 50,000+ customers"; "91,000+ tools") | [Bright Data](https://brightdata.com/pricing); [Apify](https://apify.com/pricing) | not graded | Vendor marketing; not verified. · checked 2026-10-19 |

Counts: S = 0; A = 0; B = 1; C = 1; D = 0. The "A" bar is met only when a post shows a real budget and a real hire with a paid amount. None of the sampled posts meets it.

### Inferences
- Demand for this specific niche (maintenance retainers for marketing agencies) is currently unevidenced by this sample. The one item found is a data-business buyer with a one-off discovery budget.
- Any claim that agencies pay freelancers or tools to keep scrapers running should be labelled C until a hire or invoice is found. OPINION.

### Gaps
- Sample is one search (2 results), one Freelancer page with no structured parse, and zero Fastwork listings. Thai job boards not searched. No payment, invoice, or hire data obtained from any platform.
- Grading criteria applied as given in the brief; no external rubric.
