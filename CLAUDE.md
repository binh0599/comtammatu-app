# CLAUDE.md — Cơm Tấm Má Tư Mobile App (Flutter)

> Mobile loyalty app cho chuỗi cơm tấm Má Tư. Đọc docs chi tiết: `Design_Tech_Workflow.md`, `API_Contract.md`, `Team_Hiring_Proposal.md`.

---

## I. STACK

| Layer | Choice |
| ----- | ------ |
| Framework | Flutter 3.x + Dart 3.x strict mode + Impeller rendering |
| State | Riverpod 2 (providers, notifiers, async) |
| Navigation | GoRouter (tab nav, deep linking, redirect guards) |
| Network | Dio + Supabase Flutter SDK (`supabase_flutter` v2+) |
| Offline | Drift (SQLite wrapper for Dart) |
| Animation | Rive + Flutter implicit animations (Impeller 60fps) |
| QR Scanner | mobile_scanner (ML Kit / Vision) |
| Maps | google_maps_flutter |
| Push | firebase_messaging (FCM/APNs) |
| Testing | flutter_test + integration_test + Patrol (E2E) |
| CI/CD | Fastlane + GitHub Actions + Firebase App Distribution |
| OTA | Shorebird.dev (Dart code push) |
| Monitoring | Sentry (Flutter SDK) |
| Analytics | PostHog |
| Component Docs | Widgetbook |

**Backend:** Supabase (project: `zrlriuednoaqrsvnjjyo`) — shared với web CRM.

---

## II. HARD BOUNDARIES

> Violation = stop immediately and diagnose.

1. **RLS_EVERYWHERE** — Mọi table phải có RLS policies.
2. **MONEY_TYPE** — `NUMERIC(14,2)` totals, `NUMERIC(12,2)` prices. NEVER FLOAT.
3. **TIME_TYPE** — `TIMESTAMPTZ` always.
4. **PK_TYPE** — `BIGINT GENERATED ALWAYS AS IDENTITY`.
5. **TEXT_TYPE** — `TEXT` always. Never VARCHAR.
6. **ZOD_BACKEND** — Edge Function validate input bằng Zod schema.
7. **FREEZED_FRONTEND** — Dart models dùng `@freezed` + `fromJson`.
8. **RIVERPOD_STATE** — Dùng Riverpod providers cho state. KHÔNG `setState` ngoài local UI.
9. **CONST_WIDGETS** — Mọi Widget phải có `const` constructor nếu possible.
10. **IDEMPOTENCY** — Mọi POST request gửi `X-Idempotency-Key` (UUID v7).
11. **VIETNAMESE_DIACRITICS** — Toàn bộ text tiếng Việt phải có dấu đầy đủ.
12. **API_CONTRACT** — FE và BE phải follow `API_Contract.md`. Thay đổi phải cả 2 bên review.
13. **OFFLINE_FIRST** — Mọi data hiển thị phải có local cache (Drift). Network fail ≠ app fail.

---

## III. TEAM-AGENTS (6 Người)

> Gọi agent bằng `/sr-ux-designer`, `/sr-flutter-dev`, `/mid-flutter-dev`, `/backend-dev`, `/qa-engineer`, `/devops-engineer`.

| Agent | Vai trò | Chuyên môn chính |
|-------|---------|-----------------|
| `sr-ux-designer` | Senior UI/UX Designer | Design System, Figma, v0.app, Widgetbook review, micro-interactions |
| `sr-flutter-dev` | Senior FE (Mobile) + Tech Lead | Flutter architecture, Component Library, Core screens, Offline mode, Performance |
| `mid-flutter-dev` | Mid FE (Mobile) | Delivery screens, Đặt Bàn screens, Maps, Push notification UI |
| `backend-dev` | Back-End Developer | Supabase Edge Functions, PostgreSQL, CRM sync, Security |
| `qa-engineer` | QA Engineer | Test strategy, E2E automation (Patrol), Load testing (k6), Bug tracking |
| `devops-engineer` | DevOps Engineer | CI/CD, Fastlane, Sentry, Shorebird, Monitoring, Production readiness |

### Khi Nào Gọi Agent Nào?

| Tình huống | Gọi agent |
|-----------|-----------|
| Thiết kế UI/UX, review component, design tokens | `sr-ux-designer` |
| Architecture decisions, Flutter patterns, Riverpod, performance | `sr-flutter-dev` |
| Build Delivery/Đặt Bàn screens, Maps integration | `mid-flutter-dev` |
| Database schema, Edge Functions, API, CRM sync, security | `backend-dev` |
| Viết test cases, review edge cases, bug report, load test | `qa-engineer` |
| CI/CD pipeline, Fastlane, monitoring, deployment, infra | `devops-engineer` |
| Cross-cutting decisions | Gọi nhiều agents cùng lúc |

---

## IV. BOOT SEQUENCE

```
1. Check tasks/regressions.md — rule nào áp dụng?
2. Check tasks/lessons.md — pattern nào relevant?
3. Identify agent(s) phù hợp → invoke skill
4. Fill Task Contract → confirm scope trước khi code
5. Checkpoint commit: git commit -m "checkpoint: before [task]"
6. After task: flutter analyze + flutter test → commit → kill session
```

---

## V. SKILL INVOCATION MAP

| Task involves | Invoke skill first |
|---|---|
| UI/UX design, component review | `sr-ux-designer` + `web-design-guidelines` |
| Flutter architecture, Riverpod | `sr-flutter-dev` + `vercel-react-native-skills` |
| Delivery/Reservation screens | `mid-flutter-dev` |
| Edge Functions, DB schema, RLS | `backend-dev` + `postgres` |
| Test strategy, E2E, load test | `qa-engineer` + `tdd-test-driven-development` |
| CI/CD, Fastlane, monitoring | `devops-engineer` |
| Architecture decisions | `ddd-software-architecture` + `brainstorming` |
| Bug investigation | `systematic-debugging` + `kaizen-root-cause-tracing` |
| Implementation planning | `writing-plans` + `executing-plans` |
| Code review before merge | `code-review-review-local-changes` |
| Before claiming "done" | `verification-before-completion` |

---

## VI. KEY FILES

```
docs/
  Design_Tech_Workflow.md       ← Architecture, data flow, tech stack, task delegation
  API_Contract.md               ← 20 endpoints, request/response schemas, Dart models
  Team_Hiring_Proposal.md       ← Team structure, RACI matrix, hiring JDs
  SESSION_PROTOCOL.md           ← Session lifecycle, error recovery, parallel sessions
  PROJECT_OPERATING_SYSTEM.md   ← Workflow, meta-learning, quality gates, anti-patterns

tasks/
  regressions.md  ← Rules from past failures — CHECK EVERY SESSION
  lessons.md      ← Patterns + prevention — CHECK EVERY SESSION
  friction.md     ← What slows down development
  predictions.md  ← "This will probably break when..."
  todo.md         ← Current progress
```

---

## VII. API BASE

```
Base URL: https://zrlriuednoaqrsvnjjyo.supabase.co/functions/v1
Auth: Authorization: Bearer <supabase_access_token>
Headers: X-Idempotency-Key, X-Device-Fingerprint, X-App-Version, X-Platform
Response: { success, data, meta? } | { success: false, error: { code, message, details? } }
```

---

*Team 6 người · 16 tuần · Flutter 3.x + Supabase · Loyalty App*
