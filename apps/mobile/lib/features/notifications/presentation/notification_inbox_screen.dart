import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/notification_model.dart';
import '../domain/notification_notifier.dart';

// -- Relative time helper -----------------------------------------------------

/// Formats a [DateTime] as a Vietnamese relative time string.
String formatRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.isNegative) {
    return 'Vừa xong';
  }

  if (diff.inMinutes < 1) {
    return 'Vừa xong';
  }

  if (diff.inMinutes < 60) {
    return '${diff.inMinutes} phút trước';
  }

  if (diff.inHours < 24) {
    return '${diff.inHours} giờ trước';
  }

  if (diff.inDays == 1) {
    return 'Hôm qua';
  }

  if (diff.inDays == 2) {
    return 'Hôm kia';
  }

  if (diff.inDays <= 7) {
    return '${diff.inDays} ngày trước';
  }

  // Over 7 days — show dd/MM/yyyy
  final d = dateTime.day.toString().padLeft(2, '0');
  final m = dateTime.month.toString().padLeft(2, '0');
  final y = dateTime.year.toString();
  return '$d/$m/$y';
}

// -- Type helpers -------------------------------------------------------------

IconData _iconForType(String type) {
  switch (type) {
    case 'order':
      return Icons.receipt_long;
    case 'promotion':
      return Icons.local_offer;
    case 'loyalty':
      return Icons.star;
    case 'system':
      return Icons.info;
    default:
      return Icons.notifications;
  }
}

Color _colorForType(String type) {
  switch (type) {
    case 'order':
      return AppColors.info;
    case 'promotion':
      return const Color(0xFFF5A623);
    case 'loyalty':
      return AppColors.primary;
    case 'system':
      return AppColors.textSecondary;
    default:
      return AppColors.textSecondary;
  }
}

// -- Screen -------------------------------------------------------------------

/// Notification inbox screen showing all user notifications.
class NotificationInboxScreen extends ConsumerStatefulWidget {
  const NotificationInboxScreen({super.key});

  @override
  ConsumerState<NotificationInboxScreen> createState() =>
      _NotificationInboxScreenState();
}

class _NotificationInboxScreenState
    extends ConsumerState<NotificationInboxScreen> {
  @override
  void initState() {
    super.initState();
    // Load notifications on first build.
    Future.microtask(() {
      ref.read(notificationInboxNotifierProvider.notifier).loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationInboxNotifierProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {
                ref
                    .read(notificationInboxNotifierProvider.notifier)
                    .markAllAsRead();
              },
              child: const Text('Đọc tất cả'),
            ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, NotificationInboxState state) {
    if (state is NotificationInboxLoading ||
        state is NotificationInboxInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NotificationInboxError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  size: 64, color: AppColors.textHint),
              const SizedBox(height: 16),
              Text(
                'Không thể tải thông báo',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  ref
                      .read(notificationInboxNotifierProvider.notifier)
                      .loadNotifications();
                },
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is NotificationInboxLoaded) {
      if (state.notifications.isEmpty) {
        return _buildEmptyState(context);
      }
      return RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(notificationInboxNotifierProvider.notifier)
              .loadNotifications();
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.notifications.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            color: AppColors.divider,
            indent: 72,
          ),
          itemBuilder: (context, index) {
            final notification = state.notifications[index];
            return _NotificationTile(
              notification: notification,
              onTap: () {
                ref
                    .read(notificationInboxNotifierProvider.notifier)
                    .markAsRead(notification.id);
              },
              onDismissed: () {
                ref
                    .read(notificationInboxNotifierProvider.notifier)
                    .deleteNotification(notification.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Đã xóa thông báo'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Hoàn tác',
                      onPressed: () {
                        // Reload to restore (in production, undo delete)
                        ref
                            .read(notificationInboxNotifierProvider.notifier)
                            .loadNotifications();
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications_none_outlined,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'Không có thông báo nào',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Notification tile --------------------------------------------------------

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDismissed,
  });

  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final typeColor = _colorForType(notification.type);
    final isUnread = !notification.isRead;

    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: AppColors.error,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isUnread
              ? AppColors.info.withValues(alpha: 0.04)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unread indicator + icon
              SizedBox(
                width: 48,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: typeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _iconForType(notification.type),
                        color: typeColor,
                        size: 22,
                      ),
                    ),
                    if (isUnread)
                      Positioned(
                        left: -4,
                        top: 16,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight:
                                isUnread ? FontWeight.w700 : FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatRelativeTime(notification.createdAt),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
