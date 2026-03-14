# Hướng Dẫn Code Signing — Cơm Tấm Má Tư

> Tài liệu hướng dẫn cấu hình ký số cho Android và iOS.

---

## 1. Android — Keystore

### 1.1 Tạo keystore

```bash
keytool -genkey -v \
  -keystore comtammatu-release.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias comtammatu
```

Lưu file `comtammatu-release.jks` ở nơi an toàn. **KHÔNG commit vào git.**

### 1.2 Cấu hình key.properties

Copy template và điền thông tin:

```bash
cp apps/mobile/android/key.properties.example apps/mobile/android/key.properties
```

Nội dung file `key.properties`:
```
storePassword=<mật_khẩu_keystore>
keyPassword=<mật_khẩu_key>
keyAlias=comtammatu
storeFile=../comtammatu-release.jks
```

### 1.3 Lấy SHA256 fingerprint (cho assetlinks.json)

```bash
keytool -list -v \
  -keystore comtammatu-release.jks \
  -alias comtammatu | grep SHA256
```

Copy giá trị SHA256 vào file `web/.well-known/assetlinks.json`.

### 1.4 Google Play Console

1. Đăng ký tại [play.google.com/console](https://play.google.com/console)
2. Tạo ứng dụng mới với package name: `com.comtammatu.app`
3. Tạo Service Account cho Fastlane:
   - Vào **Setup → API access**
   - Tạo service account với quyền **Release Manager**
   - Tải file JSON key
   - Đặt tên `play-store-service-account.json`

---

## 2. iOS — Apple Developer & Fastlane Match

### 2.1 Đăng ký Apple Developer Program

1. Đăng ký tại [developer.apple.com](https://developer.apple.com)
2. Phí: $99/năm
3. Tạo App ID: `com.comtammatu.app`

### 2.2 Cấu hình Fastlane Match

Match lưu trữ certificates và provisioning profiles trong một Git repo riêng.

1. Tạo private repo: `github.com/comtammatu/certificates`
2. Chạy khởi tạo:

```bash
cd apps/mobile/ios
fastlane match init
```

3. Tạo certificates:

```bash
# Development
fastlane match development

# Ad-hoc (Firebase App Distribution)
fastlane match adhoc

# App Store
fastlane match appstore
```

### 2.3 App Store Connect API Key

1. Vào [App Store Connect → Users and Access → Integrations → Keys](https://appstoreconnect.apple.com/access/integrations/api)
2. Tạo API Key với quyền **App Manager**
3. Lưu lại:
   - **Key ID** → `APP_STORE_CONNECT_API_KEY_ID`
   - **Issuer ID** → `APP_STORE_CONNECT_ISSUER_ID`
   - **Private Key (.p8)** → encode base64: `base64 -i AuthKey_XXXX.p8`

---

## 3. GitHub Actions Secrets

Cần cấu hình các secrets sau trong **Settings → Secrets and variables → Actions**:

### Android Secrets

| Secret | Mô tả | Cách lấy |
|--------|-------|---------|
| `KEYSTORE_BASE64` | Keystore file (base64) | `base64 -i comtammatu-release.jks` |
| `KEYSTORE_PASSWORD` | Mật khẩu keystore | Từ bước tạo keystore |
| `KEY_PASSWORD` | Mật khẩu key | Từ bước tạo keystore |
| `KEY_ALIAS` | Tên alias | `comtammatu` |
| `PLAY_STORE_SERVICE_ACCOUNT_JSON` | Google Play JSON key (nội dung) | Từ Google Play Console |

### iOS Secrets

| Secret | Mô tả | Cách lấy |
|--------|-------|---------|
| `APP_STORE_CONNECT_API_KEY_ID` | API Key ID | App Store Connect |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID | App Store Connect |
| `APP_STORE_CONNECT_API_KEY_BASE64` | Private key (base64) | `base64 -i AuthKey_XXXX.p8` |
| `P12_CERTIFICATE_BASE64` | Certificate (base64) | Export từ Keychain hoặc Match |
| `P12_PASSWORD` | Mật khẩu certificate | Đặt khi export |
| `PROVISIONING_PROFILE_BASE64` | Provisioning profile (base64) | `base64 -i profile.mobileprovision` |
| `KEYCHAIN_PASSWORD` | Mật khẩu tạm cho CI keychain | Tự đặt (random string) |

### Shared Secrets

| Secret | Mô tả | Cách lấy |
|--------|-------|---------|
| `FIREBASE_IOS_APP_ID` | Firebase iOS App ID | Firebase Console |
| `SUPABASE_ANON_KEY` | Supabase anonymous key | Supabase Dashboard → API |
| `SENTRY_DSN` | Sentry DSN URL | Sentry → Project Settings |
| `POSTHOG_API_KEY` | PostHog project API key | PostHog → Project Settings |
| `SHOREBIRD_TOKEN` | Shorebird auth token | `shorebird login` |

---

## 4. Checklist trước khi release

- [ ] Keystore đã tạo và lưu trữ an toàn
- [ ] `key.properties` đã cấu hình (local, không commit)
- [ ] SHA256 fingerprint đã thêm vào `assetlinks.json`
- [ ] Google Play Console đã tạo app
- [ ] Service account JSON đã tạo
- [ ] Apple Developer Program đã đăng ký
- [ ] Fastlane Match đã khởi tạo
- [ ] App Store Connect API Key đã tạo
- [ ] Tất cả GitHub Secrets đã cấu hình
- [ ] `assetlinks.json` đã host tại `comtammatu.vn/.well-known/`
- [ ] `apple-app-site-association` đã host tại `comtammatu.vn/.well-known/`
- [ ] Test build thành công cho cả Android và iOS
