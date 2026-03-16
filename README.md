# Cơm Tấm Má Tư — Ứng Dụng Khách Hàng Thân Thiết

Ứng dụng di động dành cho chuỗi cơm tấm Má Tư, giúp khách hàng tích điểm, đặt món, tìm chi nhánh và nhận ưu đãi.

## Tính Năng

- **Thực đơn** — Xem thực đơn đầy đủ với hình ảnh, giá và mô tả
- **Đặt món** — Đặt món trực tuyến, chọn chi nhánh giao/nhận
- **Tích điểm** — Quét QR tại quán để tích điểm thưởng
- **Đổi điểm** — Đổi điểm lấy ưu đãi và món miễn phí
- **Chi nhánh** — Tìm chi nhánh gần nhất trên bản đồ
- **Thông báo** — Nhận thông báo khuyến mãi và cập nhật đơn hàng
- **Lịch sử** — Xem lại lịch sử đơn hàng và giao dịch điểm
- **Hỗ trợ offline** — Xem thực đơn và thông tin chi nhánh khi không có mạng

## Công Nghệ

| Lớp | Công nghệ |
|-----|-----------|
| Framework | Flutter 3.27+ / Dart 3.6+ |
| Quản lý state | Riverpod 2 |
| Điều hướng | GoRouter |
| Mạng | Dio + Supabase Flutter SDK v2 |
| Lưu trữ offline | Drift + SharedPreferences |
| Models | Freezed + json_serializable |
| Quét QR | mobile_scanner |
| Bản đồ | google_maps_flutter + geolocator |
| Thông báo đẩy | Firebase Messaging + flutter_local_notifications |
| Kiểm thử | flutter_test (167+ tests) + Patrol (E2E) |
| CI/CD | GitHub Actions + Fastlane |
| Giám sát | Sentry |
| Phân tích | PostHog |
| Đa ngôn ngữ | flutter_localizations + ARB (Tiếng Việt + English) |

**Backend:** Supabase (PostgreSQL + Edge Functions + Auth + Storage)

## Cấu Trúc Dự Án

```text
comtammatu-app/
├── apps/mobile/          ← Mã nguồn Flutter
│   ├── lib/              ← Code Dart chính
│   ├── test/             ← Unit tests + Widget tests
│   ├── android/          ← Cấu hình Android
│   ├── ios/              ← Cấu hình iOS
│   ├── assets/           ← Hình ảnh, icon
│   └── pubspec.yaml      ← Dependencies
├── docs/                 ← Tài liệu kỹ thuật
│   ├── Design_Tech_Workflow.md
│   ├── API_Contract.md
│   └── ...
├── tasks/                ← Theo dõi tiến độ và bài học
├── diagrams/             ← Sơ đồ kiến trúc (Mermaid)
└── CLAUDE.md             ← Hướng dẫn cho AI agents
```

## Yêu Cầu Hệ Thống

- Flutter SDK >= 3.27.0
- Dart SDK >= 3.6.0
- Android Studio / Xcode (để chạy trên thiết bị thật hoặc giả lập)
- Tài khoản Firebase (cho thông báo đẩy)
- Google Maps API key (cho bản đồ)

## Cài Đặt

```bash
# Clone repo
git clone https://github.com/binh0599/comtammatu-app.git
cd comtammatu-app/apps/mobile

# Cài đặt dependencies
flutter pub get

# Sinh code (Freezed, Drift, Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Chạy ứng dụng
flutter run
```

## Lệnh Thường Dùng

```bash
# Phân tích mã nguồn
flutter analyze

# Chạy tests
flutter test

# Sinh code models
dart run build_runner build --delete-conflicting-outputs

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## Tài Liệu

| Tài liệu | Mô tả |
|-----------|--------|
| [Design & Tech Workflow](docs/Design_Tech_Workflow.md) | Kiến trúc, luồng dữ liệu, tech stack |
| [API Contract](docs/API_Contract.md) | 20+ endpoints, request/response schemas |
| [Team Hiring Proposal](docs/Team_Hiring_Proposal.md) | Cơ cấu đội ngũ, RACI matrix |
| [Tiến độ dự án](tasks/todo.md) | Roadmap Phase 5–7 |

## Trạng Thái Dự Án

**Phase 0–4 hoàn thành.** 113 Dart files, 17 Freezed models, 167+ tests, CI passing.

Đang triển khai Phase 5:
- [ ] Thông báo đẩy (Push Notifications)
- [ ] Màn hình tích/đổi điểm
- [ ] Hoàn thiện đa ngôn ngữ
- [ ] Mở rộng offline cache

## Giấy Phép

Dự án nội bộ — Không phân phối công khai.
