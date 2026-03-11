# Todo — Mobile App

> Tiến độ hiện tại. Updated: 2026-03-11

---

## REPOSITORY HEALTH ASSESSMENT

### Summary
| Metric | Status |
|--------|--------|
| Dart files | 74 files, ~11,162 LOC |
| Test coverage | 1 test file (virtually 0%) |
| CI/CD | ALL BUILDS FAILING (281 lint issues) |
| Open PRs | #8 (loyalty refactor), #9 (mockups) |
| Uncommitted changes | 6 files modified, 4 untracked on main |
| Backend (Supabase) | 32 migrations, 26 Edge Functions deployed |
| Security advisories | 5 warnings (RLS, search_path, password protection) |
| Performance advisories | 363 issues (permissive policies, unindexed FKs, unused indexes) |
| Freezed models | NONE (violates FREEZED_FRONTEND rule) |
| Offline-first (Drift) | DB schema exists but not wired to most features |
| Feature completeness | ~40% of planned features have screens |

---

## PHASE 0: EMERGENCY — Fix CI & Stabilize Main (Week 1)

### P0.1 — Fix CI Pipeline (CRITICAL)
- [ ] Fix 281 flutter analyze issues (unused imports, parameter ordering, etc.)
- [ ] Ensure `flutter analyze --no-fatal-infos` passes
- [ ] Ensure `dart format --set-exit-if-changed .` passes
- [ ] Resolve or close stale branches: `claude/design-tech-workflow-XLq26`, `claude/cleanup-crm-code-J6wtD`
- [ ] Commit uncommitted changes on main (app_database.dart, menu_screen, store_model, store_notifier, pubspec, l10n files)

### P0.2 — Merge or Close Open PRs
- [ ] Review & merge PR #8 (loyalty screen refactor) — has CodeRabbit review
- [ ] Review & merge PR #9 (HTML mockups) — design reference
- [ ] Clean up merged remote branches

### P0.3 — Version Control Edge Functions
- [ ] Create `supabase/functions/` directory in repo
- [ ] Pull all 26 Edge Functions source code into repo
- [ ] Add Edge Function deploy workflow to CI

---

## PHASE 1: FOUNDATION — Code Quality & Architecture (Weeks 2-3)

### P1.1 — Migrate Models to Freezed (FREEZED_FRONTEND rule)
All 10 models in `lib/models/` are plain Dart classes. Must migrate:
- [ ] `cart_item.dart` → `@freezed` + `fromJson`/`toJson`
- [ ] `checkin_result.dart` → `@freezed`
- [ ] `delivery_order.dart` → `@freezed`
- [ ] `loyalty_dashboard.dart` → `@freezed`
- [ ] `loyalty_member.dart` → `@freezed`
- [ ] `menu_item.dart` → `@freezed` (fix: uses `double` for price → should use proper decimal)
- [ ] `point_transaction.dart` → `@freezed`
- [ ] `promotion.dart` → `@freezed`
- [ ] `tier.dart` → `@freezed`
- [ ] `user_profile.dart` → `@freezed`
- [ ] Add `freezed`, `freezed_annotation`, `json_serializable` to pubspec if missing
- [ ] Run `build_runner` to generate `.freezed.dart` and `.g.dart` files

### P1.2 — Fix Money Types (MONEY_TYPE rule)
Models currently use `double` for monetary values:
- [ ] `menu_item.dart`: `price`, `originalPrice` → proper Decimal handling
- [ ] `delivery_order.dart`: `unitPrice`, `totalAmount` → Decimal
- [ ] `point_transaction.dart`: `points`, `balanceAfter` → Decimal
- [ ] Evaluate `decimal` package for Dart or use String-based parsing from API

### P1.3 — Wire Drift Offline Cache (OFFLINE_FIRST rule)
- [ ] `app_database.dart` has basic schema but most features don't use it
- [ ] Wire menu data caching through Drift (not just in-memory)
- [ ] Wire loyalty dashboard data caching
- [ ] Wire store list caching
- [ ] Wire order history caching
- [ ] Add sync strategy: cache-first, network-update pattern

### P1.4 — Test Infrastructure
- [ ] Set up test directory structure mirroring `lib/`
- [ ] Add unit tests for all 10 models (serialization round-trip)
- [ ] Add unit tests for all notifiers (auth, menu, loyalty, cart, delivery, stores)
- [ ] Add unit tests for repositories (mock API responses)
- [ ] Add widget tests for key screens (login, home, menu, loyalty)
- [ ] Target: minimum 60% code coverage before Phase 2

---

## PHASE 2: FEATURE COMPLETION (Weeks 4-7)

### P2.1 — Missing Core Screens
Per API Contract, these features have Edge Functions but no/incomplete screens:
- [ ] **QR Check-in screen** — `verify-checkin` Edge Function exists, no screen
- [ ] **Vouchers screen** — `vouchers` Edge Function exists, no screen
- [ ] **Feedback screen** — `feedback` Edge Function exists, no screen
- [ ] **Address management** — `addresses` Edge Function exists, no screen
- [ ] **Reservation (Đặt Bàn)** — No Edge Function, no screen (Phase 3 per design doc)

### P2.2 — Complete Existing Screens
- [ ] **Home screen**: Wire real promotions, quick actions, loyalty summary
- [ ] **Menu screen**: Add search, category filtering, add-to-cart flow
- [ ] **Cart screen**: Complete checkout flow → `create-delivery-order`
- [ ] **Delivery tracking**: Wire to `delivery-tracking` Edge Function, real-time updates
- [ ] **Order history**: Wire to `get-transactions`, pagination
- [ ] **Profile screen**: Wire to `profile-update`, add address management
- [ ] **Store locator**: Wire to Google Maps, distance calculation

### P2.3 — Push Notifications
- [ ] Configure Firebase project (iOS + Android)
- [ ] Implement FCM token registration → `push-register`
- [ ] Handle foreground/background notifications
- [ ] Notification inbox screen → `notifications-inbox`
- [ ] Deep linking from notifications

---

## PHASE 3: POLISH & SECURITY (Weeks 8-10)

### P3.1 — Backend Security Fixes
- [ ] Fix `update_menu_categories_updated_at` mutable search_path
- [ ] Fix `handle_momo_payment_success` mutable search_path
- [ ] Fix `menu_item_available_sides` overly permissive RLS (DELETE with `true`)
- [ ] Fix `menu_item_available_sides` overly permissive RLS (INSERT with `true`)
- [ ] Enable leaked password protection in Auth settings
- [ ] Audit all 203 multiple permissive policies
- [ ] Index 45 unindexed foreign keys
- [ ] Review 87 unused indexes (drop or justify)

### P3.2 — Monitoring & Analytics
- [ ] Integrate Sentry (Flutter SDK) for crash reporting
- [ ] Integrate PostHog for analytics
- [ ] Add `X-Idempotency-Key` to all POST requests (IDEMPOTENCY rule)
- [ ] Add `X-Device-Fingerprint`, `X-App-Version`, `X-Platform` headers

### P3.3 — UI/UX Polish
- [ ] Implement proper loading skeletons (not just spinners)
- [ ] Add pull-to-refresh on list screens
- [ ] Add micro-interactions and animations (Rive or implicit)
- [ ] Implement proper error states with retry
- [ ] Vietnamese diacritics audit (VIETNAMESE_DIACRITICS rule)
- [ ] Set up Widgetbook for component documentation

### P3.4 — Localization
- [ ] Complete Vietnamese l10n strings
- [ ] Complete English l10n strings
- [ ] Wire all hardcoded strings to l10n

---

## PHASE 4: PRODUCTION READINESS (Weeks 11-14)

### P4.1 — E2E Testing
- [ ] Set up Patrol for E2E tests
- [ ] Auth flow E2E (register → OTP → login)
- [ ] Menu browsing → add to cart → checkout E2E
- [ ] Loyalty dashboard E2E
- [ ] Store locator E2E

### P4.2 — Performance
- [ ] Profile app startup time
- [ ] Optimize image loading (cached_network_image)
- [ ] Implement list virtualization for long lists
- [ ] Memory leak audit
- [ ] Target: 60fps on mid-range devices

### P4.3 — CI/CD Enhancements
- [ ] Add Fastlane configuration for iOS/Android
- [ ] Firebase App Distribution for beta testing
- [ ] Shorebird.dev integration for OTA updates
- [ ] Add code signing for release builds
- [ ] Add automated release workflow

### P4.4 — Pre-launch Checklist
- [ ] App icon and splash screen
- [ ] App Store / Play Store metadata
- [ ] Privacy policy and terms of service
- [ ] Deep linking configuration
- [ ] Environment-specific configs (dev/staging/prod)

---

## DOCUMENTATION GAPS (from docs audit)

| Gap | Severity | Action |
|-----|----------|--------|
| API Contract missing menu endpoints (`/get-menu` not documented) | HIGH | Add to API_Contract.md |
| API Contract missing `/get-profile`, `/update-profile` endpoints | HIGH | Add to API_Contract.md |
| No unified error code catalog (each endpoint defines own codes) | MEDIUM | Create master error catalog |
| Offline sync protocol incomplete (conflict resolution, batch sync) | MEDIUM | Add to API_Contract.md Section 8 |
| Design token sync workflow unspecified (Figma → theme.dart pipeline) | MEDIUM | Finalize tooling |
| Realtime channel naming convention not standardized | LOW | Add to API_Contract.md Section 7 |
| Learning system files (regressions, lessons, friction, predictions) all empty | LOW | Activate on first bug/pattern |

---

## KNOWN BUGS & TECHNICAL DEBT

| # | Issue | Severity | Location |
|---|-------|----------|----------|
| 1 | CI failing — 281 lint issues | CRITICAL | Entire codebase |
| 2 | No freezed on any model | HIGH | `lib/models/` |
| 3 | `double` used for money | HIGH | `menu_item.dart`, `delivery_order.dart` |
| 4 | 1 test file total | HIGH | `test/` |
| 5 | Edge Functions not in version control | HIGH | Missing `supabase/` dir |
| 6 | Uncommitted changes on main | MEDIUM | 6 files |
| 7 | Overly permissive RLS on `menu_item_available_sides` | MEDIUM | Supabase DB |
| 8 | Mutable search_path on 2 functions | MEDIUM | Supabase DB |
| 9 | Leaked password protection disabled | MEDIUM | Supabase Auth |
| 10 | 45 unindexed foreign keys | LOW | Supabase DB |
| 11 | `store_model.dart` and feature module inconsistency (`stores/` vs `store_locator/`) | LOW | Feature structure |
| 12 | Missing `const` constructors on widgets | LOW | Various screens |

---

## FEATURE vs API COVERAGE MATRIX

| Edge Function | Flutter Screen | Status |
|---------------|---------------|--------|
| `auth-signup` | `register_screen.dart` | Built |
| `auth-login` | `login_screen.dart` | Built |
| `auth-verify-otp` | `otp_screen.dart` | Built |
| `auth-refresh` | (auto via Dio interceptor) | Partial |
| `get-menu` | `menu_screen.dart` | Built |
| `get-loyalty-dashboard` | `loyalty_screen.dart` | Built (PR #8 refactoring) |
| `get-transactions` | `order_history_screen.dart` | Built |
| `earn-points` | — | Missing screen |
| `redeem-points` | — | Missing screen |
| `verify-checkin` | — | Missing screen |
| `create-delivery-order` | `cart_screen.dart` | Partial |
| `delivery-tracking` | `delivery_tracking_screen.dart` | Built |
| `stores` | `store_locator_screen.dart` | Built |
| `vouchers` | — | Missing screen |
| `addresses` | — | Missing screen |
| `feedback` | — | Missing screen |
| `profile-update` | `profile_screen.dart` | Partial |
| `push-register` | `notification_service.dart` | Partial |
| `push-send` | — | Backend only |
| `notifications` | — | Missing screen |
| `notifications-inbox` | — | Missing screen |
| `dashboard-stats` | — | Admin/CRM only |
| `inventory` | — | Admin/CRM only |
| `staff-management` | — | Admin/CRM only |
| `health-check` | — | Ops only |
| `process-deletion-requests` | — | Background job |
