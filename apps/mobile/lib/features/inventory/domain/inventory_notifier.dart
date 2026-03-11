import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/inventory_item.dart';
import '../data/inventory_repository.dart';

// -- Inventory State --------------------------------------------------------

/// Trạng thái của tính năng quản lý kho hàng.
sealed class InventoryState {
  const InventoryState();
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState {
  const InventoryLoading();
}

class InventoryLoaded extends InventoryState {
  const InventoryLoaded({
    required this.items,
    this.selectedCategory,
    this.sortBy = InventorySortBy.name,
    this.showLowStockOnly = false,
    this.searchQuery = '',
  });

  final List<InventoryItem> items;
  final String? selectedCategory;
  final InventorySortBy sortBy;
  final bool showLowStockOnly;
  final String searchQuery;

  /// Số mặt hàng sắp hết hàng.
  int get lowStockCount => items.where((i) => i.isLowStock).length;

  /// Danh sách đã lọc và sắp xếp.
  List<InventoryItem> get filteredItems {
    var result = List<InventoryItem>.from(items);

    // Lọc theo danh mục
    if (selectedCategory != null) {
      result = result.where((i) => i.category == selectedCategory).toList();
    }

    // Lọc chỉ hàng sắp hết
    if (showLowStockOnly) {
      result = result.where((i) => i.isLowStock).toList();
    }

    // Tìm kiếm
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      result =
          result.where((i) => i.name.toLowerCase().contains(query)).toList();
    }

    // Sắp xếp
    switch (sortBy) {
      case InventorySortBy.name:
        result.sort((a, b) => a.name.compareTo(b.name));
      case InventorySortBy.stockLevel:
        result.sort((a, b) => a.stockPercentage.compareTo(b.stockPercentage));
    }

    return result;
  }
}

class InventoryError extends InventoryState {
  const InventoryError({required this.message});
  final String message;
}

/// Tiêu chí sắp xếp kho hàng.
enum InventorySortBy { name, stockLevel }

// -- Inventory Notifier -----------------------------------------------------

/// Quản lý trạng thái kho hàng bao gồm tải, lọc, sắp xếp.
class InventoryNotifier extends StateNotifier<InventoryState> {
  InventoryNotifier({required InventoryRepository inventoryRepository})
      : _inventoryRepository = inventoryRepository,
        super(const InventoryInitial());

  final InventoryRepository _inventoryRepository;

  /// Tải danh sách hàng tồn kho từ API.
  Future<void> loadInventory() async {
    state = const InventoryLoading();
    try {
      final items = await _inventoryRepository.getInventory();
      state = InventoryLoaded(items: items);
    } catch (e) {
      state = InventoryError(message: e.toString());
    }
  }

  /// Lọc theo danh mục (null = Tất cả).
  void selectCategory(String? category) {
    final current = state;
    if (current is InventoryLoaded) {
      state = InventoryLoaded(
        items: current.items,
        selectedCategory: category,
        sortBy: current.sortBy,
        showLowStockOnly: current.showLowStockOnly,
        searchQuery: current.searchQuery,
      );
    }
  }

  /// Thay đổi tiêu chí sắp xếp.
  void setSortBy(InventorySortBy sortBy) {
    final current = state;
    if (current is InventoryLoaded) {
      state = InventoryLoaded(
        items: current.items,
        selectedCategory: current.selectedCategory,
        sortBy: sortBy,
        showLowStockOnly: current.showLowStockOnly,
        searchQuery: current.searchQuery,
      );
    }
  }

  /// Bật/tắt lọc hàng sắp hết.
  void toggleLowStockFilter() {
    final current = state;
    if (current is InventoryLoaded) {
      state = InventoryLoaded(
        items: current.items,
        selectedCategory: current.selectedCategory,
        sortBy: current.sortBy,
        showLowStockOnly: !current.showLowStockOnly,
        searchQuery: current.searchQuery,
      );
    }
  }

  /// Cập nhật từ khoá tìm kiếm.
  void search(String query) {
    final current = state;
    if (current is InventoryLoaded) {
      state = InventoryLoaded(
        items: current.items,
        selectedCategory: current.selectedCategory,
        sortBy: current.sortBy,
        showLowStockOnly: current.showLowStockOnly,
        searchQuery: query,
      );
    }
  }

  /// Nhập thêm hàng cho một mặt hàng.
  Future<void> restockItem(int id, double quantity, {String? note}) async {
    final current = state;
    if (current is InventoryLoaded) {
      try {
        final updated = await _inventoryRepository.restockItem(
          id,
          quantity: quantity,
          note: note,
        );
        final newItems = current.items.map((item) {
          return item.id == id ? updated : item;
        }).toList();
        state = InventoryLoaded(
          items: newItems,
          selectedCategory: current.selectedCategory,
          sortBy: current.sortBy,
          showLowStockOnly: current.showLowStockOnly,
          searchQuery: current.searchQuery,
        );
      } catch (e) {
        // Giữ nguyên state hiện tại, để UI xử lý lỗi
        rethrow;
      }
    }
  }

  /// Cập nhật mức tồn kho.
  Future<void> updateStock(int id, double newStock) async {
    final current = state;
    if (current is InventoryLoaded) {
      try {
        final updated = await _inventoryRepository.updateStock(id, newStock);
        final newItems = current.items.map((item) {
          return item.id == id ? updated : item;
        }).toList();
        state = InventoryLoaded(
          items: newItems,
          selectedCategory: current.selectedCategory,
          sortBy: current.sortBy,
          showLowStockOnly: current.showLowStockOnly,
          searchQuery: current.searchQuery,
        );
      } catch (e) {
        rethrow;
      }
    }
  }
}

// -- Providers --------------------------------------------------------------

final inventoryNotifierProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  final repo = ref.watch(inventoryRepositoryProvider);
  return InventoryNotifier(inventoryRepository: repo);
});

/// Provider lọc theo danh mục.
final inventoryCategoryFilterProvider = StateProvider<String?>((ref) => null);

/// Provider sắp xếp.
final inventorySortProvider =
    StateProvider<InventorySortBy>((ref) => InventorySortBy.name);
