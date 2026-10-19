-- Seeds the nine P01 assumptions from validation/p01-ea-validation/assumptions.md.
-- Statements and kill_if values are copied from that file. Keep the two in step if either changes
-- before the pre-registration is locked. Re-running this file changes nothing (on conflict do nothing).
insert into assumptions (id, kind, statement, kill_if, status) values
  ('A1', 'problem',   'นักพัฒนา EA ที่ทำ backtest เองเจอปัญหาผลจริงต่างจาก backtest อย่างน้อยสัปดาห์ละครั้ง',
                      'ใน 15 คนที่ตรง segment น้อยกว่า 8 คน (K1)', 'untested'),
  ('A2', 'awareness', 'ผู้ตอบรู้จักวิธีตรวจ (walk-forward, OOS, Monte Carlo, parameter plateau) และเคยลองทำเอง',
                      'ห้าคนแรกไม่มีใครพูดถึงการเสียเงินหรือเวลากับกลยุทธ์ที่ไม่ผ่าน', 'untested'),
  ('A3', 'problem',   'มี workaround ที่จ่ายเงินหรือเวลามูลค่าชัดเจนอยู่แล้ว',
                      'น้อยกว่า 5 คนจากผู้ตรง segment (K2)', 'untested'),
  ('A4', 'value',     'Riskiest: ผู้ที่ตัดสินใจเรื่องเงินกับเครื่องมือเองจ่ายให้คนอื่นตรวจกลยุทธ์ก่อนเปิดบัญชีจริง',
                      'offer ที่ไม่ใช่คนรู้จักปิดได้น้อยกว่า 1 ราย จาก 15 ราย ในรอบที่ 2 (K3)', 'untested'),
  ('A5', 'value',     'ราคาที่ผู้ตอบจ่ายจริงอยู่ในช่วงที่ทดสอบ (990 / 2,490 / 4,990 บาท)',
                      'ไม่มีใครปิดที่ราคาใดเลยหลังปรับสคริปต์ 1 รอบ', 'untested'),
  ('A6', 'channel',   'มีช่องทางอย่างน้อย 5 ช่องที่ผ่านทั้งชื่อยืนยันแล้วและกติกายืนยันแล้ว',
                      'ทำได้ไม่ถึง 5 ช่อง', 'untested'),
  ('A7', 'awareness', 'ชุมชนไทย (Pantip, Facebook) พูดเรื่องการตรวจกลยุทธ์ EA จริง',
                      'ไม่พบบทสนทนาเรื่องนี้ในช่องทางที่ใช้ได้ภายใน Day 3', 'untested'),
  ('A8', 'value',     'บริการวิเคราะห์ความทนทานของผลทดสอบที่ลูกค้าส่งมาเอง ไม่เข้าข่ายคำแนะนำการลงทุนที่ต้องขออนุญาต',
                      'ทนายตอบว่าต้องขออนุญาต แล้วหยุด P01 ทันที', 'untested'),
  ('A9', 'awareness', 'MT5 Strategy Tester และเครื่องมือฟรีเพียงพอสำหรับผู้ตอบส่วนใหญ่',
                      'ผู้ตอบส่วนใหญ่บอกว่าเพียงพอจนไม่มีใครยอมให้ตรวจแทน แล้ว KILL', 'untested')
on conflict (id) do nothing;
