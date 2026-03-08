import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

part 'auth_state.freezed.dart';

/// Represents the authentication state of the app.
@freezed
class AppAuthState with _$AppAuthState {
  /// User is authenticated with a valid session.
  const factory AppAuthState.authenticated({
    required User user,
  }) = Authenticated;

  /// User is not authenticated.
  const factory AppAuthState.unauthenticated() = Unauthenticated;

  /// Authentication state is being determined.
  const factory AppAuthState.loading() = AuthLoading;
}
