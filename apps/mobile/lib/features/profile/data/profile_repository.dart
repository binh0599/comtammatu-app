import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/user_profile.dart';

/// Repository for user profile data, sourced from the Supabase auth session.
class ProfileRepository {
  const ProfileRepository({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  /// Returns the current user's profile from the auth session and user metadata.
  ///
  /// Throws [StateError] if no user is signed in.
  UserProfile? getCurrentProfile() {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final metadata = user.userMetadata ?? {};

    return UserProfile(
      id: user.id,
      phone: user.phone ?? metadata['phone'] as String? ?? '',
      fullName: metadata['full_name'] as String? ?? '',
      role: metadata['role'] as String? ?? 'customer',
      avatarUrl: metadata['avatar_url'] as String?,
    );
  }

  /// Updates the user's profile metadata in Supabase Auth.
  Future<UserProfile> updateProfile({
    String? fullName,
    String? avatarUrl,
  }) async {
    final updates = <String, dynamic>{};
    if (fullName != null) updates['full_name'] = fullName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

    final response = await _supabase.auth.updateUser(
      UserAttributes(data: updates),
    );

    final user = response.user;
    if (user == null) {
      throw StateError('Failed to update profile: no user returned');
    }

    final metadata = user.userMetadata ?? {};

    return UserProfile(
      id: user.id,
      phone: user.phone ?? metadata['phone'] as String? ?? '',
      fullName: metadata['full_name'] as String? ?? '',
      role: metadata['role'] as String? ?? 'customer',
      avatarUrl: metadata['avatar_url'] as String?,
    );
  }

  /// Signs the user out.
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}

/// Riverpod provider for [ProfileRepository].
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final supabase = Supabase.instance.client;
  return ProfileRepository(supabase: supabase);
});
