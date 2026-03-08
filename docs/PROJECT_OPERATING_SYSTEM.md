# 🍚 CƠM TẤM MÁ TƯ — HỆ ĐIỀU HÀNH DỰ ÁN (Project Operating System)

> **Phiên bản:** 1.0.0
> **Cập nhật:** 2026-03-08
> **Nền tảng:** Flutter Mobile App (iOS + Android)
> **Mục đích:** Tài liệu vận hành cốt lõi cho toàn bộ đội ngũ phát triển. Mọi agent, mọi phiên làm việc đều bắt đầu từ đây.

---

## Mục lục

- [I. Nguyên tắc cốt lõi](#i-nguyên-tắc-cốt-lõi)
- [II. Quy trình điều phối công việc](#ii-quy-trình-điều-phối-công-việc)
- [III. Vòng lặp siêu học tập](#iii-vòng-lặp-siêu-học-tập)
- [IV. Bản đồ công cụ & kỹ năng](#iv-bản-đồ-công-cụ--kỹ-năng)
- [V. Cổng chất lượng](#v-cổng-chất-lượng)
- [VI. Các mẫu chống chỉ định](#vi-các-mẫu-chống-chỉ-định)
- [VII. Chuỗi khởi động phiên làm việc](#vii-chuỗi-khởi-động-phiên-làm-việc)
- [VIII. Cấu trúc thư mục dự án](#viii-cấu-trúc-thư-mục-dự-án)

---

## I. NGUYÊN TẮC CỐT LÕI

Bốn quy tắc bất khả xâm phạm. Mọi quyết định kỹ thuật đều phải tuân thủ.

### 1. Đơn giản là trên hết (Simplicity First)

> **Giải pháp đơn giản nhất hoạt động là giải pháp tốt nhất.**

- Không thêm abstraction layer khi chưa cần. Một `StatelessWidget` đơn giản tốt hơn một hệ thống widget phức tạp nếu chức năng chỉ dùng một lần.
- Không tối ưu sớm. Đo lường trước (`flutter performance profiling`), tối ưu sau.
- Ưu tiên giải pháp mà developer mới đọc hiểu trong 30 giây.
- Khi phân vân giữa hai cách: chọn cách ít dòng code hơn, ít dependency hơn, ít side effect hơn.

**Ví dụ thực tế:**
- Dùng `Consumer` widget thay vì tạo một hệ thống state management tự chế.
- Dùng `go_router` cho navigation thay vì viết router framework riêng.
- Hiển thị danh sách món ăn? `ListView.builder` trước, chỉ chuyển sang `SliverList` khi có bằng chứng hiệu năng kém.

### 2. Lên kế hoạch trước khi xây (Plan Before Build)

> **Mọi task từ 3 bước trở lên phải có Task Contract trước khi viết code.**

Task Contract bao gồm:

```markdown
## Task Contract
- **Mục tiêu:** [Một câu mô tả kết quả mong muốn]
- **Màn hình ảnh hưởng:** [Liệt kê screen/widget bị tác động]
- **Provider liên quan:** [Riverpod provider nào cần tạo/sửa]
- **Rủi ro hồi quy:** [Feature nào có thể bị ảnh hưởng]
- **Định nghĩa hoàn thành:**
  - [ ] Widget test pass
  - [ ] flutter analyze clean
  - [ ] Widgetbook preview cập nhật
  - [ ] Offline mode hoạt động (nếu áp dụng)
```

- Task dưới 3 bước (fix typo, đổi màu, sửa padding): làm trực tiếp, không cần contract.
- Task 3+ bước: **bắt buộc** có contract, được xác nhận trước khi code.
- Task liên quan đến thanh toán, dữ liệu khách hàng, hoặc tích điểm: **luôn luôn** cần contract bất kể số bước.

### 3. Xác minh trước khi hoàn thành (Verify Before Done)

> **`flutter analyze` + `flutter test` + `flutter build` phải pass trước khi đánh dấu task hoàn thành.**

Ba lệnh bắt buộc chạy theo thứ tự:

```bash
# Bước 1: Phân tích tĩnh — không chấp nhận warning
flutter analyze --no-fatal-infos

# Bước 2: Chạy toàn bộ test
flutter test

# Bước 3: Build thử nghiệm
flutter build apk --debug
```

- Nếu **bất kỳ lệnh nào fail**, task chưa hoàn thành. Không ngoại lệ.
- Không được bỏ qua warning bằng `// ignore:`. Nếu cần ignore, phải có comment giải thích lý do cụ thể.
- CI/CD pipeline sẽ chạy lại ba lệnh này. Nếu fail trên CI mà pass local, đó là bug cần sửa ngay.

### 4. Học tập tích lũy (Learning Compounds)

> **Mỗi lỗi tạo ra 1 rule, mỗi rule ngăn 10 lỗi tương lai.**

- Khi gặp bug, crash, hoặc regression: **bắt buộc** thêm vào `tasks/regressions.md`.
- Khi phát hiện pattern hay: ghi vào `tasks/lessons.md`.
- Khi gặp friction (tool chậm, quy trình rườm rà): ghi vào `tasks/friction.md`.
- Kiến thức phải **chảy lên trên**: Session → Task files → `CLAUDE.md` (khi pattern được xác nhận 3+ lần).

---

## II. QUY TRÌNH ĐIỀU PHỐI CÔNG VIỆC

Năm giai đoạn tuần tự. Không bỏ qua giai đoạn nào.

### Giai đoạn 1: Tiếp nhận (Receive Task)

**Mục đích:** Hiểu đúng yêu cầu, xác định agent phù hợp.

| Hoạt động | Chi tiết |
|---|---|
| Đọc yêu cầu | Đọc kỹ toàn bộ yêu cầu, không giả định |
| Phân loại task | UI/UX, business logic, backend, testing, devops |
| Xác định agent | Dựa trên [Bản đồ kỹ năng](#iv-bản-đồ-công-cụ--kỹ-năng) |
| Đánh giá độ phức tạp | Đơn giản (< 3 bước) / Trung bình (3-7 bước) / Phức tạp (8+ bước) |
| Kiểm tra phụ thuộc | Task này phụ thuộc task nào? Task nào phụ thuộc task này? |

**Câu hỏi buộc phải trả lời:**
1. Task này thay đổi gì trên màn hình người dùng?
2. Task này ảnh hưởng đến luồng offline không?
3. Có cần cập nhật API contract với backend không?

### Giai đoạn 2: Lên kế hoạch (Plan Mode)

**Mục đích:** Tạo Task Contract, xác định phạm vi, kiểm tra hồi quy.

**Các bước thực hiện:**

1. **Điền Task Contract** theo mẫu ở mục [I.2](#2-lên-kế-hoạch-trước-khi-xây-plan-before-build).
2. **Xác định màn hình và widget:**
   - Màn hình nào cần tạo mới?
   - Widget nào cần tạo mới hoặc sửa đổi?
   - Widget nào từ thư viện dùng chung (`shared/`) có thể tái sử dụng?
3. **Xác định Riverpod provider:**
   - Provider nào đã tồn tại và có thể dùng lại?
   - Provider mới cần tạo thuộc loại nào? (`Provider`, `StateNotifierProvider`, `FutureProvider`, `StreamProvider`, `AsyncNotifierProvider`)
   - Scope của provider: global hay scoped theo feature?
4. **Kiểm tra hồi quy:**
   - Đọc `tasks/regressions.md` — có rule nào liên quan không?
   - Feature nào chia sẻ provider/model với task hiện tại?
   - Test nào hiện có có thể bị ảnh hưởng?
5. **Xác nhận phạm vi** với người yêu cầu trước khi tiến hành.

**Output bắt buộc:** Task Contract đã được xác nhận.

### Giai đoạn 3: Xây dựng (Build)

**Mục đích:** Triển khai theo kế hoạch, tuân thủ pattern dự án.

**Nguyên tắc xây dựng:**

| Nguyên tắc | Áp dụng |
|---|---|
| Riverpod patterns | Sử dụng `@riverpod` code generation. Không dùng `StateProvider` cho logic phức tạp. `AsyncNotifier` cho state có side effect. |
| Thư viện component | Kiểm tra `shared/widgets/` trước khi tạo widget mới. Nếu tạo mới, thêm vào Widgetbook. |
| Offline-first | Mọi data layer phải có cache strategy. Dùng `drift` hoặc `hive` cho local storage. Hiển thị dữ liệu cached khi mất mạng. |
| Feature-based structure | Mỗi feature là một thư mục độc lập trong `features/`. Không import trực tiếp giữa các feature — đi qua `shared/` hoặc provider. |
| Immutable models | Sử dụng `freezed` cho tất cả data models. Không dùng mutable class. |

**Quy tắc commit trong khi build:**

```
feat(feature-name): mô tả ngắn gọn bằng tiếng Việt hoặc tiếng Anh
fix(feature-name): sửa lỗi gì
refactor(feature-name): tái cấu trúc gì
test(feature-name): thêm/sửa test gì
```

- Commit nhỏ, thường xuyên. Mỗi commit là một đơn vị logic hoàn chỉnh.
- Không commit code bị `flutter analyze` báo lỗi.

### Giai đoạn 4: Xác minh & Bàn giao (Verify & Deliver)

**Mục đích:** Đảm bảo chất lượng trước khi merge.

**Bốn tầng kiểm tra:**

```
Tầng 1: flutter analyze
  └─ Không warning, không error, không info cần xử lý

Tầng 2: Widget Tests
  └─ Mỗi widget mới phải có ít nhất 1 test
  └─ Mỗi provider mới phải có ít nhất 1 test
  └─ Test phải cover: trạng thái loading, data, error, empty

Tầng 3: Integration Tests
  └─ Luồng người dùng chính phải có integration test
  └─ Test offline mode cho các feature có data

Tầng 4: Widgetbook Review
  └─ Widget mới xuất hiện đúng trong Widgetbook
  └─ Kiểm tra visual trên nhiều kích thước màn hình
  └─ Kiểm tra dark mode (nếu áp dụng)
```

**Checklist bàn giao:**
- [ ] Task Contract — tất cả mục "Định nghĩa hoàn thành" được tick
- [ ] Code review — không có TODO chưa xử lý
- [ ] PR description — mô tả rõ ràng thay đổi và cách test

### Giai đoạn 5: Học hỏi (Learn)

**Mục đích:** Trích xuất kiến thức từ task vừa hoàn thành.

**Câu hỏi bắt buộc sau mỗi task:**

1. Có regression rule mới cần thêm không? → `tasks/regressions.md`
2. Có pattern mới phát hiện không? → `tasks/lessons.md`
3. Có friction nào cần ghi nhận không? → `tasks/friction.md`
4. Dự đoán nào đã đúng/sai? → `tasks/predictions.md`

**Quy tắc cập nhật:**
- Chỉ thêm rule khi có **bằng chứng cụ thể** (bug thật, lỗi thật).
- Mỗi rule phải có format: `[NGÀY] — Mô tả lỗi — Rule phòng tránh — Nguồn gốc (PR/commit)`
- Nếu một pattern xuất hiện 3+ lần trong `tasks/lessons.md`, nâng cấp lên `CLAUDE.md`.

---

## III. VÒNG LẶP SIÊU HỌC TẬP

Bảy cơ chế để hệ thống ngày càng thông minh hơn.

### 1. Danh sách hồi quy (Regressions List)

**Tệp:** `tasks/regressions.md`

Chứa các quy tắc rút ra từ lỗi thực tế. Mọi agent **bắt buộc** đọc file này khi bắt đầu phiên làm việc.

**Format:**

```markdown
## Regressions

### [2026-03-08] Lỗi overflow text tiếng Việt
- **Mô tả:** Text tiếng Việt có dấu dài hơn text tiếng Anh, gây overflow trên màn hình nhỏ
- **Rule:** Luôn dùng `maxLines` + `overflow: TextOverflow.ellipsis` cho text hiển thị dữ liệu động
- **Nguồn:** PR #42
- **Áp dụng cho:** Mọi widget hiển thị text từ database
```

**Quy tắc:**
- Không xóa rule cũ. Rule chỉ được đánh dấu `[ĐÃ GIẢM THIỂU]` khi có giải pháp hệ thống ngăn hoàn toàn.
- Đọc trước khi code. Không đọc = vi phạm quy trình.

### 2. Các tầng bộ nhớ (Memory Tiers)

Kiến thức được tổ chức theo ba tầng, từ tạm thời đến vĩnh viễn:

```
┌─────────────────────────────────────────────────────┐
│  Tầng 3: CLAUDE.md (Hiến pháp)                     │
│  ─ Rules đã được xác nhận 3+ lần                   │
│  ─ Thay đổi cần review của tech lead               │
│  ─ Ví dụ: "Luôn dùng AsyncNotifier cho API calls"  │
├─────────────────────────────────────────────────────┤
│  Tầng 2: Task files (Bền vững)                     │
│  ─ regressions.md, lessons.md, friction.md          │
│  ─ Cập nhật sau mỗi task                           │
│  ─ Mọi agent đều đọc được                          │
├─────────────────────────────────────────────────────┤
│  Tầng 1: Session context (Bay hơi)                 │
│  ─ Biến mất khi kết thúc phiên                     │
│  ─ Ghi chú tạm, thử nghiệm, debug log             │
│  ─ Phải chuyển lên Tầng 2 nếu có giá trị          │
└─────────────────────────────────────────────────────┘
```

**Quy tắc thăng cấp:**
- Tầng 1 → Tầng 2: Khi phát hiện pattern hoặc lỗi có giá trị tái sử dụng.
- Tầng 2 → Tầng 3: Khi pattern được xác nhận 3+ lần qua các task khác nhau.
- Không bao giờ bỏ qua tầng: không thăng trực tiếp từ Tầng 1 lên Tầng 3.

### 3. Nhật ký ma sát (Friction Log)

**Tệp:** `tasks/friction.md`

Ghi nhận những gì **làm chậm** quá trình phát triển.

**Format:**

```markdown
## Friction Log

### [2026-03-08] Build time quá lâu sau khi thêm freezed
- **Mô tả:** `build_runner` mất 3+ phút mỗi lần chạy
- **Tác động:** Mất flow, giảm năng suất
- **Giải pháp đề xuất:** Chuyển sang `build_runner` với filter theo feature
- **Trạng thái:** ĐANG CHỜ
```

**Mục đích:** Tích lũy đủ bằng chứng để ưu tiên cải thiện DX (Developer Experience).

### 4. Nhật ký dự đoán (Prediction Log)

**Tệp:** `tasks/predictions.md`

Ghi lại dự đoán về rủi ro kỹ thuật. Đánh giá lại sau khi task hoàn thành.

**Format:**

```markdown
## Prediction Log

### [2026-03-08] Dự đoán: Cache loyalty points sẽ gây inconsistency
- **Dự đoán:** Nếu cache điểm tích lũy local, user có thể thấy điểm cũ sau khi thanh toán
- **Xác suất:** 70%
- **Kết quả:** [ĐÚNG/SAI/CHƯA XÁC NHẬN]
- **Bài học:** [Điền sau khi có kết quả]
```

**Mục đích:** Cải thiện khả năng đánh giá rủi ro của đội ngũ theo thời gian.

### 5. Bài học rút ra (Lessons Learned)

**Tệp:** `tasks/lessons.md`

Khác với regressions (từ lỗi), lessons ghi lại **pattern tích cực** và cách tiếp cận hiệu quả.

**Format:**

```markdown
## Lessons Learned

### [2026-03-08] Pattern: Tách API layer và cache layer
- **Bối cảnh:** Khi xây feature menu món ăn
- **Pattern:** Tạo `RemoteDataSource` và `LocalDataSource` riêng, `Repository` quyết định dùng nguồn nào
- **Lợi ích:** Test dễ hơn, offline mode "miễn phí", dễ swap backend
- **Áp dụng cho:** Mọi feature có dữ liệu từ API
```

### 6. Gắn nhãn nhận thức (Epistemic Tagging)

Mọi thông tin trong tài liệu và code comments phải được gắn nhãn mức độ chắc chắn:

| Nhãn | Ý nghĩa | Khi nào dùng |
|---|---|---|
| `[XÁC NHẬN]` | Đã kiểm chứng, có bằng chứng | Test pass, đã deploy thành công, đã đo lường |
| `[GIẢ ĐỊNH]` | Tin là đúng nhưng chưa kiểm chứng | Dựa trên tài liệu, kinh nghiệm, chưa test thực tế |
| `[KHÔNG CHẮC]` | Có thể đúng, có thể sai | Cần nghiên cứu thêm, chưa có đủ thông tin |

**Quy tắc:**
- Không đưa ra quyết định kiến trúc dựa trên thông tin `[KHÔNG CHẮC]`. Phải xác nhận trước.
- Thông tin `[GIẢ ĐỊNH]` phải được xác nhận trong vòng 2 sprint hoặc chuyển thành `[KHÔNG CHẮC]`.
- Code comment chứa `[GIẢ ĐỊNH]` là tín hiệu cần viết test để xác nhận.

### 7. Tinh chỉnh đệ quy (Recursive Refinement)

Vòng lặp cải tiến liên tục cho cả code và quy trình:

```
Review → Cải thiện → Review → Cải thiện → ...
```

**Áp dụng ở ba cấp độ:**

1. **Cấp code:** Mỗi PR phải được review. Feedback tạo ra cải thiện. Cải thiện được review lại.
2. **Cấp quy trình:** Mỗi sprint retrospective xem lại friction log, cập nhật quy trình nếu cần.
3. **Cấp tài liệu:** Tài liệu này (PROJECT_OPERATING_SYSTEM.md) được review và cập nhật mỗi tháng.

**Điều kiện dừng:** Khi cải thiện tiếp theo tạo ra lợi ích không đáng kể so với chi phí thực hiện.

---

## IV. BẢN ĐỒ CÔNG CỤ & KỸ NĂNG

### Bảng phân công agent

| Agent | Kỹ năng chính | Kỹ năng hỗ trợ |
|---|---|---|
| **sr-ux-designer** | web-design-guidelines, brainstorming | vercel-composition-patterns |
| **sr-flutter-dev** | vercel-react-native-skills, ddd-software-architecture | tdd-test-driven-development, systematic-debugging |
| **mid-flutter-dev** | vercel-react-native-skills | tdd-write-tests, test-fixing |
| **backend-dev** | postgres, ddd-software-architecture | kaizen-root-cause-tracing |
| **qa-engineer** | tdd-*, test-driven-development, test-fixing | systematic-debugging, kaizen-* |
| **devops-engineer** | kaizen-root-cause-tracing, sadd-* | finishing-a-development-branch |

### Quy tắc chọn agent

```
Nếu task liên quan đến:
  ├─ UI/UX, thiết kế, wireframe    → sr-ux-designer
  ├─ Feature mới, kiến trúc        → sr-flutter-dev
  ├─ Widget, screen đơn giản       → mid-flutter-dev
  ├─ API, database, Supabase       → backend-dev
  ├─ Test, QA, regression          → qa-engineer
  └─ CI/CD, deploy, monitoring     → devops-engineer
```

**Multi-agent cho task phức tạp:**
- Feature mới end-to-end: `sr-ux-designer` (design) → `sr-flutter-dev` (kiến trúc) → `mid-flutter-dev` (implementation) → `qa-engineer` (test)
- Bug production: `devops-engineer` (logs) → `sr-flutter-dev` (root cause) → `qa-engineer` (regression test)

### Dịch vụ kết nối

| Dịch vụ | Mục đích | Agent phụ trách |
|---|---|---|
| **Supabase** | Database (PostgreSQL), Authentication, Realtime, Edge Functions | backend-dev |
| **Vercel** | Web dashboard (quản trị), API hosting | devops-engineer |
| **Firebase** | Push notifications (FCM), Crashlytics, Remote Config | devops-engineer |
| **GitHub Actions** | CI/CD pipeline, automated testing | devops-engineer |
| **Sentry** | Error tracking, performance monitoring | devops-engineer, sr-flutter-dev |
| **PostHog** | Analytics, feature flags, session replay | sr-flutter-dev, sr-ux-designer |
| **Shorebird** | Code push, OTA updates (bypass store review) | devops-engineer |

---

## V. CỔNG CHẤT LƯỢNG

Checklist bắt buộc trước khi bàn giao bất kỳ task nào. Không đánh dấu hoàn thành nếu bất kỳ mục nào fail.

### Checklist kỹ thuật

- [ ] **`flutter analyze`** — Không có issue nào (zero warnings, zero errors)
- [ ] **`flutter test`** — Tất cả test pass, không có test bị skip mà không có lý do
- [ ] **`flutter build apk --debug`** — Build thành công, không crash khi khởi động
- [ ] **Riverpod providers đúng scope** — Provider global chỉ cho dữ liệu dùng chung. Provider feature-scoped cho dữ liệu riêng feature. Không có provider bị leak.
- [ ] **Offline mode đã test** — Bật chế độ máy bay, mở app, kiểm tra: dữ liệu cached hiển thị, thao tác được queue, thông báo rõ ràng cho user.

### Checklist UX & nội dung

- [ ] **Tiếng Việt có dấu đầy đủ** — Mọi text hiển thị cho người dùng phải có dấu chính xác. Không chấp nhận "Com Tam" thay vì "Cơm Tấm". Kiểm tra cả trường hợp chữ hoa.
- [ ] **Touch targets >= 44px** — Mọi nút bấm, link, và phần tử tương tác phải có kích thước tối thiểu 44x44 pixel (theo hướng dẫn của Apple HIG). Dùng `SizedBox` hoặc `padding` nếu cần.
- [ ] **Loading/Empty/Error states** — Mọi màn hình có dữ liệu phải xử lý đủ ba trạng thái:
  - Loading: Skeleton shimmer hoặc spinner có context
  - Empty: Minh họa + thông điệp hướng dẫn hành động
  - Error: Thông báo lỗi thân thiện + nút thử lại

### Checklist quy trình

- [ ] **Regression rules đã kiểm tra** — Đọc `tasks/regressions.md`, xác nhận không vi phạm rule nào
- [ ] **Widgetbook cập nhật** — Widget mới có story trong Widgetbook, hiển thị đúng các variant (light/dark, các kích thước, các trạng thái)

### Checklist nâng cao (cho release build)

- [ ] **`flutter build apk --release`** — Build production thành công
- [ ] **`flutter build ipa`** — Build iOS thành công (trên macOS)
- [ ] **ProGuard/R8 rules** — Không crash do obfuscation
- [ ] **Deep link hoạt động** — Kiểm tra các URI scheme đã đăng ký
- [ ] **Performance profiling** — Không có jank frame trên danh sách cuộn

---

## VI. CÁC MẪU CHỐNG CHỈ ĐỊNH

Mười hành vi bị cấm tuyệt đối. Vi phạm bất kỳ mục nào đều phải dừng lại và sửa ngay.

### 1. CẤM: Code trước khi lên kế hoạch (Coding Without a Plan)

Không bao giờ bắt đầu viết code cho task 3+ bước mà không có Task Contract. "Tôi biết phải làm gì rồi" không phải là kế hoạch. Viết ra giấy.

### 2. CẤM: Bỏ qua danh sách hồi quy (Skipping Regressions Check)

`tasks/regressions.md` tồn tại vì một lý do. Mỗi rule trong đó đại diện cho một lỗi thực tế đã xảy ra. Không đọc = lặp lại lỗi cũ.

### 3. CẤM: Quản lý state tùy tiện (Ad-hoc State Management)

Không sử dụng `setState` cho logic business. Không tạo `ChangeNotifier` riêng khi Riverpod đã cung cấp giải pháp. Không lưu state trong `static` variable. Mọi state phải đi qua Riverpod provider.

### 4. CẤM: Widget khổng lồ (God Widget)

Không có widget nào vượt quá 200 dòng. Nếu dài hơn, tách thành các widget con. Mỗi widget chỉ làm một việc. `build` method không nên có logic phức tạp — chuyển sang provider hoặc helper.

### 5. CẤM: Bỏ qua offline mode (Ignoring Offline Capability)

Ứng dụng cơm tấm phục vụ khách hàng tại quán và giao hàng. Mạng có thể không ổn định. Mọi feature hiển thị dữ liệu từ server phải có chiến lược cache. Không hiển thị màn hình trắng khi mất mạng.

### 6. CẤM: Hardcode chuỗi hiển thị (Hardcoded Display Strings)

Mọi text hiển thị cho người dùng phải nằm trong file localization (`*.arb`). Không viết `Text('Thêm vào giỏ hàng')` trực tiếp trong widget. Dùng `Text(context.l10n.addToCart)`. Điều này chuẩn bị cho đa ngôn ngữ trong tương lai.

### 7. CẤM: Import chéo giữa các feature (Cross-Feature Direct Imports)

Feature A không được import trực tiếp từ Feature B. Nếu cần chia sẻ, chuyển code vào `shared/` hoặc giao tiếp qua Riverpod provider. Điều này đảm bảo mỗi feature có thể phát triển và test độc lập.

### 8. CẤM: Commit code không qua kiểm tra (Committing Unchecked Code)

Không commit nếu `flutter analyze` có warning. Không commit nếu test fail. Không commit với message "WIP" hoặc "fix later". Mỗi commit phải là một đơn vị hoàn chỉnh, hoạt động được.

### 9. CẤM: Bỏ qua xử lý lỗi (Swallowing Errors)

Không dùng `try-catch` trống. Không `print(e)` rồi bỏ qua. Mọi lỗi phải được: (1) log vào Sentry, (2) hiển thị thông báo phù hợp cho user, (3) cung cấp hành động phục hồi (retry, quay lại, liên hệ hỗ trợ).

### 10. CẤM: Tối ưu sớm mà không đo lường (Premature Optimization Without Measurement)

Không cache sớm "cho chắc". Không dùng `RepaintBoundary` khắp nơi "phòng khi chậm". Đo trước bằng DevTools Performance overlay. Có số liệu chứng minh chậm, rồi mới tối ưu. Ghi lại số liệu trước/sau.

---

## VII. CHUỖI KHỞI ĐỘNG PHIÊN LÀM VIỆC

Sáu bước thực hiện **theo thứ tự** mỗi khi bắt đầu phiên làm việc mới.

### Bước 1: Đọc danh sách hồi quy

```bash
cat tasks/regressions.md
```

**Mục đích:** Nạp các quy tắc phòng tránh lỗi vào bộ nhớ phiên làm việc.
**Hành động:** Đọc toàn bộ. Ghi nhớ các rule liên quan đến task sắp làm.

### Bước 2: Đọc bài học rút ra

```bash
cat tasks/lessons.md
```

**Mục đích:** Biết các pattern đã được xác nhận hoạt động tốt.
**Hành động:** Đọc toàn bộ. Xác định pattern nào áp dụng được cho task sắp làm.

### Bước 3: Xác định agent phù hợp

Dựa trên task description, chọn agent theo [Bản đồ kỹ năng](#quy-tắc-chọn-agent).

**Hành động:** Xác nhận agent. Nếu task cần nhiều agent, xác định thứ tự và điểm bàn giao.

### Bước 4: Điền Task Contract và xác nhận phạm vi

Sử dụng mẫu ở [mục I.2](#2-lên-kế-hoạch-trước-khi-xây-plan-before-build).

**Hành động:**
- Điền đầy đủ các mục
- Liệt kê file sẽ tạo/sửa
- Xác nhận với người yêu cầu: "Phạm vi đúng chưa? Có thiếu gì không?"

### Bước 5: Checkpoint commit trước khi bắt đầu

```bash
git add -A && git commit -m "checkpoint: trước khi bắt đầu [tên-task]"
```

**Mục đích:** Tạo điểm an toàn để rollback nếu cần.
**Hành động:** Commit toàn bộ thay đổi hiện tại. Đảm bảo working tree sạch trước khi bắt đầu.

### Bước 6: Sau khi hoàn thành — Xác minh, commit, kết thúc

```bash
# Xác minh
flutter analyze && flutter test && flutter build apk --debug

# Commit kết quả
git add -A && git commit -m "feat(feature-name): mô tả task"

# Cập nhật tài liệu học tập
# → tasks/regressions.md (nếu có lỗi mới)
# → tasks/lessons.md (nếu có pattern mới)
# → tasks/friction.md (nếu có ma sát mới)
# → tasks/predictions.md (nếu có dự đoán cần đánh giá)
```

**Mục đích:** Đảm bảo mọi thứ sạch sẽ trước khi kết thúc phiên.
**Hành động:** Chạy đủ ba lệnh kiểm tra. Commit. Cập nhật tài liệu. Kết thúc phiên.

---

## VIII. CẤU TRÚC THƯ MỤC DỰ ÁN

```
comtammatu-app/
│
├── apps/
│   └── mobile/                        ← Flutter app chính
│       ├── lib/
│       │   ├── core/                  ← Nền tảng ứng dụng
│       │   │   ├── theme/             ← AppTheme, colors, typography
│       │   │   ├── router/            ← GoRouter configuration
│       │   │   ├── constants/         ← App-wide constants
│       │   │   ├── network/           ← HTTP client, interceptors
│       │   │   └── storage/           ← Local database (Drift/Hive)
│       │   │
│       │   ├── features/              ← Các module tính năng
│       │   │   ├── home/              ← Trang chủ, banner, khuyến mãi
│       │   │   │   ├── data/          ← Repository, data sources
│       │   │   │   ├── domain/        ← Entities, use cases
│       │   │   │   ├── presentation/  ← Screens, widgets, providers
│       │   │   │   └── home.dart      ← Barrel file
│       │   │   │
│       │   │   ├── menu/              ← Thực đơn, chi tiết món
│       │   │   ├── cart/              ← Giỏ hàng, chỉnh sửa order
│       │   │   ├── order/             ← Đặt hàng, theo dõi đơn
│       │   │   ├── loyalty/           ← Tích điểm, đổi quà
│       │   │   ├── delivery/          ← Giao hàng, bản đồ, tracking
│       │   │   ├── profile/           ← Hồ sơ người dùng
│       │   │   ├── auth/              ← Đăng nhập, đăng ký, OTP
│       │   │   ├── notifications/     ← Thông báo, FCM
│       │   │   └── store_locator/     ← Tìm cửa hàng gần nhất
│       │   │
│       │   ├── shared/                ← Dùng chung giữa các feature
│       │   │   ├── widgets/           ← Button, Card, Input, Dialog,...
│       │   │   ├── utils/             ← Formatters, validators, helpers
│       │   │   ├── extensions/        ← Dart extensions
│       │   │   └── models/            ← Shared data models (freezed)
│       │   │
│       │   ├── l10n/                  ← Localization (tiếng Việt, tiếng Anh)
│       │   │   ├── app_vi.arb         ← Tiếng Việt (ngôn ngữ chính)
│       │   │   └── app_en.arb         ← Tiếng Anh (dự phòng)
│       │   │
│       │   └── main.dart              ← Entry point
│       │
│       ├── test/                      ← Kiểm thử
│       │   ├── unit/                  ← Unit tests cho logic
│       │   ├── widget/                ← Widget tests cho UI
│       │   └── integration/           ← Integration tests cho luồng
│       │
│       ├── widgetbook/                ← Widgetbook stories
│       │
│       ├── android/                   ← Android native config
│       ├── ios/                       ← iOS native config
│       │
│       ├── pubspec.yaml               ← Dependencies
│       └── analysis_options.yaml      ← Lint rules
│
├── docs/                              ← Tài liệu dự án
│   ├── PROJECT_OPERATING_SYSTEM.md    ← Tài liệu này
│   ├── API_CONTRACT.md                ← Hợp đồng API với backend
│   ├── DESIGN_SYSTEM.md               ← Hệ thống thiết kế (colors, fonts, spacing)
│   └── ARCHITECTURE.md                ← Kiến trúc tổng thể
│
├── tasks/                             ← Tệp học tập & theo dõi
│   ├── regressions.md                 ← Quy tắc từ lỗi thực tế
│   ├── lessons.md                     ← Pattern & bài học tích cực
│   ├── friction.md                    ← Nhật ký ma sát phát triển
│   ├── predictions.md                 ← Dự đoán rủi ro kỹ thuật
│   └── todo.md                        ← Danh sách công việc hiện tại
│
├── CLAUDE.md                          ← Rules cấp hiến pháp cho AI agents
├── .github/
│   └── workflows/                     ← GitHub Actions CI/CD
│       ├── flutter_ci.yml             ← analyze + test + build
│       └── deploy.yml                 ← Deploy to stores / Shorebird
│
└── README.md                          ← Hướng dẫn cài đặt & chạy dự án
```

### Quy tắc cấu trúc

1. **Một feature = một thư mục:** Mỗi feature chứa đủ `data/`, `domain/`, `presentation/`. Không chia theo loại file (tất cả models một chỗ, tất cả screens một chỗ).

2. **Barrel files:** Mỗi feature có một file barrel (ví dụ: `home.dart`) export các class public. Import từ bên ngoài chỉ qua barrel file.

3. **Thư mục `shared/` là trung lập:** Không chứa business logic của bất kỳ feature nào. Chỉ chứa widget và utility dùng chung.

4. **Test phản chiếu source:** Cấu trúc thư mục `test/` phản ánh cấu trúc `lib/`. Dễ tìm test cho bất kỳ file nào.

5. **Tệp `tasks/` không phải code:** Đây là tệp markdown dùng cho quy trình học tập. Commit cùng repo để mọi agent đều truy cập được.

---

## PHỤ LỤC

### A. Mẫu Task Contract đầy đủ

```markdown
# Task Contract: [Tên task]

## Thông tin chung
- **Ngày tạo:** [YYYY-MM-DD]
- **Agent phụ trách:** [tên agent]
- **Độ phức tạp:** [Đơn giản / Trung bình / Phức tạp]
- **Ước lượng:** [số giờ hoặc số pomodoro]

## Mục tiêu
[Một câu mô tả kết quả mong muốn]

## Màn hình & Widget ảnh hưởng
- [ ] [ScreenName] — [tạo mới / sửa đổi]
- [ ] [WidgetName] — [tạo mới / sửa đổi]

## Riverpod Provider liên quan
- [ ] [ProviderName] — [loại provider] — [tạo mới / sửa đổi]

## Rủi ro hồi quy
- [ ] [Feature/Screen có thể bị ảnh hưởng] — [lý do]

## Kế hoạch thực hiện
1. [Bước 1]
2. [Bước 2]
3. [Bước 3]
...

## Định nghĩa hoàn thành
- [ ] flutter analyze — zero issues
- [ ] flutter test — all pass
- [ ] Widget tests cho widget mới
- [ ] Widgetbook stories cho widget mới
- [ ] Offline mode hoạt động (nếu áp dụng)
- [ ] Tiếng Việt có dấu đầy đủ
- [ ] Touch targets >= 44px
- [ ] Loading/Empty/Error states

## Ghi chú
[Thông tin bổ sung, edge cases, câu hỏi chưa trả lời]
```

### B. Template cho file trong `tasks/`

Xem format cụ thể tại các mục tương ứng trong [phần III](#iii-vòng-lặp-siêu-học-tập).

### C. Commit Message Convention

```
<type>(<scope>): <mô tả ngắn>

Các type:
  feat     — Tính năng mới
  fix      — Sửa lỗi
  refactor — Tái cấu trúc (không thay đổi hành vi)
  test     — Thêm hoặc sửa test
  docs     — Cập nhật tài liệu
  style    — Định dạng code (không thay đổi logic)
  chore    — Cập nhật build, dependencies
  perf     — Cải thiện hiệu năng

Scope = tên feature hoặc module:
  home, menu, cart, order, loyalty, delivery, profile, auth,
  notifications, store-locator, shared, core, ci

Ví dụ:
  feat(menu): thêm bộ lọc theo loại món ăn
  fix(cart): sửa lỗi tính tổng khi có khuyến mãi
  test(loyalty): thêm widget test cho màn hình tích điểm
  refactor(core): tách network layer thành module riêng
```

---

> **Tài liệu này là tài liệu sống.** Cập nhật khi phát hiện pattern mới, quy trình cần điều chỉnh, hoặc rule cần bổ sung. Mọi thay đổi phải qua review của tech lead.
