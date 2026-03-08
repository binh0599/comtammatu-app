/// Model representing a push notification device token registration.
class DeviceToken {
  final String id;
  final String userId;
  final String token;
  final String platform;
  final bool isActive;

  const DeviceToken({
    required this.id,
    required this.userId,
    required this.token,
    required this.platform,
    required this.isActive,
  });

  factory DeviceToken.fromJson(Map<String, dynamic> json) {
    return DeviceToken(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      token: json['token'] as String,
      platform: json['platform'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'token': token,
      'platform': platform,
      'is_active': isActive,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceToken &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'DeviceToken(id: $id, platform: $platform, isActive: $isActive)';
}
