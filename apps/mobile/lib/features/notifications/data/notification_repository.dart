import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import 'models/device_token_model.dart';

/// Repository for managing push notification device tokens.
class NotificationRepository {
  const NotificationRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Registers a device token for push notifications.
  Future<DeviceToken> registerToken(String token, String platform) async {
    return _apiClient.post<DeviceToken>(
      '/device-tokens',
      data: {
        'token': token,
        'platform': platform,
      },
      fromJson: (json) =>
          DeviceToken.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Unregisters (deactivates) a device token.
  Future<void> unregisterToken(String token) async {
    await _apiClient.delete<dynamic>('/device-tokens/$token');
  }

  /// Fetches all registered tokens for the current user.
  Future<List<DeviceToken>> getTokens() async {
    return _apiClient.get<List<DeviceToken>>(
      '/device-tokens',
      fromJson: (json) => (json as List<dynamic>)
          .map((e) => DeviceToken.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Riverpod provider for [NotificationRepository].
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationRepository(apiClient: apiClient);
});
