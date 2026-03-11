class MenuItem {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final String category;
  final bool available;
  final List<String>? tags;

  const MenuItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    this.category = '',
    required this.available,
    this.tags,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json, {String? categoryName}) {
    return MenuItem(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['base_price'] as num?)?.toDouble() ??
          (json['price'] as num?)?.toDouble() ??
          0,
      imageUrl: json['image_url'] as String?,
      category: categoryName ?? json['category'] as String? ?? '',
      available: json['is_available'] as bool? ??
          json['available'] as bool? ??
          true,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'base_price': price,
      'image_url': imageUrl,
      'category': category,
      'is_available': available,
      'tags': tags,
    };
  }

  MenuItem copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    bool? available,
    List<String>? tags,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      available: available ?? this.available,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'MenuItem(id: $id, name: $name, price: $price)';
}

class MenuCategory {
  final int? id;
  final String name;
  final List<MenuItem> items;

  const MenuCategory({
    this.id,
    required this.name,
    required this.items,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    final categoryName = json['name'] as String;
    return MenuCategory(
      id: json['id'] as int?,
      name: categoryName,
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(
                e as Map<String, dynamic>,
                categoryName: categoryName,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  MenuCategory copyWith({
    int? id,
    String? name,
    List<MenuItem>? items,
  }) {
    return MenuCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuCategory &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() =>
      'MenuCategory(name: $name, itemCount: ${items.length})';
}
