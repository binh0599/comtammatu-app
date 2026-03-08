import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/menu_item.dart';

/// Repository for menu-related API calls.
class MenuRepository {
  const MenuRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Fetches the full menu grouped by category.
  Future<List<MenuCategory>> getMenu() async {
    return _apiClient.get<List<MenuCategory>>(
      '/get-menu',
      fromJson: (json) {
        final list = json as List<dynamic>;
        return list
            .map((e) => MenuCategory.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }
}

/// Riverpod provider for [MenuRepository].
final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MenuRepository(apiClient: apiClient);
});
