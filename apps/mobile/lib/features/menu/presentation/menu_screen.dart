import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

// -- Data models ----------------------------------------------------------

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.description = '',
    this.imageUrl,
  });

  final int id;
  final String name;
  final int price; // VND
  final String category;
  final String description;
  final String? imageUrl;
}

// -- Sample data ----------------------------------------------------------

const _kCategories = [
  'Cơm tấm',
  'Món thêm',
  'Nước uống',
  'Tráng miệng',
];

const _kSampleItems = [
  MenuItem(
    id: 1,
    name: 'Cơm tấm sườn bì chả',
    price: 55000,
    category: 'Cơm tấm',
    description: 'Sườn nướng than hoa, bì, chả trứng, kèm đồ chua',
  ),
  MenuItem(
    id: 2,
    name: 'Cơm tấm sườn nướng',
    price: 45000,
    category: 'Cơm tấm',
    description: 'Sườn heo nướng than hoa đậm vị, ăn kèm nước mắm',
  ),
  MenuItem(
    id: 3,
    name: 'Cơm tấm sườn bì',
    price: 50000,
    category: 'Cơm tấm',
    description: 'Sườn nướng kèm bì thái sợi mỏng',
  ),
  MenuItem(
    id: 4,
    name: 'Cơm tấm đặc biệt',
    price: 65000,
    category: 'Cơm tấm',
    description: 'Sườn, bì, chả, trứng ốp la, thêm lạp xưởng',
  ),
  MenuItem(
    id: 5,
    name: 'Trứng ốp la',
    price: 8000,
    category: 'Món thêm',
    description: 'Trứng gà chiên ốp la vàng đều',
  ),
  MenuItem(
    id: 6,
    name: 'Chả trứng',
    price: 10000,
    category: 'Món thêm',
    description: 'Chả hấp trứng thơm béo',
  ),
  MenuItem(
    id: 7,
    name: 'Bì',
    price: 8000,
    category: 'Món thêm',
    description: 'Bì heo thái sợi trộn thính',
  ),
  MenuItem(
    id: 8,
    name: 'Lạp xưởng',
    price: 12000,
    category: 'Món thêm',
    description: 'Lạp xưởng nướng ngọt thơm',
  ),
  MenuItem(
    id: 9,
    name: 'Trà đá',
    price: 5000,
    category: 'Nước uống',
    description: 'Trà đá mát lạnh',
  ),
  MenuItem(
    id: 10,
    name: 'Nước ngọt',
    price: 12000,
    category: 'Nước uống',
    description: 'Coca / Pepsi / 7Up',
  ),
  MenuItem(
    id: 11,
    name: 'Nước sâm',
    price: 15000,
    category: 'Nước uống',
    description: 'Nước sâm bông cúc mát lành',
  ),
  MenuItem(
    id: 12,
    name: 'Chè thập cẩm',
    price: 20000,
    category: 'Tráng miệng',
    description: 'Chè đậu, thạch, nước cốt dừa',
  ),
  MenuItem(
    id: 13,
    name: 'Sữa chua nếp cẩm',
    price: 18000,
    category: 'Tráng miệng',
    description: 'Sữa chua tươi với nếp cẩm dẻo',
  ),
];

// -- Providers ------------------------------------------------------------

final menuItemsProvider = Provider<List<MenuItem>>((ref) => _kSampleItems);

final menuSearchQueryProvider = StateProvider<String>((ref) => '');

final menuCategoryProvider = StateProvider<int>((ref) => 0);

final filteredMenuItemsProvider = Provider<List<MenuItem>>((ref) {
  final items = ref.watch(menuItemsProvider);
  final query = ref.watch(menuSearchQueryProvider).toLowerCase();
  final catIndex = ref.watch(menuCategoryProvider);
  final category = _kCategories[catIndex];

  return items.where((item) {
    final matchesCategory = item.category == category;
    final matchesQuery =
        query.isEmpty || item.name.toLowerCase().contains(query);
    return matchesCategory && matchesQuery;
  }).toList();
});

// -- Helpers --------------------------------------------------------------

String _formatPrice(int price) {
  final str = price.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
    buffer.write(str[i]);
  }
  buffer.write('\u20ab');
  return buffer.toString();
}

// -- Screen ---------------------------------------------------------------

/// Menu screen with category tabs, search, and menu item grid.
class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(menuCategoryProvider);
    final filteredItems = ref.watch(filteredMenuItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thực đơn'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              onChanged: (value) =>
                  ref.read(menuSearchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Tìm món ăn...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Category tabs
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _kCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                return ChoiceChip(
                  label: Text(_kCategories[index]),
                  selected: isSelected,
                  onSelected: (_) =>
                      ref.read(menuCategoryProvider.notifier).state = index,
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  backgroundColor: AppColors.surface,
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                  showCheckmark: false,
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Menu items list
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Không tìm thấy món ăn',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: filteredItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _MenuItemCard(item: filteredItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// -- Menu item card -------------------------------------------------------

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.restaurant,
                size: 36,
                color: AppColors.primary.withOpacity(0.4),
              ),
            ),
            const SizedBox(width: 12),

            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    _formatPrice(item.price),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Add to cart button
            SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã thêm ${item.name} vào giỏ hàng'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Thêm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
