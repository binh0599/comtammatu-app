/// Model representing real-time delivery tracking data.
class DeliveryTracking {
  final String id;
  final String orderId;
  final String
      status; // waiting_driver, driver_assigned, picked_up, on_the_way, arrived, delivered
  final String? driverName;
  final String? driverPhone;
  final String? driverAvatarUrl;
  final double? currentLatitude;
  final double? currentLongitude;
  final DateTime? estimatedArrivalAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DeliveryTracking({
    required this.id,
    required this.orderId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.driverName,
    this.driverPhone,
    this.driverAvatarUrl,
    this.currentLatitude,
    this.currentLongitude,
    this.estimatedArrivalAt,
  });

  factory DeliveryTracking.fromJson(Map<String, dynamic> json) {
    return DeliveryTracking(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      status: json['status'] as String,
      driverName: json['driver_name'] as String?,
      driverPhone: json['driver_phone'] as String?,
      driverAvatarUrl: json['driver_avatar_url'] as String?,
      currentLatitude: (json['current_latitude'] as num?)?.toDouble(),
      currentLongitude: (json['current_longitude'] as num?)?.toDouble(),
      estimatedArrivalAt: json['estimated_arrival_at'] != null
          ? DateTime.parse(json['estimated_arrival_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'status': status,
      'driver_name': driverName,
      'driver_phone': driverPhone,
      'driver_avatar_url': driverAvatarUrl,
      'current_latitude': currentLatitude,
      'current_longitude': currentLongitude,
      'estimated_arrival_at': estimatedArrivalAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  DeliveryTracking copyWith({
    String? id,
    String? orderId,
    String? status,
    String? driverName,
    String? driverPhone,
    String? driverAvatarUrl,
    double? currentLatitude,
    double? currentLongitude,
    DateTime? estimatedArrivalAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeliveryTracking(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone ?? this.driverPhone,
      driverAvatarUrl: driverAvatarUrl ?? this.driverAvatarUrl,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
      estimatedArrivalAt: estimatedArrivalAt ?? this.estimatedArrivalAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryTracking &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'DeliveryTracking(id: $id, orderId: $orderId, status: $status)';
}
