import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/formatters.dart';
import '../data/delivery_notifier.dart';
import '../data/models/delivery_tracking_model.dart';

// -- Status helpers ---------------------------------------------------------

const _kStatuses = [
  'waiting_driver',
  'driver_assigned',
  'picked_up',
  'on_the_way',
  'arrived',
  'delivered',
];

const _kStatusLabels = {
  'waiting_driver': 'Chờ tài xế',
  'driver_assigned': 'Đã nhận đơn',
  'picked_up': 'Đã lấy hàng',
  'on_the_way': 'Đang giao',
  'arrived': 'Đã đến',
  'delivered': 'Hoàn thành',
};

const _kStatusIcons = {
  'waiting_driver': Icons.access_time,
  'driver_assigned': Icons.person_pin,
  'picked_up': Icons.inventory_2_outlined,
  'on_the_way': Icons.delivery_dining,
  'arrived': Icons.location_on,
  'delivered': Icons.check_circle,
};

// -- Screen -----------------------------------------------------------------

/// Delivery tracking screen with realtime updates, driver info and ETA.
class DeliveryTrackingScreen extends ConsumerStatefulWidget {
  const DeliveryTrackingScreen({super.key, required this.orderId});

  final String orderId;

  @override
  ConsumerState<DeliveryTrackingScreen> createState() =>
      _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState
    extends ConsumerState<DeliveryTrackingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(deliveryNotifierProvider.notifier);
      notifier.loadTracking(widget.orderId);
      notifier.subscribeToUpdates(widget.orderId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deliveryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theo dõi giao hàng'),
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, DeliveryState state) {
    if (state is DeliveryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is DeliveryError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Không thể tải thông tin giao hàng',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(deliveryNotifierProvider.notifier)
                      .loadTracking(widget.orderId);
                },
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is DeliveryLoaded) {
      return _TrackingContent(
        tracking: state.tracking,
        orderId: widget.orderId,
      );
    }

    // DeliveryInitial — show loading
    return const Center(child: CircularProgressIndicator());
  }
}

// -- Tracking content -------------------------------------------------------

class _TrackingContent extends StatelessWidget {
  const _TrackingContent({
    required this.tracking,
    required this.orderId,
  });

  final DeliveryTracking tracking;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final currentStepIndex = _kStatuses.indexOf(tracking.status);
    final hasDriver = currentStepIndex >= 1; // driver_assigned or later

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order status stepper
          _buildStatusStepper(context, currentStepIndex),
          const SizedBox(height: 24),

          // Driver info card
          if (hasDriver) ...[
            _buildDriverCard(context),
            const SizedBox(height: 16),
          ],

          // Map preview placeholder
          _buildMapPlaceholder(context),
          const SizedBox(height: 16),

          // ETA display
          if (tracking.estimatedArrivalAt != null) ...[
            _buildEtaCard(context),
            const SizedBox(height: 16),
          ],

          // Order summary
          _buildOrderSummary(context),
        ],
      ),
    );
  }

  Widget _buildStatusStepper(BuildContext context, int currentStepIndex) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trạng thái đơn hàng',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            ...List.generate(_kStatuses.length, (index) {
              final status = _kStatuses[index];
              final label = _kStatusLabels[status] ?? status;
              final icon = _kStatusIcons[status] ?? Icons.circle;
              final isCompleted = index <= currentStepIndex;
              final isCurrent = index == currentStepIndex;
              final isLast = index == _kStatuses.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step indicator column
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        child: Icon(
                          icon,
                          size: 18,
                          color: isCompleted
                              ? Colors.white
                              : AppColors.textHint,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 28,
                          color: index < currentStepIndex
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Label
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        label,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isCurrent
                                      ? AppColors.primary
                                      : isCompleted
                                          ? AppColors.textPrimary
                                          : AppColors.textHint,
                                  fontWeight: isCurrent
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Driver avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              backgroundImage: tracking.driverAvatarUrl != null
                  ? NetworkImage(tracking.driverAvatarUrl!)
                  : null,
              child: tracking.driverAvatarUrl == null
                  ? Icon(
                      Icons.person,
                      size: 28,
                      color: AppColors.primary,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            // Driver info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tài xế',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tracking.driverName ?? 'Đang cập nhật...',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (tracking.driverPhone != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      Formatters.phone(tracking.driverPhone!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            // Call button
            if (tracking.driverPhone != null)
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse('tel:${tracking.driverPhone}'));
                },
                icon: Icon(Icons.phone, color: AppColors.primary),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPlaceholder(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 48,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 8),
          Text(
            'Bản đồ giao hàng',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          if (tracking.currentLatitude != null &&
              tracking.currentLongitude != null) ...[
            const SizedBox(height: 4),
            Text(
              '${tracking.currentLatitude!.toStringAsFixed(4)}, ${tracking.currentLongitude!.toStringAsFixed(4)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEtaCard(BuildContext context) {
    final eta = tracking.estimatedArrivalAt!;
    final now = DateTime.now();
    final remaining = eta.difference(now);
    final minutesLeft = remaining.inMinutes;

    return Card(
      elevation: 0,
      color: AppColors.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.schedule, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thời gian dự kiến',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    minutesLeft > 0
                        ? 'Còn khoảng $minutesLeft phút'
                        : 'Đang đến nơi',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            Text(
              Formatters.time(eta),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin đơn hàng',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mã đơn hàng',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                Text(
                  '#${orderId.length > 8 ? orderId.substring(0, 8).toUpperCase() : orderId.toUpperCase()}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trạng thái',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _kStatusLabels[tracking.status] ?? tracking.status,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
