# Todo — Mobile App

> Tiến độ hiện tại. Updated: 2026-03-16

---

## REPOSITORY HEALTH SNAPSHOT

| Metric | Trước (Mar 08) | Hiện tại (Mar 16) |
|--------|----------------|-------------------|
| Dart source files (excl. generated) | 74 | 113 |
| Generated files (.freezed + .g) | 0 | 34 (17 models × 2) |
| Test files | 1 (0% coverage) | 14 files, 167+ tests |
| CI/CD | FAILING (281 lint issues) | PASSING (analyze + test + build) |
| Freezed models | NONE | All 17 migrated |
| Offline-first (Drift) | Not wired | Menu + Store cache-first |
| Feature completeness | ~40% screens | ~90% screens wired to API |
| Deep linking | Not configured | Android + iOS configured |
| Analytics/Monitoring | Not wired | PostHog + Sentry integrated |
| i18n | Hardcoded | ARB setup done, strings partial |
| Fastlane | Not configured | Android + iOS configured |
| Store metadata | None | 12 files (vi-VN + en-US) |

---

## COMPLETED PHASES (0–4)

<details>
<summary>PHASE 0: EMERGENCY — Fix CI & Stabilize Main ✅</summary>

- [x] Fix 283 flutter analyze issues → 0 issues
- [x] Consolidate CI workflows (deleted `mobile-ci.yml`)
- [x] Ensure `flutter analyze` and `dart format` pass
- [x] Resolve stale branches (4 deleted)
- [x] Commit uncommitted changes on main
</details>

<details>
<summary>PHASE 1: FOUNDATION — Code Quality & Architecture ✅</summary>

- [x] All 17 models migrated to `@freezed` with `fromJson`/`toJson`
- [x] `build_runner` generates `.freezed.dart` and `.g.dart` files
- [x] Test directory structure mirroring `lib/`
- [x] Model serialization round-trip tests (17 models)
- [x] Notifier unit tests (cart, menu)
- [x] Repository unit tests with mocked API (menu, store)
- [x] 100+ unit tests passing
- [x] Menu data cache-first via Drift + CacheService
- [x] Store list cache-first via Drift + CacheService
</details>

<details>
<summary>PHASE 2: FEATURE COMPLETION ✅</summary>

- [x] Cart checkout wired to `OrderRepository.createDeliveryOrder()`
- [x] Order history with pagination, shimmer, infinite scroll
- [x] Profile edit (load + save)
- [x] Saved addresses (full CRUD)
- [x] QR check-in with `mobile_scanner`
</details>

<details>
<summary>PHASE 3: POLISH & TESTING ✅</summary>

- [x] Additional unit tests (cart, orders, addresses) — 167 total
- [x] PostHog analytics + Sentry crash reporting
- [x] `X-Device-Fingerprint` header
- [x] Loading shimmers, pull-to-refresh, error states
- [ ] ~~Micro-animations (Rive)~~ — deferred to Phase 6
- [ ] ~~Vietnamese diacritics audit~~ — deferred to Phase 6
- [ ] ~~Widgetbook setup~~ — deferred to Phase 6
</details>

<details>
<summary>PHASE 4: PRODUCTION READINESS ✅</summary>

- [x] Widget tests (login, cart, orders, shared widgets)
- [x] `CachedNetworkImage` for menu images
- [x] Deep linking (Android + iOS, custom scheme + App Links)
- [x] Package name fix → `com.comtammatu.app`
- [x] App icon + splash screen configs ready
- [x] Fastlane setup (Android + iOS)
- [x] Store metadata (12 files)
- [x] Privacy policy + Terms of service
- [x] Code signing guide + templates
- [x] Deep link verification files (`.well-known/`)
</details>

---

## ⏳ PHASE 5: CRITICAL GAPS (Tiếp theo — Ưu tiên cao)

> Đây là những tính năng còn thiếu cần hoàn thành trước khi có thể beta test.

### P5.1 — Push Notifications (FCM) 🔴
- [ ] FCM token registration → `push-register` API
- [ ] Foreground notification handling (flutter_local_notifications)
- [ ] Background notification handling
- [ ] Deep linking from notification taps → GoRouter
- [ ] Notification permission request flow (iOS)
- **Owner:** `mid-flutter-dev`
- **Dependencies:** Firebase project configured, FCM server key in Supabase secrets

### P5.2 — Earn/Redeem Points Screens 🔴
- [ ] `earn_points_screen.dart` — hiển thị cách tích điểm, QR code
- [ ] `redeem_points_screen.dart` — danh sách rewards, đổi điểm
- [ ] Wire to `earn-points` + `redeem-points` Edge Functions
- [ ] Add routes to GoRouter
- **Owner:** `sr-flutter-dev`
- **Dependencies:** Backend endpoints `earn-points`, `redeem-points` phải sẵn sàng

### P5.3 — Localization Completion 🟡
- [ ] Audit tất cả hardcoded Vietnamese strings trong `lib/`
- [ ] Di chuyển vào `app_vi.arb` + `app_en.arb`
- [ ] Wire `AppLocalizations.of(context)` thay thế hardcoded text
- [ ] Vietnamese diacritics audit (VIETNAMESE_DIACRITICS rule)
- **Owner:** `sr-flutter-dev`

### P5.4 — Offline Cache Expansion 🟡
- [ ] Orders cache-first via Drift (hiện chỉ có menu + store)
- [ ] Loyalty dashboard cache-first
- [ ] Addresses cache-first
- [ ] Vouchers cache-first
- [ ] Network connectivity listener + auto-sync khi có mạng lại
- **Owner:** `sr-flutter-dev`
- **Rule:** OFFLINE_FIRST — mọi data hiển thị phải có local cache

---

## ⏳ PHASE 6: QUALITY & POLISH

### P6.1 — Tech Debt Resolution
- [ ] `menu_screen.dart` has inline `MenuItem` class duplicating domain model → refactor
- [ ] `double` used for monetary values → audit per MONEY_TYPE rule, chuyển sang `int` (đơn vị VND)
- [ ] Auth token refresh interceptor chưa handle edge cases (expired refresh token)
- [ ] `CacheService` mixed SharedPreferences + Drift → chuẩn hóa sang Drift only
- **Owner:** `sr-flutter-dev`

### P6.2 — E2E Testing (Patrol)
- [ ] Configure Patrol runner + test driver
- [ ] Auth flow E2E (login → OTP → home)
- [ ] Menu → Cart → Checkout E2E
- [ ] Check-in flow E2E
- **Owner:** `qa-engineer`

### P6.3 — UI/UX Enhancements
- [ ] Micro-animations (Rive hoặc implicit animations)
- [ ] Widgetbook setup cho shared components
- [ ] Dark mode polish (hiện có `AppTheme.dark` nhưng chưa test kỹ)
- [ ] Skeleton loading cho tất cả screens (hiện chỉ có order history)
- **Owner:** `sr-ux-designer` + `sr-flutter-dev`

### P6.4 — Performance Optimization
- [ ] Profile app performance với Flutter DevTools
- [ ] ListView → SliverList cho menu nếu cần
- [ ] Image caching strategy review
- [ ] Memory leak audit (Riverpod providers dispose)
- **Owner:** `sr-flutter-dev`

---

## ⏳ PHASE 7: BACKEND HARDENING (Requires Supabase Admin)

- [ ] Fix mutable `search_path` on 2 DB functions
- [ ] Fix overly permissive RLS on `menu_item_available_sides`
- [ ] Enable leaked password protection
- [ ] Index 45 unindexed foreign keys
- [ ] Audit permissive RLS policies
- [ ] Compliance: Decree 70/2025 e-invoicing integration
- [ ] VietQR payment integration
- **Owner:** `backend-dev`

---

## 🚨 CHỜ USER ACTION (Blockers)

| # | Action | Blocking |
|---|--------|----------|
| 1 | Copy logo PNG 1024x1024 → `assets/icon/app_icon.png` | App icon + splash screen |
| 2 | Chạy `dart run flutter_launcher_icons` + `flutter_native_splash:create` | Build final |
| 3 | Đăng ký Apple Developer Account + Google Play Console | Store submission |
| 4 | Cấu hình code signing theo `docs/CODE_SIGNING.md` | Release builds |
| 5 | Mua domain `comtammatu.vn` + host deep link verification files | Deep links |
| 6 | Luật sư review privacy policy + terms of service | Store submission |
| 7 | Firebase project setup (FCM server key) | Push notifications |
| 8 | Supabase secrets cho `earn-points` + `redeem-points` | Points feature |

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
| `push-register` | `notification_service.dart` | ⚠️ Partial (cần P5.1) |
| `notifications-inbox` | `notification_inbox_screen.dart` | ✅ Built |
| `earn-points` | — | ❌ Missing (cần P5.2) |
| `redeem-points` | — | ❌ Missing (cần P5.2) |
| `push-send` | — | Backend only |
| `dashboard-stats` | `dashboard_screen.dart` | ✅ Admin only |
| `inventory` | `inventory_screen.dart` | ✅ Admin only |
| `staff-management` | `staff_management_screen.dart` | ✅ Admin only |
| `health-check` | — | Ops only |
| `process-deletion-requests` | — | Background job |

---

## ARCHITECTURE SUMMARY

```
apps/mobile/
├── lib/
│   ├── core/           # cache, config, network, router, storage, theme
│   ├── features/       # 14 feature modules (auth, cart, dashboard, delivery,
│   │                   #   feedback, home, inventory, loyalty, menu,
│   │                   #   notifications, order, profile, staff, stores, voucher)
│   ├── models/         # 17 Freezed models + generated files
│   ├── shared/         # extensions, utils, reusable widgets
│   ├── l10n/           # AppLocalizations (vi + en)
│   └── main.dart       # Entry point (Supabase, Firebase, Sentry, PostHog)
├── test/
│   ├── unit/           # 8 test files (notifiers, repositories, models)
│   └── widget/         # 5 test files (screens, shared widgets)
└── pubspec.yaml        # Flutter 3.27+, Dart 3.6+
```

**State:** Riverpod 2 (providers + notifiers)
**Navigation:** GoRouter with ShellRoute (customer + admin shells)
**Network:** Dio + Supabase Flutter SDK
**Offline:** Drift (menu + store) + SharedPreferences (cart, orders)
**CI/CD:** GitHub Actions (analyze → test → build Android/iOS) + Fastlane
