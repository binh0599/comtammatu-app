import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/inventory_item.dart';
import '../../../shared/utils/formatters.dart';
import '../domain/inventory_notifier.dart';

// ---------------------------------------------------------------------------
// Dữ liệu mẫu — 13 mặt hàng bao phủ tất cả danh mục
// ---------------------------------------------------------------------------

final _sampleInventoryItems = <InventoryItem>[
  // Nguyên liệu chính
  InventoryItem(
    id: 1,
    name: 'Thịt sườn heo',
    category: 'Nguyên liệu chính',
    unit: 'kg',
    currentStock: 15.0,
    minStock: 20.0,
    maxStock: 50.0,
    lastRestocked: DateTime(2026, 3, 5),
    pricePerUnit: 120000,
    supplierId: 1,
    supplierName: 'Công ty Thực phẩm Vissan',
  ),
  InventoryItem(
    id: 2,
    name: 'Trứng gà',
    category: 'Nguyên liệu chính',
    unit: 'hộp',
    currentStock: 8.0,
    minStock: 5.0,
    maxStock: 20.0,
    lastRestocked: DateTime(2026, 3, 6),
    pricePerUnit: 45000,
    supplierId: 2,
    supplierName: 'Trại gà Ba Huân',
  ),
  InventoryItem(
    id: 3,
    name: 'Bì heo',
    category: 'Nguyên liệu chính',
    unit: 'kg',
    currentStock: 5.0,
    minStock: 8.0,
    maxStock: 15.0,
    lastRestocked: DateTime(2026, 3, 4),
    pricePerUnit: 80000,
    supplierId: 1,
    supplierName: 'Công ty Thực phẩm Vissan',
  ),
  InventoryItem(
    id: 4,
    name: 'Gạo tấm',
    category: 'Nguyên liệu chính',
    unit: 'kg',
    currentStock: 45.0,
    minStock: 30.0,
    maxStock: 100.0,
    lastRestocked: DateTime(2026, 3, 7),
    pricePerUnit: 18000,
    supplierId: 3,
    supplierName: 'Đại lý gạo Phước Thành',
  ),

  // Gia vị
  InventoryItem(
    id: 5,
    name: 'Nước mắm',
    category: 'Gia vị',
    unit: 'lít',
    currentStock: 10.0,
    minStock: 5.0,
    maxStock: 20.0,
    lastRestocked: DateTime(2026, 3, 3),
    pricePerUnit: 35000,
    supplierId: 4,
    supplierName: 'Nước mắm Phú Quốc',
  ),
  InventoryItem(
    id: 6,
    name: 'Đường',
    category: 'Gia vị',
    unit: 'kg',
    currentStock: 8.0,
    minStock: 5.0,
    maxStock: 15.0,
    lastRestocked: DateTime(2026, 3, 5),
    pricePerUnit: 22000,
    supplierId: 5,
    supplierName: 'Đường Biên Hòa',
  ),
  InventoryItem(
    id: 7,
    name: 'Tiêu',
    category: 'Gia vị',
    unit: 'kg',
    currentStock: 2.0,
    minStock: 3.0,
    maxStock: 5.0,
    lastRestocked: DateTime(2026, 3, 1),
    pricePerUnit: 250000,
    supplierId: 6,
    supplierName: 'Tiêu Phú Quốc Hưng Lợi',
  ),
  InventoryItem(
    id: 8,
    name: 'Tỏi',
    category: 'Gia vị',
    unit: 'kg',
    currentStock: 3.0,
    minStock: 4.0,
    maxStock: 8.0,
    lastRestocked: DateTime(2026, 3, 2),
    pricePerUnit: 60000,
    supplierId: 7,
    supplierName: 'Tỏi Lý Sơn',
  ),

  // Đồ uống
  InventoryItem(
    id: 9,
    name: 'Coca Cola',
    category: 'Đồ uống',
    unit: 'chai',
    currentStock: 48.0,
    minStock: 20.0,
    maxStock: 100.0,
    lastRestocked: DateTime(2026, 3, 6),
    pricePerUnit: 10000,
    supplierId: 8,
    supplierName: 'Đại lý nước giải khát Tân Hiệp Phát',
  ),
  InventoryItem(
    id: 10,
    name: 'Nước suối',
    category: 'Đồ uống',
    unit: 'chai',
    currentStock: 60.0,
    minStock: 30.0,
    maxStock: 100.0,
    lastRestocked: DateTime(2026, 3, 7),
    pricePerUnit: 5000,
    supplierId: 8,
    supplierName: 'Đại lý nước giải khát Tân Hiệp Phát',
  ),
  InventoryItem(
    id: 11,
    name: 'Trà đá',
    category: 'Đồ uống',
    unit: 'lít',
    currentStock: 5.0,
    minStock: 3.0,
    maxStock: 10.0,
    lastRestocked: DateTime(2026, 3, 7),
    pricePerUnit: 15000,
  ),

  // Đóng gói
  InventoryItem(
    id: 12,
    name: 'Hộp xốp',
    category: 'Đóng gói',
    unit: 'hộp',
    currentStock: 200.0,
    minStock: 100.0,
    maxStock: 500.0,
    lastRestocked: DateTime(2026, 3, 5),
    pricePerUnit: 1500,
    supplierId: 9,
    supplierName: 'Bao bì Thành Đạt',
  ),
  InventoryItem(
    id: 13,
    name: 'Túi nilon',
    category: 'Đóng gói',
    unit: 'gói',
    currentStock: 50.0,
    minStock: 30.0,
    maxStock: 100.0,
    lastRestocked: DateTime(2026, 3, 4),
    pricePerUnit: 25000,
    supplierId: 9,
    supplierName: 'Bao bì Thành Đạt',
  ),
];

// ---------------------------------------------------------------------------
// Danh mục lọc
// ---------------------------------------------------------------------------

const _kCategories = [
  'Tất cả',
  'Nguyên liệu chính',
  'Gia vị',
  'Đồ uống',
  'Đóng gói',
];

// ---------------------------------------------------------------------------
// Màn hình chính — Quản lý kho hàng
// ---------------------------------------------------------------------------

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(inventoryNotifierProvider.notifier).loadInventory();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        ref.read(inventoryNotifierProvider.notifier).search('');
      }
    });
  }

  void _showSortMenu() {
    final state = ref.read(inventoryNotifierProvider);
    if (state is! InventoryLoaded) return;

    showMenu<InventorySortBy>(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 48,
        kToolbarHeight + MediaQuery.of(context).padding.top,
        16,
        0,
      ),
      items: [
        PopupMenuItem(
          value: InventorySortBy.name,
          child: Row(
            children: [
              Icon(
                Icons.check,
                size: 18,
                color: state.sortBy == InventorySortBy.name
                    ? AppColors.primary
                    : Colors.transparent,
              ),
              const SizedBox(width: 8),
              const Text('Theo tên'),
            ],
          ),
        ),
        PopupMenuItem(
          value: InventorySortBy.stockLevel,
          child: Row(
            children: [
              Icon(
                Icons.check,
                size: 18,
                color: state.sortBy == InventorySortBy.stockLevel
                    ? AppColors.primary
                    : Colors.transparent,
              ),
              const SizedBox(width: 8),
              const Text('Theo mức tồn kho'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        ref.read(inventoryNotifierProvider.notifier).setSortBy(value);
      }
    });
  }

  void _showRestockDialog() {
    final state = ref.read(inventoryNotifierProvider);
    if (state is! InventoryLoaded) return;

    InventoryItem? selectedItem;
    final quantityController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Nhập hàng',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Chọn mặt hàng
                const Text(
                  'Mặt hàng',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<InventoryItem>(
                  value: selectedItem,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: 'Chọn mặt hàng',
                    hintStyle: const TextStyle(color: AppColors.textHint),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  items: state.items.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        '${item.name} (${item.unit})',
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() => selectedItem = value);
                  },
                ),

                const SizedBox(height: 16),

                // Số lượng
                const Text(
                  'Số lượng nhập',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: quantityController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Nhập số lượng',
                    hintStyle: const TextStyle(color: AppColors.textHint),
                    suffixText: selectedItem?.unit ?? '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Ghi chú
                const Text(
                  'Ghi chú',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: noteController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Ghi chú (tuỳ chọn)',
                    hintStyle: const TextStyle(color: AppColors.textHint),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'Huỷ',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedItem == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng chọn mặt hàng'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                final quantity =
                    double.tryParse(quantityController.text.trim());
                if (quantity == null || quantity <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng nhập số lượng hợp lệ'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                Navigator.of(ctx).pop();
                ref.read(inventoryNotifierProvider.notifier).restockItem(
                      selectedItem!.id,
                      quantity,
                      note: noteController.text.trim().isNotEmpty
                          ? noteController.text.trim()
                          : null,
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetailSheet(InventoryItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _ItemDetailSheet(
        item: item,
        onRestock: () {
          Navigator.of(ctx).pop();
          _showRestockDialogForItem(item);
        },
        onEditStock: () {
          Navigator.of(ctx).pop();
          _showEditStockDialog(item);
        },
      ),
    );
  }

  void _showRestockDialogForItem(InventoryItem item) {
    final quantityController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Nhập hàng — ${item.name}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tồn kho hiện tại: ${_formatStock(item.currentStock)} ${item.unit}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Số lượng nhập thêm',
                suffixText: item.unit,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Ghi chú',
                hintText: 'Tuỳ chọn',
                hintStyle: const TextStyle(color: AppColors.textHint),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Huỷ',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity =
                  double.tryParse(quantityController.text.trim());
              if (quantity == null || quantity <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng nhập số lượng hợp lệ'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              Navigator.of(ctx).pop();
              ref.read(inventoryNotifierProvider.notifier).restockItem(
                    item.id,
                    quantity,
                    note: noteController.text.trim().isNotEmpty
                        ? noteController.text.trim()
                        : null,
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Nhập hàng'),
          ),
        ],
      ),
    );
  }

  void _showEditStockDialog(InventoryItem item) {
    final stockController = TextEditingController(
      text: _formatStock(item.currentStock),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Chỉnh sửa tồn kho — ${item.name}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: stockController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Mức tồn kho mới',
                suffixText: item.unit,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Huỷ',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newStock =
                  double.tryParse(stockController.text.trim());
              if (newStock == null || newStock < 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng nhập số lượng hợp lệ'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              Navigator.of(ctx).pop();
              ref
                  .read(inventoryNotifierProvider.notifier)
                  .updateStock(item.id, newStock);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: AppColors.textOnPrimary),
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm mặt hàng...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  ref
                      .read(inventoryNotifierProvider.notifier)
                      .search(value);
                },
              )
            : const Text('Quản lý kho hàng'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortMenu,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showRestockDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        icon: const Icon(Icons.add),
        label: const Text(
          'Nhập hàng',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: switch (inventoryState) {
        InventoryInitial() || InventoryLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        InventoryError(:final message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(inventoryNotifierProvider.notifier)
                          .loadInventory();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            ),
          ),
        InventoryLoaded() => _InventoryLoadedBody(
            state: inventoryState,
            onItemTap: _showItemDetailSheet,
          ),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Body khi đã tải xong
// ---------------------------------------------------------------------------

class _InventoryLoadedBody extends ConsumerWidget {
  const _InventoryLoadedBody({
    required this.state,
    required this.onItemTap,
  });

  final InventoryLoaded state;
  final void Function(InventoryItem item) onItemTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = state.filteredItems;
    final lowStockCount = state.lowStockCount;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(inventoryNotifierProvider.notifier).loadInventory();
      },
      color: AppColors.primary,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Cảnh báo hàng sắp hết
          if (lowStockCount > 0)
            _LowStockBanner(
              count: lowStockCount,
              isFiltering: state.showLowStockOnly,
              onTap: () {
                ref
                    .read(inventoryNotifierProvider.notifier)
                    .toggleLowStockFilter();
              },
            ),

          if (lowStockCount > 0) const SizedBox(height: 12),

          // Chip lọc danh mục
          _CategoryFilterChips(
            selectedCategory: state.selectedCategory,
            onSelected: (category) {
              ref
                  .read(inventoryNotifierProvider.notifier)
                  .selectCategory(category);
            },
          ),

          const SizedBox(height: 12),

          // Tổng quan nhanh
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              '${filteredItems.length} mặt hàng',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Danh sách mặt hàng
          if (filteredItems.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 48,
                      color: AppColors.textHint,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Không tìm thấy mặt hàng nào',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...filteredItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _InventoryItemCard(
                  item: item,
                  onTap: () => onItemTap(item),
                ),
              ),
            ),

          // Khoảng trống cho FAB
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Banner cảnh báo hàng sắp hết
// ---------------------------------------------------------------------------

class _LowStockBanner extends StatelessWidget {
  const _LowStockBanner({
    required this.count,
    required this.isFiltering,
    required this.onTap,
  });

  final int count;
  final bool isFiltering;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.warning.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.warning,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                isFiltering
                    ? 'Đang hiển thị $count mặt hàng sắp hết — nhấn để xem tất cả'
                    : '\u26A0 $count mặt hàng sắp hết',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning.withValues(alpha: 0.9),
                ),
              ),
            ),
            Icon(
              isFiltering ? Icons.filter_list_off : Icons.filter_list,
              size: 18,
              color: AppColors.warning.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Chip lọc danh mục
// ---------------------------------------------------------------------------

class _CategoryFilterChips extends StatelessWidget {
  const _CategoryFilterChips({
    required this.selectedCategory,
    required this.onSelected,
  });

  final String? selectedCategory;
  final void Function(String? category) onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _kCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final category = _kCategories[index];
          final isAll = category == 'Tất cả';
          final isSelected =
              isAll ? selectedCategory == null : selectedCategory == category;

          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) {
              onSelected(isAll ? null : category);
            },
            selectedColor: AppColors.primary.withValues(alpha: 0.15),
            checkmarkColor: AppColors.primary,
            labelStyle: TextStyle(
              fontSize: 13,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Thẻ mặt hàng trong danh sách
// ---------------------------------------------------------------------------

class _InventoryItemCard extends StatelessWidget {
  const _InventoryItemCard({
    required this.item,
    required this.onTap,
  });

  final InventoryItem item;
  final VoidCallback onTap;

  Color get _stockColor {
    final pct = item.stockPercentage;
    if (pct > 0.5) return AppColors.success;
    if (pct >= 0.2) return AppColors.warning;
    return AppColors.error;
  }

  Color get _categoryColor {
    switch (item.category) {
      case 'Nguyên liệu chính':
        return AppColors.primary;
      case 'Gia vị':
        return AppColors.secondary;
      case 'Đồ uống':
        return AppColors.info;
      case 'Đóng gói':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên + badge danh mục + cảnh báo
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _categoryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item.category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _categoryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.isLowStock)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 20,
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Thanh tiến trình tồn kho
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_formatStock(item.currentStock)} / ${_formatStock(item.maxStock)} ${item.unit}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _stockColor,
                            ),
                          ),
                          Text(
                            '${(item.stockPercentage * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _stockColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: item.stockPercentage,
                          minHeight: 6,
                          backgroundColor: _stockColor.withValues(alpha: 0.12),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(_stockColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Ngày nhập cuối + giá
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nhập lần cuối: ${Formatters.date(item.lastRestocked)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
                Text(
                  '${Formatters.currency(item.pricePerUnit)}/${item.unit}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
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

// ---------------------------------------------------------------------------
// Bottom sheet chi tiết mặt hàng
// ---------------------------------------------------------------------------

class _ItemDetailSheet extends StatelessWidget {
  const _ItemDetailSheet({
    required this.item,
    required this.onRestock,
    required this.onEditStock,
  });

  final InventoryItem item;
  final VoidCallback onRestock;
  final VoidCallback onEditStock;

  Color get _stockColor {
    final pct = item.stockPercentage;
    if (pct > 0.5) return AppColors.success;
    if (pct >= 0.2) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thanh kéo
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tiêu đề
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.category,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // Thông tin tồn kho
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _stockColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _stockColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tồn kho hiện tại',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${_formatStock(item.currentStock)} ${item.unit}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _stockColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: item.stockPercentage,
                        minHeight: 8,
                        backgroundColor: _stockColor.withValues(alpha: 0.15),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(_stockColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tối thiểu: ${_formatStock(item.minStock)} ${item.unit}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                          ),
                        ),
                        Text(
                          'Tối đa: ${_formatStock(item.maxStock)} ${item.unit}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Chi tiết bổ sung
              _DetailRow(
                label: 'Đơn giá',
                value: '${Formatters.currency(item.pricePerUnit)}/${item.unit}',
              ),
              _DetailRow(
                label: 'Nhập lần cuối',
                value: Formatters.date(item.lastRestocked),
              ),
              if (item.supplierName != null)
                _DetailRow(
                  label: 'Nhà cung cấp',
                  value: item.supplierName!,
                ),
              if (item.isLowStock)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 18,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tồn kho dưới mức tối thiểu (${_formatStock(item.minStock)} ${item.unit}). Cần nhập thêm hàng.',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Nút hành động
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onEditStock,
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Chỉnh sửa'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: onRestock,
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text(
                        'Nhập hàng',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textOnPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dòng chi tiết trong bottom sheet
// ---------------------------------------------------------------------------

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tiện ích format số tồn kho
// ---------------------------------------------------------------------------

String _formatStock(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
