import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/notification_model.dart';
import '../data/notification_repository.dart';

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

/// Manages notification inbox state via notifications-inbox Edge Function.
class NotificationInboxNotifier extends StateNotifier<NotificationInboxState> {
  NotificationInboxNotifier({required NotificationRepository repository})
      : _repository = repository,
        super(const NotificationInboxInitial());

  final NotificationRepository _repository;

  /// Load notifications from the API.
  Future<void> loadNotifications() async {
    state = const NotificationInboxLoading();
    try {
      final notifications = await _repository.getNotifications();
      state = NotificationInboxLoaded(notifications: notifications);
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
          final intId = int.tryParse(id);
          if (intId != null) {
            _repository.markAsRead(intId);
          }
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

  /// Delete a notification by id (calls API then removes from UI).
  Future<void> deleteNotification(String id) async {
    final current = state;
    if (current is NotificationInboxLoaded) {
      // Optimistic UI update
      final updated = current.notifications.where((n) => n.id != id).toList();
      state = NotificationInboxLoaded(notifications: updated);

      // Fire-and-forget API call
      final intId = int.tryParse(id);
      if (intId != null) {
        try {
          await _repository.deleteNotification(intId);
        } catch (_) {
          // Revert on failure
          state = current;
        }
      }
    }
  }
}

// -- Providers ----------------------------------------------------------------

final notificationInboxNotifierProvider =
    StateNotifierProvider<NotificationInboxNotifier, NotificationInboxState>(
        (ref) {
  final repo = ref.watch(notificationRepositoryProvider);
  return NotificationInboxNotifier(repository: repo);
});

/// Provider that exposes the unread notification count.
final unreadNotificationCountProvider = Provider<int>((ref) {
  final state = ref.watch(notificationInboxNotifierProvider);
  if (state is NotificationInboxLoaded) {
    return state.notifications.where((n) => !n.isRead).length;
  }
  return 0;
});
