# Todo — Mobile App

> Tiến độ hiện tại. Updated: 2026-03-11

---

## REPOSITORY HEALTH (Post Phase 4)

| Metric | Before | After |
|--------|--------|-------|
| Dart files | 74 files | 109+ files |
| Test files | 1 (0% coverage) | 13 files, 167 tests |
| CI/CD | FAILING (281 lint issues) | PASSING (0 issues) |
| Freezed models | NONE | All 17 migrated |
| Offline-first (Drift) | Not wired | Menu + Store cache-first |
| Feature completeness | ~40% screens | ~90% screens wired to API |
| Deep linking | Not configured | Android + iOS configured |
| Analytics | Not wired | PostHog + Sentry integrated |

---

## PHASE 0: EMERGENCY — Fix CI & Stabilize Main ✅ COMPLETE

- [x] Fix 283 flutter analyze issues → 0 issues
- [x] Consolidate CI workflows (deleted `mobile-ci.yml`)
- [x] Ensure `flutter analyze` and `dart format` pass
- [x] Resolve stale branches (4 deleted)
- [x] Commit uncommitted changes on main

---

## PHASE 1: FOUNDATION — Code Quality & Architecture ✅ COMPLETE

### P1.1 — Migrate Models to Freezed ✅
- [x] All 17 models migrated to `@freezed` with `fromJson`/`toJson`
- [x] `build_runner` generates `.freezed.dart` and `.g.dart` files

### P1.2 — Test Infrastructure ✅
- [x] Test directory structure mirroring `lib/`
- [x] Model serialization round-trip tests (17 models)
- [x] Notifier unit tests (cart, menu)
- [x] Repository unit tests with mocked API (menu, store)
- [x] 100+ unit tests passing

### P1.3 — Wire Drift Offline Cache ✅
- [x] Menu data cache-first via Drift + CacheService
- [x] Store list cache-first via Drift + CacheService
- [x] Cache-first, network-update pattern implemented

---

## PHASE 2: FEATURE COMPLETION ✅ COMPLETE

### P2.1 — Cart Checkout ✅
- [x] Cart screen wired to `CartNotifier.placeOrder()` → `OrderRepository.createDeliveryOrder()`
- [x] Loading state, error handling, clear cart on success

### P2.2 — Order History ✅
- [x] `OrderHistoryNotifier` with pagination, filtering, loading states
- [x] Shimmer loading, infinite scroll, pull-to-refresh
- [x] Wired to `/get-transactions` API

### P2.3 — Profile Edit ✅
- [x] Loads user data from `ProfileRepository.getCurrentProfile()`
- [x] Saves via `ProfileRepository.updateProfile()`

### P2.4 — Saved Addresses ✅
- [x] New `AddressRepository` + `AddressNotifier` (full CRUD)
- [x] Loading, error states, optimistic updates

### P2.5 — QR Check-in ✅
- [x] `CheckinScreen` with `mobile_scanner` for QR scanning
- [x] Route added, home quick action wired
- [x] Success dialog with points earned and streak info

---

## PHASE 3: POLISH & TESTING ✅ COMPLETE

### P3.1 — Additional Tests ✅
- [x] `cart_placeorder_test.dart` — checkout flow tests
- [x] `order_history_notifier_test.dart` — pagination, filter tests
- [x] `address_notifier_test.dart` — CRUD operation tests
- [x] 29 new tests (144 total at Phase 3)

### P3.2 — Monitoring & Analytics ✅
- [x] PostHog analytics wired (lifecycle events, env-aware)
- [x] Sentry crash reporting wired (screenshot attachment, sampling)
- [x] `X-Device-Fingerprint` header added to API client

### P3.3 — UI/UX Polish (Partial)
- [x] Loading shimmers on order history
- [x] Pull-to-refresh on order history
- [x] Error states with retry on orders and addresses
- [ ] Micro-animations (Rive or implicit) — deferred
- [ ] Vietnamese diacritics audit — deferred
- [ ] Widgetbook setup — deferred

---

## PHASE 4: PRODUCTION READINESS ✅ COMPLETE

### P4.1 — Widget Tests ✅
- [x] `login_screen_test.dart` — 6 tests (validation, loading, rendering)
- [x] `cart_screen_test.dart` — 3 tests (empty state, items, total)
- [x] `order_history_screen_test.dart` — 3 tests (loading, empty, cards)
- [x] `shared_widgets_test.dart` — 9 tests (AppButton, AppTextField)
- [x] Total: 167 tests passing, 3 skipped

### P4.2 — Performance ✅
- [x] `CachedNetworkImage` wired for menu item images

### P4.3 — Deep Linking ✅
- [x] Android: `AndroidManifest.xml` with custom scheme `comtammatu://` + App Links `comtammatu.vn`
- [x] iOS: `Info.plist` URL types + `Runner.entitlements` Associated Domains
- [x] `FlutterDeepLinkingEnabled` set on both platforms

### P4.4 — Pre-launch Checklist
- [x] Fix package name mismatch (`vn.comtammatu.app` → `com.comtammatu.app`)
- [x] App icon config (`flutter_launcher_icons.yaml` ready — chờ copy logo vào `assets/icon/app_icon.png` rồi chạy `dart run flutter_launcher_icons`)
- [x] Splash screen config (`flutter_native_splash.yaml` updated — chờ logo rồi chạy `dart run flutter_native_splash:create`)
- [x] App Store / Play Store metadata (12 files: vi-VN + en-US cho cả Android & iOS)
- [x] Privacy policy (`docs/privacy_policy.md`) — ⚠️ cần luật sư review
- [x] Terms of service (`docs/terms_of_service.md`) — ⚠️ cần luật sư review
- [x] Code signing guide (`docs/CODE_SIGNING.md`) + templates (`key.properties.example`, `Matchfile`, `.env.example`)
- [x] Deep link verification files (`web/.well-known/assetlinks.json` + `apple-app-site-association`) — chờ deploy lên domain

#### Chờ User Action:
- [ ] Copy logo PNG 1024x1024 vào `apps/mobile/assets/icon/app_icon.png`
- [ ] Chạy `dart run flutter_launcher_icons` và `dart run flutter_native_splash:create`
- [ ] Đăng ký Apple Developer Account + Google Play Console
- [ ] Cấu hình code signing theo `docs/CODE_SIGNING.md`
- [ ] Mua domain `comtammatu.vn` và host `assetlinks.json` + `apple-app-site-association`
- [ ] Luật sư review privacy policy + terms of service

---

## REMAINING WORK (Backlog)

### Backend Security (Not addressed — requires Supabase admin)
- [ ] Fix mutable `search_path` on 2 DB functions
- [ ] Fix overly permissive RLS on `menu_item_available_sides`
- [ ] Enable leaked password protection
- [ ] Index 45 unindexed foreign keys
- [ ] Audit permissive RLS policies

### E2E Testing
- [ ] Set up Patrol E2E tests (package installed, not configured)
- [ ] Auth flow E2E
- [ ] Menu → Cart → Checkout E2E

### Push Notifications
- [ ] FCM token registration → `push-register`
- [ ] Foreground/background notification handling
- [ ] Deep linking from notification taps

### Localization
- [ ] Complete Vietnamese l10n strings (many hardcoded)
- [ ] Complete English l10n strings
- [ ] Wire all hardcoded strings to ARB files

### Tech Debt
- [ ] `menu_screen.dart` has inline `MenuItem` class duplicating domain model
- [ ] Drift offline cache not connected to orders, loyalty, addresses
- [ ] `double` used for monetary values (should audit per MONEY_TYPE rule)

---

## FEATURE vs API COVERAGE MATRIX

| Edge Function | Flutter Screen | Status |
|---------------|---------------|--------|
| `auth-signup` | `register_screen.dart` | ✅ Built |
| `auth-login` | `login_screen.dart` | ✅ Built |
| `auth-verify-otp` | `otp_screen.dart` | ✅ Built |
| `auth-refresh` | (auto via Dio interceptor) | ✅ Wired |
| `get-menu` | `menu_screen.dart` | ✅ Built + cached |
| `get-loyalty-dashboard` | `loyalty_screen.dart` | ✅ Built |
| `get-transactions` | `order_history_screen.dart` | ✅ Wired + paginated |
| `verify-checkin` | `checkin_screen.dart` | ✅ Built |
| `create-delivery-order` | `cart_screen.dart` | ✅ Wired |
| `delivery-tracking` | `delivery_tracking_screen.dart` | ✅ Built |
| `stores` | `store_locator_screen.dart` | ✅ Built + cached |
| `vouchers` | `voucher_screen.dart` | ✅ Built |
| `addresses` | `saved_addresses_screen.dart` | ✅ Wired (CRUD) |
| `feedback` | `feedback_screen.dart` | ✅ Built |
| `profile-update` | `profile_edit_screen.dart` | ✅ Wired |
| `push-register` | `notification_service.dart` | ⚠️ Partial |
| `notifications-inbox` | `notification_inbox_screen.dart` | ✅ Built |
| `earn-points` | — | ❌ Missing screen |
| `redeem-points` | — | ❌ Missing screen |
| `push-send` | — | Backend only |
| `dashboard-stats` | `dashboard_screen.dart` | ✅ Admin only |
| `inventory` | `inventory_screen.dart` | ✅ Admin only |
| `staff-management` | `staff_management_screen.dart` | ✅ Admin only |
| `health-check` | — | Ops only |
| `process-deletion-requests` | — | Background job |
