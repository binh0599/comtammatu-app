# CLAUDE.md — Cơm Tấm Má Tư Mobile App (Flutter)

> Mobile loyalty app cho chuỗi cơm tấm Má Tư. Đọc docs chi tiết: `Design_Tech_Workflow.md`, `API_Contract.md`, `Team_Hiring_Proposal.md`.

---

## 0. TRẠNG THÁI HIỆN TẠI (Updated: 2026-03-18)

**Phase 0–5 HOÀN THÀNH.** App đã có 116+ Dart files, 16 test files (183 tests), CI PASSING.

| Đã xong | Chưa xong |
|---------|-----------|
| 18 Freezed models | E2E tests (P6.2) |
| 95% screens wired to API | Monetary `double` → `int` audit (P6.1) |
| Localization (285 strings, 17 screens) | Vietnamese diacritics audit |
| Offline cache (6/6 repos cache-first) | UI polish + dark mode (P6.3) |
| Push notifications (FCM + permission) | Performance optimization (P6.4) |
| Earn/Redeem points (API + QR code) | Backend hardening (P7) |
| PostHog + Sentry | |
| Deep linking (Android + iOS) | |
| Fastlane + CI/CD | |

**Next:** Phase 6 — Quality & Polish (Tech Debt, E2E Tests, UI/UX, Performance).
**Blockers:** Logo, Apple/Google dev accounts, domain setup. Xem `tasks/todo.md` → "Chờ User Action".

---

## I. STACK

| Layer | Choice |
| ----- | ------ |
| Framework | Flutter 3.27+ / Dart 3.6+ strict mode + Impeller |
| State | Riverpod 2 (providers, notifiers, async) |
| Navigation | GoRouter (2 ShellRoutes: customer 5 tabs + admin 4 tabs) |
| Network | Dio (interceptors: Auth → Idempotency → Error) + Supabase Flutter SDK v2 |
| Offline | Drift (menu, store) + SharedPreferences (cart, orders, settings) |
| Models | Freezed + json_serializable (18 models, all with fromJson/toJson) |
| QR Scanner | mobile_scanner (ML Kit / Vision) |
| Maps | google_maps_flutter + geolocator |
| Push | firebase_messaging + flutter_local_notifications |
| Testing | flutter_test (183 tests) + Patrol (E2E — not yet configured) |
| CI/CD | GitHub Actions (analyze → test → build) + Fastlane |
| Monitoring | Sentry (crash reports, screenshots) |
| Analytics | PostHog (lifecycle events, env-aware) |
| i18n | flutter_localizations + ARB (vi + en, 285 strings, 17 screens) |

**Backend:** Supabase (project: `zrlriuednoaqrsvnjjyo`) — shared với web CRM.

---

## II. HARD BOUNDARIES

> Violation = stop immediately and diagnose.

1. **RLS_EVERYWHERE** — Mọi table phải có RLS policies.
2. **MONEY_TYPE** — `NUMERIC(14,2)` totals, `NUMERIC(12,2)` prices. NEVER FLOAT. ⚠️ FE hiện dùng `double` — cần audit P6.1
3. **TIME_TYPE** — `TIMESTAMPTZ` always.
4. **PK_TYPE** — `BIGINT GENERATED ALWAYS AS IDENTITY`.
5. **TEXT_TYPE** — `TEXT` always. Never VARCHAR.
6. **ZOD_BACKEND** — Edge Function validate input bằng Zod schema.
7. **FREEZED_FRONTEND** — Dart models dùng `@freezed` + `fromJson`. ✅ All 18 models migrated.
8. **RIVERPOD_STATE** — Dùng Riverpod providers cho state. KHÔNG `setState` ngoài local UI.
9. **CONST_WIDGETS** — Mọi Widget phải có `const` constructor nếu possible.
10. **IDEMPOTENCY** — Mọi POST request gửi `X-Idempotency-Key` (UUID v7). ✅ Wired in Dio interceptor.
11. **VIETNAMESE_DIACRITICS** — Toàn bộ text tiếng Việt phải có dấu đầy đủ. ⚠️ Chưa audit — P5.3
12. **API_CONTRACT** — FE và BE phải follow `API_Contract.md`. Thay đổi phải cả 2 bên review.
13. **OFFLINE_FIRST** — Mọi data hiển thị phải có local cache (Drift). ⚠️ Chỉ menu + store — cần expand P5.4

---

## III. TEAM-AGENTS (6 Người)

> Gọi agent bằng `/sr-ux-designer`, `/sr-flutter-dev`, `/mid-flutter-dev`, `/backend-dev`, `/qa-engineer`, `/devops-engineer`.

| Agent | Vai trò | Chuyên môn chính |
|-------|---------|-----------------|
| `sr-ux-designer` | Senior UI/UX Designer | Design System, Figma, Widgetbook, micro-interactions |
| `sr-flutter-dev` | Senior FE + Tech Lead | Architecture, Riverpod, Offline, Performance |
| `mid-flutter-dev` | Mid FE (Mobile) | Delivery/Đặt Bàn screens, Maps, Push notification UI |
| `backend-dev` | Back-End Developer | Supabase Edge Functions, PostgreSQL, Security |
| `qa-engineer` | QA Engineer | Test strategy, E2E (Patrol), Load testing |
| `devops-engineer` | DevOps Engineer | CI/CD, Fastlane, Sentry, Monitoring |

---

## IV. BOOT SEQUENCE

```
1. Check tasks/regressions.md — 7 rules from past failures
2. Check tasks/lessons.md — 7 patterns discovered
3. Check tasks/predictions.md — 6 predicted risks
4. Identify agent(s) phù hợp → invoke skill
5. Fill Task Contract → confirm scope trước khi code
6. Checkpoint commit: git commit -m "checkpoint: before [task]"
7. After task: flutter analyze + flutter test → commit → kill session
```

---

## V. KEY FILES

```
docs/
  Design_Tech_Workflow.md       ← Architecture, data flow, tech stack (123KB)
  API_Contract.md               ← 20+ endpoints, request/response schemas (30KB)
  Team_Hiring_Proposal.md       ← Team structure, RACI matrix, hiring JDs
  SESSION_PROTOCOL.md           ← Session lifecycle, error recovery
  PROJECT_OPERATING_SYSTEM.md   ← Workflow, meta-learning, quality gates

tasks/
  todo.md         ← Progress tracker + Phase 5–7 roadmap
  regressions.md  ← 7 rules from past failures — CHECK EVERY SESSION
  lessons.md      ← 7 patterns + prevention — CHECK EVERY SESSION
  friction.md     ← 6 friction points slowing development
  predictions.md  ← 6 predicted risks + mitigation

diagrams/
  architecture.mmd              ← System architecture (Mermaid)
  point-accumulation-flow.mmd   ← Points flow (Mermaid)
```

---

## VI. API BASE

```
Base URL: https://zrlriuednoaqrsvnjjyo.supabase.co/functions/v1
Auth: Authorization: Bearer <supabase_access_token>
Headers: X-Idempotency-Key, X-Device-Fingerprint, X-App-Version, X-Platform
Response: { success, data, meta? } | { success: false, error: { code, message, details? } }
```

---

*Team 6 agents · Flutter 3.27 + Supabase · Loyalty App · Phase 5 next*
