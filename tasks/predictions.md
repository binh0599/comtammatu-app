# Predictions — Mobile App

> "Cái này chắc sẽ lỗi khi..." — ghi lại để phòng ngừa.

---

### [2026-03-16] Push notification sẽ gặp vấn đề permission trên iOS 16+
- **Risk:** High
- **When:** Implement P5.1 — FCM push notification
- **Mitigation:** Phải request permission đúng thời điểm (sau onboarding, không phải lúc mở app lần đầu). Dùng `firebase_messaging` provisional authorization. Xử lý case user deny → show in-app banner giải thích lợi ích.

### [2026-03-16] Token refresh race condition khi nhiều API calls đồng thời
- **Risk:** Medium
- **When:** App có nhiều concurrent requests (ví dụ: home screen load menu + loyalty + notifications cùng lúc) và token hết hạn.
- **Mitigation:** Implement token refresh queue trong `_AuthInterceptor`. Khi token expire, queue tất cả pending requests, refresh 1 lần, rồi retry tất cả. Xem Dio `QueuedInterceptorsWrapper`.

### [2026-03-16] Drift migration break khi thêm table/column mới
- **Risk:** Medium
- **When:** Phase 5.4 khi expand offline cache (thêm orders, loyalty, addresses tables vào Drift)
- **Mitigation:** Luôn dùng `schemaVersion` incremental + migration strategy trong `app_database.dart`. Test migration từ version cũ → mới. KHÔNG xóa data cũ.

### [2026-03-16] Deep link verification sẽ fail nếu domain chưa host `.well-known` files
- **Risk:** High
- **When:** User cố mở deep link trên device thật trước khi domain được setup
- **Mitigation:** Custom scheme (`comtammatu://`) hoạt động ngay không cần domain. App Links / Universal Links cần domain live. Fallback: catch unverified link → show in-app screen.

### [2026-03-16] `double` → `int` migration cho monetary values sẽ gây API contract mismatch
- **Risk:** High
- **When:** Phase 6.1 tech debt — đổi price/total từ `double` sang `int`
- **Mitigation:** PHẢI update cả FE models + BE Edge Functions cùng lúc. Review `API_Contract.md` trước. Có thể giữ API trả về `number` và FE convert `.toInt()` ở fromJson layer.

### [2026-03-16] Android build sẽ fail khi upgrade `targetSdkVersion`
- **Risk:** Medium
- **When:** Google Play yêu cầu targetSdk 35+ (expected late 2026)
- **Mitigation:** Review `AndroidManifest.xml` permissions. Kiểm tra `mobile_scanner` + `geolocator` + `google_maps_flutter` compatibility. Chạy `flutter build apk --release` sau mỗi lần upgrade.
