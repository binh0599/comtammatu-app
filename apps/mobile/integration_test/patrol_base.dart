import 'dart:async';

import 'package:comtammatu/core/cache/cache_service.dart';
import 'package:comtammatu/core/network/api_client.dart';
import 'package:comtammatu/features/auth/data/auth_repository.dart';
import 'package:comtammatu/features/auth/domain/auth_notifier.dart';
import 'package:comtammatu/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockAuthRepository extends Mock implements AuthRepository {}

// ---------------------------------------------------------------------------
// Patrol configuration
// ---------------------------------------------------------------------------

/// Standard Patrol configuration used across all E2E tests.
const patrolTesterConfig = PatrolTesterConfig(
  settleTimeout: Duration(seconds: 10),
  existsTimeout: Duration(seconds: 5),
);

// ---------------------------------------------------------------------------
// App builder helpers
// ---------------------------------------------------------------------------

/// Builds the full [ComTamMaTuApp] wrapped with provider overrides for E2E
/// testing. Avoids real Firebase, Supabase, Sentry, and PostHog initialization.
///
/// [authRepo] — inject a mocked auth repository (defaults to unauthenticated).
/// [prefs] — SharedPreferences instance (from [createTestPrefs]).
/// [extraOverrides] — additional provider overrides for specific tests.
Widget buildTestApp({
  required SharedPreferences prefs,
  MockAuthRepository? authRepo,
  List<Override> extraOverrides = const [],
}) {
  final mockAuthRepo = authRepo ?? defaultMockAuthRepo();

  return ProviderScope(
    overrides: [
      cacheServiceProvider.overrideWithValue(CacheService(prefs: prefs)),
      deviceFingerprintProvider.overrideWithValue('test-device-fingerprint'),
      authRepositoryProvider.overrideWithValue(mockAuthRepo),
      ...extraOverrides,
    ],
    child: const ComTamMaTuApp(),
  );
}

/// Creates in-memory SharedPreferences for test isolation.
Future<SharedPreferences> createTestPrefs() async {
  SharedPreferences.setMockInitialValues({});
  return SharedPreferences.getInstance();
}

/// Creates a [MockAuthRepository] that starts unauthenticated.
MockAuthRepository defaultMockAuthRepo() {
  final repo = MockAuthRepository();
  when(() => repo.getCurrentUser()).thenReturn(null);
  when(() => repo.onAuthStateChange())
      .thenAnswer((_) => const Stream<supa.AuthState>.empty());
  return repo;
}

/// Creates a [MockAuthRepository] where [signIn] completes without error.
/// The auth notifier picks up state changes via the stream, so callers should
/// also override [authNotifierProvider] if they need the app to navigate
/// post-login.
MockAuthRepository signInSuccessMockAuthRepo({
  required StreamController<supa.AuthState> authController,
}) {
  final repo = MockAuthRepository();
  when(() => repo.getCurrentUser()).thenReturn(null);
  when(() => repo.onAuthStateChange()).thenAnswer((_) => authController.stream);
  when(() => repo.signIn(
        phone: any(named: 'phone'),
        password: any(named: 'password'),
      )).thenAnswer((_) async {
    return supa.AuthResponse(session: null, user: null);
  });
  when(() => repo.signOut()).thenAnswer((_) async {});
  return repo;
}

/// Creates a [MockAuthRepository] where [signIn] throws.
MockAuthRepository signInFailureMockAuthRepo({String? errorMessage}) {
  final repo = defaultMockAuthRepo();
  when(() => repo.signIn(
        phone: any(named: 'phone'),
        password: any(named: 'password'),
      )).thenThrow(Exception(errorMessage ?? 'Invalid credentials'));
  return repo;
}
