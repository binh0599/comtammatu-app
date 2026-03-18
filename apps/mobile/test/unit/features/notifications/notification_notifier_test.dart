// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/notifications/data/notification_repository.dart';
import 'package:comtammatu/features/notifications/domain/notification_notifier.dart';
import 'package:comtammatu/models/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

List<NotificationItem> _sampleNotifications() {
  return [
    NotificationItem(
      id: '1',
      title: 'Đơn hàng #123',
      body: 'Đơn hàng của bạn đang được giao',
      type: 'order',
      isRead: false,
      createdAt: DateTime(2026, 3, 18, 10),
    ),
    NotificationItem(
      id: '2',
      title: 'Khuyến mãi mới',
      body: 'Giảm 20% cho đơn hàng hôm nay',
      type: 'promotion',
      isRead: false,
      createdAt: DateTime(2026, 3, 17, 15),
    ),
    NotificationItem(
      id: '3',
      title: 'Tích điểm thành công',
      body: 'Bạn đã nhận được 50 điểm',
      type: 'loyalty',
      isRead: true,
      createdAt: DateTime(2026, 3, 16, 12),
    ),
  ];
}

void main() {
  late MockNotificationRepository mockRepo;
  late NotificationInboxNotifier notifier;

  setUp(() {
    mockRepo = MockNotificationRepository();
    notifier = NotificationInboxNotifier(repository: mockRepo);
  });

  group('NotificationInboxNotifier', () {
    test('initial state is NotificationInboxInitial', () {
      expect(notifier.state, isA<NotificationInboxInitial>());
    });

    test('loadNotifications success → NotificationInboxLoaded', () async {
      final notifications = _sampleNotifications();
      when(() => mockRepo.getNotifications())
          .thenAnswer((_) async => notifications);

      await notifier.loadNotifications();

      expect(notifier.state, isA<NotificationInboxLoaded>());
      final loaded = notifier.state as NotificationInboxLoaded;
      expect(loaded.notifications.length, 3);
    });

    test('loadNotifications failure → NotificationInboxError', () async {
      when(() => mockRepo.getNotifications())
          .thenThrow(Exception('Network error'));

      await notifier.loadNotifications();

      expect(notifier.state, isA<NotificationInboxError>());
    });

    test('markAsRead updates notification in state', () async {
      final notifications = _sampleNotifications();
      when(() => mockRepo.getNotifications())
          .thenAnswer((_) async => notifications);
      when(() => mockRepo.markAsRead(1)).thenAnswer((_) async {});

      await notifier.loadNotifications();
      notifier.markAsRead('1');

      final loaded = notifier.state as NotificationInboxLoaded;
      final notification = loaded.notifications.firstWhere((n) => n.id == '1');
      expect(notification.isRead, true);
    });

    test('markAllAsRead marks all as read', () async {
      final notifications = _sampleNotifications();
      when(() => mockRepo.getNotifications())
          .thenAnswer((_) async => notifications);

      await notifier.loadNotifications();
      notifier.markAllAsRead();

      final loaded = notifier.state as NotificationInboxLoaded;
      expect(loaded.notifications.every((n) => n.isRead), true);
    });

    test('deleteNotification removes from state and calls API', () async {
      final notifications = _sampleNotifications();
      when(() => mockRepo.getNotifications())
          .thenAnswer((_) async => notifications);
      when(() => mockRepo.deleteNotification(1)).thenAnswer((_) async {});

      await notifier.loadNotifications();
      await notifier.deleteNotification('1');

      final loaded = notifier.state as NotificationInboxLoaded;
      expect(loaded.notifications.length, 2);
      expect(loaded.notifications.any((n) => n.id == '1'), false);
      verify(() => mockRepo.deleteNotification(1)).called(1);
    });

    test('deleteNotification reverts on API failure', () async {
      final notifications = _sampleNotifications();
      when(() => mockRepo.getNotifications())
          .thenAnswer((_) async => notifications);
      when(() => mockRepo.deleteNotification(2))
          .thenThrow(Exception('Server error'));

      await notifier.loadNotifications();
      await notifier.deleteNotification('2');

      // Should revert back to original state
      final loaded = notifier.state as NotificationInboxLoaded;
      expect(loaded.notifications.length, 3);
    });

    test('unread count is correct', () async {
      final notifications = _sampleNotifications();
      when(() => mockRepo.getNotifications())
          .thenAnswer((_) async => notifications);

      await notifier.loadNotifications();

      final loaded = notifier.state as NotificationInboxLoaded;
      final unreadCount = loaded.notifications.where((n) => !n.isRead).length;
      expect(unreadCount, 2);
    });
  });
}
