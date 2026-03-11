import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_model.freezed.dart';
part 'voucher_model.g.dart';

/// Voucher / Coupon model for the loyalty redemption feature.
@freezed
class Voucher with _$Voucher {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Voucher({
    required int id,
    required String code,
    required String title,
    required String description,

    /// Either `'percentage'` or `'fixed'`.
    required String discountType,

    /// Percentage value (e.g. 20 for 20%) or fixed amount in VND.
    required int discountValue,

    /// Minimum order amount (VND) required to apply the voucher.
    required int minOrderAmount,

    /// Voucher expiration date.
    required DateTime expiresAt,

    /// Loyalty points required to redeem this voucher.
    required int pointsCost,

    /// Maximum discount cap in VND (only relevant for percentage type).
    int? maxDiscount,

    /// Whether the user has already used this voucher.
    @Default(false) bool isUsed,
  }) = _Voucher;

  const Voucher._();

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  /// Whether this voucher has expired.
  bool get isExpired => DateTime.now().isAfter(expiresAt);
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
    expiresAt: DateTime(2026, 4, 15),
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
    expiresAt: DateTime(2026, 4, 30),
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
    expiresAt: DateTime(2026, 5),
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
    expiresAt: DateTime(2026, 3, 20),
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
    expiresAt: DateTime(2026, 4, 10),
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
    expiresAt: DateTime(2026, 3, 15),
    pointsCost: 100,
  ),
];
