class LoyaltyMember {
  final int id;
  final String fullName;
  final String phone;
  final String? avatarUrl;
  final double totalPoints;
  final double availablePoints;
  final double lifetimePoints;
  final int version;

  const LoyaltyMember({
    required this.id,
    required this.fullName,
    required this.phone,
    this.avatarUrl,
    required this.totalPoints,
    required this.availablePoints,
    required this.lifetimePoints,
    required this.version,
  });

  factory LoyaltyMember.fromJson(Map<String, dynamic> json) {
    return LoyaltyMember(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      avatarUrl: json['avatar_url'] as String?,
      totalPoints: (json['total_points'] as num).toDouble(),
      availablePoints: (json['available_points'] as num).toDouble(),
      lifetimePoints: (json['lifetime_points'] as num).toDouble(),
      version: json['version'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'avatar_url': avatarUrl,
      'total_points': totalPoints,
      'available_points': availablePoints,
      'lifetime_points': lifetimePoints,
      'version': version,
    };
  }

  LoyaltyMember copyWith({
    int? id,
    String? fullName,
    String? phone,
    String? avatarUrl,
    double? totalPoints,
    double? availablePoints,
    double? lifetimePoints,
    int? version,
  }) {
    return LoyaltyMember(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      totalPoints: totalPoints ?? this.totalPoints,
      availablePoints: availablePoints ?? this.availablePoints,
      lifetimePoints: lifetimePoints ?? this.lifetimePoints,
      version: version ?? this.version,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoyaltyMember &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          version == other.version;

  @override
  int get hashCode => id.hashCode ^ version.hashCode;

  @override
  String toString() =>
      'LoyaltyMember(id: $id, fullName: $fullName, availablePoints: $availablePoints)';
}
