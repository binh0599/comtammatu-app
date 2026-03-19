import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../data/notification_repository.dart';
import '../domain/notification_config.dart';
import '../domain/notification_types.dart';

void _log(String message) {
  if (kDebugMode) debugPrint(message);
}

/// Hàm xử lý thông báo nền cấp cao nhất (top-level function).
///
/// Firebase yêu cầu hàm này phải là top-level hoặc static,
/// không được là closure hay method của instance.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  _log('[NotificationService] Xử lý thông báo nền: ${message.messageId}');
  // Không cần hiển thị local notification ở đây vì hệ thống
  // sẽ tự hiển thị thông báo khi app ở background.
}

/// Service singleton quản lý toàn bộ vòng đời thông báo đẩy.
///
/// Bao gồm:
/// - Khởi tạo kênh thông báo Android (notification channel)
/// - Cấu hình các handler FCM (foreground, background, tap)
/// - Quản lý quyền thông báo trên iOS/Android
/// - Đăng ký device token với backend
/// - Hiển thị thông báo cục bộ khi app đang mở
/// - Điều hướng deep link khi người dùng nhấn thông báo
class NotificationService {
  NotificationService._();

  static final NotificationService _instance = NotificationService._();

  /// Truy cập singleton instance.
  static NotificationService get instance => _instance;

  /// Plugin hiển thị thông báo cục bộ.
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Instance Firebase Cloud Messaging.
  FirebaseMessaging get _fcm => FirebaseMessaging.instance;

  /// Cờ đánh dấu đã khởi tạo để tránh khởi tạo trùng lặp.
  bool _isInitialized = false;

  /// Router dùng để điều hướng deep link khi nhấn thông báo.
  GoRouter? _router;

  /// Repository để đăng ký token với backend.
  NotificationRepository? _repository;

  /// Gán router cho deep link navigation.
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Gán repository cho việc đăng ký token.
  void setRepository(NotificationRepository repository) {
    _repository = repository;
  }

  // ---------------------------------------------------------------------------
  // Khởi tạo
  // ---------------------------------------------------------------------------

  /// Khởi tạo toàn bộ hệ thống thông báo đẩy.
  ///
  /// Bao gồm:
  /// 1. Tạo kênh thông báo Android
  /// 2. Khởi tạo plugin local notifications
  /// 3. Đăng ký handler cho foreground, background, và notification tap
  /// 4. Đăng ký các FCM topic mặc định
  ///
  /// Gọi method này một lần duy nhất khi app khởi động (trong `main()`).
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Cấu hình kênh thông báo Android với độ ưu tiên cao
      const androidChannel = AndroidNotificationChannel(
        NotificationChannelConfig.channelId,
        NotificationChannelConfig.channelName,
        description: NotificationChannelConfig.channelDescription,
        importance: Importance.high,
      );

      // Tạo kênh thông báo đơn hàng riêng (ưu tiên cao nhất)
      const orderChannel = AndroidNotificationChannel(
        NotificationChannelConfig.orderChannelId,
        NotificationChannelConfig.orderChannelName,
        description: NotificationChannelConfig.orderChannelDescription,
        importance: Importance.max,
      );

      // Đăng ký kênh thông báo với hệ thống Android
      final androidPlugin =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(androidChannel);
      await androidPlugin?.createNotificationChannel(orderChannel);

      // Cấu hình khởi tạo cho Android
      const androidSettings = AndroidInitializationSettings(
        NotificationIconConfig.defaultIcon,
      );

      // Cấu hình khởi tạo cho iOS
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Khởi tạo local notifications với callback xử lý khi nhấn
      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: handleNotificationTap,
      );

      // Đăng ký handler xử lý thông báo nền
      FirebaseMessaging.onBackgroundMessage(
        firebaseMessagingBackgroundHandler,
      );

      // Lắng nghe thông báo khi app đang mở (foreground)
      FirebaseMessaging.onMessage.listen(handleForegroundMessage);

      // Lắng nghe khi người dùng nhấn thông báo để mở app
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Kiểm tra nếu app được mở từ thông báo khi đang terminated
      final initialMessage = await _fcm.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      // Đăng ký các topic mặc định
      await _subscribeToDefaultTopics();

      // Lắng nghe khi token được làm mới
      _fcm.onTokenRefresh.listen(_onTokenRefresh);

      _isInitialized = true;
      _log('[NotificationService] Khởi tạo thành công');
    } catch (e, stackTrace) {
      _log(
        '[NotificationService] Lỗi khởi tạo: $e\n$stackTrace',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Quản lý quyền
  // ---------------------------------------------------------------------------

  /// Yêu cầu quyền thông báo từ người dùng.
  ///
  /// Trên iOS: Hiển thị hộp thoại xin quyền alert, badge, sound.
  /// Trên Android 13+: Yêu cầu quyền POST_NOTIFICATIONS.
  ///
  /// Trả về `true` nếu người dùng cho phép, `false` nếu từ chối.
  Future<bool> requestPermission() async {
    try {
      final settings = await _fcm.requestPermission();

      final isGranted =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
              settings.authorizationStatus == AuthorizationStatus.provisional;

      _log(
        '[NotificationService] Quyền thông báo: '
        '${settings.authorizationStatus.name} '
        '(${isGranted ? "được cấp" : "bị từ chối"})',
      );

      return isGranted;
    } catch (e) {
      _log('[NotificationService] Lỗi yêu cầu quyền: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Quản lý Token
  // ---------------------------------------------------------------------------

  /// Lấy FCM device token hiện tại.
  ///
  /// Token này dùng để server gửi thông báo đến thiết bị cụ thể.
  /// Trả về chuỗi rỗng nếu không lấy được token.
  Future<String> getToken() async {
    try {
      final token = await _fcm.getToken();
      _log(
        '[NotificationService] FCM Token: ${token?.substring(0, 20)}...',
      );
      return token ?? '';
    } catch (e) {
      _log('[NotificationService] Lỗi lấy token: $e');
      return '';
    }
  }

  /// Đăng ký device token với backend để nhận thông báo đẩy.
  ///
  /// Gửi token kèm thông tin platform (ios/android) lên server.
  /// Server lưu token vào bảng device_tokens và liên kết với user.
  Future<void> registerToken(String token) async {
    if (token.isEmpty) {
      _log('[NotificationService] Token rỗng, bỏ qua đăng ký');
      return;
    }

    try {
      final platform = Platform.isIOS ? 'ios' : 'android';
      await _repository?.registerToken(token, platform);
      _log('[NotificationService] Đăng ký token thành công');
    } catch (e) {
      _log('[NotificationService] Lỗi đăng ký token: $e');
    }
  }

  /// Callback khi FCM tự động làm mới token.
  void _onTokenRefresh(String token) {
    _log('[NotificationService] Token được làm mới');
    registerToken(token);
  }

  // ---------------------------------------------------------------------------
  // Xử lý thông báo
  // ---------------------------------------------------------------------------

  /// Xử lý thông báo khi app đang ở foreground.
  ///
  /// Khi app đang mở, hệ thống không tự hiển thị thông báo,
  /// nên cần hiển thị qua local notification plugin.
  Future<void> handleForegroundMessage(RemoteMessage message) async {
    _log(
      '[NotificationService] Thông báo foreground: ${message.messageId}',
    );

    final payload = PushNotificationPayload.fromRemoteMessage(
      _remoteMessageToMap(message),
    );

    await _showLocalNotification(
      title: payload.title,
      body: payload.body,
      payload: payload.toPayloadString(),
      type: payload.type,
    );
  }

  /// Xử lý thông báo nền (static handler).
  ///
  /// Được gọi bởi [firebaseMessagingBackgroundHandler].
  /// Lưu ý: method này chạy trong isolate riêng,
  /// không truy cập được state của app.
  static Future<void> handleBackgroundMessage(
    Map<String, dynamic> message,
  ) async {
    _log(
      '[NotificationService] Xử lý thông báo nền: ${message['messageId']}',
    );
  }

  /// Xử lý khi người dùng nhấn vào thông báo.
  ///
  /// Phân tích payload để xác định loại thông báo,
  /// sau đó điều hướng đến màn hình tương ứng.
  void handleNotificationTap(NotificationResponse response) {
    _log(
      '[NotificationService] Nhấn thông báo, payload: ${response.payload}',
    );

    final payloadString = response.payload;
    if (payloadString == null || payloadString.isEmpty) return;

    try {
      final payload = PushNotificationPayload.fromPayloadString(payloadString);
      final route = payload.route;

      _log(
        '[NotificationService] Điều hướng đến: $route',
      );

      _router?.go(route);
    } catch (e) {
      _log('[NotificationService] Lỗi xử lý payload: $e');
      // Mặc định điều hướng về danh sách thông báo
      _router?.go(AppRoutes.notifications);
    }
  }

  /// Xử lý khi app được mở từ thông báo (background → foreground).
  void _handleMessageOpenedApp(RemoteMessage message) {
    _log(
      '[NotificationService] App mở từ thông báo: ${message.messageId}',
    );

    final payload = PushNotificationPayload.fromRemoteMessage(
      _remoteMessageToMap(message),
    );
    final route = payload.route;

    _log('[NotificationService] Điều hướng đến: $route');
    _router?.go(route);
  }

  // ---------------------------------------------------------------------------
  // Hiển thị thông báo cục bộ
  // ---------------------------------------------------------------------------

  /// Hiển thị thông báo cục bộ trên thiết bị.
  ///
  /// [title] — Tiêu đề thông báo.
  /// [body] — Nội dung thông báo.
  /// [payload] — Dữ liệu payload đính kèm để xử lý khi nhấn.
  /// [type] — Loại thông báo, ảnh hưởng đến kênh hiển thị.
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
    NotificationType type = NotificationType.system,
  }) async {
    // Chọn kênh thông báo dựa trên loại
    final channelId = _channelIdForType(type);
    final channelName = _channelNameForType(type);
    final channelDescription = _channelDescriptionForType(type);

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: _importanceForType(type),
      priority: _priorityForType(type),
      icon: NotificationIconConfig.defaultIcon,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Sử dụng timestamp làm notification ID duy nhất
    final notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _localNotifications.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // ---------------------------------------------------------------------------
  // Quản lý FCM Topics
  // ---------------------------------------------------------------------------

  /// Đăng ký tất cả topic mặc định cho người dùng mới.
  Future<void> _subscribeToDefaultTopics() async {
    for (final topic in NotificationTopicConfig.defaultSubscriptions) {
      try {
        await _fcm.subscribeToTopic(topic);
        _log('[NotificationService] Đăng ký topic: $topic');
      } catch (e) {
        _log('[NotificationService] Lỗi đăng ký topic $topic: $e');
      }
    }
  }

  /// Đăng ký nhận thông báo theo khu vực cửa hàng.
  Future<void> subscribeToRegion(String regionCode) async {
    try {
      final topic = '${NotificationTopicConfig.regionPrefix}$regionCode';
      await _fcm.subscribeToTopic(topic);
      _log('[NotificationService] Đăng ký khu vực: $topic');
    } catch (e) {
      _log('[NotificationService] Lỗi đăng ký khu vực: $e');
    }
  }

  /// Hủy đăng ký thông báo theo khu vực.
  Future<void> unsubscribeFromRegion(String regionCode) async {
    try {
      final topic = '${NotificationTopicConfig.regionPrefix}$regionCode';
      await _fcm.unsubscribeFromTopic(topic);
      _log('[NotificationService] Hủy đăng ký khu vực: $topic');
    } catch (e) {
      _log('[NotificationService] Lỗi hủy khu vực: $e');
    }
  }

  /// Hủy đăng ký tất cả topic (khi đăng xuất).
  Future<void> unsubscribeFromAllTopics() async {
    for (final topic in NotificationTopicConfig.defaultSubscriptions) {
      try {
        await _fcm.unsubscribeFromTopic(topic);
      } catch (e) {
        _log('[NotificationService] Lỗi hủy topic $topic: $e');
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Tiện ích nội bộ
  // ---------------------------------------------------------------------------

  /// Chuyển đổi [RemoteMessage] sang Map để dùng với
  /// [PushNotificationPayload.fromRemoteMessage].
  Map<String, dynamic> _remoteMessageToMap(RemoteMessage message) {
    return {
      'notification': {
        'title': message.notification?.title,
        'body': message.notification?.body,
      },
      'data': message.data,
    };
  }

  /// Lấy channel ID phù hợp theo loại thông báo.
  String _channelIdForType(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
      case NotificationType.deliveryUpdate:
        return NotificationChannelConfig.orderChannelId;
      case NotificationType.promotion:
        return NotificationChannelConfig.promoChannelId;
      case NotificationType.loyaltyPoints:
      case NotificationType.system:
        return NotificationChannelConfig.channelId;
    }
  }

  /// Lấy tên channel phù hợp theo loại thông báo.
  String _channelNameForType(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
      case NotificationType.deliveryUpdate:
        return NotificationChannelConfig.orderChannelName;
      case NotificationType.promotion:
        return NotificationChannelConfig.promoChannelName;
      case NotificationType.loyaltyPoints:
      case NotificationType.system:
        return NotificationChannelConfig.channelName;
    }
  }

  /// Lấy mô tả channel phù hợp theo loại thông báo.
  String _channelDescriptionForType(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
      case NotificationType.deliveryUpdate:
        return NotificationChannelConfig.orderChannelDescription;
      case NotificationType.promotion:
        return NotificationChannelConfig.promoChannelDescription;
      case NotificationType.loyaltyPoints:
      case NotificationType.system:
        return NotificationChannelConfig.channelDescription;
    }
  }

  /// Xác định mức độ quan trọng của thông báo theo loại.
  Importance _importanceForType(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
      case NotificationType.deliveryUpdate:
        return Importance.max;
      case NotificationType.promotion:
      case NotificationType.loyaltyPoints:
        return Importance.high;
      case NotificationType.system:
        return Importance.defaultImportance;
    }
  }

  /// Xác định mức ưu tiên hiển thị thông báo theo loại.
  Priority _priorityForType(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
      case NotificationType.deliveryUpdate:
        return Priority.max;
      case NotificationType.promotion:
      case NotificationType.loyaltyPoints:
        return Priority.high;
      case NotificationType.system:
        return Priority.defaultPriority;
    }
  }
}

// =============================================================================
// Riverpod Providers
// =============================================================================

/// Provider cho [NotificationService] singleton.
///
/// Tự động gán router và repository khi được tạo.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService.instance;

  // Gán repository để đăng ký token
  final repository = ref.watch(notificationRepositoryProvider);
  service.setRepository(repository);

  // Gán router cho deep link navigation
  final router = ref.watch(appRouterProvider);
  service.setRouter(router);

  return service;
});

/// Provider tiện ích để khởi tạo và đăng ký token trong một bước.
///
/// Sử dụng:
/// ```dart
/// // Trong main() hoặc splash screen
/// await ref.read(initializeNotificationsProvider.future);
/// ```
final initializeNotificationsProvider = FutureProvider<void>((ref) async {
  final service = ref.read(notificationServiceProvider);

  // Khởi tạo hệ thống thông báo
  await service.initialize();

  // Yêu cầu quyền
  final granted = await service.requestPermission();
  if (!granted) {
    _log(
      '[NotificationService] Người dùng từ chối quyền thông báo',
    );
    return;
  }

  // Lấy và đăng ký token
  final token = await service.getToken();
  if (token.isNotEmpty) {
    await service.registerToken(token);
  }
});

/// Provider lấy FCM token hiện tại.
final fcmTokenProvider = FutureProvider.autoDispose<String>((ref) async {
  final service = ref.read(notificationServiceProvider);
  return service.getToken();
});
