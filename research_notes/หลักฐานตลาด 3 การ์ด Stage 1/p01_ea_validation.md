# EA Strategy Validation Tools: Evidence Brief (p01)

**Scope.** Retail MetaTrader 5 / EA strategy developers. Thailand focus, global MQL5 view.
**Date checked.** All fetches and searches were run on 2026-10-19 (environment date). Page-level dates, where a page shows one, are given separately.
**Labels.** FACT = read on the stated URL on the stated date. OPINION = a person's view, not a verified fact. UNVERIFIED = could not confirm from a source I read. Demand grades: S (verifiable buyer-to-seller payment), A (verifiable past behaviour with a number), B (past behaviour in narrative form, incl. self-reported numbers), C (stated future intent), D (politeness, marketing or agreement).

**Method and limits (read first).**
- Working tools: Firecrawl scrape and search, WebSearch, and Bash/curl (curl to the pricing hosts was refused at the proxy with 403 CONNECT).
- WebFetch could not resolve strategyquant.com, buildalpha.com, quantconnect.com, tradingview.com, myfxbook.com, mql5.com or www.sec.or.th (ENOTFOUND). All primary pages were read via Firecrawl instead.
- Exa MCP did not connect (proxy 403 on mcp.exa.ai). No Exa search was run.
- WebSearch refuses reddit.com. Reddit evidence below comes only from a third-party mirror seen in search results.
- Firecrawl hit its per-minute rate limit several times. Some search results are excerpts I did not open; these are marked UNVERIFIED.
- About 35 tool calls were made, well above the ~15-call guideline, to cover six named tools and the Thai regulatory question.

---

## KQ1. How do EA developers validate strategies in practice?

### Takeaway
Community practice centres on walk-forward testing, one untouched final out-of-sample (OOS) period, Monte Carlo variants, parameter-plateau checks, and multiple-testing awareness. The most substantive practitioner thread I read (MQL5 forum 515754) argues the main risk is validation overfitting, not only parameter overfitting. I found no verified Thai-language source and no primary reddit.com thread.

### Cited Findings
- **FACT.** An MQL5 forum thread asks how to test an adaptive EA without tuning the testing process to history. The poster lists walk-forward testing, a final OOS period never touched during development, Monte Carlo, multi-symbol testing, realistic spread and slippage, and fixing the procedure before the final result. [MQL5 forum 515754](https://www.mql5.com/en/forum/515754), checked 2026-10-19. Post date and reply count were not visible in the extracted text: UNVERIFIED.
- **OPINION** (reply in the same thread). Freeze the whole evaluation procedure (adaptation rules, parameter ranges, walk-forward windows, objective, costs, symbol set, Monte Carlo rules) before the single OOS run. Compare the adaptive version with a fixed-parameter version. [Same thread](https://www.mql5.com/en/forum/515754), checked 2026-10-19.
- **OPINION** (reply). Monte Carlo variants: permute the regime labels and shift switch dates to test whether adaptation carries information; bootstrap the trade sequence to see the drawdown distribution; perturb each adaptive parameter to check for a plateau rather than a spike. [Same thread](https://www.mql5.com/en/forum/515754), checked 2026-10-19.
- **OPINION / self-reported** (reply). Hash the sorted trade list for each configuration to detect when a switch changes nothing. Count entries per regime branch, since a branch that fires rarely was never really tested. [Same thread](https://www.mql5.com/en/forum/515754), checked 2026-10-19.
- **OPINION / self-reported** (reply). One contributor tested 121 candidate lags. The best cell showed p = 0.036 against the base rate, but a permutation test on the maximum gave p = 0.947. This is an illustration of multiple-testing risk, not a verified result. [Same thread](https://www.mql5.com/en/forum/515754), checked 2026-10-19.
- **FACT** (MQL5 Market rules). Market products get an automatic Strategy Tester pre-test and a "formal test". The rules state that the Administration "does not guarantee the profitability of Expert Advisors", and that passing the test "does not mean that the results stated in the Product description will be obtained in the future". [MQL5 Market rules](https://www.mql5.com/en/market/rules), checked 2026-10-19. The rules page shows no revision date.
- **FACT** (vendor description). StrategyQuant's Professional tier includes "Advanced robustness tests" (Monte Carlo simulations, system parameter permutations, optimization profile, Walk-Forward matrix) and an "Optimizer (Simple + Walk-forward)". [StrategyQuant pricing](https://strategyquant.com/pricing/), checked 2026-10-19; page metadata shows modified 2026-09-21.
- **FACT** (vendor description). QuantConnect sells "Cloud Optimization" as a paid add-on on every tier except Free, described as a way to "measure your algorithm sensitivity" across parameter combinations. [QuantConnect pricing](https://www.quantconnect.com/pricing/?billing=mo), checked 2026-10-19. The QuantConnect page also says the optimizer helps "avoid overfitting". That is vendor marketing.
- **UNVERIFIED** (search snippets only, not opened). A guide recommends a 2/3 backtest and 1/3 forward split, and says a sharp drop in the forward period signals overfitting. Another suggests limiting optimized parameters to about 2 to 3. The guide's URL could not be matched to the snippet. Treat as OPINION heuristics. [WebSearch, 2026-10-19].
- **UNVERIFIED** (search snippet). MQL5 article 23250 proposes a walk-forward efficiency ratio to detect over-optimized strategies. [MQL5 article 23250](https://www.mql5.com/en/articles/23250), checked 2026-10-19 as a search result only; not fetched.
- **CONFLICT, unresolved** (search snippets). One source says MetaTrader does not automate walk-forward testing natively. A Spanish-language source says walk-forward is built into MT5. The MT5 testing help page linked from the forum thread would settle it: [MT5 Strategy Testing help](https://www.metatrader5.com/en/terminal/help/algotrading/testing). Not opened. UNVERIFIED.
- **OPINION** (Reddit, via third-party mirror). An r/algotrading post argues walk-forward is the minimum for a credible backtest and that one long equity curve is usually curve-fitting. A commenter says parameter sensitivity is the test most people skip. [Mirror snapshot, 2026-05-15](https://reddit.sentinel-team.org/posts/1t5e9q6/snapshots/2026-05-15T19%3A02%3A50.96329Z), seen in search results 2026-10-19; not opened and not the primary reddit.com page.

### Inferences
- The practice described mostly maps the institutional checklist (walk-forward, OOS, Monte Carlo, multiple-testing awareness) onto MT5 tooling. The MQL5 thread reaches for multiple-testing logic without naming PBO or the Deflated Sharpe Ratio.
- The MQL5 Market check is formal, not robustness-based. The gap between a formal pre-test and a robustness claim is the space robustness tools sell into. (OPINION.)

### Gaps
- **PBO (Probability of Backtest Overfitting) and Deflated Sharpe Ratio:** no retail or community source naming either was found in this pass. UNVERIFIED that retail EA developers use them.
- **Thai community** (Pantip, Thai Facebook groups): a Thai-language search returned no Thai results, only garbled text. Facebook groups were not attempted (login-gated). UNVERIFIED that these communities discuss validation at all.
- **Reddit:** only the mirror above. reddit.com was not accessible through WebSearch.
- **MQL5 forum 515754:** post date and reply count not visible in the extracted text.

---

## KQ2. Is there evidence that people pay for robustness checks, EA audits, validation tools, or signal and EA marketplaces?

### Takeaway
Paid markets exist: StrategyQuant, Build Alpha and QuantConnect sell tools; the MQL5 Market takes a 20% commission on EA sales; Myfxbook lets verified accounts sell premium signal access at $20 to $100 a month. I found no public source showing buyer-side transaction counts or revenue for robustness checks, EA audits or validation tools. The best public demand evidence is grade B (seller-stated numbers). Nothing reached grade S or A.

### Cited Findings: market structure (FACT)
- **FACT.** MQL5 Market: a 20% commission is charged automatically on each sale; the seller's payment is frozen for a week; the minimum paid price is $30; free distribution is allowed. [MQL5 Market rules](https://www.mql5.com/en/market/rules), checked 2026-10-19.
- **FACT.** MQL5 Market product rules: EX4/EX5 files only; no DLL calls; products must not present backtests as real results or promise profits; products must not embed third-party sales or license-control systems. Seller's own demo limits are restricted. [MQL5 Market rules](https://www.mql5.com/en/market/rules), checked 2026-10-19.
- **FACT.** Myfxbook: any public, fully verified trading account may sell "premium account access" at a monthly fee between $20 and $100. Sellers see sales in a Reports tab. The help article is marked "Updated on July 11, 2024". The help page gives no commission rate: the commission rate is UNVERIFIED. [Myfxbook premium account access](https://www.myfxbook.com/help/knowledge-base/premium-account-access/), checked 2026-10-19.
- **CONFLICT, unresolved.** A Myfxbook members-page excerpt says "Premium access is not yet available". Its date is unknown. Which statement is current is UNVERIFIED. [Myfxbook members/Subscription](https://www.myfxbook.com/members/Subscription), search excerpt 2026-10-19.

### Cited Findings: seller-stated demand (grade B, unverifiable)
- **Grade B.** An MQL5 listing shows launch pricing of $129, rising to $160 after 10 units, and states "So far, 6 units have been purchased at the current price level". [MQL5 Market](https://www.mql5.com/en/market), checked 2026-10-19. This is a seller claim about past sales. It cannot be verified from the page.
- **Grade B.** Another listing says its launch price "increases by 100 USD for every 10 copies sold". This is a price model, not evidence of volume. [MQL5 Market](https://www.mql5.com/en/market), checked 2026-10-19.
- **Grade D.** Scarcity and bundle claims ("only 10 licenses left", "only a few copies left at current price", "Final price: 990$") are marketing. [MQL5 Market](https://www.mql5.com/en/market), checked 2026-10-19.
- **Price points seen on the MQL5 listings page (not sales):** $95 current with $195 final (Scraper Gold MT5); $299 against $499 regular; $749 against $999; $499 for a single EA. These are seller-set asking prices, not market averages. [MQL5 Market](https://www.mql5.com/en/market), checked 2026-10-19.

### Cited Findings: vendor claims (grade D)
- **Grade D.** StrategyQuant says it "is used by thousands of users from all over the world since 2005". No count is verifiable. [StrategyQuant pricing](https://strategyquant.com/pricing/), checked 2026-10-19.
- **Grade D.** StrategyQuant shows seven testimonials, including one from an automated-trading course coordinator. The page presents them as its own selection. [StrategyQuant pricing](https://strategyquant.com/pricing/), checked 2026-10-19.
- **Grade D.** Build Alpha's homepage headline: "Real cost of NOT using Build Alpha: $20,000 or more per year". No support is given. [Build Alpha homepage](https://www.buildalpha.com/), search excerpt 2026-10-19; not opened.
- **Grade D.** Build Alpha's licensing page describes the seller as "a one-man shop". This is the seller's own description. [Build Alpha licensing](https://www.buildalpha.com/licensing/), checked 2026-10-19.
- **Grade D.** An aggregator listing shows Build Alpha at "$2,500.00" with a "5.0 (5)" rating. This conflicts with the vendor's $1,497 price, and five ratings is too few to grade. [SoftwareSuggest Build Alpha](https://www.softwaresuggest.com/buildalpha), search excerpt 2026-10-19; not opened.
- **Grade D.** An MQL5 forum sidebar says "Over 8,000 signals for copying". This is a platform marketing claim, undated. [MQL5 forum 515754](https://www.mql5.com/en/forum/515754), checked 2026-10-19.

### Cited Findings: EA audits
- No EA-audit service with a price or a transaction was found. Myfxbook's site navigation lists an "EA Programming Services" category. That is a category only; no prices or demand figures. [Myfxbook](https://www.myfxbook.com/pricing) (page nav), checked 2026-10-19. Demand for audits: UNVERIFIED.

### Demand evidence grading summary

| # | Evidence | Grade | Source, date checked | Note |
|---|---|---|---|---|
| 1 | MQL5 listing: "6 units purchased" at $129 rising to $160 | B | mql5.com/en/market, 2026-10-19 | Seller-stated number, not verifiable |
| 2 | MQL5 Market 20% commission policy | FACT (market structure, not buyer demand) | mql5.com/en/market/rules, 2026-10-19 | Shows a commission market exists |
| 3 | Myfxbook premium sellers' sales reports | UNVERIFIED | Help page, updated 2024-07-11 | Feature exists; no public figures |
| 4 | StrategyQuant "thousands of users" | D | strategyquant.com/pricing, 2026-10-19 | Vendor claim |
| 5 | StrategyQuant testimonials | D | same | Vendor-curated |
| 6 | Build Alpha "$20,000 per year" cost framing | D | buildalpha.com, 2026-10-19 (excerpt) | Unsupported |
| 7 | MQL5 adaptive-EA thread replies | B for practice; not purchase | forum 515754, 2026-10-19 | Narrative of own testing, no payment |
| 8 | r/algotrading mirror thread | D for purchase | mirror snapshot 2026-05-15 | Opinion |
| 9 | Stated future intent to buy a validation tool (C) | None found | n/a | Not found |
| 10 | Any S or A evidence | None found | n/a | No verifiable transaction or number |

### Inferences
- Public evidence is B or lower. Most forum posts are B for practice and D for purchase. The public seller claims (listing counts) are B at best.
- Robustness checks are sold as a tier feature (StrategyQuant Professional and above; Build Alpha's post-build checklist). That is a vendor product choice, not proof that buyers pay for robustness separately. (OPINION.)
- The MQL5 Market's 20% cut, EX5-only and no-DLL rules, and ban on embedded license systems limit how a standalone validation tool could be sold through that channel. (OPINION, from the rules page.)

### Gaps
- No public buyer-side sales counts or revenue for any named tool, validation service or EA audit.
- MQL5 Signals subscription pricing: service exists (linked from MQL5 rules pages) but pricing was not read. UNVERIFIED.
- No Thai-baht pricing or Thai buyer data found.
- EA audit services: not searched in depth. UNVERIFIED.

---

## KQ3. Named competitors: verified tools and current public pricing

All figures are as displayed on the stated pages on 2026-10-19. Where a page shows two figures per option and the extraction does not say which one is struck through, both are reported and the current one is UNVERIFIED.

### StrategyQuant (SQX): VERIFIED
Source: [strategyquant.com/pricing](https://strategyquant.com/pricing/), checked 2026-10-19; page metadata modified 2026-09-21. Prices in USD, ex-VAT, payment via FastSpring.

- **Starter:** $129 per month for 12 months, or $1,290 one-time. Includes Builder, Retester and Improver. No Professional robustness tests, no Optimizer. **FACT.**
- **Professional:** $149 per month for 12 months (also shown: $175), or $1,490 one-time (also shown: $1,790). Adds advanced robustness tests (Monte Carlo, permutations, Walk-Forward matrix), Optimizer (simple and walk-forward) and custom projects. **FACT.** Which of the paired prices is current: UNVERIFIED.
- **Ultimate:** $290 per month for 12 months (also shown: $420), or $2,900 one-time (also shown: $4,900). Adds SQ for Business (MQL Market support), QuantAnalyzer PRO (stated as "$349 value"), Portfolio Master and premium data. **FACT.** Which of the paired prices is current: UNVERIFIED.
- **Installment note.** The FAQ says there is a "17% price increase when paid in installments". **FACT.**
- **Upgrade and support.** Professional to Ultimate: $1,900 one-time, or 12 x $190. Support and updates extension: $300. **FACT.**
- **Refunds.** Purchases are "generally non-refundable"; a 14-day free trial is offered. **FACT.**
- **Vendor self-description.** "Analysis and strategy-development software. We are not a broker or investment advisor." **FACT** (vendor disclosure).
- **Market and Volume Profile add-ons** have monthly and yearly subscription options. Prices not read. UNVERIFIED.
- **Other family products listed on the same page (found, not priced):** QuantAnalyzer, QuantDataManager, AlgoCloud. Existence FACT.

### Build Alpha: VERIFIED (lifetime price); subscription price UNVERIFIED
Source: [buildalpha.com/licensing](https://www.buildalpha.com/licensing/), checked 2026-10-19; page metadata modified 2026-07-28.

- **Lifetime license:** $1,497 one-time (struck: $2,497). Includes full access, upgrades, portfolio mode, Fast-Start package and "own for life". **FACT.**
- **Subscription option:** the FAQ implies a subscription that can be upgraded to lifetime within 30 days, with a $197 conversion fee. The subscription price was not captured. UNVERIFIED.
- **Build Alpha for TradingView:** "$597 + $59 / month" shown in a search excerpt. Not opened. UNVERIFIED in full. [Build Alpha for TradingView](https://www.buildalpha.com/build-alpha-for-tradingview/), search excerpt 2026-10-19.
- **Trial.** No free trial or demo; the FAQ says the seller gives "everything up front". **FACT** (vendor FAQ).
- **Self-description.** "Not a signal service or trade copier"; "stress test and filter out fragile candidates automatically". **FACT** (vendor claim).
- **Multi-seat / institutional:** quote on request. **FACT.**
- **Old URL.** buildalpha.com/pricing/ returned a 404 page on 2026-10-19; the licensing page is now the pricing page. **FACT.**

### QuantConnect: VERIFIED (monthly view)
Source: [quantconnect.com/pricing/?billing=mo](https://www.quantconnect.com/pricing/?billing=mo), checked 2026-10-19.

- **Free:** $0. Unlimited backtesting; 1 backtest node; 0 live nodes; Cloud Optimization not included (add-on). **FACT.**
- **Quant Researcher** (page header "RESEARCHER"): $84 per month ("recommended setup"). Includes 2 backtest and 2 live nodes; Cloud Optimization is an add-on. **FACT.** Annual price: UNVERIFIED.
- **Team:** $168 per user per month, minimum 2 users; annual billing saves $288 per user. 10 backtest and 10 live nodes. **FACT.**
- **Trading Firm:** $480 per user per month, minimum 2 users; annual billing saves $768 per user. Unlimited nodes. **FACT.**
- **Institution:** $1,272 per user per month, minimum 5 users; annual billing saves $2,352 per user. On-premises option. **FACT.**
- **Platform scope.** The broker list on the pricing page includes no MetaTrader broker. This page does not show a route for running MQL5 EAs on QuantConnect. **FACT** about page content; compatibility not otherwise verified.

### TradingView: VERIFIED (annual prices)
Source: [tradingview.com/pricing](https://www.tradingview.com/pricing/), checked 2026-10-19.

- **Basic:** $0 forever.
- **Essential:** $12.95 per month, billed annually (labelled "special price"; saves $24 a year). **FACT.**
- **Plus:** $29.95 per month, billed annually (saves $60 a year). **FACT.**
- **Premium:** $59.95 per month, billed annually (saves $120 a year). **FACT.**
- **Ultimate:** $199.95 per month, billed annually (saves $480 a year). **FACT.**
- **Monthly (non-annual) prices:** UNVERIFIED (not captured).
- **Strategy tester per plan:** the feature table lists "Strategy backtesting", "Basic report metrics", "Advanced report metrics", "Export trades in CSV" and "Deep backtesting", but the per-plan checkmarks did not survive extraction. Per-plan access: UNVERIFIED.
- **Historical data limits (matrix):** Basic 5K bars; Essential 10K; Plus 10K; Premium 20K; Ultimate 40K. Tick data: 7 days, Ultimate only. **FACT.**
- **Refunds:** annual plans only, within 14 days of payment; none for monthly plans. **FACT.**
- **MetaTrader or MQL5 mention:** none on the pricing page. **FACT** about page content.

### MQL5 Market and MQL5 Signals: VERIFIED (Market rules); Signals pricing UNVERIFIED
- **MQL5 Market:** exists; rules read on [mql5.com/en/market/rules](https://www.mql5.com/en/market/rules), checked 2026-10-19. Commission 20%; minimum price $30; seller-set activations with a minimum of 5 and a maximum of 20 per buyer; products may not be resold; free distribution allowed; one-week payment hold. **FACT.** The rules page shows no revision date.
- **MQL5 Signals:** service exists and is linked from the Market rules and listings. Its pricing and fees were not read. UNVERIFIED.

### Myfxbook: VERIFIED (existence and premium-access model); /pricing page does not exist
- **Pricing page:** [myfxbook.com/pricing](https://www.myfxbook.com/pricing) returned a 404 page on 2026-10-19. No Myfxbook plan price table was found. **FACT.**
- **Premium account access:** sellers set a monthly fee of $20 to $100. Commission rate: UNVERIFIED. [Help article, updated 2024-07-11](https://www.myfxbook.com/help/knowledge-base/premium-account-access/), checked 2026-10-19. **FACT** for the fee range.
- **Ad-free subscription:** $10.00 per month; $8.32 per month on the yearly plan. Search excerpt only, not opened. UNVERIFIED in full. [Myfxbook ad-free subscription](https://www.myfxbook.com/ad-free-subscription), 2026-10-19.
- **Multi-account subscription:** "$5 per month, billed yearly". Seen in a user suggestion thread, not an official page. UNVERIFIED.

### Other names found (listed for completeness, not evaluated)
- **MetaTrader 5 Strategy Tester:** built-in tester. Linked from the MQL5 forum thread (existence FACT); the page was not read and its pricing (the terminal is free to download) is UNVERIFIED. [MT5 Strategy Tester](https://www.metatrader5.com/en/automated-trading/strategy-tester).
- **ForexPeaceArmy / EarnForex forum threads:** community sites. Walk-forward explanation seen in search snippets only. UNVERIFIED.
- **quantalphaalgorithms.odoo.com:** blog; seller and product status not evaluated.
- **newyorkcityservers.com:** blog page on walk-forward and Monte Carlo testing of EAs; operator and product status not evaluated.
- **backtrex.com:** Spanish-language MT5 backtesting tutorial site; operator and product status not evaluated.

### Inferences (KQ3)
- Price clustering: lifetime licences near $1,000 to $1,500 (StrategyQuant Professional $1,490; Build Alpha $1,497), plus tiered subscriptions (QuantConnect, TradingView). (OPINION from the figures above.)
- Robustness features are gated to the middle or top tier at StrategyQuant (Professional and above). (FACT, vendor page.)

### Gaps (KQ3)
- MQL5 Signals fees; Build Alpha subscription price; Build Alpha for TradingView price (only an excerpt); TradingView monthly prices and per-plan strategy-tester access; QuantConnect annual Researcher price; Myfxbook premium commission rate; StrategyQuant currency and payment for Thai buyers beyond the stated USD display.

---

## KQ4. Thailand regulatory boundary: investment advice, analysis and software

### Takeaway
The primary source I read, the SEC's 18 September 2024 statement (unofficial English translation; the Thai text governs), defines what foreign operators may and may not do with Thai investors. It names an exemption for advice to no more than 15 investors in any 12-month period, and lists marketing activities that can amount to unlicensed business. It does not address software, EAs, trading signals or robo-advice as product types. It mentions "training" only in the context of promotion and a proposed Foreign Business Act waiver, and "website or application" only as an access channel for licensed services. Whether a signal or EA product is "investment advice" under Notification Kor Thor 1/2560 is a fact-specific question. A Thai lawyer should decide it.

### Cited Findings
- **FACT** (primary). The SEC statement dated 18 September 2024 concerns foreign business operators providing services to Thai investors. The English text is marked as an unofficial translation for reference. [SEC statement PDF](https://www.sec.or.th/EN/Template3/SECStatement/2024/SECstatementEN-180924.pdf), checked 2026-10-19; nine pages, read in full by the Firecrawl PDF parser.
- **FACT.** Section 2.2 lists advisory exemptions "for example": advice given in or from Thailand to "not more than 15 investors during any 12-month period without presenting oneself to provide services as an investment advisory"; advice to investors abroad presented under foreign law; advice to companies in the same group; advice exclusively to institutional investors; and "general advice" from a foreign juristic person approved by the SEC. Same URL, checked 2026-10-19.
- **FACT.** Footnote 10 defines "general advice" as advice given without considering "investment suitability, investment objectives, financial position or specific needs of any particular individual". Same URL, checked 2026-10-19.
- **FACT.** The exemption criteria rest on Notification Kor Thor 1/2560, "Determination of the Characteristics of Providing Advice to the Public Not Deemed to Be an Undertaking of Securities Business in the Category of Investment Advisory", dated 12 January 2017, as cited in the SEC statement. The notification text was not opened. Conditions beyond the statement's examples are UNVERIFIED. Same URL.
- **FACT.** Section 4 lists activities that may amount to operating without a licence for foreign operators and their personnel. These include: "offering for sale or providing information/advice regarding investment products"; "organizing seminars and promotional activities", including "inviting Thai investors to attend training organized by a foreign business operator"; "using a foreign website or application but facilitating access ... by using Thai language, allowing payments in Thai baht"; and advising Thai investors to use a foreign operator's services, which can make affiliates and introducers liable as co-principals or supporters. Same URL, checked 2026-10-19.
- **FACT.** Penalties stated by the SEC: for unlicensed securities business, imprisonment of 2 to 5 years and a fine of 200,000 to 500,000 baht, plus a daily fine up to 10,000 baht while the breach continues; for derivatives, imprisonment up to 3 years or a fine up to 300,000 baht, or both. Aiding unlicensed business carries two-thirds of the penalty. Same URL.
- **FACT.** A representative office may collect and analyse information and send opinions to its head office, but may not provide services to Thai investors. Same URL, section 3.1.
- **FACT.** The SEC has proposed to the Ministry of Commerce a waiver so that services such as "provision of news and information and training on capital market products" are excluded from List 3 of the Foreign Business Act. Adoption status: UNVERIFIED. Same URL, section 1.
- **FACT.** The statement does not address software, algorithms, expert advisors, trading signals, robo-advice or automated analysis as products. "Application" appears only as an access channel for services (section 4), and "training" only in the promotion and waiver contexts above. Same URL, full text read.
- **UNVERIFIED** (search results only). The Securities and Exchange Act defines investment advisory as regular advice to the public, directly or indirectly, on a security's value or whether investing is suitable, offered for a fee; advice given in a manner specified by SEC notification is excluded. Primary text not opened. The Act's consolidated English text is at [sec.or.th Securities and Exchange Act (as amended)](https://www.sec.or.th/en/documents/actandroyalenactment/act/act-sea1992-amended.pdf), listed in search results, not opened.
- **UNVERIFIED** (search results only). Notification numbering: Thai sources write "กธ. 1/2560", and the SEC statement romanises it "Kor Thor. 1/2560". Sources also mention an amending notification "กธ. 8/2560", a 2023 draft that would repeal a sub-item of article 3(6), and a 2019 hearing document. Current status unknown. Search results: [SEC hearing PDF](https://capital.sec.or.th/webapp/phs/upload/phs1546591653hearing_01_2562_s01.pdf), not opened.

### Inferences (OPINION; lawyer to confirm)
- A standalone MT5 EA or indicator sold as software, run by the buyer on the buyer's own account, is a different question from a service that tells Thai investors what to trade. The SEC statement does not resolve this.
- Signal subscriptions are the closest case. A paid signal feed sent to many Thai subscribers could fall within the "general advice" category or the 15-investor exemption, depending on the notification's conditions. The 15-investor limit is a count per 12-month period; a feed with many subscribers may exceed it. The notification's conditions must be read to decide.
- The higher-risk features under Section 4 for a Thailand-facing vendor are: Thai-language marketing or websites; Thai baht payments; affiliate or introducer marketing; and paid training events or seminars.
- Education is not clearly exempt. The SEC's proposed waiver covers "training on capital market products" only as a proposal for the Foreign Business Act list, and its status is unknown.

### Gaps and what a qualified lawyer should confirm
- Notification Kor Thor 1/2560 full text, and any amendments (8/2560, the 2023 draft). Current consolidated text not read.
- SEC guidance on signals, EAs, algorithmic tools or education specifically: none found in this pass.
- Thai legal commentary: none read; none used.
- Thai SEC enforcement examples against signal or "advice" groups: not searched.
- Broker-side regulation for MT5 use in Thailand: not researched.
- A Thai lawyer should confirm: (1) whether the product is software or "advice" on these facts; (2) whether paid signal subscriptions for multiple Thai buyers require a licence or fit an exemption; (3) whether the marketing and affiliate activity counts as solicitation under section 4; (4) the current consolidated text of Notification 1/2560 and any amendments; (5) whether the 2023 draft changed the exemption list.
