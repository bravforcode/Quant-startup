# Competitor worksheet — P01 (Day 3, review mining)

> **สถานะ: ปิดบางส่วน.** Trustpilot ของ StrategyQuant, QuantConnect และ Build Alpha ตรวจครบแล้ว ส่วน Reddit, MQL5 และ Pantip ถูก proxy บล็อก (403) จึงยังไม่ได้อ่าน
> วันที่ตรวจ: 2026-10-19 · รันโดย workflow `review-mining-p01` (run `wf_dbdcf5d0-1ae`) · เกรดตาม `preregistration.md`: ราคาจากหน้าขายของผู้ขาย = FACT · รีวิวที่ยืนยันย้อนกลับแล้ว = B (ผู้ใช้เขียนเองและตรวจได้) · แท็กประเด็นของ agent = OPINION · คำโฆษณาของผู้ขาย = D

## 1. ราคาและฟีเจอร์ตรวจความทนทาน (จาก brief Stage 1, KQ3)

| เครื่องมือ | ราคาที่ยืนยัน (USD, ex-VAT) | ฟีเจอร์ตรวจความทนทาน | ใช้กับ MT5 | หมายเหตุ |
|---|---|---|---|---|
| StrategyQuant X | Starter $129/เดือน (12 เดือน) หรือ $1,290 ครั้งเดียว · Professional $149/เดือน หรือ $1,490 | Professional ขึ้นไป: Monte Carlo, permutation, Walk-Forward matrix, Optimizer | มี (SQ for Business ใน Ultimate) | ราคาคู่บางตัว (เช่น $175 / $1,790) ยังไม่ระบุว่าอันไหนปัจจุบัน ไม่คืนเงิน ผ่อนแพงขึ้น 17% |
| Build Alpha | ตลอดชีพ $1,497 (ขีดฆ่า $2,497) · ราคาสมัครสมาชิกยังไม่ยืนยัน | "stress test และกรอง candidate ที่เปราะออกอัตโนมัติ" (คำของผู้ขาย) | มี | ไม่มีทดลองฟรี · หน้า licensing ระบุว่า "one-man shop" |
| QuantConnect | Free $0 · Researcher $84/เดือน · Team $168/ผู้ใช้/เดือน · Trading Firm $480 · Institution $1,272 · Cloud Optimization เป็น add-on | "Cloud Optimization" วัดความไวต่อ parameter (หน้าผู้ขายเขียนว่า "avoid overfitting") | **ไม่มี** broker MetaTrader ในหน้าราคา | ใช้ Python/C# บนคลาวด์ ไม่ใช่ EA บน MT5 |
| TradingView | Essential $12.95 · Plus $29.95 · Premium $59.95 · Ultimate $199.95 ต่อเดือน (จ่ายรายปี) | Strategy backtesting, report, export CSV (สิทธิ์แต่ละแพ็กเกจยังไม่ยืนยัน) | ไม่มีการกล่าวถึง MetaTrader | ไม่ใช่เครื่องมือ robustness โดยตรง |
| MT5 Strategy Tester | ฟรี (ติดมากับ terminal) | Walk-forward ยังขัดแย้งกันในแหล่งที่อ่านได้ (ยังไม่ได้เปิดหน้า help) | — | **คู่แข่งหลักที่ผู้ตอบอาจบอกว่า "เพียงพอ" (A9)** |
| MQL5 Market | ค่าคอมมิชชัน 20% · ราคาขั้นต่ำ $30 | ไม่ใช่บริการตรวจ มีแค่ formal pre-test | — | กฎห้ามสินค้าที่แสดง backtest เป็นผลจริงและห้ามสัญญาผลกำไร |

## 2. Trustpilot: ผลการอ่านรีวิวและการยืนยัน

| ผู้ขาย | รีวิวทั้งหมดตามหน้า | รีวิว 1–2 ดาวที่อ่าน | ยืนยันย้อนกลับ | หมายเหตุ |
|---|---|---|---|---|
| StrategyQuant | 8 | **0** (ทั้ง 8 รายการ 5 ดาว ตัวกรอง 1–2 ดาวแสดง "No matches") | ไม่มีรายการให้ยืนยัน | TrustScore 4.3 · โปรไฟล์ยังไม่ถูกเคลม · บริษัทระบุว่าไม่ได้เชิญลูกค้าให้รีวิว จึงอาจไม่เป็นตัวแทน |
| QuantConnect | 67 | **15** (หน้า 2 ซ้ำกับหน้า 1 จึงไม่มีรายการเพิ่ม) | **15/15** | TrustScore 4.2 · บริษัทไม่ตอบรีวิวเชิงลบ |
| Build Alpha | ไม่มีหน้า (404 ทั้งสอง URL) | 0 | — | ไม่มีรีวิวบน Trustpilot ที่เข้าถึงได้ |

**การกระจายปีของ 15 รีวิว QuantConnect (ตามวันที่บนการ์ด):** 2026: 2 · 2025: 1 · 2024: 3 · 2023: 1 · 2022: 3 · 2021: 2 · 2020: 3 รีวิวล่าสุดอยู่ในปี 2026 จึงใช้เป็นสัญญาณปัจจุบันได้บางส่วน

**แท็กประเด็นของ 15 รีวิว QuantConnect (agent จัดให้ ยังไม่ได้ตรวจด้วยมือทั้งหมด = OPINION):**

| ประเด็น | จำนวนรีวิว (จาก 15) | ตัวอย่างสั้น |
|---|---|---|
| learning-curve (เรียนรู้ยาก) | 10 | "QC is an extremely difficult system to use for the average trader" |
| other | 8 | รวมคำด่าทั่วไป เช่น "It's absolute trash" |
| cost (ราคา) | 7 | "Some people like to make simple things complicated and charge a fee for everything." |
| bugs | 6 | "The coding environment has lots of bugs, wont save files" |
| slow (backtest ช้า) | 4 | "backtesting is slow when trading many assets with high resolution data" |
| billing (การเรียกเก็บเงิน) | 3 | "False advertising $10 tier is $60" |
| support | 3 | "he deleted my account" |
| robustness-feature | 3 | แท็กนี้ไม่แม่น: รายการ "They deleted my file" เกี่ยวกับการลบไฟล์ ไม่ใช่ความทนทานของผลทดสอบ |
| backtest-accuracy | 2 | ยังไม่พบการร้องเรียนว่าผลลัพธ์ผิด |
| refund | 1 | — |
| mt5-support | 1 | ไม่พบการร้องเรียนว่า MT5 ไม่รองรับโดยตรง |

## 3. ความคืบหน้า Day 3 (review mining)

- [x] QuantConnect: Trustpilot 1–2 ดาว 15 รายการ ยืนยันย้อนกลับ 15/15
- [x] StrategyQuant: Trustpilot ทั้ง 8 รีวิว (ไม่มี 1–2 ดาว)
- [x] Build Alpha: Trustpilot ตรวจแล้ว ไม่มีหน้ารีวิว
- [ ] **ค้าง (proxy 403):** reddit.com (r/algotrading, r/Forex) และ mql5.com (EA forum 515316, 466402, 459197 และ General 515754) และ pantip.com
- [ ] **ยังไม่ได้:** ฟอรัม StrategyQuant ที่เรียงตามปีล่าสุด (ผลค้นส่วนใหญ่เก่า 2019–2023)
- [ ] **ยังไม่ได้:** Elite Trader และ NexusFi กระทู้ปี 2025–2026 (มีแค่กระทู้ NexusFi ที่ค้นเจอจากผลค้นหา)

**สิ่งที่จะทำให้ปิดได้ครบ:** ผู้ก่อตั้งเพิ่ม reddit.com, mql5.com และ pantip.com ใน Allowed domains ของ environment (ตามเอกสาร environment.network) แล้วให้ผมอ่านต่อ หรืออ่านด้วยตัวเองแล้ววางข้อความให้

## 4. ข้อสังเกตสำหรับ P01 (สมมติฐาน ไม่ใช่ข้อสรุป)

- ในรีวิว Trustpilot ที่อ่านได้ ไม่พบรีวิวที่ร้องเรียนขั้นตอนตรวจความทนทานของผลทดสอบโดยตรง ประเด็นที่พบซ้ำคือการเรียนรู้ยาก ราคา และบั๊ก
- StrategyQuant บน Trustpilot มีแต่ 5 ดาว คำร้องเรียนที่พบก่อนหน้านี้อยู่ในฟอรัมเก่า
- เครื่องมือที่ทำ robustness มักอยู่ใน bundle ราคาประมาณ $1,000–1,500 (SQX Professional, Build Alpha) หรือเป็นแพลตฟอร์มคลาวด์ที่ไม่รองรับ MT5 (QuantConnect) ซึ่งเป็นช่องว่างที่ต้องทดสอบด้วย A4 และ A9
- ยังไม่มีหลักฐานว่าคนจ่ายแยกสำหรับขั้นตอนตรวจความทนทานโดยเฉพาะ
- สิ่งที่ทำให้สมมติฐานนี้อ่อนลง: ผู้ตอบบอกว่า SQX Professional หรือ Build Alpha ตอบโจทย์แล้ว หรือใช้ MT5 Strategy Tester ฟรีและพอใจ

## 5. แหล่งที่ใช้

- Trustpilot StrategyQuant: https://www.trustpilot.com/review/strategyquant.com (รวมตัวกรอง 1–2 ดาวและ languages=all)
- Trustpilot QuantConnect 1–2 ดาว: https://www.trustpilot.com/review/quantconnect.com?stars=1&stars=2 (รีวิวแต่ละรายการมี URL ที่ `trustpilot.com/reviews/...` ใน run `wf_dbdcf5d0-1ae`)
- Trustpilot Build Alpha: https://www.trustpilot.com/review/buildalpha.com (ได้ 404)
- ฟอรัมและกระทู้ที่ค้นเจอก่อนหน้า: [StrategyQuant Annoyances](https://strategyquant.com/forum/topic/strategyquant-annoyances/), [Multiple bugs](https://strategyquant.com/forum/topic/multiple-bugs/), [SQ3 import bugs](https://roadmap.strategyquant.com/tasks/sq4_1276), [NexusFi Build Alpha](https://nexusfi.com/showthread.php?p=911156)
- ราคาและฟีเจอร์: `research_notes/.../p01_ea_validation.md` (commit `ae1d6b8`) ตามที่เปิดอ่านจากหน้าขายของผู้ขายและ mql5.com/en/market/rules เมื่อ 2026-10-19
