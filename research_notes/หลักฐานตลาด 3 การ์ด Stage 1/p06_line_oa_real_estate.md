# LINE OA Lead Handling and LINE CRM/Chatbot Tools for Independent Real Estate Agents in Thailand

Current state as of 2026-10-19. Labels: FACT (source and date checked), OPINION, UNVERIFIED. Grades for willingness-to-pay: S/A/B/C/D as defined in the brief.

Method: official LINE pages and two competitor pricing pages were read with Firecrawl scrape on 2026-10-19 (maxAge 0). Everything else is from search-index excerpts; excerpt pages usually show no publication date, and this is noted where it applies. Direct fetches were refused by the egress proxy (403 on CONNECT) for developers.line.biz, respond.io, sleekflow.io, chatcone.com and botnoi.ai, and WebFetch failed on DNS for the same hosts, so Firecrawl was used. Firecrawl hit its rate limit on several calls, so Chatcone and Botnoi pricing pages could not be scraped. The Exa MCP server did not connect (ERR_PROXY_TUNNEL) and was not used. Pantip and Facebook group pages were not read in full.

## KQ1. (a) Public evidence that agents lose leads or deals to slow LINE replies

### Takeaway
No Thai real-estate-specific evidence with a named study or a sample size was found in this pass. What exists is vendor marketing and generic SME blogs, plus one Instagram caption that cites unnamed "industry research" on reply delay. The claim that slow LINE replies cost independent agents deals is plausible but untested by public data here.

### Cited Findings
- OPINION, unsourced, grade C-D. Instagram caption with real estate and PropTech hashtags (#อสังหาริมทรัพย์ #นายหน้าอสังหา #CRM #PropTech). Leads arriving on LINE "disappear into the agent's private chat," and the caption says: "งานวิจัยในวงการบอกตรงๆ ว่าถ้าตอบช้ากว่านั้น มูลค่าลีดส่วนใหญ่หายไปแล้ว" (roughly: "industry research says bluntly that if you reply slower than that, most of the lead value is already gone"). No study is named, no sample size is given, and author and post date are not visible in the excerpt. Source: [Instagram post](https://www.instagram.com/p/Dd0xX1JFiS7/), search excerpt checked 2026-10-19. Post date: UNVERIFIED.
- OPINION, vendor marketing, grade D. Facebook video from SellStory, tagged #SalesCRM. Thai text: "ถ้ายังต้องมานั่งเครียด เพราะตอบแชทลูกค้าไม่ไหว จนลูกค้าหาย ยอดขายตก" (roughly: "if you're still stressed because you can't keep up replying to chats, customers vanish and sales drop"). It addresses general businesses, not real estate, and gives no data. Source: [SellStory Facebook video](https://www.facebook.com/sellstoryth/videos/%E0%B8%96%E0%B9%89%E0%B8%B2%E0%B8%A2%E0%B8%B1%E0%B8%87%E0%B8%95%E0%B9%89%E0%B8%AD%E0%B8%87%E0%B8%A1%E0%B8%B2%E0%B8%99%E0%B8%B1%E0%B9%88%E0%B8%87%E0%B9%80%E0%B8%84%E0%B8%A3%E0%B8%B5%E0%B8%A2%E0%B8%94-%E0%B9%80%E0%B8%9E%E0%B8%A3%E0%B8%B2%E0%B8%B0%E0%B8%95%E0%B8%AD%E0%B8%9A%E0%B9%81%E0%B8%8A%E0%B8%97%E0%B8%A5%E0%B8%B9%E0%B8%81%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B9%84%E0%B8%A1%E0%B9%88%E0%B9%84%E0%B8%AB%E0%B8%A7-%E0%B8%88%E0%B8%99%E0%B8%A5%E0%B8%B9%E0%B8%81%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%A2-%E0%B8%A2%E0%B8%AD%E0%B8%94%E0%B8%82%E0%B8%B2%E0%B8%A2%E0%B8%95%E0%B8%81-%E0%B8%96%E0%B8%B6%E0%B8%87%E0%B9%80%E0%B8%A7%E0%B8%A5%E0%B8%B2%E0%B8%88%E0%B8%B1%E0%B8%94%E0%B8%81%E0%B8%B2/592918163651576/), search excerpt checked 2026-10-19.
- OPINION, generic SME vendor blog, no data. thisaan blog on LINE customer service: chats arrive together, replies are late, and "ตอบช้าจนเขาไปซื้อเจ้าอื่น" (slow replies, so they buy from someone else). Source: [thisaan blog](https://thisaan.cloud/blog/line-customer-service-system/), search excerpt checked 2026-10-19. Date: UNVERIFIED.
- UNVERIFIED relevance. Facebook post from twsme with the headline "ทำไมลงทรัพย์ใน Facebook หรือ LINE แล้วยังปิดการขายได้ช้า?" (why are listings on Facebook or LINE still slow to close?), aimed at buyers of houses and villas in Phuket, especially foreigners. The excerpt does not say reply speed is the cause, so it is not evidence for the claim. Source: [twsme Facebook post](https://www.facebook.com/twsme/posts/%E0%B8%97%E0%B8%B3%E0%B9%84%E0%B8%A1%E0%B8%A5%E0%B8%87%E0%B8%97%E0%B8%A3%E0%B8%B1%E0%B8%9E%E0%B8%A2%E0%B9%8C%E0%B9%83%E0%B8%99-facebook-%E0%B8%AB%E0%B8%A3%E0%B8%B7%E0%B8%AD-line-%E0%B9%81%E0%B8%A5%E0%B9%89%E0%B8%A7%E0%B8%A2%E0%B8%B1%E0%B8%87%E0%B8%9B%E0%B8%B4%E0%B8%94%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%82%E0%B8%B2%E0%B8%A2%E0%B9%84%E0%B8%94%E0%B9%89%E0%B8%8A%E0%B9%89%E0%B8%B2-%E0%B8%81%E0%B8%A5%E0%B8%B8%E0%B9%88%E0%B8%A1%E0%B8%A5%E0%B8%B9%E0%B8%81%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%8B%E0%B8%B7%E0%B9%89%E0%B8%AD%E0%B8%9A%E0%B9%89%E0%B8%B2%E0%B8%99-%E0%B8%A7/1022120174182699/), search excerpt checked 2026-10-19.

### Inferences
- The "slow reply loses leads" message in Thai marketing is carried mostly by vendors and generic SME content. The segment-specific claim (independent agents, LINE as the lead channel) has no public quantitative support in this brief.

### Gaps
- Pantip and Thai agent Facebook groups were not searched in depth (one Thai query only). Facebook group content is mostly not readable through search. Still needed: targeted public searches on Pantip and agent groups, with post dates and counts.
- LINE for Business Thai success stories (lineforbusiness.com/th/success-stories) were not reviewed.
- A widely cited US study on lead response time (Oldroyd, McElheran and Elkington, HBR 2011, "The Short Life of Online Sales Leads") is a candidate for verification. It was not checked here, and no figures from it are recorded.
- No sample size exists for any Thai real estate claim found.

## KQ2. (b) LINE OA auto-reply features, plan tiers, quotas, and reply vs push

### Takeaway
As of 2026-10-19, LINE's Thai official page lists three tiers: Free (300 broadcast messages per month, no charge), Basic (1,280 THB per month excl. VAT, 15,000 messages, 0.10 THB per extra message) and Pro (1,780 THB per month excl. VAT, 35,000 messages, 0.06 THB per extra message). The Free quota was cut from 500 to 300 by LINE's own announcement effective 1 Aug 2024, and 300 is still the figure on the page checked 2026-10-19. "Light" and "Standard" are Japan's plan names in LINE's developer docs, not Thai plans. Per LINE's developer docs, reply messages do not count toward the quota; push, multicast, broadcast and narrowcast do.

### Cited Findings
- FACT, checked 2026-10-19 by scrape. Thai tiers: Free 0 THB / 300 broadcast messages; Basic 1,280 THB* / 15,000 messages, extra 0.1 THB per message; Pro 1,780 THB* / 35,000 messages, extra 0.06 THB per message. *Excludes 7% VAT. The Free tier shows no extra-message price ("-"). Source: [LINE for Business TH, broadcast message page](https://lineforbusiness.com/th/service/line-oa-features/broadcast-message). The page shows no revision date.
- FACT, same source, 2026-10-19. MyCustomer | CRM costs 369 THB* on Free and on Basic, and is included at no extra cost on Pro.
- FACT, same source, 2026-10-19. Monthly packages cannot be bought on iOS and must be bought through manager.line.biz.
- FACT, official LINE announcement (not a community note). LINE for Business announced on 19 June 2024 that from 1 Aug 2024 the Free broadcast quota falls from 500 to 300 messages per month. The same notice says the Pro package's extra-message price rises from 0.04 to 0.06 THB, and that Pro is priced at 1,780 THB with MyCustomer included. Source: [LINE for Business TH news, 2024-06-19](https://lineforbusiness.com/th/news/20240619_1), search excerpt checked 2026-10-19.
- FACT, status check. The 500-to-300 change is still in effect on 2026-10-19, because the official page scraped that day shows 300 for Free. LINE's pages carry no revision date, so a change between the scrape and this check cannot be ruled out, but none is visible.
- FACT, global developer doc. The Messaging API pricing page covers quotas for all countries, and its Thailand row points to the Thai broadcast page. It says: "The number of messages is counted by the number of people you send a message to." Counted: push, multicast, broadcast and narrowcast messages. Not counted: reply messages. Messages to users who blocked the account, or to non-existent user IDs, are not counted. Once the monthly limit is exceeded, the API returns an error and nothing is sent. Usage can be checked with the get-quota and get-consumption endpoints. Upgrading mid-month raises that month's free allowance. Source: [LINE Developers, Messaging API pricing](https://developers.line.biz/en/docs/messaging-api/pricing/), scraped 2026-10-19.
- FACT, same developer doc. Its example plan table is for Japan: Communication (free, up to 200 messages), Light (JPY 5,000, up to 5,000 messages), Standard (JPY 15,000, up to 30,000 messages, up to JPY 3 per additional message). Light and Standard do not apply to Thailand.
- FACT, Thai official page, 2026-10-19. LINE lists greeting messages and auto-reply messages (ข้อความตอบกลับอัตโนมัติ) among OA features. Source: [LINE for Business TH, broadcast page](https://lineforbusiness.com/th/service/line-oa-features/broadcast-message).
- FACT, search excerpt, 2026-10-19. LINE's OA Chat package page lists chat tags and an "AI Chatbot ผู้ช่วยตอบแชทอัตโนมัติ" (AI chat auto-reply assistant). The price is not shown in the excerpt. Source: [LINE for Business TH, OA Chat package](https://lineforbusiness.com/th/service/line-oa-features/oa-chat-package).
- UNVERIFIED. A third-party guide (Syncedge) gives the OA Chat package price as THB 555 per month plus VAT, with the AI chatbot in Beta, citing LINE for Business on 27 Sep 2026. This was not confirmed on LINE's page. Source: [Syncedge LINE AI chatbot guide](https://syncedge.tech/en/guides/line-ai-chatbot/), search excerpt checked 2026-10-19.
- UNVERIFIED. Reply-token validity window. One unofficial guide says five minutes. Another guide says LINE does not publish an exact figure. Neither LINE page read here states it.

### Inferences
- The Free tier has no paid overage (the table shows "-"), and the developer doc says over-quota sends fail. A Free OA that sends more than 300 broadcasts in a month therefore stops sending until the next month or until it upgrades.
- Because reply messages are not counted, an inbound-reply bot built on reply messages would not use up the broadcast quota. Whether LINE's built-in auto-reply uses the reply endpoint in Thailand is not verified here.
- Because reply tokens expire, a reply-based bot has a time limit on responding. The length of that limit is UNVERIFIED.

### Gaps
- Whether OA Manager auto-replies consume quota in Thailand. Check the LINE Thai help center and test on a live account if possible.
- Reply-token validity window. Check LINE's Messaging API reply documentation.
- Thai price of the OA Chat package. The LINE page scrape was rate-limited; a retry is needed.

## KQ3. (c) Named competing tools in Thailand: existence and current pricing

### Takeaway
All four named tools exist. Public USD pricing was verified for respond.io and SleekFlow on 2026-10-19. Neither vendor publishes Thai-baht pricing on the pages checked. Botnoi and Chatcone exist and reference LINE OA, but their prices could not be verified in this pass. Other Thai names were found in search, but only LINE's own MyCustomer price is verified.

### Cited Findings
Named tools:
- FACT, existence and price. respond.io exists. Its pricing page, checked 2026-10-19 (page timestamp 2026-10-19T09:22Z), shows monthly-billed-yearly figures in USD: Starter $79/mo ($948/yr billed yearly), Growth $159/mo ($1,908/yr), Advanced $279/mo ($3,348/yr), Enterprise custom. The billing unit is Monthly Active Contacts (MAC), with a 1,000-contact entry tier shown. Overage is $12 per 100 MAC on Growth and $15 per 100 MAC on Advanced. Free trial: 7 days, with Growth features for 5 users and 1,000 MAC. WhatsApp fees are not included. Source: [respond.io pricing](https://respond.io/pricing), scraped 2026-10-19.
- UNVERIFIED. respond.io monthly (non-yearly) prices were not captured by the scrape. A Macha review (search excerpt) reports $99 / $199 / $349 monthly and says it checked the page on 19 Sep 2026. That fits a "save up to 20%" yearly discount ($79 / 0.8 is about $99), but it was not confirmed on the page. Source: [Macha, respond.io pricing explained](https://www.getmacha.com/blog/respond-io-pricing-explained). Whether LINE is a supported channel on a respond.io plan: UNVERIFIED. The LINE item in the page's chat widget is the vendor's own contact option, not evidence of channel support.
- FACT, existence and price. SleekFlow exists. Its pricing page, checked 2026-10-19, redirects to the en-us page. USD figures are yearly-billed per month, with the implied monthly list price in brackets: Essential $49/mo ($588/yr; monthly list about $69), Pro $109/mo ($1,308/yr; monthly list about $139), Premium $279/mo ($3,348/yr; monthly list about $349), Enterprise custom. Contacts: Essential unlimited MAC, Pro from 500 MAC, Premium from 1,000 MAC, add-on US$20 per 100 MAC. Seats: 3 / 10 / 10. Channels: 5 / 10 / 10 / unlimited. Free trial: 7 days of Pro, no card needed. LINE appears in the "channels included on every plan" list, and no LINE-specific fee is shown. WhatsApp hosting ($15/mo) and per-message fees are charged separately. Source: [SleekFlow pricing](https://sleekflow.io/pricing), scraped 2026-10-19 (en-us version). The page states that plans and pricing vary by location, and the Thai or ASEAN price was not captured: UNVERIFIED for Thailand.
- FACT, conflict. An earlier search summary said SleekFlow's official page lists a free Startup tier with 100 contacts. The 2026-10-19 scrape shows no free tier, so the summary is not used. Third-party SleekFlow figures conflict and are not used: Linktly Starter $39/mo (Jul 2026), Dupple Pro $79 and Premium $199 annual (Jul 2026), Toolradar Pro AI $149 (Sep 2026).
- FACT, existence. Botnoi exists. Its homepage excerpt shows a LINE logo and "Reply Chat, Call, Answer Automatically with Intelligent AI Agent." Source: [botnoi.ai](https://botnoi.ai/), search excerpt checked 2026-10-19. LINE Developers Thailand's OA store lists "BOTNOI SME PLATFORM" as a chatbot platform for LINE OA and Facebook Page with live chat and API connections. Source: [LINE Developers TH, Botnoi SME Platform](https://linedevth.line.me/th/oa-store/boinoi-sme-platform), excerpt, date not shown.
- UNVERIFIED, Botnoi pricing. A Facebook post excerpt (linebizth page) mentions a "แพ็กเกจ Business (เริ่มต้นที่ 2,000 บาท)" (Business package, starting at 2,000 THB), but it is not confirmed that this is Botnoi's price or that the post is about Botnoi. Source: [LINE Business TH Facebook post](https://www.facebook.com/linebizth/posts/-%E0%B8%AD%E0%B8%A2%E0%B8%B2%E0%B8%81%E0%B9%83%E0%B8%AB%E0%B9%89%E0%B8%A5%E0%B8%B9%E0%B8%81%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B9%84%E0%B8%94%E0%B9%89%E0%B8%84%E0%B8%B3%E0%B8%95%E0%B8%AD%E0%B8%9A%E0%B9%84%E0%B8%A7-%E0%B9%84%E0%B8%A1%E0%B9%88%E0%B8%95%E0%B9%89%E0%B8%AD%E0%B8%87%E0%B8%A3%E0%B8%AD%E0%B8%99%E0%B8%B2%E0%B8%99%E0%B9%80%E0%B8%AB%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%99%E0%B8%A1%E0%B8%B5%E0%B8%9C%E0%B8%B9%E0%B9%89%E0%B8%8A%E0%B9%88%E0%B8%A7%E0%B8%A2%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%88%E0%B8%B3%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%99%E0%B8%AD%E0%B8%A2%E0%B8%B9%E0%B9%88%E0%B8%95%E0%B8%A5%E0%B8%AD%E0%B8%94%E0%B8%A7%E0%B8%B1%E0%B8%99-%E0%B8%97%E0%B8%B3%E0%B9%84%E0%B8%94%E0%B9%89%E0%B9%81%E0%B8%A5/1244679891020645/). A separate Botnoi group page (botnoigroup.com/teamprice) lists THB 1,000 per user per month for a Voice and AI product, with a 3-month minimum, excl. VAT. It is a different product line and its date is not shown. Source: [Botnoi group team price](https://botnoigroup.com/teamprice), excerpt.
- FACT, existence. Chatcone exists. Its homepage excerpt describes a unified inbox for Facebook, LINE, Instagram, Lazada and TikTok with an AI chatbot. Source: [Chatcone](https://www.chatcone.com/), search excerpt checked 2026-10-19. No price was in the excerpt, and the scrape was rate-limited: pricing UNVERIFIED.

Other Thai names found in search (existence only, unless stated):
- FACT, LINE's own MyCustomer | CRM. 369 THB per month on Free and Basic, included on Pro. Verified 2026-10-19 on the official TH page (see KQ2).
- UNVERIFIED, Atlas Chat by Relevant Audience. Search excerpt lists plans including "Business ฿5,900" (20 agents, 10 LINE OAs) and "Dedicated from ฿15,000." Not scraped; date not shown. Source: [Relevant Audience, LINE CRM](https://www.relevantaudience.com/line-crm/).
- UNVERIFIED, ReadyPlanet (R-CRM, R-ChatCenter). Named in a LineBot.pro comparison blog with a "2026 pricing" heading. No ReadyPlanet price was read. Source: [LineBot.pro comparison, Thailand](https://linebot.pro/blog/line-bot-builder-comparison-thailand).
- UNVERIFIED, SellStory (sales CRM). Named in the Facebook video above. Pricing not checked.
- UNVERIFIED, Oho Chat. A chat-response blog, [oho.chat](https://www.oho.chat/blog/how-to-respond-to-customer-faster). Pricing not checked.

### Inferences
- The global tools (respond.io, SleekFlow) are priced in USD for the US or regional markets, with MAC-based billing. Thai buyers would pay in a different currency, with VAT and possibly different tiers. The Thai-baht figures above are not comparable to USD figures without a checked exchange rate and a feature match.
- LINE-native options (OA Pro at 1,780 THB, MyCustomer at 369 THB) are the cheapest verified LINE-specific items found.

### Gaps
- Chatcone and Botnoi pricing: scrape chatcone.com and botnoi.ai (and their pricing pages) once the Firecrawl rate limit resets.
- Thai-baht or ASEAN pricing for respond.io and SleekFlow: not captured. SleekFlow's "Other ASEAN countries" page (sleekflow.io/en-asean/pricing) was not scraped.
- Whether respond.io supports LINE on its plans: not verified.
- Pricing for Atlas Chat, ReadyPlanet, SellStory and Oho Chat: not verified.

## KQ4. (d) Willingness to pay for LINE chat automation, CRM or lead-response tools (real estate)

### Takeaway
No public evidence was found in this pass that independent real estate agents or agencies pay for LINE chat automation, CRM or lead-response tools. The sector-adjacent items are price lists and vendor claims, which grade D or are not willingness-to-pay data. Under the S/A/B/C/D scale, nothing reaches B for this segment, and nothing reaches S or A.

### Cited Findings
- FACT, price list, not graded. LINE Thai OA paid tiers exist (Basic 1,280 THB, Pro 1,780 THB, MyCustomer 369 THB). A price list shows availability, not purchases. Source: [LINE for Business TH, broadcast page](https://lineforbusiness.com/th/service/line-oa-features/broadcast-message), 2026-10-19.
- FACT, vendor claim, grade D. respond.io's pricing page displays "Based on 500+ G2 reviews" with a 4.8 rating. This is a vendor-displayed figure and is not specific to real estate. Source: [respond.io pricing](https://respond.io/pricing), 2026-10-19.
- FACT, vendor claim, grade D. SleekFlow's pricing page says "More than 7,000 businesses trust SleekFlow." This is a vendor claim and is not sector-specific. Source: [SleekFlow pricing](https://sleekflow.io/pricing), 2026-10-19.
- FACT, vendor marketing, grade D. Go Online Thailand, a LINE partner agency, sells LINE OA account and package setup. The blog excerpt gives no customer counts or revenue, and nothing is real estate-specific. Source: [Go Online Thailand, LINE OA category](https://goonlinethailand.com/blog/category/social-media/line/), excerpt checked 2026-10-19.
- UNVERIFIED, stated interest, grade C at most. A Facebook group post in the LINEDEVTH group asks whether LINE OA offers an annual broadcast package and what it costs (Thai: "Line OA มีแพ็กเกจบรอดแคสต์รายปี ราคาเท่าไหร่"). It is a question, not a purchase. The poster's role, the post date and any link to real estate are not visible. Source: [LINEDEVTH Facebook group post](https://www.facebook.com/groups/LINEDEVTH/posts/1537931083537459/), excerpt checked 2026-10-19.

### Inferences
- Demand signals for LINE-native paid tiers exist in general (LINE sells several tiers). None of the public sources links that demand to real estate agents.

### Gaps
- No public Thai real estate agent or agency posts about paying for a LINE CRM or chatbot with prices or dates were found.
- Pantip threads on LINE CRM cost for agents were not searched.
- LINE's Thai success stories were not checked for real estate cases.
- No customer count or revenue figure for any named tool in the Thai real estate segment was found.
- Atlas Chat's listed "Business" price is a price point only; no customers are disclosed.

### Source log (date checked: 2026-10-19 for all)
- Scrape: [LINE for Business TH broadcast page](https://lineforbusiness.com/th/service/line-oa-features/broadcast-message)
- Scrape: [LINE Developers, Messaging API pricing](https://developers.line.biz/en/docs/messaging-api/pricing/)
- Scrape: [respond.io pricing](https://respond.io/pricing) (page timestamp 2026-10-19T09:22Z)
- Scrape: [SleekFlow pricing](https://sleekflow.io/pricing) (en-us version)
- Search excerpt: [LINE for Business TH news, 2024-06-19](https://lineforbusiness.com/th/news/20240619_1)
- Search excerpt: [LINE for Business TH, OA Chat package](https://lineforbusiness.com/th/service/line-oa-features/oa-chat-package)
- Search excerpt: [Syncedge](https://syncedge.tech/en/guides/line-ai-chatbot/) (third-party, UNVERIFIED)
- Search excerpt: [Macha](https://www.getmacha.com/blog/respond-io-pricing-explained) (third-party, UNVERIFIED)
- Search excerpt: [botnoi.ai](https://botnoi.ai/), [LINE Developers TH Botnoi listing](https://linedevth.line.me/th/oa-store/boinoi-sme-platform), [Botnoi group team price](https://botnoigroup.com/teamprice), [Chatcone](https://www.chatcone.com/)
- Search excerpt: [Relevant Audience, LINE CRM](https://www.relevantaudience.com/line-crm/), [LineBot.pro comparison](https://linebot.pro/blog/line-bot-builder-comparison-thailand)
- Search excerpt, social posts: [Instagram](https://www.instagram.com/p/Dd0xX1JFiS7/), [SellStory video](https://www.facebook.com/sellstoryth/videos/%E0%B8%96%E0%B9%89%E0%B8%B2%E0%B8%A2%E0%B8%B1%E0%B8%87%E0%B8%95%E0%B9%89%E0%B8%AD%E0%B8%87%E0%B8%A1%E0%B8%B2%E0%B8%99%E0%B8%B1%E0%B9%88%E0%B8%87%E0%B9%80%E0%B8%84%E0%B8%A3%E0%B8%B5%E0%B8%A2%E0%B8%94-%E0%B9%80%E0%B8%9E%E0%B8%A3%E0%B8%B2%E0%B8%B0%E0%B8%95%E0%B8%AD%E0%B8%9A%E0%B9%81%E0%B8%8A%E0%B8%97%E0%B8%A5%E0%B8%B9%E0%B8%81%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B9%84%E0%B8%A1%E0%B9%88%E0%B9%84%E0%B8%AB%E0%B8%A7-%E0%B8%88%E0%B8%99%E0%B8%A5%E0%B8%B9%E0%B8%81%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%A2-%E0%B8%A2%E0%B8%AD%E0%B8%94%E0%B8%82%E0%B8%B2%E0%B8%A2%E0%B8%95%E0%B8%81-%E0%B8%96%E0%B8%B6%E0%B8%87%E0%B9%80%E0%B8%A7%E0%B8%A5%E0%B8%B2%E0%B8%88%E0%B8%B1%E0%B8%94%E0%B8%81%E0%B8%B2/592918163651576/), [LINEDEVTH group post](https://www.facebook.com/groups/LINEDEVTH/posts/1537931083537459/)
- Search excerpt, blogs: [thisaan](https://thisaan.cloud/blog/line-customer-service-system/), [Oho Chat](https://www.oho.chat/blog/how-to-respond-to-customer-faster), [Go Online Thailand](https://goonlinethailand.com/blog/category/social-media/line/)
- Access failures: direct fetch of developers.line.biz, respond.io, sleekflow.io, chatcone.com and botnoi.ai refused by the egress proxy (403 on CONNECT) and by WebFetch DNS. Firecrawl rate limit hit on several calls; the Chatcone, Botnoi and LINE OA Chat package scrapes were not completed.
