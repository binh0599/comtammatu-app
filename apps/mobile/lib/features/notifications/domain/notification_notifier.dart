import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/notification_model.dart';

// -- Sample data for development ----------------------------------------------

final _kSampleNotifications = [
  NotificationItem(
    id: 'n1',
    title: 'Đơn hàng #10300 đang được giao',
    body: 'Tài xế đang trên đường giao đơn hàng của bạn. Dự kiến 15 phút nữa.',
    type: 'order',
    isRead: false,
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    data: {'order_id': 10300, 'route': '/delivery/10300'},
  ),
  NotificationItem(
    id: 'n2',
    title: 'Giảm 20% cho đơn hàng tiếp theo!',
    body: 'Ưu đãi đặc biệt dành riêng cho bạn. Áp dụng mã COMTAM20 khi thanh toán. Hết hạn 15/03.',
    type: 'promotion',
    isRead: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    data: {'promo_code': 'COMTAM20', 'route': '/promotions'},
  ),
  NotificationItem(
    id: 'n3',
    title: 'Bạn đã tích được 55 điểm',
    body: 'Đơn hàng #10298 đã được xác nhận. Bạn nhận được 55 điểm thưởng. Tổng điểm hiện tại: 320.',
    type: 'loyalty',
    isRead: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    data: {'points': 55, 'total_points': 320, 'route': '/loyalty'},
  ),
  NotificationItem(
    id: 'n4',
    title: 'Cập nhật phiên bản mới 1.1.0',
    body: 'Phiên bản mới có tính năng đặt bàn trước và theo dõi giao hàng trực tiếp trên bản đồ.',
    type: 'system',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  NotificationItem(
    id: 'n5',
    title: 'Đơn hàng #10295 đã hoàn thành',
    body: 'Cảm ơn bạn đã sử dụng dịch vụ giao hàng. Hãy đánh giá trải nghiệm của bạn nhé!',
    type: 'order',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    data: {'order_id': 10295, 'route': '/orders/10295'},
  ),
  NotificationItem(
    id: 'n6',
    title: 'Mua 1 tặng 1 - Chỉ hôm nay!',
    body: 'Mua 1 phần cơm tấm sườn bì chả, tặng 1 ly nước sâm. Áp dụng tại tất cả chi nhánh.',
    type: 'promotion',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    data: {'route': '/promotions'},
  ),
  NotificationItem(
    id: 'n7',
    title: 'Chúc mừng! Bạn đã lên hạng Bạc',
    body: 'Với 500 điểm tích lũy, bạn đã đạt hạng Bạc và được hưởng ưu đãi giảm 5% cho mọi đơn hàng.',
    type: 'loyalty',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    data: {'tier': 'silver', 'route': '/loyalty'},
  ),
  NotificationItem(
    id: 'n8',
    title: 'Bảo trì hệ thống',
    body: 'Hệ thống sẽ bảo trì từ 02:00 đến 04:00 ngày 10/03. Vui lòng đặt hàng trước thời gian này.',
    type: 'system',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 6)),
  ),
];

// -- State --------------------------------------------------------------------

/// State for the notification inbox feature.
sealed class NotificationInboxState {
  const NotificationInboxState();
}

class NotificationInboxInitial extends NotificationInboxState {
  const NotificationInboxInitial();
}

class NotificationInboxLoading extends NotificationInboxState {
  const NotificationInboxLoading();
}

class NotificationInboxLoaded extends NotificationInboxState {
  const NotificationInboxLoaded({required this.notifications});
  final List<NotificationItem> notifications;
}

class NotificationInboxError extends NotificationInboxState {
  const NotificationInboxError({required this.message});
  final String message;
}

// -- Notifier -----------------------------------------------------------------

/// Manages notification inbox state.
class NotificationInboxNotifier extends StateNotifier<NotificationInboxState> {
  NotificationInboxNotifier() : super(const NotificationInboxInitial());

  /// Load notifications (uses sample data during development).
  Future<void> loadNotifications() async {
    state = const NotificationInboxLoading();
    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 300));
      state = NotificationInboxLoaded(
        notifications: List<NotificationItem>.from(_kSampleNotifications),
      );
    } catch (e) {
      state = NotificationInboxError(message: e.toString());
    }
  }

  /// Mark a single notification as read.
  void markAsRead(String id) {
    final current = state;
    if (current is NotificationInboxLoaded) {
      final updated = current.notifications.map((n) {
        if (n.id == id && !n.isRead) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      state = NotificationInboxLoaded(notifications: updated);
    }
  }

  /// Mark all notifications as read.
  void markAllAsRead() {
    final current = state;
    if (current is NotificationInboxLoaded) {
      final updated = current.notifications
          .map((n) => n.isRead ? n : n.copyWith(isRead: true))
          .toList();
      state = NotificationInboxLoaded(notifications: updated);
    }
  }

  /// Delete a notification by id.
  void deleteNotification(String id) {
    final current = state;
    if (current is NotificationInboxLoaded) {
      final updated =
          current.notifications.where((n) => n.id != id).toList();
      state = NotificationInboxLoaded(notifications: updated);
    }
  }
}

// -- Providers ----------------------------------------------------------------

final notificationInboxNotifierProvider = StateNotifierProvider<
    NotificationInboxNotifier, NotificationInboxState>((ref) {
  return NotificationInboxNotifier();
});

/// Provider that exposes the unread notification count.
final unreadNotificationCountProvider = Provider<int>((ref) {
  final state = ref.watch(notificationInboxNotifierProvider);
  if (state is NotificationInboxLoaded) {
    return state.notifications.where((n) => !n.isRead).length;
  }
  return 0;
});
