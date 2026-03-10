/// Các loại thông báo đẩy và model payload cho ứng dụng Cơm Tấm Má Tư.
library;

/// Loại thông báo đẩy được hỗ trợ trong ứng dụng.
enum NotificationType {
  /// Cập nhật trạng thái đơn hàng (xác nhận, đang nấu, hoàn thành, v.v.).
  orderStatus('order_status'),

  /// Thông báo khuyến mãi, ưu đãi, mã giảm giá.
  promotion('promotion'),

  /// Cập nhật điểm thưởng, thăng hạng thành viên.
  loyaltyPoints('loyalty_points'),

  /// Cập nhật tiến trình giao hàng (tài xế đã nhận, đang giao, đã giao).
  deliveryUpdate('delivery_update'),

  /// Thông báo hệ thống (bảo trì, cập nhật phiên bản, v.v.).
  system('system');

  const NotificationType(this.value);

  /// Giá trị chuỗi dùng trong payload thông báo từ server.
  final String value;

  /// Tạo [NotificationType] từ chuỗi nhận được trong payload.
  ///
  /// Trả về [NotificationType.system] nếu không khớp loại nào.
  factory NotificationType.fromString(String? type) {
    return NotificationType.values.firstWhere(
      (e) => e.value == type,
      orElse: () => NotificationType.system,
    );
  }

  /// Trả về đường dẫn route tương ứng để điều hướng khi nhấn thông báo.
  ///
  /// [data] chứa dữ liệu bổ sung như orderId để xây dựng route động.
  String toRoute({Map<String, dynamic>? data}) {
    switch (this) {
      case NotificationType.orderStatus:
        return '/orders';
      case NotificationType.deliveryUpdate:
        final orderId = data?['order_id']?.toString() ?? '';
        return orderId.isNotEmpty ? '/delivery/$orderId' : '/orders';
      case NotificationType.promotion:
        return '/vouchers';
      case NotificationType.loyaltyPoints:
        return '/loyalty';
      case NotificationType.system:
        return '/notifications';
    }
  }

  /// Nhãn hiển thị tiếng Việt cho loại thông báo.
  String get displayLabel {
    switch (this) {
      case NotificationType.orderStatus:
        return 'Đơn hàng';
      case NotificationType.promotion:
        return 'Khuyến mãi';
      case NotificationType.loyaltyPoints:
        return 'Điểm thưởng';
      case NotificationType.deliveryUpdate:
        return 'Giao hàng';
      case NotificationType.system:
        return 'Hệ thống';
    }
  }
}

/// Model chứa payload từ thông báo đẩy (FCM Remote Message).
class PushNotificationPayload {
  const PushNotificationPayload({
    required this.type,
    required this.title,
    required this.body,
    this.data = const {},
  });

  /// Loại thông báo.
  final NotificationType type;

  /// Tiêu đề thông báo.
  final String title;

  /// Nội dung thông báo.
  final String body;

  /// Dữ liệu bổ sung đi kèm thông báo (order_id, promo_code, v.v.).
  final Map<String, dynamic> data;

  /// Tạo [PushNotificationPayload] từ dữ liệu FCM Remote Message.
  ///
  /// Trích xuất `notification.title`, `notification.body`, và `data` từ
  /// message map. Trường `type` được lấy từ `data['type']`.
  factory PushNotificationPayload.fromRemoteMessage(
    Map<String, dynamic> message,
  ) {
    final notification =
        message['notification'] as Map<String, dynamic>? ?? {};
    final data = message['data'] as Map<String, dynamic>? ?? {};

    return PushNotificationPayload(
      type: NotificationType.fromString(data['type'] as String?),
      title: (notification['title'] as String?) ??
          (data['title'] as String?) ??
          'Cơm Tấm Má Tư',
      body: (notification['body'] as String?) ??
          (data['body'] as String?) ??
          '',
      data: data,
    );
  }

  /// Đường dẫn route để điều hướng khi người dùng nhấn thông báo này.
  String get route => type.toRoute(data: data);

  /// Chuyển payload thành JSON string dùng làm notification payload.
  String toPayloadString() {
    final buffer = StringBuffer()
      ..write(type.value)
      ..write('|')
      ..write(data.entries.map((e) => '${e.key}=${e.value}').join(','));
    return buffer.toString();
  }

  /// Phân tích lại payload string thành [PushNotificationPayload].
  factory PushNotificationPayload.fromPayloadString(String payload) {
    final parts = payload.split('|');
    final type = NotificationType.fromString(parts.isNotEmpty ? parts[0] : null);

    final data = <String, dynamic>{};
    if (parts.length > 1 && parts[1].isNotEmpty) {
      for (final pair in parts[1].split(',')) {
        final kv = pair.split('=');
        if (kv.length == 2) {
          data[kv[0]] = kv[1];
        }
      }
    }

    return PushNotificationPayload(
      type: type,
      title: '',
      body: '',
      data: data,
    );
  }

  @override
  String toString() =>
      'PushNotificationPayload(type: ${type.value}, title: $title)';
}
