import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/utils/formatters.dart';
import '../../../shared/widgets/app_button.dart';
import '../data/models/store_model.dart';
import '../data/store_notifier.dart';

/// Store locator screen with map placeholder and scrollable store list.
class StoreLocatorScreen extends ConsumerStatefulWidget {
  const StoreLocatorScreen({super.key});

  @override
  ConsumerState<StoreLocatorScreen> createState() =>
      _StoreLocatorScreenState();
}

class _StoreLocatorScreenState extends ConsumerState<StoreLocatorScreen> {
  bool _sortedByNearest = false;

  @override
  Widget build(BuildContext context) {
    // Use hardcoded sample stores for now
    final stores = ref.watch(sampleStoresProvider);
    final displayStores = _sortedByNearest ? _sortByDistance(stores) : stores;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm cửa hàng'),
      ),
      body: Column(
        children: [
          // Map placeholder
          _buildMapPlaceholder(context),

          // Store list
          Expanded(
            child: displayStores.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.store_outlined,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Không tìm thấy cửa hàng',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: displayStores.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _StoreCard(store: displayStores[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _sortedByNearest = !_sortedByNearest;
          });
          if (_sortedByNearest) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đã sắp xếp theo khoảng cách gần nhất'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.near_me),
        label: const Text('Gần tôi'),
      ),
    );
  }

  Widget _buildMapPlaceholder(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      color: AppColors.border.withValues(alpha: 0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 56,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 8),
          Text(
            'Bản đồ cửa hàng',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tích hợp Google Maps sẽ hiển thị ở đây',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  /// Sort stores by distance from a hardcoded "current" location
  /// (District 1, HCM center) for demo purposes.
  List<StoreInfo> _sortByDistance(List<StoreInfo> stores) {
    const userLat = 10.7769;
    const userLng = 106.7009;

    final sorted = List<StoreInfo>.from(stores);
    sorted.sort((a, b) {
      final distA = _squaredDist(userLat, userLng, a.latitude ?? 0, a.longitude ?? 0);
      final distB = _squaredDist(userLat, userLng, b.latitude ?? 0, b.longitude ?? 0);
      return distA.compareTo(distB);
    });
    return sorted;
  }

  /// Simplified squared distance for sort ordering.
  double _squaredDist(double lat1, double lng1, double lat2, double lng2) {
    final dLat = lat2 - lat1;
    final dLng = lng2 - lng1;
    return dLat * dLat + dLng * dLng;
  }
}

// -- Store card -------------------------------------------------------------

class _StoreCard extends StatelessWidget {
  const _StoreCard({required this.store});

  final StoreInfo store;

  @override
  Widget build(BuildContext context) {
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
            // Store name
            Text(
              store.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),

            // Address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    store.address,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Phone
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  Formatters.phone(store.phone),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('tel:${store.phone}'));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.phone,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Opening hours
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Giờ mở cửa: ${store.openingTime} - ${store.closingTime}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Direction button
            SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'Chỉ đường',
                variant: AppButtonVariant.outlined,
                icon: Icons.directions,
                onPressed: () {
                  final url =
                      'https://www.google.com/maps/dir/?api=1&destination=${store.latitude},${store.longitude}';
                  launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
