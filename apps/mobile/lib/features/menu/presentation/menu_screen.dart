import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_service.dart';
import '../../../core/network/api_client.dart';
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
    this.isPopular = false,
  });

  final int id;
  final String name;
  final int price; // VND
  final String category;
  final String description;
  final String? imageUrl;
  final bool isPopular;

  factory MenuItem.fromJson(Map<String, dynamic> json, {String? categoryName}) => MenuItem(
        id: json['id'] as int,
        name: json['name'] as String,
        price: (json['base_price'] as num?)?.toInt() ??
            (json['price'] as num?)?.toInt() ??
            0,
        category: categoryName ?? json['category'] as String? ?? '',
        description: json['description'] as String? ?? '',
        imageUrl: json['image_url'] as String?,
        isPopular: json['is_popular'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'category': category,
        'description': description,
        'image_url': imageUrl,
        'is_popular': isPopular,
      };
}

// -- Sample data ----------------------------------------------------------

const _kCategories = [
  'Tất cả',
  'Cơm Tấm',
  'Món Khác',
  'Ăn Kèm',
  'Giải Khát',
];

const _kSampleItems = [
  MenuItem(
    id: 1,
    name: 'Cơm tấm sườn bì chả',
    price: 55000,
    category: 'Cơm tấm',
    description: 'Sườn nướng than hoa, bì, chả trứng, kèm đồ chua',
    isPopular: true,
  ),
  MenuItem(
    id: 2,
    name: 'Cơm tấm sườn nướng',
    price: 45000,
    category: 'Cơm tấm',
    description: 'Sườn heo nướng than hoa đậm vị, ăn kèm nước mắm',
    isPopular: true,
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
    isPopular: true,
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

// -- Menu state ------------------------------------------------------------

sealed class MenuLoadState {
  const MenuLoadState();
}

class MenuInitial extends MenuLoadState {
  const MenuInitial();
}

class MenuLoading extends MenuLoadState {
  const MenuLoading();
}

class MenuLoaded extends MenuLoadState {
  const MenuLoaded(this.items, {this.fromCache = false});
  final List<MenuItem> items;
  final bool fromCache;
}

class MenuError extends MenuLoadState {
  const MenuError(this.message);
  final String message;
}

// -- Menu notifier with cache support --------------------------------------

class MenuNotifier extends StateNotifier<MenuLoadState> {
  MenuNotifier({
    required this.apiClient,
    required this.cacheService,
  }) : super(const MenuInitial());

  final ApiClient apiClient;
  final CacheService cacheService;

  static const _cacheMaxAge = Duration(minutes: 30);

  Future<void> loadMenu() async {
    // Try cache first
    if (cacheService.isCacheValid('cache_menu', _cacheMaxAge)) {
      final cached = cacheService.getCachedMenu();
      if (cached.isNotEmpty) {
        final items = cached.map((e) => MenuItem.fromJson(e)).toList();
        state = MenuLoaded(items, fromCache: true);
        // Still fetch fresh data in background
        _refreshFromApi();
        return;
      }
    }

    state = const MenuLoading();

    // Try API
    try {
      await _refreshFromApi();
    } catch (_) {
      // Fallback to cache even if expired
      final cached = cacheService.getCachedMenu();
      if (cached.isNotEmpty) {
        final items = cached.map((e) => MenuItem.fromJson(e)).toList();
        state = MenuLoaded(items, fromCache: true);
      } else {
        // Last resort: sample data
        state = const MenuLoaded(_kSampleItems);
      }
    }
  }

  Future<void> _refreshFromApi() async {
    try {
      final items = await apiClient.get<List<MenuItem>>(
        '/get-menu',
        queryParameters: {'branch_id': '1'},
        fromJson: (json) {
          final map = json as Map<String, dynamic>;
          final categories = map['categories'] as List<dynamic>? ?? [];
          final allItems = <MenuItem>[];
          for (final cat in categories) {
            final catMap = cat as Map<String, dynamic>;
            final catName = catMap['name'] as String? ?? '';
            final catItems = catMap['items'] as List<dynamic>? ?? [];
            for (final item in catItems) {
              allItems.add(MenuItem.fromJson(
                item as Map<String, dynamic>,
                categoryName: catName,
              ));
            }
          }
          return allItems;
        },
      );
      if (items.isNotEmpty) {
        final jsonData = items.map((e) => e.toJson()).toList();
        await cacheService.cacheMenu(jsonData);
        state = MenuLoaded(items);
      }
    } catch (_) {
      // Silent fail for background refresh
    }
  }
}

final menuNotifierProvider =
    StateNotifierProvider<MenuNotifier, MenuLoadState>((ref) {
  try {
    final apiClient = ref.watch(apiClientProvider);
    final cacheService = ref.watch(cacheServiceProvider);
    return MenuNotifier(apiClient: apiClient, cacheService: cacheService);
  } catch (_) {
    // Fallback if providers not yet initialized
    return MenuNotifier(
      apiClient: ApiClient(),
      cacheService: CacheService(
        prefs: throw UnimplementedError('SharedPreferences not ready'),
      ),
    );
  }
});

// Fallback providers for when MenuNotifier isn't initialized
final menuItemsProvider =
    Provider<List<MenuItem>>((ref) => _kSampleItems);

final menuSearchQueryProvider = StateProvider<String>((ref) => '');

final menuCategoryProvider = StateProvider<int>((ref) => 0);

final filteredMenuItemsProvider = Provider<List<MenuItem>>((ref) {
  final menuState = ref.watch(menuNotifierProvider);
  final items = switch (menuState) {
    MenuLoaded(items: final loadedItems) => loadedItems,
    _ => _kSampleItems,
  };
  final query = ref.watch(menuSearchQueryProvider).toLowerCase();
  final catIndex = ref.watch(menuCategoryProvider);

  return items.where((item) {
    final matchesCategory =
        catIndex == 0 || item.category == _kCategories[catIndex];
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

/// Menu screen with category tabs, search, cache-first loading, and menu item grid.
class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // Try loading from cache/API
    Future.microtask(() {
      try {
        ref.read(menuNotifierProvider.notifier).loadMenu();
      } catch (_) {
        // Provider not ready, will use sample data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(menuCategoryProvider);
    final filteredItems = ref.watch(filteredMenuItemsProvider);
    final menuState = ref.watch(menuNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thực đơn'),
        actions: [
          if (menuState is MenuLoaded && menuState.fromCache)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                label: const Text(
                  'Ngoại tuyến',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
                backgroundColor: AppColors.warning,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ),
        ],
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

          // Loading state
          if (menuState is MenuLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          // Menu items list
          else
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        try {
                          await ref
                              .read(menuNotifierProvider.notifier)
                              .loadMenu();
                        } catch (_) {}
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: filteredItems.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return _MenuItemCard(item: filteredItems[index]);
                        },
                      ),
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
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: item.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.restaurant,
                              size: 36,
                              color: AppColors.primary.withValues(alpha: 0.4),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.restaurant,
                          size: 36,
                          color: AppColors.primary.withValues(alpha: 0.4),
                        ),
                ),
                if (item.isPopular)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Hot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
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
