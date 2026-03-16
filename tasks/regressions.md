# Regressions — Mobile App

> Rules từ các lỗi đã xảy ra. CHECK MỖI SESSION.

---

### [2026-03-10] Firebase initialization crash on iOS
- **Root cause:** `Firebase.initializeApp()` không có `options` parameter → crash trên iOS vì thiếu `GoogleService-Info.plist` config.
- **Rule:** Luôn pass `DefaultFirebaseOptions.currentPlatform` khi init Firebase.
- **Applies to:** `main.dart`, bất kỳ file nào init Firebase

### [2026-03-10] MenuScreen stuck in loading state
- **Root cause:** `MenuNotifier` không emit state khi API call fail. UI giữ mãi `MenuLoading`.
- **Rule:** Mọi async notifier PHẢI có `try/catch` và emit error state. Không được để UI stuck.
- **Applies to:** Tất cả `*_notifier.dart` files

### [2026-03-10] CacheService fallback crash khi SharedPreferences chưa init
- **Root cause:** `CacheService` throw exception khi `SharedPreferences` chưa sẵn sàng.
- **Rule:** `CacheService` phải có fallback path. Hiện dùng `CacheService.fromDrift()` cho trường hợp này.
- **Applies to:** `cache_service.dart`, `main.dart`

### [2026-03-10] Notification import missing
- **Root cause:** `flutter_local_notifications` package thiếu trong `pubspec.yaml` nhưng đã import trong code.
- **Rule:** Sau khi thêm import mới → chạy `flutter pub get` ngay. CI sẽ catch nhưng local build fail trước.
- **Applies to:** `pubspec.yaml`, tất cả imports

### [2026-03-10] iOS build fail do thiếu --dart-define
- **Root cause:** iOS build step trong CI không có `--dart-define` flags cho secrets (SUPABASE_ANON_KEY, etc.).
- **Rule:** Mọi platform build step PHẢI có cùng set `--dart-define` flags. Copy-paste từ Android build step.
- **Applies to:** `.github/workflows/flutter_ci.yml`, Fastlane

### [2026-03-10] Store data dùng String IDs thay vì int
- **Root cause:** Sample data dùng String IDs (`"1"`, `"2"`) nhưng model expect int. Nullable lat/lng cũng gây crash.
- **Rule:** Luôn dùng `int.tryParse()` khi parse ID từ JSON. Lat/lng phải nullable trong model.
- **Applies to:** `store_repository.dart`, Freezed models có ID fields

### [2026-03-11] Merge conflicts khi nhiều PRs touch cùng file
- **Root cause:** PR #8 và PR #10 cùng sửa navigation index, loyalty imports. Conflict khi merge.
- **Rule:** Không mở 2 PRs cùng touch `app_router.dart` hoặc barrel files. Merge tuần tự.
- **Applies to:** `app_router.dart`, barrel export files (`*.dart` trong feature root)
