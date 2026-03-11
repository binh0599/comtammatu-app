/// Cấu hình hằng số cho hệ thống thông báo đẩy Cơm Tấm Má Tư.
library;

import 'notification_types.dart';

/// Cấu hình kênh thông báo Android (Notification Channel).
class NotificationChannelConfig {
  NotificationChannelConfig._();

  /// ID kênh thông báo chính.
  static const String channelId = 'com_tam_ma_tu_main';

  /// Tên kênh thông báo hiển thị cho người dùng.
  static const String channelName = 'Cơm Tấm Má Tư';

  /// Mô tả kênh thông báo.
  static const String channelDescription =
      'Thông báo đơn hàng, khuyến mãi và cập nhật từ Cơm Tấm Má Tư';

  /// ID kênh thông báo cho đơn hàng (ưu tiên cao).
  static const String orderChannelId = 'com_tam_ma_tu_orders';

  /// Tên kênh thông báo đơn hàng.
  static const String orderChannelName = 'Đơn hàng';

  /// Mô tả kênh đơn hàng.
  static const String orderChannelDescription =
      'Cập nhật trạng thái đơn hàng và giao hàng';

  /// ID kênh thông báo khuyến mãi (ưu tiên mặc định).
  static const String promoChannelId = 'com_tam_ma_tu_promos';

  /// Tên kênh thông báo khuyến mãi.
  static const String promoChannelName = 'Khuyến mãi';

  /// Mô tả kênh khuyến mãi.
  static const String promoChannelDescription =
      'Ưu đãi, mã giảm giá và chương trình khuyến mãi';
}

/// Cấu hình biểu tượng thông báo.
class NotificationIconConfig {
  NotificationIconConfig._();

  /// Biểu tượng mặc định cho thông báo Android.
  /// Đặt file tại `android/app/src/main/res/drawable/ic_notification.png`.
  static const String defaultIcon = '@drawable/ic_notification';

  /// Biểu tượng dự phòng (sử dụng icon launcher).
  static const String fallbackIcon = '@mipmap/ic_launcher';
}

/// Ánh xạ loại thông báo sang đường dẫn route cho deep link.
class NotificationRouteConfig {
  NotificationRouteConfig._();

  /// Bảng ánh xạ mặc định từ [NotificationType] sang route path.
  static const Map<NotificationType, String> defaultRoutes = {
    NotificationType.orderStatus: '/orders',
    NotificationType.deliveryUpdate: '/delivery',
    NotificationType.promotion: '/vouchers',
    NotificationType.loyaltyPoints: '/loyalty',
    NotificationType.system: '/notifications',
  };

  /// Lấy route cho loại thông báo. Sử dụng [data] cho route động.
  static String routeFor(
    NotificationType type, {
    Map<String, dynamic>? data,
  }) {
    return type.toRoute(data: data);
  }
}

/// Cấu hình FCM Topics mà ứng dụng sẽ đăng ký nhận thông báo.
class NotificationTopicConfig {
  NotificationTopicConfig._();

  /// Topic chung cho tất cả người dùng ứng dụng.
  static const String allUsers = 'com_tam_ma_tu_all';

  /// Topic cho thông báo khuyến mãi.
  static const String promotions = 'com_tam_ma_tu_promotions';

  /// Topic cho cập nhật hệ thống.
  static const String systemUpdates = 'com_tam_ma_tu_system';

  /// Topic cho thông báo theo khu vực (prefix, thêm mã khu vực phía sau).
  static const String regionPrefix = 'com_tam_ma_tu_region_';

  /// Danh sách tất cả topic mặc định mà mọi người dùng cần đăng ký.
  static const List<String> defaultSubscriptions = [
    allUsers,
    promotions,
    systemUpdates,
  ];
}

/// Giới hạn và cấu hình chung cho thông báo.
class NotificationLimits {
  NotificationLimits._();

  /// Số lượng thông báo tối đa lưu trong bộ nhớ cục bộ.
  static const int maxLocalNotifications = 100;

  /// Thời gian tự động xóa thông báo cũ (30 ngày).
  static const Duration retentionPeriod = Duration(days: 30);

  /// Khoảng thời gian tối thiểu giữa hai lần đăng ký token (tránh spam).
  static const Duration tokenRefreshInterval = Duration(hours: 24);

  /// Timeout khi gọi API đăng ký token.
  static const Duration tokenRegistrationTimeout = Duration(seconds: 10);
}
