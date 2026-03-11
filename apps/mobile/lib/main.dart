import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:uuid/uuid.dart';

import 'core/cache/cache_service.dart';
import 'core/config/env_config.dart';
import 'core/network/api_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set environment from dart-define
  const envName = String.fromEnvironment('ENV', defaultValue: 'dev');
  EnvConfig.init(
    switch (envName) {
      'production' => AppEnvironment.production,
      'staging' => AppEnvironment.staging,
      _ => AppEnvironment.dev,
    },
  );

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Initialize Supabase
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize PostHog analytics (staging/production only)
  if (EnvConfig.enableAnalytics && EnvConfig.posthogApiKey.isNotEmpty) {
    final posthogConfig = PostHogConfig(EnvConfig.posthogApiKey)
      ..host = 'https://us.i.posthog.com'
      ..captureApplicationLifecycleEvents = true;
    await Posthog().setup(posthogConfig);
  }

  // Set global error widget before runApp
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 64, color: AppColors.warning),
                const SizedBox(height: 16),
                const Text('Đã xảy ra lỗi hiển thị'),
                const SizedBox(height: 8),
                if (EnvConfig.enableDebugLogs)
                  Text(
                    details.exceptionAsString(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  };

  // Initialize Sentry (only in staging/production)
  if (EnvConfig.enableCrashReporting && EnvConfig.sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = EnvConfig.sentryDsn
          ..environment = EnvConfig.environment.name
          ..tracesSampleRate = EnvConfig.isProduction ? 0.2 : 1.0
          ..attachScreenshot = true
          ..sendDefaultPii = false;
      },
      appRunner: () => _runApp(prefs),
    );
  } else {
    _runApp(prefs);
  }
}

/// Returns a persistent device fingerprint (UUID), creating one if needed.
String _getOrCreateDeviceFingerprint(SharedPreferences prefs) {
  const key = 'device_fingerprint';
  final existing = prefs.getString(key);
  if (existing != null) return existing;

  final fingerprint = const Uuid().v4();
  prefs.setString(key, fingerprint);
  return fingerprint;
}

void _runApp(SharedPreferences prefs) {
  final deviceFingerprint = _getOrCreateDeviceFingerprint(prefs);

  runApp(
    ProviderScope(
      overrides: [
        cacheServiceProvider.overrideWithValue(CacheService(prefs: prefs)),
        deviceFingerprintProvider.overrideWithValue(deviceFingerprint),
      ],
      child: const ComTamMaTuApp(),
    ),
  );
}

class ComTamMaTuApp extends ConsumerWidget {
  const ComTamMaTuApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Cơm Tấm Má Tư',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
      ],
      locale: const Locale('vi'),
    );
  }
}
