# Lessons Learned — Mobile App

> Patterns và cách phòng ngừa. CHECK MỖI SESSION.

---

### [2026-03-10] Stabilize CI trước khi build features
- **Context:** Phase 0 phải fix 283 lint issues trước khi làm gì khác. Mỗi feature PR đều fail CI.
- **Lesson:** CI health là prerequisite. Không skip. Không "sửa sau".
- **Prevention:** Mỗi session mở đầu bằng `flutter analyze`. Nếu fail → fix trước, không làm feature.

### [2026-03-10] Freezed migration nên làm batch, không từng model một
- **Context:** 17 models migrated cùng lúc trong Phase 1. Nếu làm từng cái sẽ gây conflict liên tục.
- **Lesson:** Migration toàn bộ models 1 lần giảm friction đáng kể. `build_runner` chạy 1 lần cho tất cả.
- **Prevention:** Khi thêm model mới: tạo model → chạy `dart run build_runner build --delete-conflicting-outputs` → commit cả `.freezed.dart` + `.g.dart`.

### [2026-03-11] Cache-first pattern: trả về cached data trước, update sau
- **Context:** Menu và Store dùng pattern: load từ Drift → trả về UI → fetch API → update Drift → notify UI.
- **Lesson:** UX tốt hơn hẳn. App hiển thị ngay, không blank screen khi mạng chậm.
- **Prevention:** Mọi screen mới phải implement cache-first. Xem `MenuRepository` và `StoreRepository` làm mẫu.

### [2026-03-11] Dio interceptor chain: order matters
- **Context:** Auth → Idempotency → Error interceptor phải đúng thứ tự. Auth trước để có token, Error cuối để catch tất cả.
- **Lesson:** Thêm interceptor mới → luôn xem xét vị trí trong chain.
- **Prevention:** Xem `api_client.dart` — interceptors được add theo thứ tự cố định.

### [2026-03-12] Widget test cần mock Riverpod providers
- **Context:** Widget test cho `LoginScreen`, `CartScreen` cần `ProviderScope` với overrides.
- **Lesson:** Không thể test widget có `Consumer`/`ref.watch` mà không wrap trong `ProviderScope`.
- **Prevention:** Tạo helper `testWidgetWithProviders()` để reuse setup. Xem `login_screen_test.dart`.

### [2026-03-15] Diagrams phải match code thực tế
- **Context:** Commit `9c2ae41` fix diagrams lệch với codebase sau nhiều phase thay đổi.
- **Lesson:** Diagrams drift nhanh. Cập nhật diagram mỗi khi thay đổi architecture.
- **Prevention:** Sau mỗi phase hoàn thành → review `diagrams/` xem còn chính xác không.

### [2026-03-16] GoRouter ShellRoute: tách Customer và Admin navigation
- **Context:** App có 2 shell: Customer (5 tabs) và Admin (4 tabs). Dùng 2 `ShellRoute` riêng biệt.
- **Lesson:** Tách shell giúp navigation logic sạch. Admin routes không ảnh hưởng customer flow.
- **Prevention:** Feature mới → xác định thuộc shell nào trước khi code route.
