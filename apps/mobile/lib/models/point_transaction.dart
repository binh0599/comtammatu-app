class PointTransaction {
  final int id;
  final String type;
  final double points;
  final double balanceAfter;
  final String description;
  final String? referenceType;
  final int? referenceId;
  final DateTime createdAt;

  const PointTransaction({
    required this.id,
    required this.type,
    required this.points,
    required this.balanceAfter,
    required this.description,
    this.referenceType,
    this.referenceId,
    required this.createdAt,
  });

  factory PointTransaction.fromJson(Map<String, dynamic> json) {
    return PointTransaction(
      id: json['id'] as int,
      type: json['type'] as String,
      points: (json['points'] as num).toDouble(),
      balanceAfter: (json['balance_after'] as num).toDouble(),
      description: json['description'] as String,
      referenceType: json['reference_type'] as String?,
      referenceId: json['reference_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'points': points,
      'balance_after': balanceAfter,
      'description': description,
      'reference_type': referenceType,
      'reference_id': referenceId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  PointTransaction copyWith({
    int? id,
    String? type,
    double? points,
    double? balanceAfter,
    String? description,
    String? referenceType,
    int? referenceId,
    DateTime? createdAt,
  }) {
    return PointTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      points: points ?? this.points,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      description: description ?? this.description,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Whether this transaction added points (earn, cashback, checkin_bonus, positive adjust).
  bool get isCredit => points > 0;

  /// Whether this transaction removed points (redeem, expire, negative adjust).
  bool get isDebit => points < 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'PointTransaction(id: $id, type: $type, points: $points)';
}
