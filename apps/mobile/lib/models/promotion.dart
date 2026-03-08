class Promotion {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;
  final String cashbackType;
  final double cashbackValue;
  final DateTime startDate;
  final DateTime endDate;
  final bool eligible;

  const Promotion({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.cashbackType,
    required this.cashbackValue,
    required this.startDate,
    required this.endDate,
    required this.eligible,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      cashbackType: json['cashback_type'] as String,
      cashbackValue: (json['cashback_value'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      eligible: json['eligible'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'cashback_type': cashbackType,
      'cashback_value': cashbackValue,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'eligible': eligible,
    };
  }

  Promotion copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? cashbackType,
    double? cashbackValue,
    DateTime? startDate,
    DateTime? endDate,
    bool? eligible,
  }) {
    return Promotion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      cashbackType: cashbackType ?? this.cashbackType,
      cashbackValue: cashbackValue ?? this.cashbackValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eligible: eligible ?? this.eligible,
    );
  }

  /// Whether the promotion is currently active based on date range.
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Promotion &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Promotion(id: $id, name: $name, eligible: $eligible)';
}
