import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/menu_repository.dart';
import 'menu_state.dart';

/// Manages menu state including categories, search, and filtering.
class MenuNotifier extends StateNotifier<MenuState> {
  MenuNotifier({required MenuRepository menuRepository})
      : _menuRepository = menuRepository,
        super(const MenuInitial());

  final MenuRepository _menuRepository;

  /// Load menu from API for a given branch.
  Future<void> loadMenu({required int branchId}) async {
    state = const MenuLoading();
    try {
      final categories = await _menuRepository.getMenu(branchId: branchId);
      state = MenuLoaded(categories: categories);
    } catch (e) {
      state = MenuError(message: e.toString());
    }
  }

  /// Filter by category.
  void selectCategory(String? category) {
    final current = state;
    if (current is MenuLoaded) {
      state = MenuLoaded(
        categories: current.categories,
        selectedCategory: category,
        searchQuery: current.searchQuery,
      );
    }
  }

  /// Update search query.
  void search(String query) {
    final current = state;
    if (current is MenuLoaded) {
      state = MenuLoaded(
        categories: current.categories,
        selectedCategory: current.selectedCategory,
        searchQuery: query,
      );
    }
  }
}

final menuNotifierProvider =
    StateNotifierProvider<MenuNotifier, MenuState>((ref) {
  final repo = ref.watch(menuRepositoryProvider);
  return MenuNotifier(menuRepository: repo);
});
