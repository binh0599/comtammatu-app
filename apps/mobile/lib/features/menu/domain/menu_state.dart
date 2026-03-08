import '../../../models/menu_item.dart';

/// State for the menu feature.
sealed class MenuState {
  const MenuState();
}

class MenuInitial extends MenuState {
  const MenuInitial();
}

class MenuLoading extends MenuState {
  const MenuLoading();
}

class MenuLoaded extends MenuState {
  const MenuLoaded({
    required this.categories,
    this.selectedCategory,
    this.searchQuery = '',
  });

  final List<MenuCategory> categories;
  final String? selectedCategory;
  final String searchQuery;

  List<MenuItem> get filteredItems {
    var items = <MenuItem>[];
    for (final cat in categories) {
      if (selectedCategory == null || cat.name == selectedCategory) {
        items.addAll(cat.items);
      }
    }
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      items = items
          .where((item) =>
              item.name.toLowerCase().contains(query) ||
              (item.description?.toLowerCase().contains(query) ?? false))
          .toList();
    }
    return items;
  }
}

class MenuError extends MenuState {
  const MenuError({required this.message});
  final String message;
}
