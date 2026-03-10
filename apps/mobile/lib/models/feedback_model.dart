/// Model representing a user feedback entry for an order.
class FeedbackModel {
  final int id;
  final int orderId;
  final int rating;
  final String comment;
  final List<String> tags;
  final DateTime createdAt;

  const FeedbackModel({
    required this.id,
    required this.orderId,
    required this.rating,
    required this.comment,
    required this.tags,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] as int,
      orderId: json['order_id'] as int,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'rating': rating,
      'comment': comment,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
    };
  }

  FeedbackModel copyWith({
    int? id,
    int? orderId,
    int? rating,
    String? comment,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'FeedbackModel(id: $id, orderId: $orderId, rating: $rating)';
}
