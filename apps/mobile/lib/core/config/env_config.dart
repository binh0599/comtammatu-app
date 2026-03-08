import 'package:flutter/foundation.dart';

enum AppEnvironment { dev, staging, production }

class EnvConfig {
  EnvConfig._();

  static AppEnvironment _env = AppEnvironment.dev;
  static AppEnvironment get environment => _env;

  static void init(AppEnvironment env) => _env = env;

  static bool get isDev => _env == AppEnvironment.dev;
  static bool get isStaging => _env == AppEnvironment.staging;
  static bool get isProduction => _env == AppEnvironment.production;

  static String get supabaseUrl {
    switch (_env) {
      case AppEnvironment.dev:
      case AppEnvironment.staging:
      case AppEnvironment.production:
        return 'https://zrlriuednoaqrsvnjjyo.supabase.co';
    }
  }

  static String get supabaseAnonKey {
    // In production, load from dart-define or secure storage
    return const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
  }

  static String get apiBaseUrl => '$supabaseUrl/functions/v1';

  static String get sentryDsn {
    return const String.fromEnvironment('SENTRY_DSN', defaultValue: '');
  }

  static String get posthogApiKey {
    return const String.fromEnvironment('POSTHOG_API_KEY', defaultValue: '');
  }

  static bool get enableAnalytics => isProduction || isStaging;
  static bool get enableCrashReporting => isProduction || isStaging;
  static bool get enableDebugLogs => !isProduction || kDebugMode;
}
