import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_repository.dart';

/// Service class for push notification setup, token management, and handling.
///
/// Currently uses placeholder implementations. Will integrate with
/// firebase_messaging (FCM/APNs) when ready.
class NotificationService {
  NotificationService({required NotificationRepository repository})
      : _repository = repository;

  final NotificationRepository _repository;

  /// Initializes the notification service.
  /// Placeholder for FCM initialization.
  Future<void> initialize() async {
    // TODO: Initialize firebase_messaging
    // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  /// Requests notification permission from the user.
  /// Placeholder for platform-specific permission request.
  Future<bool> requestPermission() async {
    // TODO: Request via firebase_messaging
    // final settings = await FirebaseMessaging.instance.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    // return settings.authorizationStatus == AuthorizationStatus.authorized;
    return true;
  }

  /// Returns the current device push token.
  /// Returns a dummy token for development.
  Future<String> getToken() async {
    // TODO: Get real token from firebase_messaging
    // return await FirebaseMessaging.instance.getToken() ?? '';
    return 'dummy_fcm_token_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Registers the current device token with the backend.
  Future<void> registerToken(WidgetRef ref) async {
    final token = await getToken();
    final platform = Platform.isIOS ? 'ios' : 'android';
    await _repository.registerToken(token, platform);
  }

  /// Handles an incoming push notification message.
  /// Placeholder for processing notification payload.
  Future<void> handleMessage(Map<String, dynamic> message) async {
    // TODO: Route based on notification type
    // final type = message['type'] as String?;
    // switch (type) {
    //   case 'order_update':
    //     // Navigate to order tracking
    //     break;
    //   case 'promotion':
    //     // Navigate to promotion detail
    //     break;
    //   default:
    //     break;
    // }
  }
}

/// Riverpod provider for [NotificationService].
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationService(repository: repository);
});
