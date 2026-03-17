import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository wrapping Supabase Auth for the Com Tam Ma Tu app.
class AuthRepository {
  AuthRepository({required SupabaseClient supabase}) : _supabase = supabase;

  final SupabaseClient _supabase;

  GoTrueClient get _auth => _supabase.auth;

  /// Sign up with phone and password.
  Future<AuthResponse> signUp({
    required String phone,
    required String password,
    String? fullName,
  }) async {
    return _auth.signUp(
      phone: phone,
      password: password,
      data: {
        if (fullName != null) 'full_name': fullName,
      },
    );
  }

  /// Verify OTP sent to phone number.
  Future<AuthResponse> verifyOtp({
    required String phone,
    required String token,
    OtpType type = OtpType.sms,
  }) async {
    return _auth.verifyOTP(
      phone: phone,
      token: token,
      type: type,
    );
  }

  /// Resend OTP to phone number.
  Future<ResendResponse> resendOtp({
    required String phone,
    OtpType type = OtpType.sms,
  }) async {
    return _auth.resend(phone: phone, type: type);
  }

  /// Sign in with phone and password.
  Future<AuthResponse> signIn({
    required String phone,
    required String password,
  }) async {
    return _auth.signInWithPassword(
      phone: phone,
      password: password,
    );
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Refresh the current session token.
  Future<AuthResponse> refreshToken() async {
    return _auth.refreshSession();
  }

  /// Get the currently authenticated user, if any.
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Get the current session, if any.
  Session? getCurrentSession() {
    return _auth.currentSession;
  }

  /// Stream of auth state changes.
  Stream<AuthState> onAuthStateChange() {
    return _auth.onAuthStateChange;
  }
}

/// Riverpod provider for AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(supabase: Supabase.instance.client);
});
