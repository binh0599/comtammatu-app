import 'package:supabase_flutter/supabase_flutter.dart' show User;

/// Represents the authentication state of the app.
sealed class AppAuthState {
  const AppAuthState();
}

class Authenticated extends AppAuthState {
  const Authenticated({required this.user});
  final User user;
}

class Unauthenticated extends AppAuthState {
  const Unauthenticated();
}

class AuthLoading extends AppAuthState {
  const AuthLoading();
}
