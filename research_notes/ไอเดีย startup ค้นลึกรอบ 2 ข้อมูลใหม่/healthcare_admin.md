# Administrative pain in Thai private clinics, dental/aesthetic clinics and small hospitals (as of 2026)

Research date: 2026-10-20. Scope: scale, payer/claim friction, records and data rules, and existing clinic-management software (Thailand and SEA).

Labels used:
- **FACT**: stated by the cited source (usually a government page, regulator, or news report that quotes an official). Not checked against the raw dataset unless noted.
- **ESTIMATE**: my arithmetic on cited figures.
- **OPINION**: vendor marketing, blog, or commentator characterization.
- **UNVERIFIED**: secondary-only, date or scope unclear, internally inconsistent, or not found in a primary source.

No business ideas are recommended or ranked in this file.

---

## 0. Key takeaways (short)

1. Clinic counts exist but do not reconcile. DHSS-derived totals range from ~20,000 "clinical" clinics (2026 statement) to 40,552 "private clinics" (2024). Dental clinics have a clean official series (6,639 at end-2023). Aesthetic clinics: DHSS says ~9,500 (2026 statement), but no primary table was found.
2. Claim rejection or denial rates: no measured figure was found for SSO, NHSO or private insurers. The widely quoted "85% preventable" figure has no primary source.
3. Payer rules are fragmented: SSO private-hospital caps (e.g. 1,000 baht outpatient, 700 baht/day room), NHSO e-claim timeliness tiers, and OIC co-pay rules for private health insurance since 20 March 2025.
4. Health data is "sensitive personal data" under PDPA s.26. Enforcement is live: a private hospital was fined 1.2M baht in 2025 after 1,000+ patient record pages leaked during destruction. A PDPC healthcare-specific draft guideline (July 2026) explicitly covers aesthetic clinics and vendors.
5. Clinic software is crowded and cheap at the entry tier (about 1,490 to 2,990 THB/month). Public funding data is thin. The one clear exit found is JERA Cloud (acquired by LINE MAN Wongnai, announced August 2025).

---

## 1. Scale: number of clinics and hospitals

| # | Claim | Value | Label | Source URL | Published / data date |
|---|---|---|---|---|---|
| 1.1 | Private clinics, all types, nationwide (licensed, per DHSS) | 40,552 in 2024 (+6,389 vs 2022). Bangkok 8,273; upcountry 32,279 | FACT (as reported) | https://www.nationthailand.com/health-wellness/40056407 | Article 2025-10-06, citing DHSS. Dataset: https://gdcatalog.go.th/en/dataset/gdpublish-dataset-5-1-03 (CSV, last updated 2025-08-06, years 2565-2568; CSV not downloaded, so the number is from the press report) |
| 1.2 | Licensed clinical clinics (คลินิกเวชกรรม) nationwide | "about 20,000", of which about 9,500 are aesthetic clinics ("nearly 50%") | FACT (as stated by DHSS deputy DG in press). Scope conflicts with 1.1 | https://www.bangkokbiznews.com/health/public-health/1231744 | 2026-04-29 |
| 1.3 | In Bangkok, share of new clinic-opening applications that are aesthetic | "80%" | FACT (as stated in the same article) | same as 1.2 | 2026-04-29 |
| 1.4 | Earlier aesthetic clinic count (trend anchor) | 1,458 aesthetic-service clinics out of 10,904 general and specialist clinics | FACT (dated) | https://hss.moph.go.th/show_topic.php?id=393 | 2016-06-02 |
| 1.5 | Implied growth in aesthetic clinics 2016 to 2026 | 1,458 to about 9,500 (about 6.5x) | ESTIMATE. Definitions may differ between the 2016 and 2026 statements | derived from 1.2 and 1.4 | - |
| 1.6 | Private hospitals, licensed (DHSS) | 440 in 2024 (411 in 2022). Bangkok 145; upcountry 295 | FACT (as reported) | https://www.nationthailand.com/health-wellness/40056407 | 2025-10-06 |
| 1.7 | Private hospitals with inpatient beds (MoPH resource report) | 347 hospitals; 35,620 private beds (2024 data year). 349 hospitals and 35,494 beds in the prior year's report | FACT | https://spd.moph.go.th/wp-content/uploads/2025/07/Report-Health-Resource-2024.pdf (2024 report); https://spd.moph.go.th/wp-content/uploads/2024/07/Report-Health-Resource-2023-670716.pdf (2023 report) | Report published 2025-07; prior 2024-07 |
| 1.8 | Private-bed growth 2023 to 2024 | +126 beds (about +0.35%) | ESTIMATE | derived from 1.7 | - |
| 1.9 | Data quality caveat on the MoPH resource report | Only 464 of 14,080 units reporting to GIS Health were private (3.3%). The report itself advises users to check data before use. Reporting is voluntary | FACT | same MoPH 2024 report | 2025-07 |
| 1.10 | Dental clinics, total | 6,639 at end-2023 (Bangkok 1,871; regions 4,768). Series: 2,538 at end-2014 to 6,639 at end-2023 | FACT | https://dentalcouncil.or.th/upload/files/pVimkvf1D0WKzMAYgBtxolOGUQ3R7uhw.pdf (Dental Council statistics page: https://dentalcouncil.or.th/Pages/Stat) | Data as of 2024-02-28. The series labelled "end of year 2566" (Thai BE = 2023 CE). No later clinic count was found |
| 1.11 | Dental clinic growth per year, 2014-2023 | about +456 per year on average; +658 in the last year (5,981 to 6,639) | ESTIMATE | derived from 1.10 | - |
| 1.12 | Broad "beauty" business registrations (DBD) | 6,621 registered businesses (5,994 limited companies). Includes specialised clinics, dental clinics AND general beauty/salon services. Not a clinic count | FACT (as reported). As-of date UNVERIFIED | https://www.nationthailand.com/business/economy/40046901 | 2025-03-01. New registrations 1,135 in 2024 (same article) |
| 1.13 | Gap | No clean count of aesthetic clinics that reconciles with 1.1, and no official breakdown of 40,552 by clinic type | UNVERIFIED (not found) | - | - |

---

## 2. Insurance and payer claim friction

### 2a. Social Security Office (SSO, สปส.)

| # | Claim | Label | Source URL | Date |
|---|---|---|---|---|
| 2.1 | Private hospital, outpatient: reimbursable up to 1,000 baht per visit. Extra items (blood, anti-tetanus, rabies vaccine/serum, ultrasound for acute abdomen, CT up to 4,000 and MRI up to 8,000, D&C for post-partum/miscarriage bleeding, resuscitation up to 4,000, observation 3+ hours up to 200) | FACT (SSO-derived pages) | https://portal.info.go.th/sso-medical-expenses-reimbursement/ and https://lb.mol.go.th (rate table in this page cites rates "as of 6 March 2015") | Article 2022-04-27; rate table dated 2015. Current validity UNVERIFIED |
| 2.2 | Private hospital, inpatient: room and food up to 700 baht/day; ICU up to 4,500/day; non-ICU treatment up to 2,000/day; major surgery 8,000-16,000 per procedure depending on duration; lab/X-ray up to 1,000 per item | FACT (same sources) | same as 2.1 | same as 2.1 |
| 2.3 | Emergency claims: submit reimbursement within 90 days of payment, with medical certificate, receipt, claim form SSO 2-01 and bank book copy | FACT | https://portal.info.go.th/sso-medical-expenses-reimbursement/ | 2022-04-27 |
| 2.4 | Appeal against a benefit decision within 30 days | FACT | https://www.sso.go.th/wpr/main/privilege/... (SSO emergency-benefit page, undated) | undated |
| 2.5 | High-cost treatments at contracted hospitals: SSO fixed reimbursement of 12,000 baht per patient per year. Private Hospital Association reportedly asked for 15,000 baht. Article text is partly reversed in the scrape, so the 15,000 detail is UNVERIFIED | FACT (headline figure); UNVERIFIED (second figure) | https://www.bangkokpost.com/thailand/general/2883148/new-cap-for-private-hospital-claims | 2024-10-14 |
| 2.6 | Private hospitals reportedly opting out of SSO because low reimbursement causes losses. Number of hospitals affected not confirmed from the scrape | UNVERIFIED (counts) | https://www.bangkokpost.com/thailand/general/2871333/private-hospitals-opting-out-of-govt-health-scheme | 2024-09-24 |
| 2.7 | Split billing at private hospitals: SSO pays the covered portion, and the patient pays the excess, which may be claimed from a private insurer. Excess claims need itemised receipt, itemised statement, doctor's certificate with diagnosis, and claim form. Insurer processing reportedly 7-15 working days | OPINION (blog). Not verified against insurer rules | https://prakun101.com/claiming-medical-excess-sso/ | 2026-02-06 |
| 2.8 | Older SSO complaints data: 676 medical-service complaints in 2011, 58.44% closed. SSO moved to DRG-based payment to hospitals | FACT (dated) | https://www.sso.go.th/wpr/assets/upload/files_storage/sso_th/740bdcd828b7585546606ebfdef304fd.pdf | 2011 (BE 2554). Old, use only as historical context |

### 2b. NHSO / UCS (สปสช.)

| # | Claim | Label | Source URL | Date |
|---|---|---|---|---|
| 2.9 | Late e-claim submission reduces payment: submitted up to 30 days late, 95% of reimbursed cost paid; up to 60 days late, 90%; up to 330 days late, 80% | FACT (as presented). Presentation is undated; it cites a FY2017 survey and a 2018 target | https://www.nhso.go.th/en/resources-center/documents/presentations/55236-ucs-claim-presentation/file | presentation undated, c. 2018 |
| 2.10 | NHSO on-time payment target achieved in 2018 (98.4%). Satisfaction with e-Claim FY2017: 89.2% | FACT (as presented) | same | c. 2018 |
| 2.11 | Appeals on e-Claim allowed within 1 year after statement is issued; workflow is offline export, edit, re-import | FACT | same | c. 2018 |

### 2c. Private health insurance (OIC)

| # | Claim | Label | Source URL | Date |
|---|---|---|---|---|
| 2.12 | From 20 March 2025, insurers may apply co-payment to renewing individual health policies after repeated claims. Case 1: inpatient simple illness, 3+ claims and total claim ratio 200%+, co-pay cap 30%. Case 2: inpatient excluding critical illness and major surgery, 3+ claims and ratio 400%+, cap 30%. Both cases: cap 50%. Rates are caps set by each insurer | FACT (as reported, citing OIC) | https://media.milliman.com/v1/media/edge/images/millimaninc5660-milliman6442-prod27d5-0001/media/Milliman/PDFs/2025-Articles/10-13-25_SEA-Health-Newsletter_October-2025.pdf; secondary: https://www.thailandstarterkit.com/health/dispute-appeal-rejected-health-insurance-claim-thailand/ | Milliman 2025-10-13; Starter Kit 2026-09-24 |
| 2.13 | Medical trend about 15% in 2024 (claims inflation outpacing premiums) | FACT (as stated by Milliman, citing OIC) | same Milliman PDF | 2025-10-13 |
| 2.14 | Private hospital medical inflation about 15% per year vs general inflation 3-5% | OPINION/FACT (attributed to the Private Hospital Association president) | https://www.nationthailand.com/health-wellness/40056407 | 2025-10-06 |
| 2.15 | Common private-insurance denial reasons: missing paperwork, no diagnosis on certificate, late filing (often 30-90 days), pre-approval skipped, network confusion | OPINION (broker/blog sources). Not measured | https://www.thailandstarterkit.com/health/dispute-appeal-rejected-health-insurance-claim-thailand/ ; https://expatcompares.com/can-i-contest-my-health-insurance-claim-in-thailand/ | 2026-09-24; 2025-04-11 |
| 2.16 | "85% of claim rejections are preventable paperwork errors" (ASEAN NOW forum post, citing unnamed "research") | UNVERIFIED. No primary source. Do not use as fact | https://aseannow.com/topic/1355605-how-to-avoid-health-insurance-claim-denials-in-thailand/ | 2025-03-24 |

### 2d. Measured claim rejection rates

**Not found.** Searches did not return any published rejection, denial or delay rate for SSO, NHSO, OIC-regulated insurers, or private clinics. Any future figure would need an FOI request or a direct data source (e.g. SSO catalog dataset "ข้อมูลรพ. เบิกค่ารักษา", which is listed but has no description or statistics in the metadata: https://catalog.sso.go.th/en/dataset/stg_t_hospital_application_claim, created 2024-08-07, updated 2025-11-27).

---

## 3. Records, data protection and regulator rules

| # | Rule or claim | Label | Source URL | Date |
|---|---|---|---|---|
| 3.1 | PDPA s.26: health data is sensitive personal data. Collection requires explicit consent unless an exception applies, e.g. medical diagnosis, treatment, health-care management (s.26(5)(a)); social security or national health security (s.26(5)(c)); or public-health interest (s.26(5)(b)) | FACT (unofficial translation; Thai text is authoritative) | https://www.mwit.ac.th/html/mwitDoc/PDPA/1-2_PDPA-2019.pdf; https://www.mdes.go.th/law/detail/1905-Personal-Data-Protection-Act--B-E--2562--2019- | Gazette 2019-05-27; translation corrected 2021-06-20 |
| 3.2 | PDPA s.37(1): security measures; s.37(3): erase or destroy data when retention ends; s.37(4): notify the Office of a personal data breach within 72 hours where feasible | FACT | same as 3.1 | same as 3.1 |
| 3.3 | PDPA s.40: processors act only on the controller's instruction, must keep security measures and records, and the controller must have a written agreement with them (DPA) | FACT | same as 3.1 | same as 3.1 |
| 3.4 | Penalties: administrative fine up to 5M baht; criminal up to 1 year imprisonment and/or 1M baht fine; civil liability with punitive damages | FACT (as summarized by law firm) | https://www.lexology.com/library/detail.aspx?g=19f4e3df-4b1b-4db3-8806-ddc505be443b | 2025-03-17 |
| 3.5 | Enforcement: a private hospital was ordered to pay 1.2M baht after 1,000+ patient record pages leaked during the destruction process. Photos of snack bags made from record sheets spread on social media. MoPH then issued 6 measures, including DPA and NDA for external shredding contractors and a documented destruction policy | FACT (as reported; PDPC action per Thai PBS) | https://www.thaipbs.or.th/news/content/355090 | 2025-08-06 |
| 3.6 | Records retention: DHSS states that under the 2002 ministerial regulation on clinician and patient documents, medical records must be kept in auditable form for at least 5 years from creation. Breach can be an offense under the Private Hospital Act B.E. 2541 (up to 1 year and/or 20,000 baht fine). Excess retention can also breach PDPA if data leaks | FACT (as stated by DHSS) | https://hss.moph.go.th/show_topic.php?id=5991 | 2024-05-14 |
| 3.7 | Public-sector (subdistrict health-promotion hospital) standard: keep records permanently for living patients; deceased patients' records kept 10 years (natural death) or 20 years (unnatural death). Applies to public PHC, not private clinics. Reference only | FACT (public standard, BE 2559) | https://spd.moph.go.th/wp-content/uploads/2025/09/111111.pdf | standard year BE 2559 (2016) |
| 3.8 | Medical Council notice 54/2563 on telemedicine and online clinics: must use information systems with international security standards, identity verification, and PDPA-consistent controls. AI used with telemedicine must comply with product law. Online clinics must operate through a licensed facility | FACT | https://www.tmc.or.th/download/%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%B2%E0%B8%A8%20%E0%B9%82%E0%B8%97%E0%B8%A3%E0%B9%80%E0%B8%A7%E0%B8%8A%E0%B8%81%E0%B8%A3%E0%B8%A3%E0%B8%A1%202563.PDF | Royal Gazette 2020-07-21; effective 90 days later |
| 3.9 | Medical Council ethics code 2565 (article 17) and National Health Act B.E. 2550 (s.9) cited for confidentiality of medical records | FACT (as cited by Thai PBS) | https://www.thaipbs.or.th/news/content/355090 | 2025-08-06 |
| 3.10 | PDPC draft healthcare guideline (public consultation). Scope: 8 categories including hospitals and clinics, aesthetic clinics, health spas, telemedicine, pharmacies, home and elderly care, and cross-sector support (HR, IT, finance, customer service, cybersecurity). Expects DPAs with vendors. Cross-border transfers (overseas cloud, regional EMR) scrutinised. Before/after photos likely require explicit consent. PDPA consent must be separate from clinical consent | FACT (as summarized by law firm). Primary draft not read. Final status UNVERIFIED | https://www.hlc.com/en/publications/thailand-pdpc-consults-on-first-healthcarespecific-data-protection-guideline | 2026-07-09 |
| 3.11 | Chambers 2026 guide: PDPA processing of health data permitted for medical purposes and public health if authorised by law and with safeguards | FACT (secondary) | https://practiceguides.chambers.com/practice-guides/data-protection-privacy-2026/thailand | 2026 edition, undated |
| 3.12 | Gap: no Medical Council or DHSS rule found that certifies or specifies EMR software. ETDA publishes an e-Medical Record standard page (undated; not fully read) | UNVERIFIED (not found) | https://www.etda.or.th/th/Our-Service/Standard-(1)/Certifications/Example-1/Electronic-list.aspx | undated |

Implication for software vendors (FACT-based reading of 3.1-3.10, not a legal opinion): a vendor that stores clinic records acts as a PDPA processor. It needs a DPA, security controls, breach notice within 72 hours, cross-border transfer checks, and consent flows for photos and marketing.

---

## 4. Clinic-management software (Thailand and SEA)

Prices are monthly list prices in THB as published on vendor pages, not verified by invoice. Pages are undated unless stated.

| Vendor | Market and scope claims | Published tiers (THB/month) | Funding | Sources and dates | Labels |
|---|---|---|---|---|---|
| **JERA Cloud** (Lamunpun IT / ละมุนภัณฑ์ไอที; products JERA Cloud, JERA Dent, Sherwe) | Founded 2017. Beauty and dental clinic POS and management. 1,700+ locations (press); "2,000+ branches" (company site) | Not in sources reviewed | Acquired by LINE MAN Wongnai (announced August 2025). Secondary article says the company grew organically without outside investors. Deal value not disclosed in sources reviewed | https://www.padmel.com/archives/59301 (2025-08-31); https://www.longtunman.com/62338 (2025-09-12); https://www.lamunpunit.com/ (undated) | Acquisition: FACT. Market-leader and "no investors": OPINION. Revenue figures UNVERIFIED (article gives both 20,000 and 26,000 million baht) |
| **DoctorEase** (Atiz Innovation Co., Ltd.; brands Dr.Ease / EaseCare; Bangkok) | Beauty, dental, ENT, GP, psychiatry and other clinics. OPD paperless, POS, membership, LINE CRM, Thai tax documents. Company says it has been in hospital IT since 2017 | Starter 2,900 (package page) vs 2,590 (Thai pages). Standard 5,900. Elite/Pro 10,900 | Tracxn profile: unfunded; founded 2020; reported revenue 18.9M THB (Dec 2022) for linked entity Etiz Innovation. Founding date conflicts with company claim | https://doctorease.co/en/package/ (undated); https://doctorease.co/ (undated); https://software-listing.com/tools/doctorease (verified Aug 2026); https://tracxn.com/d/companies/doctorease/... (updated 2025-04-11) | Prices FACT as published, with a discrepancy. Founding date and revenue UNVERIFIED |
| **EMRPad** (emrpad.com) | 9 specialty modules (general, dental, aesthetic, paediatrics, OB-GYN, eye, physio, Thai medicine). Smartcard reading, ICD-10, SOAP, LINE, eClaim 16-file, PDPA consent | Solo 1,490; Growing (2-5 doctors) 2,990; Multi-branch (up to 5 branches) 4,990. 30-day trial | Not found | https://emrpad.com/ (undated) | Prices FACT as published. Feature claims OPINION (marketing) |
| **HexaHealth** (hexahealths.app) | Aesthetic, dental, internal medicine, spa, elderly care, hospital clinics. 20+ modules, AI scribe, PDPA-compliant claim, REST API | Free tier; Growth 1,490; Professional 3,990 | Not found | https://hexahealths.app/clinic (undated) | Prices FACT as published. Claims OPINION |
| **ClinicOS by Kiddung** | Aesthetic clinics. Lead to close, OCR of payment slips with human approval, commissions, stock, multi-branch. Invitation-only paid pilot | Core 2,490; Growth 4,990; Scale 6,990. Founding-clinic promo 1,990 for first 10 clinics (price lock 12 months). Setup 4,900 one-time | Not found | https://kiddung.com/ (undated) | Prices FACT as published. Pilot status FACT |
| **AirClinic** (บริษัท แอร์ กรุ๊ป โฮลดิ้ง จำกัด) | "AI operating system" for aesthetic and wellness clinics. Chat, AI agent, booking, EMR, payments (Beam, card fee from 1.8%), accounting | Not shown in the result | Not found | https://air.clinic/ (undated) | "30+ clinics across SEA" = company claim, OPINION. Payment fee terms: vendor-side (Beam) |
| **MEDHIS Lite** (MEDCURY Co., Ltd. with Vault Dragon International (Thailand); Singapore tech) | HIS + CRM for small specialised hospitals and aesthetic clinics. Product-as-a-service, customised. Multi-branch linking, membership, packages, commission | Not published | Not found | https://www.nationthailand.com/pr-news/pr-news/40047503 (press release) | Launch FACT (2025-03-17, press release). Vault Dragon founded 2013 (per PR) |
| **MedicalMet** (Kuala Lumpur HQ; SEA: MY, SG, BN, PH, TH, VN) | Cloud CMS, 80+ modules, 13+ specialties including dental and aesthetic. LHDN e-invoice compliance (Malaysia), AI notes, telehealth | From USD 12/month; 30-day trial | Not found | https://medicalmet.com/faq/what-is-medicalmet/ (undated) | Claims OPINION. Thai compliance not verified |
| Other Thai names (no detail gathered) | CLICKNIC, MeDiSee (Chiang Mai), Deverhood (EHR). Tracxn lists them as unfunded | - | Tracxn: unfunded | https://tracxn.com/d/explore/healthcare-it-startups-in-thailand/... (updated 2026-01-10) | UNVERIFIED (names only) |

### 4a. Funding and sector data
- Tracxn Thailand healthcare IT (updated 2026-01-10): 88 companies; 6 funded; total raised about USD 360K; 2 acquisitions. https://tracxn.com/d/explore/healthcare-it-startups-in-thailand/__n78fBD3-wBHJ0HofRrQv7Tw22ARagSdX9dW05hCGY6I. Label: UNVERIFIED. Tracxn is an aggregator with incomplete coverage.
- Same aggregator lists HD (Bangkok, medical information services, founded 2019) with USD 19.4M total and a Series A on 2025-02-13. This conflicts with the USD 360K sector total above. Label: UNVERIFIED. HD is also not a clinic-admin vendor, so it is shown only to flag the data inconsistency. https://tracxn.com/d/companies/hd/__pSPJJLFO8CWrXAw25znqxeNXAENw0ckZ_yEaUyQGLDs (updated 2026-02-18).
- Price band across the seven vendors with public prices: about THB 1,490 to 10,900 per month for the main tiers (ESTIMATE from the table above; excludes setup fees, VAT and per-branch add-ons).

### 4b. Pain points named in vendor and press material (all OPINION unless stated)
- Paper consent forms, paper tooth charts and treatment plans, difficult billing (EMRPad).
- Multiple programs for multiple services, LINE-based patient communication as the main channel (EMRPad, DoctorEase, AirClinic).
- Staff time on documents and commission calculation (JERA Cloud via longtunman).
- Paper-based records still destroyed as paper in large volumes (FACT, Thai PBS 2025-08-06).

---

## 5. Gaps and limits

1. No measured claim rejection or delay rate for SSO, NHSO or private insurers. Section 2d.
2. Clinic counts do not reconcile: 40,552 (all private clinics, 2024) vs about 20,000 clinical clinics (2026 statement). No primary table for aesthetic clinics. Section 1.
3. SSO rate sheets used are 2015 and 2022 pages. Current SSO announcements need checking before use.
4. The NHSO e-claim presentation is undated (c. 2018).
5. PDPC healthcare guideline is read only through a law-firm summary. The primary draft was not opened.
6. GD Catalog CSV files were not downloaded. Clinic counts are from press coverage of the same data.
7. Funding data is thin. Only aggregator profiles (Tracxn) and JERA Cloud's acquisition were found. No investor-announced funding rounds for the clinic-software vendors listed.
8. International clinic-software vendors (Western EMR/PM) were not researched in depth. This is a coverage gap for "SEA competitors".
9. Scraped Bangkok Post text (2.5, 2.6) is partly reversed. Only the headline figures are relied on.

---

## 6. Source list (checked in this session)

- https://www.nationthailand.com/health-wellness/40056407 (2025-10-06, private hospitals and clinics counts)
- https://www.bangkokbiznews.com/health/public-health/1231744 (2026-04-29, aesthetic clinic count)
- https://hss.moph.go.th/show_topic.php?id=393 (2016-06-02, aesthetic clinic training)
- https://gdcatalog.go.th/en/dataset/gdpublish-dataset-5-1-03 (dataset metadata, updated 2025-08-06)
- https://spd.moph.go.th/wp-content/uploads/2025/07/Report-Health-Resource-2024.pdf (MoPH resource report, 2024 data)
- https://spd.moph.go.th/wp-content/uploads/2024/07/Report-Health-Resource-2023-670716.pdf (MoPH resource report, 2023 data)
- https://dentalcouncil.or.th/upload/files/pVimkvf1D0WKzMAYgBtxolOGUQ3R7uhw.pdf (dental clinic statistics, data as of 2024-02-28)
- https://www.nationthailand.com/business/economy/40046901 (2025-03-01, DBD beauty businesses)
- https://www.bangkokpost.com/thailand/general/2883148/new-cap-for-private-hospital-claims (2024-10-14)
- https://www.bangkokpost.com/thailand/general/2871333/private-hospitals-opting-out-of-govt-health-scheme (2024-09-24)
- https://portal.info.go.th/sso-medical-expenses-reimbursement/ (2022-04-27)
- https://lb.mol.go.th (e-Labour; rate table cites 2015)
- https://www.nhso.go.th/en/resources-center/documents/presentations/55236-ucs-claim-presentation/file (undated, c. 2018)
- https://media.milliman.com/... (2025-10-13, OIC co-pay rules)
- https://prakun101.com/claiming-medical-excess-sso/ (2026-02-06, blog)
- https://www.thailandstarterkit.com/health/dispute-appeal-rejected-health-insurance-claim-thailand/ (2026-09-24, blog)
- https://aseannow.com/topic/1355605-how-to-avoid-health-insurance-claim-denials-in-thailand/ (2025-03-24, forum; the 85% figure is UNVERIFIED)
- https://www.hlc.com/en/publications/thailand-pdpc-consults-on-first-healthcarespecific-data-protection-guideline (2026-07-09)
- https://www.mwit.ac.th/html/mwitDoc/PDPA/1-2_PDPA-2019.pdf (PDPA unofficial translation)
- https://www.mdes.go.th/law/detail/1905-Personal-Data-Protection-Act--B-E--2562--2019- (PDPA)
- https://www.lexology.com/library/detail.aspx?g=19f4e3df-4b1b-4db3-8806-ddc505be443b (2025-03-17, penalties)
- https://www.thaipbs.or.th/news/content/355090 (2025-08-06, leak fine and MoPH measures)
- https://hss.moph.go.th/show_topic.php?id=5991 (2024-05-14, DHSS retention rule)
- https://www.tmc.or.th/download/... (Medical Council notice 54/2563, 2020)
- https://practiceguides.chambers.com/practice-guides/data-protection-privacy-2026/thailand (2026 edition)
- https://emrpad.com/ ; https://hexahealths.app/clinic ; https://kiddung.com/ ; https://air.clinic/ ; https://medicalmet.com/faq/what-is-medicalmet/ (vendor pages, undated)
- https://doctorease.co/en/package/ ; https://software-listing.com/tools/doctorease (2026-08) ; https://tracxn.com/d/companies/doctorease/... (2025-04-11)
- https://www.padmel.com/archives/59301 (2025-08-31) ; https://www.longtunman.com/62338 (2025-09-12) ; https://www.lamunpunit.com/ (undated)
- https://www.nationthailand.com/pr-news/pr-news/40047503 (2025-03-17, MEDHIS Lite)
- https://tracxn.com/d/explore/healthcare-it-startups-in-thailand/... (2026-01-10) ; https://tracxn.com/d/companies/hd/... (2026-02-18)
