import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../data/auth_repository.dart';
import 'auth_state.dart';

/// Manages authentication state across the app.
class AuthNotifier extends StateNotifier<AppAuthState> {
  AuthNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthLoading()) {
    _init();
  }

  final AuthRepository _authRepository;
  StreamSubscription<supa.AuthState>? _authSub;

  void _init() {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      state = Authenticated(user: user);
    } else {
      state = const Unauthenticated();
    }

    _authSub = _authRepository.onAuthStateChange().listen((authState) {
      final session = authState.session;
      if (session != null) {
        state = Authenticated(user: session.user);
      } else {
        state = const Unauthenticated();
      }
    });
  }

  Future<void> signIn({
    required String phone,
    required String password,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.signIn(phone: phone, password: password);
    } catch (e) {
      state = const Unauthenticated();
      rethrow;
    }
  }

  Future<void> signUp({
    required String phone,
    required String password,
    String? fullName,
  }) async {
    state = const AuthLoading();
    try {
      await _authRepository.signUp(
        phone: phone,
        password: password,
        fullName: fullName,
      );
    } catch (e) {
      state = const Unauthenticated();
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const Unauthenticated();
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}

/// Provider for auth state.
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AppAuthState>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository: authRepo);
});

/// Convenience provider to check if user is authenticated.
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState is Authenticated;
});
