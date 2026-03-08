/// Model representing a store / branch location.
class StoreInfo {
  final int id;
  final String name;
  final String? code;
  final String address;
  final String phone;
  final double? latitude;
  final double? longitude;
  final String openingTime;
  final String closingTime;
  final bool isActive;

  const StoreInfo({
    required this.id,
    required this.name,
    this.code,
    required this.address,
    required this.phone,
    this.latitude,
    this.longitude,
    required this.openingTime,
    required this.closingTime,
    required this.isActive,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    // Parse operating_hours JSONB: {"open_time":"06:00","close_time":"22:00"}
    final operatingHours = json['operating_hours'] as Map<String, dynamic>?;
    return StoreInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String?,
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      openingTime: operatingHours?['open_time'] as String? ?? '06:00',
      closingTime: operatingHours?['close_time'] as String? ?? '22:00',
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'operating_hours': {
        'open_time': openingTime,
        'close_time': closingTime,
      },
      'is_active': isActive,
    };
  }

  StoreInfo copyWith({
    int? id,
    String? name,
    String? code,
    String? address,
    String? phone,
    double? latitude,
    double? longitude,
    String? openingTime,
    String? closingTime,
    bool? isActive,
  }) {
    return StoreInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreInfo &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'StoreInfo(id: $id, name: $name)';
}
