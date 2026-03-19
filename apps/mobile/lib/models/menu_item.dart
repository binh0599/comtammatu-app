import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

@freezed
class MenuItem with _$MenuItem {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory MenuItem({
    required int id,
    required String name,
    @JsonKey(name: 'base_price') required int price,
    String? description,
    String? imageUrl,
    @Default('') String category,
    @JsonKey(name: 'is_available') @Default(true) bool available,
    @JsonKey(name: 'is_popular') @Default(false) bool isPopular,
    List<String>? tags,
  }) = _MenuItem;

  const MenuItem._();

  /// Standard generated deserialization.
  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  /// Parse with optional category name override and price fallback.
  factory MenuItem.fromApiJson(
    Map<String, dynamic> json, {
    String? categoryName,
  }) {
    final merged = Map<String, dynamic>.from(json);
    if (merged['base_price'] == null && merged['price'] != null) {
      merged['base_price'] = merged['price'];
    }
    if (categoryName != null) {
      merged['category'] = categoryName;
    }
    return _$MenuItemFromJson(merged);
  }
}

@freezed
class MenuCategory with _$MenuCategory {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory MenuCategory({
    required String name,
    required List<MenuItem> items,
    int? id,
  }) = _MenuCategory;

  const MenuCategory._();

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    final categoryName = json['name'] as String;
    final rawItems = json['items'] as List<dynamic>;
    return MenuCategory(
      id: json['id'] as int?,
      name: categoryName,
      items: rawItems
          .map((e) => MenuItem.fromApiJson(
                e as Map<String, dynamic>,
                categoryName: categoryName,
              ))
          .toList(),
    );
  }
}
