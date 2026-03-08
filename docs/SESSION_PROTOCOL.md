# Quy Trình Phiên Làm Việc — Ứng Dụng Di Động "Cơm Tấm Má Tư"

> Tài liệu này quy định cách tổ chức phiên làm việc với AI agent khi phát triển ứng dụng Flutter.
> Nguyên tắc cốt lõi: **phiên ngắn, checkpoint rõ ràng, không để context suy giảm.**

---

## 1. Nguyên Tắc Chủ Đạo

- **Một nhiệm vụ = một phiên.** Commit trước. Commit sau. Kết thúc phiên.
- Context bắt đầu suy giảm sau khoảng **45 phút** hoặc **15–20 lượt trao đổi**.
- Phiên ngắn + checkpoint sạch **tốt hơn** phiên dài với output kém chất lượng.
- Mọi màn hình đều phải hỗ trợ **offline-first** — không có ngoại lệ.

---

## 2. Vòng Đời Phiên Làm Việc

### 2.1. Trước Phiên (Before)

```bash
# 1. Đồng bộ mã nguồn
git pull origin main

# 2. Kiểm tra trạng thái sạch
git status  # phải trả về "nothing to commit, working tree clean"

# 3. Commit checkpoint (nếu có thay đổi chưa commit)
git add -A && git commit -m "checkpoint: trước phiên [mô tả ngắn]"

# 4. Xác nhận build thành công
flutter analyze
flutter test
```

**Mở phiên mới với Task Contract:**

```
NHIỆM VỤ: [Mô tả cụ thể, ví dụ: "Tạo màn hình Lịch sử đơn hàng"]
PHẠM VI: [Các file/thư mục sẽ thay đổi]
RÀNG BUỘC: [Giới hạn, ví dụ: "Chỉ UI, không đổi logic backend"]
TIÊU CHÍ HOÀN THÀNH: [Điều kiện để coi là xong]
DỰ KIẾN: [Số lượt trao đổi / thời gian]
```

### 2.2. Trong Phiên (During)

- **Giữ đúng phạm vi.** Không mở rộng nếu chưa thống nhất.
- Nếu phát hiện việc ngoài phạm vi → **ghi lại, không làm ngay.** Tạo nhiệm vụ riêng.
- Sau **15 lượt trao đổi** hoặc **45 phút** → checkpoint commit + kết thúc phiên.
- Mỗi thay đổi phải duy trì trạng thái build được (`flutter analyze` phải pass).

### 2.3. Sau Phiên (After)

```bash
# 1. Xác minh toàn bộ
flutter analyze                      # Không warning, không error
flutter test                         # Tất cả test pass
flutter build apk --debug           # Build Android thành công
flutter build ios --debug --no-codesign  # Build iOS thành công (trên macOS)

# 2. Commit kết quả
git add -A && git commit -m "feat/fix/refactor: [mô tả ngắn gọn]"

# 3. Kết thúc phiên — KHÔNG tiếp tục
```

---

## 3. Xử Lý Lỗi

Khi gặp lỗi mà agent không sửa được trong 2–3 lượt:

```
DỪNG LẠI → revert về checkpoint → kết thúc phiên → mở phiên mới
```

**Mẫu prompt cho phiên khôi phục:**

```
PHIÊN KHÔI PHỤC LỖI:
- Nhiệm vụ gốc: [mô tả]
- Lỗi gặp phải: [mô tả lỗi cụ thể]
- Đã thử: [liệt kê các cách đã thử]
- Trạng thái hiện tại: đã revert về commit [hash]
- Cách tiếp cận mới: [hướng đi khác]
```

**Quy tắc quan trọng:** Không để agent tự sửa lỗi của chính nó trong cùng phiên. Context đã bị nhiễm — mở phiên mới sẽ hiệu quả hơn.

---

## 4. Phiên Song Song

Chỉ áp dụng khi các module **hoàn toàn độc lập** (khác màn hình, khác file).

**Thứ tự bắt buộc:**

1. Thay đổi package dùng chung (`core/`, `shared/`, `models/`) → commit trước.
2. Sau đó mới chạy song song các module tiêu thụ.

**Ví dụ hợp lệ:**

```
Phiên 1: Màn hình Đặt hàng (lib/features/order/)
Phiên 2: Màn hình Đánh giá (lib/features/review/)
→ OK — khác thư mục, không chia sẻ state
```

**Ví dụ KHÔNG hợp lệ:**

```
Phiên 1: Thêm model OrderItem vào core
Phiên 2: Dùng OrderItem trong màn hình Đặt hàng
→ SAI — phiên 2 phụ thuộc vào kết quả phiên 1
```

---

## 5. Xác Minh Dành Riêng Cho Flutter

### 5.1. Trước mỗi commit

```bash
flutter analyze                        # Phân tích tĩnh
flutter test                           # Unit test + widget test
dart format --set-exit-if-changed .    # Kiểm tra format
```

### 5.2. Trước khi merge

```bash
flutter build apk --debug             # Build Android
flutter build ios --debug --no-codesign  # Build iOS
flutter test integration_test/         # Integration test (nếu có)
```

### 5.3. Kiểm tra theo ngữ cảnh

| Thay đổi liên quan đến | Kiểm tra thêm |
|---|---|
| Riverpod provider | Provider scope đúng, không leak, `ref.watch` hợp lý |
| Drift (database) | Migration chạy đúng, dữ liệu cũ không mất |
| Cache offline | Đọc/ghi khi không có mạng, đồng bộ khi có mạng lại |
| Widget mới | Có widget test, đã thêm vào Widgetbook |
| API mới | Xử lý lỗi mạng, timeout, retry, cache response |
| Fastlane | `fastlane android beta` / `fastlane ios beta` chạy thành công |

---

## 6. Hướng Dẫn Quy Mô Phiên

| Loại nhiệm vụ | Số lượt trao đổi | Thời gian | Ghi chú |
|---|---|---|---|
| Màn hình đơn giản (chỉ UI) | 8–12 | 20–30 phút | Không có API call |
| Màn hình có tích hợp API | 12–18 | 30–45 phút | Bao gồm xử lý lỗi mạng |
| Tính năng đồng bộ offline | 10–15 | 25–40 phút | Drift cache + sync logic |
| Migration database (Drift) | 6–10 | 15–25 phút | Kiểm tra dữ liệu cũ |
| Sửa lỗi (một widget) | 4–8 | 10–20 phút | Bao gồm viết test cho lỗi |
| Tính năng lớn (nhiều màn hình) | — | — | **Chia thành 2–3 phiên** |

**Quy tắc chia phiên cho tính năng lớn:**

```
Ví dụ: Tính năng "Đặt hàng giao tận nơi"

Phiên 1: Model + Repository + Drift schema (nền tảng dữ liệu)
Phiên 2: Màn hình chọn món + giỏ hàng (UI + state)
Phiên 3: Màn hình xác nhận + tích hợp bản đồ + thanh toán
```

---

## 7. Bản Đồ Gọi Kỹ Năng (Skill Invocation Map)

Khi bắt đầu phiên, chọn đúng kỹ năng theo loại nhiệm vụ:

| Nhiệm vụ liên quan đến | Gọi kỹ năng |
|---|---|
| Thiết kế UI/UX, review component | `sr-ux-designer` + `web-design-guidelines` |
| Kiến trúc Flutter, mẫu Riverpod | `sr-flutter-dev` + `vercel-react-native-skills` |
| Màn hình Giao hàng/Đặt bàn, Bản đồ | `mid-flutter-dev` |
| Supabase Edge Functions, DB schema, RLS | `backend-dev` + `postgres` |
| Chiến lược test, E2E, load testing | `qa-engineer` + `tdd-test-driven-development` |
| CI/CD, Fastlane, giám sát | `devops-engineer` |
| Review mã nguồn trước merge | `code-review-review-local-changes` |
| Quyết định kiến trúc | `ddd-software-architecture` + `brainstorming` |
| Điều tra lỗi | `systematic-debugging` + `kaizen-root-cause-tracing` |
| Lập kế hoạch triển khai | `writing-plans` + `executing-plans` |

---

## 8. Các Lỗi Thường Gặp (Anti-patterns)

### 8.1. Xây dựng mà không lập kế hoạch

Luôn bắt đầu bằng Task Contract. Không có Task Contract = không bắt đầu code.

### 8.2. Nhiều nhiệm vụ trong một phiên

Một phiên chỉ làm một việc. Phát hiện việc mới → ghi lại → phiên mới.

### 8.3. Để agent tự sửa lỗi của chính nó

Sau 2–3 lần thử sửa không thành → revert → kết thúc phiên → phiên mới với ngữ cảnh sạch.

### 8.4. Bỏ qua checkpoint commit

Không commit checkpoint = không có điểm an toàn để revert. Luôn commit trước và sau phiên.

### 8.5. CLAUDE.md quá dài

Giữ dưới 150 dòng. Thông tin chi tiết chuyển vào file riêng trong `docs/`.

### 8.6. Thêm hướng dẫn tính cách cho agent

Không có tác dụng. Chỉ đưa hướng dẫn kỹ thuật cụ thể.

### 8.7. Mở rộng phạm vi âm thầm

Khi agent đề xuất "tiện thể làm thêm cái này" → từ chối → tạo nhiệm vụ riêng.

### 8.8. Bỏ qua `flutter analyze` trước commit

`flutter analyze` phải pass trước MỌI commit. Không có ngoại lệ.

### 8.9. Bỏ qua offline-first

Mọi màn hình đều cần cache Drift. Không có màn hình nào chỉ hoạt động khi có mạng. Ứng dụng giao đồ ăn phải chạy được trong điều kiện mạng kém.

### 8.10. Bỏ qua Widgetbook cho component mới

Mỗi widget tái sử dụng phải có entry trong Widgetbook. Review trực quan trước khi merge.

---

## 9. Checklist Nhanh

Dùng checklist này ở đầu và cuối mỗi phiên:

### Đầu phiên

- [ ] `git pull` và trạng thái sạch
- [ ] Checkpoint commit đã tạo
- [ ] Task Contract đã viết rõ ràng
- [ ] Kỹ năng phù hợp đã được chọn

### Cuối phiên

- [ ] `flutter analyze` — không lỗi
- [ ] `flutter test` — tất cả pass
- [ ] `dart format --set-exit-if-changed .` — format chuẩn
- [ ] Build debug thành công (APK và/hoặc iOS)
- [ ] Commit kết quả với message rõ ràng
- [ ] Offline cache đã được kiểm tra (nếu có thay đổi UI/data)
- [ ] Widgetbook đã cập nhật (nếu có widget mới)
- [ ] Phiên đã kết thúc — không tiếp tục thêm

---

## 10. Mẫu Task Contract

```
===== TASK CONTRACT =====
PHIÊN: #[số thứ tự]
NGÀY: [ngày tháng]
NHIỆM VỤ: [Mô tả rõ ràng trong 1–2 câu]
PHẠM VI:
  - File/thư mục: [liệt kê]
  - Provider: [liệt kê nếu có]
  - Database: [bảng/migration nếu có]
RÀNG BUỘC:
  - [Giới hạn 1]
  - [Giới hạn 2]
TIÊU CHÍ HOÀN THÀNH:
  - [ ] [Điều kiện 1]
  - [ ] [Điều kiện 2]
  - [ ] flutter analyze pass
  - [ ] flutter test pass
  - [ ] Cache offline hoạt động
DỰ KIẾN: [X] lượt trao đổi / [Y] phút
KỸ NĂNG: [skill cần gọi]
==========================
```
