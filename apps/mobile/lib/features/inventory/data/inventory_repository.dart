import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/inventory_item.dart';

/// Repository cho các API liên quan đến quản lý kho hàng.
class InventoryRepository {
  const InventoryRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Lấy danh sách toàn bộ hàng tồn kho.
  Future<List<InventoryItem>> getInventory() async {
    return _apiClient.get<List<InventoryItem>>(
      '/inventory',
      queryParameters: {'action': 'list'},
      fromJson: (json) {
        final map = json as Map<String, dynamic>;
        final list = map['items'] as List<dynamic>? ?? [];
        return list
            .map((e) => InventoryItem.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Nhập thêm hàng cho một mặt hàng.
  Future<InventoryItem> restockItem(
    int id, {
    required double quantity,
    String? note,
  }) async {
    return _apiClient.post<InventoryItem>(
      '/inventory',
      data: {
        'action': 'restock',
        'item_id': id,
        'quantity': quantity,
        if (note != null) 'note': note,
      },
      fromJson: (json) => InventoryItem.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Cập nhật mức tồn kho trực tiếp.
  Future<InventoryItem> updateStock(int id, double newStock) async {
    return _apiClient.post<InventoryItem>(
      '/inventory',
      data: {
        'action': 'update_stock',
        'item_id': id,
        'current_stock': newStock,
      },
      fromJson: (json) => InventoryItem.fromJson(json as Map<String, dynamic>),
    );
  }
}

/// Riverpod provider cho [InventoryRepository].
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return InventoryRepository(apiClient: apiClient);
});
