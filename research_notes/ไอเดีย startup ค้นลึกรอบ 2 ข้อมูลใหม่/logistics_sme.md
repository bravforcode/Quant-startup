# Thailand logistics: SME freight, cold chain, last-mile pain (as of 2026)

- Research date: 2026-10-20
- Scope: SME freight, cold chain, last-mile. Quick commerce excluded.
- Method: Exa web_search and web_fetch. WebSearch used as fallback for NESDC 2024 and cold-chain market size. The Exa connector reported ERR_PROXY_TUNNEL at startup, but search and fetch calls succeeded.
- Fetch failures: NESDC "Thailand's Logistics Report 2024" PDF (CRAWL_TIMEOUT) and NESDC article PDF (CRAWL_REDIRECT). 2024 figures below are from search excerpts only.
- Dates: publication dates from page metadata. "Undated" means no date was found on the page.

## Labels

- FACT: figure or statement read in a primary document or official page (or directly quoted from one).
- ESTIMATE: derived arithmetic from FACT figures, or a forecast or projection.
- OPINION: company, analyst, or blog claim with no disclosed method.
- UNVERIFIED: secondary citation, search excerpt only, undated, conflicting with another source, or primary not fetched.

---

## 1. Logistics cost as share of GDP and trucking scale

### 1a. Logistics cost to GDP (NESDC via NSO)

| Year | Total logistics cost (THB bn) | Logistics cost / GDP | Label | Source (URL, date) |
|---|---|---|---|---|
| 2019 | 2,254.2 | 13.4% | FACT | NSO Statistical Yearbook 2025, Table 15.17, https://www.nso.go.th/public/e-book/Statistical-Yearbook/SYB-2025_webPage/File%20SYB/2025/15/T%2015.17%202025.pdf (SYB 2025) |
| 2020 | 2,180.6 | 13.9% | FACT | same (SYB 2025) |
| 2021 | 2,268.2 | 14.0% | FACT | same (SYB 2025). SYB 2023 showed 2021 at 2,238.8 THB bn and 13.8%, so the series was revised: https://www.nso.go.th/public/e-book/Statistical-Yearbook/SYB-2023/515/ |
| 2022 | 2,438.1 | 14.0% | FACT | SYB 2025 (2022 is marked "p" = provisional) |
| 2023 | 2,527.4 | 14.1% | FACT | SYB 2025 (2023 is marked "e" = estimate) |
| 2024 | ~2,509.4 | ~13.5% | UNVERIFIED | NESDC Thailand's Logistics Report 2024 (published 2025-09), via WebSearch excerpt. PDF not fetched: https://www.nesdc.go.th/wordpress/wp-content/uploads/2025/09/logistics-2567-Full-Report-ENG-F.pdf |

Other reference points:

- 2017: 13.6%, per NESDC as cited in OECD. FACT (secondary). OECD, 2020-09 (date from URL): https://www.oecd.org/content/dam/oecd/en/publications/reports/2020/09/oecd-competition-assessment-reviews-logistics-sector-in-thailand_735f5484/a2dc2db0-en.pdf
- 2022: ttb analytics estimate of 14.1%. ESTIMATE. ttb, 2022-10-27: https://www.ttbbank.com/en/analytics/business-industry/transportation-telecom/20221028-ttb-analytics-logistics-cost-to-gdp
- Benchmarks cited by ttb (2021 data): US 8%, Europe 8.6%, Japan 8.5%, Asia-Pacific 12.9%. FACT as cited by ttb (2022-10-27, same URL).
- Government target of 11% of GDP by 2026, per WebSearch summary of NESDC material. UNVERIFIED (primary not fetched).

Cost components, 2019 to 2023 (NSO, same table):

- Transport cost: 1,113.7 (2019) to 1,195.1 THB bn (2023). FACT.
- Road within transport: 564.5 (2019), 493.8 THB bn (2023). FACT.
- Parcel services: 57.7 (2019) to 117.0 THB bn (2023). FACT. This is about 2.0x in four years. ESTIMATE (derived).
- Road share of 2023 transport cost: 493.8 / 1,195.1 = 41%. ESTIMATE (derived). Conflict: ttb (2022-10-27) states road is 49.7% of the transport cost structure. Different year and definition, so do not mix the two.

### 1b. Freight mode split (Office of Transport and Traffic Policy and Planning)

- Document: POTP Executive Summary, dated 2025-06-25 (from URL): https://www.otp.go.th/uploads/tiny_uploads/PDF/2568-06/POTP-25062025-ExecutiveSummaryReport_Eng.pdf
- 2022 freight: 88.31 million tons, 168,121 million ton-km. FACT.
- Road: 141,648 million ton-km (84.25%). Water: 22,011 (13.09%). Rail: 4,445. Air: 17. FACT.
- Road-to-rail and road-to-water shifts of 10% and 13% could cut transport cost to GDP by 5.0%. ESTIMATE (government analysis, same document).

### 1c. Truck fleet size

- DLT data as of 2024-07-31, reported 2024-08-17: about 1.2 million trucks registered for service in Thailand. Roughly 420,000 under "non-scheduled" (ไม่ประจำทาง) and roughly 820,000 under "private/personal" (ส่วนบุคคล). FACT as reported. The category mapping to for-hire freight is UNVERIFIED. Source: https://www.bangkokbiznews.com/business/economic/1140668
- OECD (citing Ken Research, 2018): 23,404 trucks in 2017. UNVERIFIED and not usable. It conflicts with the DLT figure, probably due to category definitions. OECD: https://www.oecd.org/content/dam/oecd/en/publications/reports/2020/09/oecd-competition-assessment-reviews-logistics-sector-in-thailand_735f5484/a2dc2db0-en.pdf
- Mordor Intelligence: median freight operator runs under five trucks; fragmented fleets. UNVERIFIED (secondary, undated): https://www.mordorintelligence.com/industry-reports/thailand-freight-and-logistics-market
- NSO Table 15.1 (vehicle registrations 2020 to 2024) covers cars and motorcycles only. It is not a truck count. FACT. https://www.nso.go.th/nsoweb/downloadFile/stat_main_nso/FgCt/file_th

---

## 2. Documented SME pain points

### 2a. Empty return trips (backhaul)

Thai figures (all UNVERIFIED because they come from a secondary slide deck, and the underlying studies were not fetched):

- Backhaul ratios cited for Thailand: 60% (Tanit Sorat, 2011), 86% (Peetijade and Bangviwat, 2012), 95% (Chanchaichujit et al., 2018). Different studies, years and methods. Source: Chanchaichujit slides, https://www.thailog.org/wp-content/uploads/2019/02/TILOX18.pdf (2019-02, from URL)
- Cross-country comparison in the same slides: Denmark 17%, Germany 25%, USA 28%, UK 29%, China 40%, Hong Kong 46%, Vietnam 70%, Malaysia 77%. UNVERIFIED (secondary).
- Annual economic loss from backhauling, Free Zone to Suvarnabhumi Airport: approximately THB 247 million, with driver 156, maintenance 69, and a third category at 22 (the column labels are garbled in extraction). UNVERIFIED. Same source.

Company and press claims:

- APX blog, 2022-11-01: "approximately 80% of trucks face empty or near-empty backhauls" in Thailand. OPINION (company marketing; no method given). https://apx.group/how-apx-tackles-empty-truck-problems/
- Deliveree (TechCrunch, 2022-06-26): pre-platform truck utilization of 40 to 50% called "above average"; up to 80% on platform. OPINION (company claim). https://techcrunch.com/2022/06/26/deliveree-is-smoothing-southeast-asias-bumpy-logistics-landscape/
- Ezyhaul CEO (The Loadstar, 2021-04-23): fragmented market with under-capacity and empty backhaul. OPINION. https://theloadstar.com/ezyhaul-shell-tie-up-the-latest-start-up-in-growing-asia-digital-road-freight-sector/

Measured Thai backhaul data for 2024 to 2026 was not found.

### 2b. Price opacity and cash flow

- Shell (quoted in The Loadstar, 2021-04-23): transporters face 45 to 90 day payment terms, with 20 to 25% of fuel spent up front. OPINION (company statement, not measured). https://theloadstar.com/ezyhaul-shell-tie-up-the-latest-start-up-in-growing-asia-digital-road-freight-sector/
- APX (Thai company site, undated): Thai trucking is "fragmented," with "lack of transparency," and logistics costs "up to 50%" higher than Europe or the US. OPINION. https://apx.group/apx-story/
- Mordor Intelligence (undated): SME carriers face tighter credit as banks favour lower-risk segments. UNVERIFIED (secondary, no figure). https://www.mordorintelligence.com/industry-reports/thailand-freight-and-logistics-market

No measured price-opacity data was found.

### 2c. Cold-chain loss rates

Measured (FACT for each study, with limited generalizability):

- Fresh vegetables, Northern Thailand to Central Thailand packing house, about 750 km, 17 to 18 hours transit. Loss 27 to 42% by weight at the packing house after cutting damage. Internal truck temperature 22 to 30 C, against a stated target of 5 C or below. Single-route case study; sample size not stated. Rattanawong and Ongkunaruk, 2018-03-01: https://doi.org/10.18502/kls.v4i2.1679
- Chinese cabbage, Thailand value chain: a head lost 44 to 66% of wet weight before reaching the consumer, mainly from trimming. Modern-retail-linked stakeholders trimmed 42% on average versus 18 to 24% for others. Ortiz-Gonzalo et al., Resources, Conservation and Recycling, 2021-06-25: https://doi.org/10.1016/j.resconrec.2021.105714

Official and secondary Thai figures (UNVERIFIED, undated or old):

- OAE, as cited by a DLT-linked PDF: 30% of Thai food loss is due to ineffective transport and storage. Undated: https://www.thaitruckcenter.com/tdsc/ViewFile?fname=FileReportdoc1936453525.pdf&fpath=FileReportdoc&id=980&sname=1936453525.pdf
- Thai post-harvest losses (Dept of Agriculture, cited in APEC Thailand report, Aug 2013): fruit 20 to 50%, vegetables 30%, rice 30%. UNVERIFIED (2013 data). https://studylib.net/doc/5574719/member-economy-voluntary-reports%E2%80%94thailand
- Thai MFA course outline (undated): perishable losses 20 to 40%, roughly THB 20 billion a year. UNVERIFIED. https://image.mfa.go.th/mfa/0/GH2PYnujXi/%E0%B9%80%E0%B8%AD%E0%B8%81%E0%B8%AA%E0%B8%B2%E0%B8%A3/Course_Outline_-_Prevention_of_Postharvest_Loss_in_the_Value_Chain_of_Agricultural_Crop.pdf
- Global 45% fruit and vegetable loss figure (FAO SAVE FOOD). The Kitinoja white paper says many widely quoted losses come from unclear methods, and that surveys underestimate measured losses. UNVERIFIED for Thailand. https://mavunolab.org/wp-content/uploads/2024/03/PEF-White-Paper-15-02-PHL-FV-measurement.pdf (uploaded 2024-03, from URL)

Regulatory standard for cold chain:

- DLT "Q Cold Chain" standard, accredited under DLT announcement B.E. 2562 (2019). Temperature bands: fresh fruit and vegetables 0 to 15 C; chilled 0 to 8 C; frozen -18 C or below. FACT (undated official manual): https://www.thaitruckcenter.com/tdsc/ViewFile?fname=FileReportdoc1936453525.pdf&fpath=FileReportdoc&id=980&sname=1936453525.pdf

No 2024 to 2026 measured Thai cold-chain loss rate for SMEs was found.

### 2d. Driver shortage

- DLT announced 10,000 free heavy-vehicle licence training places to address a shortage of heavy truck drivers. FACT (announced policy). The shortage size is not quantified and is UNVERIFIED. Thairath, 2025-10-04: https://www.thairath.co.th/news/governmentpolicy/2887021 . Daily News, 2025-10-04: https://www.dailynews.co.th/news/5174177/
- DLT and Dept of Skill Development MOU on driver training, linked to Q Mark and Q Cold Chain standards. FACT. Thailandplus, 2025-12-15: https://www.thailandplus.tv/archives/982099 . Trans Time News, 2025-12-17: https://www.transtimenews.co/24005/
- Foreign drivers: DLT draft rule stops accepting international driving permits for temporary Thai licences; foreigners must pass a written test. FACT (draft as reported; final status UNVERIFIED). The Nation, 2025-06-20: https://www.nationthailand.com/blogs/news/general/40051501
- Driver-hours rule (see Section 4). The operator federation asked for a 12-hour daily limit instead of 10 hours. Reported as a request, not a decision. FACT. Infoquest, 2026-01-17: https://www.infoquest.co.th/2026/561871

### 2e. Price war in last mile (regional)

- Ninja Van CEO described regional logistics as "a race to the bottom" (Tech in Asia, May 2025, quoted by VOV). Ninja Van 2023 revenue fell 7%, parcel volume fell nearly 20%, and operating losses widened 32% (Bloomberg, cited by VOV). FACT as reported. VOV, 2025-09-04: https://english.vov.vn/en/economy/ninja-van-halts-express-logistics-operations-in-vietnam-post1227579.vov
- Ninja Van suspended express operations in Vietnam, per a customer email dated 2025-09-03. FACT (Vietnam only; Thailand not affected by this report).

---

## 3. Platforms, startups, and funding or shutdowns

### 3a. Thailand freight and logistics platforms

| Company | Model | Funding (reported) | Date | Status (2026) | Label | Source |
|---|---|---|---|---|---|---|
| APX (Asia Pallet Express / APX Solutions) | LTL pallet network, hub-and-spoke, Palli AI platform | ORZON pre-Series A (2023-07-14). ADB Ventures, ORZON, WV Fund II (2024-02-02, amount not in excerpt). SBI Ven Capital (2024-08-02). Amounts not disclosed in the excerpts read. | 2023 to 2024 | Active. LinkedIn post dated 2026-07-29 describes domestic service in TH, MY, SG. Revenue (USD 460k in Nov 2023) and volume (~27,000 pallets, 90+ clients) are company-reported. | Funding: FACT. Metrics: OPINION (company). | https://ventures.adb.org/apx-accelerates-growth-with-adb-ventures-funding-eyes-singapore-and-malaysia-for-2024-launch/ (2024-02-02) ; https://www.thaipr.net/en/logistics_en/3503159 (2024-08-02) ; https://apx.group/apx-story/ ; https://linkedin.com/company/apxsolutions |
| Deliveree | On-demand truck booking, marketplace | Series C USD 70M, total USD 109M (TechCrunch) | 2022-06-26 | Not verified for 2026. Present in ID, PH, TH as of 2022. | Funding: FACT as reported. 100k drivers, 20% commission: OPINION (company). | https://techcrunch.com/2022/06/26/deliveree-is-smoothing-southeast-asias-bumpy-logistics-landscape/ |
| Giztix | Road freight marketplace (Bangkok, founded 2015) | Total ~USD 11.65M. Series B Nov 2021, ~USD 10M led by Bualuang Ventures and WHA. | 2021-11-17 | Not verified for 2026. | UNVERIFIED (aggregator data) | https://www.caplight.com/company/giztix ; https://tracxn.com/d/companies/giztix/__nMNFE9nF6LPyWYlEaohP_5W4qdPFaDqcnwpYxKBRCBI |
| 360TRUCK (Bangkok, founded 2018) | Freight booking marketplace, backhaul reduction | Total USD 560k, Series A 2022-08-02 | 2022 | Not verified for 2026. Caplight reports monthly visitors 11.1K as of 2025-11-07. | UNVERIFIED (aggregator) | https://www.caplight.com/company/360truck |
| Ezyhaul (Singapore, 2016; TH, MY, PH, ID, IN) | Digital road freight marketplace | USD 16M in 2019. Shell partnership 2021. | 2019 to 2021 | Not verified for 2026. | FACT (funding as reported by The Loadstar) | https://theloadstar.com/ezyhaul-shell-tie-up-the-latest-start-up-in-growing-asia-digital-road-freight-sector/ |
| eTrucknow (Kuehne+Nagel) | Road freight platform, TH and SG | Corporate | 2021 | Not verified for 2026. | FACT (launch as reported, 2021) | https://theloadstar.com/ezyhaul-shell-tie-up-the-latest-start-up-in-growing-asia-digital-road-freight-sector/ |
| Karzo (Bangkok HQ; MM, KH, SG; founded 2016) | B2B logistics platform connecting truck owners | Total USD 810k (LinkedIn snapshot, aggregator) | Seeds 2019 to 2024 | BOI company status announced 2026-01-08 (LinkedIn post). | UNVERIFIED (funding). BOI status: FACT (self-reported). | https://linkedin.com/company/karzologistics |
| MAKESEND Express (Bangkok, founded 2020) | Same-day parcel delivery, including same-day cold delivery | Seed 2021-03-01 (LinkedIn) | 2021 | Not verified for 2026. | Funding: UNVERIFIED. "Only scheduled parcel company with same-day cold delivery" and 99.5% on-time: OPINION (company). | https://linkedin.com/company/makesend |

### 3b. Cold-chain players in Thailand

- Kerry Express and Betagro JV "Kerry Cool" cold delivery platform. Board approved 2021-10-08. 60/40 split; registered capital THB 1M, planned THB 50M. Partial service late 2021, full service planned Q2 2022. FACT (announced plans). Status in 2026 not verified. Bangkok Biznews, 2021-10-11: https://www.bangkokbiznews.com/business/965068
- Linfox Thailand compact refrigerated fleet (0 to -25 C, GPS and live temperature monitoring). FACT (company announcement). 2024-12-18: https://www.linfox.com/compact-cold-chain-fleet-in-thailand/
- MPColdchain (Bangkok, Chiang Mai, Lamphun, Phuket, Hat Yai). Coordinates chilled, frozen and general cargo through partner trucks; GPS and temperature logger on every truck; cargo insurance from THB 1M. FACT (self-described service). Undated. Funding not found. https://mpcoldchain.asia/en/
- ShipD2D (Bangkok, founded 2024; temperature-controlled import for F&B brands). Team of 2 on LinkedIn snapshot. Accelerator selections in 2026 (LinkedIn posts through 2026-08-25). FACT (self-reported). https://linkedin.com/company/shipd2d

No Thai cold-chain startup with a reported shutdown was found in this search.

### 3c. SEA freight and logistics shutdowns and distress (not all Thai)

| Company | Country | Reported event | Reported reason | Label | Source |
|---|---|---|---|---|---|
| Ritase | Indonesia | Tech assets bought by Meratus, reported 2023-11-24 (DealStreetAsia). Distress sale after layoffs (Tech in Asia, through 2023). Total funding about USD 12.9M. | Mass layoffs; distress sale. No closure notice from company. | UNVERIFIED (secondary database citing DealStreetAsia) | https://1001startup.id/closed |
| Kargo Technologies | Indonesia | Conflicting. UnicornBurn (2026-05-28) says closed 2023 after USD 31M raised, reason competition from GoBox and GrabTruck (OPINION). Tech Collective (2025-01-24) says Kargo acquired TheLorry (Malaysia) in 2024. Indonesia-agent "2025 edition" lists Kargo as active with a USD 30M round. | Competition (per UnicornBurn, OPINION) | UNVERIFIED (conflicting; do not treat as closed without a primary source) | https://unicornburn.com/autopsy/kargo-trucking-indonesia ; https://techcollectivesea.com/2025/01/24/southeast-asia-logistics-funding-indonesia/ ; https://indonesia-agent.com/top-logistics-startups-in-indonesia-to-watch-this-year/ |
| EdenFarm | Indonesia | B2B produce supply. Paused operations 2024-02-29; distress sale talks April 2024 (DealStreetAsia). Mass layoffs 2023. | Layoffs; no completed deal reported. | UNVERIFIED (secondary database citing DealStreetAsia) | https://1001startup.id/closed |
| Pitik | Indonesia | Agritech broiler platform. Layoffs of more than half of staff April 2024; ceased operations, reported 2024-07-13 (DealStreetAsia). USD 14M Series A (2022-05). | Not stated in excerpt. | UNVERIFIED | https://1001startup.id/closed |

### 3d. Funding climate (SEA)

- DealStreetAsia State of Logistics SEA 2024, as summarised by Tech Collective (2025-01-24): 9M 2024 deals 19 (+21.4% YoY), deal value USD 95.8M (+83.4%). Indonesia held 37.7% of deal volume and 71% of value (Jan 2020 to Sep 2024). Later-stage share of inflows fell from 93.6% (2021) to 37.7% (2023), with no late-stage deals in 9M 2024. FACT (secondary). https://techcollectivesea.com/2025/01/24/southeast-asia-logistics-funding-indonesia/

### 3e. Stated causes of failure (pattern)

- Competition from conglomerate platforms (Kargo, per UnicornBurn). OPINION.
- Overinvestment during COVID and a funding winter (Ninja Van CEO, quoted by Tech Collective). OPINION (CEO).
- Mass layoffs followed by distress sales (Ritase, EdenFarm). UNVERIFIED.
- Thin margins, and "bare" low-price competition in parcel. OPINION (Ninja Van CEO, via VOV).

These reasons are not measured causes. The pattern is drawn from a small set of secondary sources.

---

## 4. Regulatory changes affecting trucking or cold chain (2025 to 2026)

| Date | Change | Status | Label | Source |
|---|---|---|---|---|
| 2025-06-20 | DLT draft: international driving permits no longer accepted for temporary licence; foreigners must pass a written test | Draft, public comment (as reported) | FACT (draft); final UNVERIFIED | https://www.nationthailand.com/blogs/news/general/40051501 |
| 2025-10-01 | New DLT director-general took office; eight priority projects announced, including GPS two-way upgrade, digital transport inspection, DLT One App, 10,000 free heavy-licence training, Surat Thani freight station | Announced policy | FACT (announcement) | https://www.thairath.co.th/news/governmentpolicy/2887021 ; https://www.dailynews.co.th/news/5174177/ |
| 2025-11-17 (date from URL path, UNVERIFIED) | DLT policy direction document: graduated driver licensing; power to refuse or revoke licences for repeated unsafe behaviour; transport operator licences on a concession model (UK example, 21-year term with reviews); limits on red plates; AI speed and plate detection; digital vehicle registration book | Policy proposals | FACT (document contents); implementation UNVERIFIED | https://web.dlt.go.th/dlt-direction/media/attachments/2568/11/17/final-dlt-policy.pdf |
| 2025-12-15 | DLT and Dept of Skill Development MOU on driver training; tied to Q Mark and Q Cold Chain | Signed | FACT | https://www.thailandplus.tv/archives/982099 ; https://www.transtimenews.co/24005/ |
| Around New Year 2026 (reported 2026-01-17) | Driver-hours enforcement: max 4 hours continuous driving, at least 30 minutes rest, max 10 hours driving per day. Enforcement is warning-first. Operators cite too few rest areas on secondary roads. DLT says accidents involving freight and public vehicles fell more than 30% versus the same period in 2025. | Enforced, warning-first | FACT (rule); 30% accident claim is an official claim, UNVERIFIED | https://www.infoquest.co.th/2026/561871 |
| 2026-01-12 | Truck operator licence applications and renewals via the "ทางรัฐ" government app (headline only, body not read) | Reported | UNVERIFIED (headline only) | https://www.prachachat.net/hilight-prachachat/news-1949218 |
| 2026-03-11 (reported 2026-03-30) | DLT policy items: operator licence issuance, Q Mark upgrade, preparing freight stations, for-hire vehicle registration via app, AI-based inspection | Policy statements | FACT (statements) | https://www.springnews.co.th/news/pr-news/862732 |
| Proposal (2024-08-17 report) | Bangkok truck access zoning (NESTA/OTP proposal): trucks allowed in the Ratchada ring road zone 21:00 to 06:00 from 2023 to 2027; from 2028 to 2032, Euro 5 and below diesel trucks barred from the orange zone at peak hours; from 2033, only Euro 5+, EV and clean-energy trucks in the ring zone at night | Draft plan. Adoption not verified. | FACT (as proposed); adoption UNVERIFIED | https://www.bangkokbiznews.com/business/economic/1140668 |

Cold-chain standard: DLT Q Cold Chain (see Section 2c). Government targets for transport and logistics (Action Plan Phase 1 2023 to 2027, Phase 2 2028 to 2037): see https://www.otp.go.th/uploads/tiny_uploads/PDF/2568-06/POTP-25062025-ExecutiveSummaryReport_Eng.pdf (2025-06-25).

---

## 5. Conflicts and data gaps

Conflicts (do not mix without resolving):

1. NESDC 2023 logistics ratio: 14.1% (SYB 2025, FACT) vs 14.2% (NESDC 2024 report, per WebSearch excerpt, UNVERIFIED). The series was revised.
2. Road share of transport cost: 41% (NSO 2023, derived, ESTIMATE) vs 49.7% (ttb 2022, FACT as cited). Different years and definitions.
3. Truck count: ~1.2M registered (DLT 2024 as reported, FACT) vs 23,404 (OECD citing Ken Research 2017, UNVERIFIED). Likely different categories.
4. Kargo status: closed 2023 (UnicornBurn, 2026-05-28) vs active with 2024 acquisition (Tech Collective, 2025-01-24).
5. Cold-chain market size: USD 1.21B (Nexdigm) vs USD 2.31B (Mordor / ResearchAndMarkets) for 2025. UNVERIFIED market-research estimates. Not used. Nexdigm: https://www.nexdigm.com/market-research/report-store/thailand-cold-chain-market-research-report/ ; ResearchAndMarkets: https://www.researchandmarkets.com/reports/5986192/thailand-cold-chain-logistics-market-share

Data gaps (not found in this pass):

- Measured empty-run or backhaul ratio for Thailand, 2024 to 2026.
- Official count of for-hire heavy trucks (DLT Land Transport Act series, not fetched).
- Measured SME cold-chain loss rate, 2024 to 2026.
- Quantified driver shortage (number of vacancies or missing drivers).
- Thai cold-chain startups with funding or shutdown events.
- 2026 status of Deliveree, Giztix, 360TRUCK, Ezyhaul, Kerry Cool, MAKESEND.
- NESDC 2024 PDF (fetch failed; figure from search excerpt only).

Not used because they are unsourced or opinion-only: market-size estimates from market-research firms, the 50% Thai-vs-EU/US cost gap (APX), and the 80% empty-backhaul figure (APX) except as a labelled company claim.
