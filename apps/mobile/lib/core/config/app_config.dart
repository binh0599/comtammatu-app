class AppConfig {
  AppConfig._();

  static const String appName = 'Cơm Tấm Má Tư';
  static const String appScheme = 'comtammatu';
  static const String bundleIdIos = 'com.comtammatu.app';
  static const String packageNameAndroid = 'com.comtammatu.app';

  // Version info
  static const String version = '1.0.0';
  static const int buildNumber = 1;

  // Feature flags
  static const bool enableDelivery = true;
  static const bool enableReservation = false; // Phase 2
  static const bool enableReferral = false; // Phase 2
  static const bool enableGamification = true;

  // Limits
  static const int maxCartItems = 50;
  static const int maxAddresses = 10;
  static const int otpLength = 6;
  static const int otpTimeoutSeconds = 120;
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB

  // Cache TTL (seconds)
  static const int menuCacheTtl = 300; // 5 min
  static const int profileCacheTtl = 600; // 10 min
  static const int loyaltyCacheTtl = 120; // 2 min

  // Deep link
  static const String deepLinkScheme = 'comtammatu';
  static const String universalLinkDomain = 'app.comtammatu.vn';
}
