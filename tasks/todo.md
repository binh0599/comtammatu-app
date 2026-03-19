# Todo — Mobile App

> Tiến độ hiện tại. Updated: 2026-03-18

---

## REPOSITORY HEALTH SNAPSHOT

| Metric | Trước (Mar 08) | Hiện tại (Mar 18) |
|--------|----------------|-------------------|
| Dart source files (excl. generated) | 74 | 116 |
| Generated files (.freezed + .g) | 0 | 36 (18 models × 2) |
| Test files | 1 (0% coverage) | 16 files, 183 tests |
| CI/CD | FAILING (281 lint issues) | PASSING (analyze + test + build) |
| Freezed models | NONE | All 18 migrated |
| Offline-first (Drift) | Not wired | 6/6 repos cache-first + connectivity |
| Feature completeness | ~40% screens | ~95% screens wired to API |
| Deep linking | Not configured | Android + iOS configured |
| Analytics/Monitoring | Not wired | PostHog + Sentry integrated |
| i18n | Hardcoded | 285 ARB strings, 17 screens wired |
| Fastlane | Not configured | Android + iOS configured |
| Store metadata | None | 12 files (vi-VN + en-US) |
| Push Notifications | Not wired | FCM + permission dialog + badge |
| Points Earn/Redeem | Hardcoded | API-wired + member QR code |

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

### P5.1 — Push Notifications (FCM) ✅ (2026-03-18)
- [x] FCM token registration → `push-register` API
- [x] Foreground notification handling (flutter_local_notifications)
- [x] Background notification handling
- [x] Deep linking from notification taps → GoRouter
- [x] Notification permission request flow (bottom sheet dialog, SharedPreferences flag)
- [x] Unread notification badge on home screen bell icon
- [x] Notification delete → API call with optimistic UI
- [x] Localization (7 new ARB strings, vi + en)
- [x] Unit tests (7 tests: notifier state, markAsRead, deleteNotification)
- **Owner:** `sr-flutter-dev`

### P5.2 — Earn/Redeem Points Screens ✅ (2026-03-18)
- [x] `earn_points_screen.dart` — hướng dẫn tích điểm + member QR code (qr_flutter)
- [x] `redeem_points_screen.dart` — fetch rewards từ API, đổi điểm per API Contract §2.3
- [x] Reward Freezed model (`reward_model.dart`) + build_runner
- [x] `LoyaltyRepository.getAvailableRewards()` + `redeemPoints()` updated per contract
- [x] `LoyaltyNotifier.redeemPoints()` returns `RedemptionResult` with voucher details
- [x] `availableRewardsProvider` (FutureProvider) for rewards list
- [x] Routes already configured in GoRouter
- [x] Localization (20+ new ARB strings, vi + en)
- [x] Unit tests (9 tests: notifier, RedemptionResult.fromJson)
- **Owner:** `sr-flutter-dev`

### P5.3 — Localization Completion ✅ (2026-03-18)
- [x] Audit tất cả hardcoded Vietnamese strings trong `lib/` — 250+ strings identified
- [x] Di chuyển vào `app_vi.arb` + `app_en.arb` — 88 → 258 strings
- [x] Wire `AppLocalizations.of(context)` thay thế hardcoded text — 15 screens wired
- [x] Widget tests updated with l10n delegates
- [ ] Vietnamese diacritics audit (VIETNAMESE_DIACRITICS rule) — deferred to P6
- **Owner:** `sr-flutter-dev`

### P5.4 — Offline Cache Expansion ✅ (2026-03-18)
- [x] Orders cache-first via CacheService (3-tier: fresh → API → stale fallback)
- [x] Loyalty dashboard cache-first
- [x] Addresses cache-first (write ops invalidate cache)
- [x] Vouchers cache-first (available + mine, separate cache keys)
- [x] CacheService expanded: loyalty, addresses, vouchers keys + clearCache updated
- [x] Network connectivity listener (`connectivity_plus` + Riverpod providers)
- **Owner:** `sr-flutter-dev`
- **Rule:** OFFLINE_FIRST — ✅ 6/6 customer-facing repositories now cache-first

---

## ⏳ PHASE 6: QUALITY & POLISH

### P6.1 — Tech Debt Resolution
- [ ] `menu_screen.dart` has inline `MenuItem` class duplicating domain model → refactor
- [x] `double` → `int` monetary audit: 28 fields across 12 models + CartState + UI + tests (2026-03-19)
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

### P6.4 — Performance Optimization ✅ (2026-03-19)
- [x] Profile app performance → ListView.builder already used, no SliverList needed
- [x] Image caching strategy review → CachedNetworkImage centralized via AppNetworkImage
- [x] Memory leak audit: 19 providers updated to `.autoDispose` (10 StateNotifierProviders, 5 StateProviders, 2 FutureProviders, 2 derived Providers)
- [x] Kept app-level providers persistent (auth, cart, addresses, notifications, connectivity)
- [x] All 206 tests passing, 0 analyze errors
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

| # | Action | Blocking | Status |
|---|--------|----------|--------|
| 1 | ~~Copy logo PNG 1024x1024 → `assets/icon/app_icon.png`~~ | App icon + splash screen | ✅ Done (logo.jpg → app_icon.png) |
| 2 | ~~Chạy `flutter_launcher_icons` + `flutter_native_splash:create`~~ | Build final | ✅ Done (icons + splash generated) |
| 3 | Đăng ký Apple Developer Account + Google Play Console | Store submission | |
| 4 | Cấu hình code signing theo `docs/CODE_SIGNING.md` | Release builds | |
| 5 | ~~Mua domain `comtammatu.com`~~ + host deep link verification files | Deep links | ✅ Domain đã mua |
| 6 | Luật sư review privacy policy + terms of service | Store submission | |
| 7 | ~~Firebase project setup (FCM server key)~~ | Push notifications | ✅ Đã tạo tài khoản |
| 8 | Supabase secrets cho `earn-points` + `redeem-points` | Points feature | |

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
| `push-register` | `notification_service.dart` | ✅ Wired (FCM + permission dialog) |
| `notifications-inbox` | `notification_inbox_screen.dart` | ✅ Built + delete API |
| `earn-points` | `earn_points_screen.dart` | ✅ Informational + member QR |
| `redeem-points` | `redeem_points_screen.dart` | ✅ API-wired (rewards + redeem) |
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
