# Competitor worksheet — P01 (Day 3, review mining)

> **สถานะ: บางส่วน (partial).** ข้อมูลส่วนใหญ่มาจากผลค้นหา (snippet) ที่ยังไม่ได้เปิดอ่านหน้าเต็ม ยังไม่ได้นับรีวิว 1–2 ดาวจากทุกแหล่ง
> วันที่ตรวจ: 2026-10-19 · เกรดตาม `preregistration.md`: ราคาจากหน้าขายของผู้ขาย = FACT · รีวิวจาก snippet = C · คำโฆษณาของผู้ขาย = D

## 1. ราคาและฟีเจอร์ตรวจความทนทาน (จาก brief Stage 1, KQ3)

| เครื่องมือ | ราคาที่ยืนยัน (USD, ex-VAT) | ฟีเจอร์ตรวจความทนทาน | ใช้กับ MT5 | หมายเหตุ |
|---|---|---|---|---|
| StrategyQuant X | Starter $129/เดือน (12 เดือน) หรือ $1,290 ครั้งเดียว · Professional $149/เดือน หรือ $1,490 | Professional ขึ้นไป: Monte Carlo, permutation, Walk-Forward matrix, Optimizer | มี (SQ for Business ใน Ultimate) | ราคาคู่บางตัว (เช่น $175 / $1,790) ยังไม่ระบุว่าอันไหนปัจจุบัน; ไม่คืนเงิน; ผ่อนแพงขึ้น 17% |
| Build Alpha | ตลอดชีพ $1,497 (ขีดฆ่า $2,497) · ราคาสมัครสมาชิกยังไม่ยืนยัน | "stress test และกรอง candidate ที่เปราะออกอัตโนมัติ" (คำของผู้ขาย) | มี | ไม่มีทดลองฟรี · ชื่อผู้ขายบนหน้า licensing: "one-man shop" |
| QuantConnect | Free $0 · Researcher $84/เดือน · Team $168/ผู้ใช้/เดือน · Trading Firm $480 · Institution $1,272 · Cloud Optimization เป็น add-on | "Cloud Optimization" วัดความไวต่อ parameter (หน้าผู้ขายเขียนว่า "avoid overfitting") | **ไม่มี** broker MetaTrader ในหน้าราคา | ใช้ Python/C# บนคลาวด์ ไม่ใช่ EA บน MT5 |
| TradingView | Essential $12.95 · Plus $29.95 · Premium $59.95 · Ultimate $199.95 ต่อเดือน (จ่ายรายปี) | Strategy backtesting, report, export CSV (สิทธิ์แต่ละแพ็กเกจยังไม่ยืนยัน) | ไม่มีการกล่าวถึง MetaTrader | ไม่ใช่เครื่องมือ robustness โดยตรง |
| MT5 Strategy Tester | ฟรี (ติดมากับ terminal) | Walk-forward ยังขัดแย้งกันในแหล่งที่อ่านได้ (ยังไม่ได้เปิดหน้า help) | — | **คู่แข่งหลักที่ผู้ตอบบอกว่า "เพียงพอ" (A9)** |
| MQL5 Market | ค่าคอมมิชชัน 20% · ราคาขั้นต่ำ $30 | ไม่ใช่บริการตรวจ — มีแค่ formal pre-test | — | กฎห้ามสินค้าที่แสดง backtest เป็นผลจริง และห้ามสัญญาผลกำไร |

## 2. ประเด็นร้องเรียนที่พบ (จาก snippet — ไม่ใช่การนับจากทั้งหมด)

| ธีม | StrategyQuant | Build Alpha | QuantConnect |
|---|---|---|---|
| บั๊ก / ความเสถียร | มี: ฟิลเตอร์ผิด (SQ3 เลิกอัปเดตแล้ว), "Multiple bugs" ในฟอรัม | ไม่พบ | มี: timeout ใน backtest หลายสินทรัพย์, local LEAN ตั้งยาก (รีวิว 1 ดาว ปี 2021) |
| ราคา / ความคุ้มค่า | Trustpilot 4.3 จาก 8 รีวิว ค่าต่ำสุด "cost vs value" 3.4 (aggregator, URL ไม่ได้บันทึก) | "$20,000 ต่อปี" เป็นกรอบการขายของผู้ขาย (D) | "แพงสำหรับนักลงทุนรายบุคคล" (รีวิว 1 ดาว ปี 2021) |
| การเรียนรู้ / การเขียนโค้ด | อ้างว่า "code-free" แต่มีผู้ใช้โต้แย้ง | ไม่พบ | Python debug ยาก, API เรียนรู้ยาก |
| ความไว้วางใจต่อผู้ขาย | "เครื่องมือเปลี่ยนชื่อหลายครั้ง ไม่แน่ใจว่าจะอยู่ต่อ" | ไม่พบ | ไม่พบ |
| ข้อจำกัดของบัญชี | คำเตือนจากแหล่งที่สาม: prop firm บางแห่งห้ามเครื่องมือเทรดอัตโนมัติ | ไม่พบ | ไม่พบ |
| ประสิทธิภาพเครื่อง | ไม่พบ | ผู้ใช้ NexusFi รายหนึ่ง: CPU หนักจนผลช้า | ไม่พบ |
| ความน่าเชื่อถือของ "การตรวจ overfit" | ไม่พบคำร้องเรียน | ไม่พบคำร้องเรียน | ไม่พบคำร้องเรียน |

**อ่านจากตารางนี้:** ในผลที่ค้นได้ **ไม่พบคำร้องเรียนเรื่องขั้นตอนตรวจความทนทานเลย** ที่พบคือเรื่องบั๊ก ราคา และการใช้งาน (OPINION — จำนวนตัวอย่างน้อย และส่วนใหญ่เป็นกระทู้เก่า)

## 3. ความคืบหน้า Day 3 (review mining)

- [x] StrategyQuant: ค้นกระทู้ฟอรัม, aggregator, รีวิว 10 วัน (futures.io) — ยังไม่เปิดหน้าเต็ม
- [x] QuantConnect: ค้นรีวิว Trustpilot และกระทู้ฟอรัม — รีวิว 1 ดาวที่พบเป็นปี 2021
- [x] Build Alpha: ค้นกระทู้ NexusFi และ aggregator — ไม่มีหน้ารีวิวบน Trustpilot
- [ ] **ยังไม่ได้:** เปิดรีวิว 1–2 ดาวทั้งหมดบน Trustpilot และหน้า review ของ StrategyQuant
- [ ] **ยังไม่ได้:** ฟอรัม StrategyQuant และ QuantConnect เรียงตามปีล่าสุด (ผลค้นส่วนใหญ่เก่า)
- [ ] **ยังไม่ได้:** r/algotrading — เครื่องมือค้นหาไม่ให้ผลจาก reddit.com ต้องเปิดเองหรือผ่าน Reddit search
- [ ] **ยังไม่ได้:** Elite Trader / NexusFi กระทู้ปี 2025–2026

**จะปิด Day 3 ได้เมื่อ:** นับธีมจากรีวิว 1–2 ดาวอย่างน้อย 20 รายการต่อเครื่องมือ (หรือทั้งหมดถ้าน้อยกว่า) และบันทึกลิงก์ทุกรายการที่ใช้

## 4. ข้อสังเกตสำหรับ P01 (สมมติฐาน ไม่ใช่ข้อสรุป)

- ช่องว่างที่ค้นพบ: เครื่องมือที่ทำ robustness มักอยู่ใน bundle ราคาประมาณ $1,000–1,500 (SQX Professional, Build Alpha) หรือเป็นแพลตฟอร์มคลาวด์ที่ไม่รองรับ MT5 (QuantConnect) ผู้ตอบที่เป็นนักพัฒนา MT5 อาจไม่ต้องการ bundle นี้ก็ได้ — ต้องทดสอบด้วย A4 และ A9
- ยังไม่มีหลักฐานว่าคนจ่ายแยกสำหรับขั้นตอนตรวจความทนทานโดยเฉพาะ (ไม่พบยอดขายหรือ intent ที่ยืนยันได้)
- สิ่งที่ทำให้สมมติฐานนี้อ่อนลง: ถ้าผู้ตอบบอกว่า SQX Professional หรือ Build Alpha ตอบโจทย์แล้ว หรือใช้ MT5 Strategy Tester ฟรีและพอใจ

## 5. แหล่งที่ใช้ (ผลค้นหา ยังไม่ได้เปิดทั้งหมด)

- [StrategyQuant Annoyances](https://strategyquant.com/forum/topic/strategyquant-annoyances/) · [Multiple bugs](https://strategyquant.com/forum/topic/multiple-bugs/) · [SQ3 import bugs](https://roadmap.strategyquant.com/tasks/sq4_1276)
- [รีวิว 10 วัน StrategyQuant (futures.io)](https://futures.io/trading-reviews-vendors/35508-my-review-strategyquant-strategyquant-com-after-10-days-trial-2.html)
- [Build Alpha (GodFunded)](https://thegodfunded.com/en/tools/build-alpha/) · [NexusFi Build Alpha thread](https://nexusfi.com/showthread.php?p=911156)
- [QuantConnect รีวิว Trustpilot หน้า 4](https://at.trustpilot.com/review/quantconnect.com?page=4) · [กระทู้ QuantConnect "a new user's initial impressions"](https://www.quantconnect.com/forum/discussion/12235/a-new-user-039-s-initial-impressions/)
- ราคาและฟีเจอร์: `research_notes/.../p01_ea_validation.md` (commit `ae1d6b8`) ตามที่เปิดอ่านจาก strategyquant.com/pricing, buildalpha.com/licensing, quantconnect.com/pricing, tradingview.com/pricing และ mql5.com/en/market/rules เมื่อ 2026-10-19
