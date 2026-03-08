class TierProgress {
  final String name;
  final String tierCode;
  final double minPoints;
  final double pointsNeeded;
  final double progressPercent;

  const TierProgress({
    required this.name,
    required this.tierCode,
    required this.minPoints,
    required this.pointsNeeded,
    required this.progressPercent,
  });

  factory TierProgress.fromJson(Map<String, dynamic> json) {
    return TierProgress(
      name: json['name'] as String,
      tierCode: json['tier_code'] as String,
      minPoints: (json['min_points'] as num).toDouble(),
      pointsNeeded: (json['points_needed'] as num).toDouble(),
      progressPercent: (json['progress_percent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tier_code': tierCode,
      'min_points': minPoints,
      'points_needed': pointsNeeded,
      'progress_percent': progressPercent,
    };
  }

  TierProgress copyWith({
    String? name,
    String? tierCode,
    double? minPoints,
    double? pointsNeeded,
    double? progressPercent,
  }) {
    return TierProgress(
      name: name ?? this.name,
      tierCode: tierCode ?? this.tierCode,
      minPoints: minPoints ?? this.minPoints,
      pointsNeeded: pointsNeeded ?? this.pointsNeeded,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TierProgress &&
          runtimeType == other.runtimeType &&
          tierCode == other.tierCode;

  @override
  int get hashCode => tierCode.hashCode;

  @override
  String toString() =>
      'TierProgress(name: $name, tierCode: $tierCode, progressPercent: $progressPercent)';
}

class Tier {
  final int id;
  final String name;
  final String tierCode;
  final double pointMultiplier;
  final double cashbackPercent;
  final List<String> benefits;
  final TierProgress? nextTier;

  const Tier({
    required this.id,
    required this.name,
    required this.tierCode,
    required this.pointMultiplier,
    required this.cashbackPercent,
    required this.benefits,
    this.nextTier,
  });

  factory Tier.fromJson(Map<String, dynamic> json) {
    return Tier(
      id: json['id'] as int,
      name: json['name'] as String,
      tierCode: json['tier_code'] as String,
      pointMultiplier: (json['point_multiplier'] as num).toDouble(),
      cashbackPercent: (json['cashback_percent'] as num).toDouble(),
      benefits: (json['benefits'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nextTier: json['next_tier'] != null
          ? TierProgress.fromJson(json['next_tier'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tier_code': tierCode,
      'point_multiplier': pointMultiplier,
      'cashback_percent': cashbackPercent,
      'benefits': benefits,
      'next_tier': nextTier?.toJson(),
    };
  }

  Tier copyWith({
    int? id,
    String? name,
    String? tierCode,
    double? pointMultiplier,
    double? cashbackPercent,
    List<String>? benefits,
    TierProgress? nextTier,
  }) {
    return Tier(
      id: id ?? this.id,
      name: name ?? this.name,
      tierCode: tierCode ?? this.tierCode,
      pointMultiplier: pointMultiplier ?? this.pointMultiplier,
      cashbackPercent: cashbackPercent ?? this.cashbackPercent,
      benefits: benefits ?? this.benefits,
      nextTier: nextTier ?? this.nextTier,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tier && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Tier(id: $id, name: $name, tierCode: $tierCode)';
}
