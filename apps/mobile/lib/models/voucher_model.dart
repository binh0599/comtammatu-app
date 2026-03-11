/// Voucher / Coupon model for the loyalty redemption feature.
class Voucher {
  final int id;
  final String code;
  final String title;
  final String description;

  /// Either `'percentage'` or `'fixed'`.
  final String discountType;

  /// Percentage value (e.g. 20 for 20%) or fixed amount in VND.
  final int discountValue;

  /// Minimum order amount (VND) required to apply the voucher.
  final int minOrderAmount;

  /// Maximum discount cap in VND (only relevant for percentage type).
  final int? maxDiscount;

  /// Voucher expiration date.
  final DateTime expiresAt;

  /// Whether the user has already used this voucher.
  final bool isUsed;

  /// Loyalty points required to redeem this voucher.
  final int pointsCost;

  const Voucher({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minOrderAmount,
    this.maxDiscount,
    required this.expiresAt,
    required this.isUsed,
    required this.pointsCost,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'] as int,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      discountType: json['discount_type'] as String,
      discountValue: json['discount_value'] as int,
      minOrderAmount: json['min_order_amount'] as int,
      maxDiscount: json['max_discount'] as int?,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      isUsed: json['is_used'] as bool? ?? false,
      pointsCost: json['points_cost'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'discount_type': discountType,
      'discount_value': discountValue,
      'min_order_amount': minOrderAmount,
      'max_discount': maxDiscount,
      'expires_at': expiresAt.toIso8601String(),
      'is_used': isUsed,
      'points_cost': pointsCost,
    };
  }

  Voucher copyWith({
    int? id,
    String? code,
    String? title,
    String? description,
    String? discountType,
    int? discountValue,
    int? minOrderAmount,
    int? maxDiscount,
    DateTime? expiresAt,
    bool? isUsed,
    int? pointsCost,
  }) {
    return Voucher(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      expiresAt: expiresAt ?? this.expiresAt,
      isUsed: isUsed ?? this.isUsed,
      pointsCost: pointsCost ?? this.pointsCost,
    );
  }

  /// Whether this voucher has expired.
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Voucher && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Voucher(id: $id, code: $code, isUsed: $isUsed)';
}

/// Sample vouchers for development / preview.
final sampleAvailableVouchers = <Voucher>[
  Voucher(
    id: 1,
    code: 'GIAM20PT',
    title: 'Giảm 20% đơn hàng',
    description: 'Áp dụng cho tất cả món cơm tấm tại Má Tư',
    discountType: 'percentage',
    discountValue: 20,
    minOrderAmount: 50000,
    maxDiscount: 40000,
    expiresAt: DateTime(2026, 3, 31),
    isUsed: false,
    pointsCost: 200,
  ),
  Voucher(
    id: 2,
    code: 'GIAM30K',
    title: 'Giảm 30.000đ',
    description: 'Đơn hàng từ 80.000đ trở lên',
    discountType: 'fixed',
    discountValue: 30000,
    minOrderAmount: 80000,
    maxDiscount: null,
    expiresAt: DateTime(2026, 4, 15),
    isUsed: false,
    pointsCost: 300,
  ),
  Voucher(
    id: 3,
    code: 'FREESHIP',
    title: 'Miễn phí giao hàng',
    description: 'Freeship cho đơn từ 60.000đ trong bán kính 5km',
    discountType: 'fixed',
    discountValue: 25000,
    minOrderAmount: 60000,
    maxDiscount: null,
    expiresAt: DateTime(2026, 4, 30),
    isUsed: false,
    pointsCost: 150,
  ),
  Voucher(
    id: 4,
    code: 'GIAM15PT',
    title: 'Giảm 15% đơn hàng',
    description: 'Áp dụng cho đơn giao hàng buổi trưa (11h-13h)',
    discountType: 'percentage',
    discountValue: 15,
    minOrderAmount: 40000,
    maxDiscount: 30000,
    expiresAt: DateTime(2026, 5, 1),
    isUsed: false,
    pointsCost: 120,
  ),
  Voucher(
    id: 5,
    code: 'GIAM50K',
    title: 'Giảm 50.000đ',
    description: 'Đơn hàng từ 150.000đ — combo gia đình',
    discountType: 'fixed',
    discountValue: 50000,
    minOrderAmount: 150000,
    maxDiscount: null,
    expiresAt: DateTime(2026, 3, 20),
    isUsed: false,
    pointsCost: 500,
  ),
  Voucher(
    id: 6,
    code: 'GIAM10PT',
    title: 'Giảm 10% đơn hàng',
    description: 'Áp dụng cho khách hàng mới đổi điểm lần đầu',
    discountType: 'percentage',
    discountValue: 10,
    minOrderAmount: 30000,
    maxDiscount: 20000,
    expiresAt: DateTime(2026, 6, 30),
    isUsed: false,
    pointsCost: 80,
  ),
];

final sampleMyVouchers = <Voucher>[
  Voucher(
    id: 101,
    code: 'MY-GIAM25PT',
    title: 'Giảm 25% đơn hàng',
    description: 'Áp dụng cho tất cả món tại Má Tư',
    discountType: 'percentage',
    discountValue: 25,
    minOrderAmount: 60000,
    maxDiscount: 50000,
    expiresAt: DateTime(2026, 3, 25),
    isUsed: false,
    pointsCost: 250,
  ),
  Voucher(
    id: 102,
    code: 'MY-GIAM20K',
    title: 'Giảm 20.000đ',
    description: 'Đơn hàng từ 50.000đ trở lên',
    discountType: 'fixed',
    discountValue: 20000,
    minOrderAmount: 50000,
    maxDiscount: null,
    expiresAt: DateTime(2026, 4, 10),
    isUsed: false,
    pointsCost: 200,
  ),
  Voucher(
    id: 103,
    code: 'MY-FREESHIP2',
    title: 'Miễn phí giao hàng',
    description: 'Freeship đơn từ 40.000đ',
    discountType: 'fixed',
    discountValue: 25000,
    minOrderAmount: 40000,
    maxDiscount: null,
    expiresAt: DateTime(2026, 3, 15),
    isUsed: false,
    pointsCost: 100,
  ),
];
