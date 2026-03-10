class Address {
  final int? id;
  final String label; // 'home' | 'work' | 'other'
  final String addressLine;
  final String ward;
  final String district;
  final String city;
  final bool isDefault;
  final double? lat;
  final double? lng;

  const Address({
    this.id,
    required this.label,
    required this.addressLine,
    required this.ward,
    required this.district,
    required this.city,
    this.isDefault = false,
    this.lat,
    this.lng,
  });

  /// Full formatted address string.
  String get fullAddress => '$addressLine, $ward, $district, $city';

  /// Vietnamese display label.
  String get displayLabel {
    switch (label) {
      case 'home':
        return 'Nhà';
      case 'work':
        return 'Công ty';
      default:
        return 'Khác';
    }
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int?,
      label: json['label'] as String,
      addressLine: json['address_line'] as String,
      ward: json['ward'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      isDefault: json['is_default'] as bool? ?? false,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'address_line': addressLine,
      'ward': ward,
      'district': district,
      'city': city,
      'is_default': isDefault,
      'lat': lat,
      'lng': lng,
    };
  }

  Address copyWith({
    int? id,
    String? label,
    String? addressLine,
    String? ward,
    String? district,
    String? city,
    bool? isDefault,
    double? lat,
    double? lng,
  }) {
    return Address(
      id: id ?? this.id,
      label: label ?? this.label,
      addressLine: addressLine ?? this.addressLine,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      city: city ?? this.city,
      isDefault: isDefault ?? this.isDefault,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Address(id: $id, label: $label, address: $fullAddress, isDefault: $isDefault)';
}
