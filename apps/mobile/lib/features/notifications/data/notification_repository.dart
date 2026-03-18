import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/notification_model.dart';
import 'models/device_token_model.dart';

/// Repository for managing push notifications and device tokens.
class NotificationRepository {
  const NotificationRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Registers a device token for push notifications.
  Future<DeviceToken> registerToken(String token, String platform) async {
    return _apiClient.post<DeviceToken>(
      '/push-register',
      data: {
        'token': token,
        'platform': platform,
      },
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        return DeviceToken.fromJson(
          map['subscription'] as Map<String, dynamic>,
        );
      },
    );
  }

  /// Unregisters (deactivates) a device token.
  Future<void> unregisterToken(String token) async {
    await _apiClient.delete<dynamic>(
      '/push-register/$token',
    );
  }

  /// Fetches notification inbox for the current user.
  Future<List<NotificationItem>> getNotifications({
    String? cursor,
    int limit = 20,
  }) async {
    return _apiClient.get<List<NotificationItem>>(
      '/notifications-inbox',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      },
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        final list = map['notifications'] as List<dynamic>? ?? [];
        return list
            .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Marks a notification as read.
  Future<void> markAsRead(int notificationId) async {
    await _apiClient.put<dynamic>(
      '/notifications-inbox/read/$notificationId',
    );
  }

  /// Deletes a notification.
  Future<void> deleteNotification(int notificationId) async {
    await _apiClient.delete<dynamic>(
      '/notifications-inbox/$notificationId',
    );
  }
}

/// Riverpod provider for [NotificationRepository].
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationRepository(apiClient: apiClient);
});
