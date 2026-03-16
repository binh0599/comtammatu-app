# Friction Log — Mobile App

> Những gì làm chậm development. Dùng để cải thiện workflow.

---

### [2026-03-16] `build_runner` chạy chậm (~30–60s mỗi lần)
- **Impact:** Medium — phải chạy sau mỗi thay đổi Freezed model
- **Workaround:** Dùng `--delete-conflicting-outputs` để tránh stale cache. Chạy watch mode: `dart run build_runner watch`
- **Fix:** Cân nhắc giảm số lượng generated files bằng cách dùng `json_serializable` only cho simple models

### [2026-03-16] CacheService có 2 backend (SharedPreferences + Drift) gây confusion
- **Impact:** Medium — developer phải biết khi nào dùng sync getCachedMenu() vs async getCachedMenuAsync()
- **Workaround:** Document rõ trong code comments
- **Fix:** Migrate toàn bộ sang Drift only (P6.1). SharedPreferences chỉ giữ cho settings đơn giản.

### [2026-03-16] Hardcoded strings rải khắp codebase
- **Impact:** High — block localization, gây inconsistent UX
- **Workaround:** Không có. Phải fix thủ công từng file.
- **Fix:** Phase 5.3 — audit toàn bộ `lib/` và chuyển sang ARB files

### [2026-03-16] Không có Widgetbook → khó review visual changes
- **Impact:** Low-Medium — phải chạy app để kiểm tra UI thay đổi
- **Workaround:** Chạy app trên simulator
- **Fix:** Phase 6.3 — setup Widgetbook cho shared components

### [2026-03-16] Monetary values dùng `double` thay vì `int` (VND)
- **Impact:** High — rủi ro rounding errors trong tính tiền
- **Workaround:** Cẩn thận khi so sánh giá trị. Dùng `.toInt()` khi hiển thị.
- **Fix:** Phase 6.1 — audit tất cả monetary fields, chuyển sang `int` (đơn vị VND, không có phần thập phân)

### [2026-03-16] Thiếu E2E test → regression risk cao khi refactor
- **Impact:** High — unit test cover logic, nhưng integration gaps giữa screens không được test
- **Workaround:** Manual testing trên simulator
- **Fix:** Phase 6.2 — setup Patrol E2E
