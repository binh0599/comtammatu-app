// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return _Voucher.fromJson(json);
}

/// @nodoc
mixin _$Voucher {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Either `'percentage'` or `'fixed'`.
  String get discountType => throw _privateConstructorUsedError;

  /// Percentage value (e.g. 20 for 20%) or fixed amount in VND.
  int get discountValue => throw _privateConstructorUsedError;

  /// Minimum order amount (VND) required to apply the voucher.
  int get minOrderAmount => throw _privateConstructorUsedError;

  /// Voucher expiration date.
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Loyalty points required to redeem this voucher.
  int get pointsCost => throw _privateConstructorUsedError;

  /// Maximum discount cap in VND (only relevant for percentage type).
  int? get maxDiscount => throw _privateConstructorUsedError;

  /// Whether the user has already used this voucher.
  bool get isUsed => throw _privateConstructorUsedError;

  /// Serializes this Voucher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherCopyWith<Voucher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) then) =
      _$VoucherCopyWithImpl<$Res, Voucher>;
  @useResult
  $Res call(
      {int id,
      String code,
      String title,
      String description,
      String discountType,
      int discountValue,
      int minOrderAmount,
      DateTime expiresAt,
      int pointsCost,
      int? maxDiscount,
      bool isUsed});
}

/// @nodoc
class _$VoucherCopyWithImpl<$Res, $Val extends Voucher>
    implements $VoucherCopyWith<$Res> {
  _$VoucherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? title = null,
    Object? description = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? minOrderAmount = null,
    Object? expiresAt = null,
    Object? pointsCost = null,
    Object? maxDiscount = freezed,
    Object? isUsed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discountType: null == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String,
      discountValue: null == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as int,
      minOrderAmount: null == minOrderAmount
          ? _value.minOrderAmount
          : minOrderAmount // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pointsCost: null == pointsCost
          ? _value.pointsCost
          : pointsCost // ignore: cast_nullable_to_non_nullable
              as int,
      maxDiscount: freezed == maxDiscount
          ? _value.maxDiscount
          : maxDiscount // ignore: cast_nullable_to_non_nullable
              as int?,
      isUsed: null == isUsed
          ? _value.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherImplCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$$VoucherImplCopyWith(
          _$VoucherImpl value, $Res Function(_$VoucherImpl) then) =
      __$$VoucherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String code,
      String title,
      String description,
      String discountType,
      int discountValue,
      int minOrderAmount,
      DateTime expiresAt,
      int pointsCost,
      int? maxDiscount,
      bool isUsed});
}

/// @nodoc
class __$$VoucherImplCopyWithImpl<$Res>
    extends _$VoucherCopyWithImpl<$Res, _$VoucherImpl>
    implements _$$VoucherImplCopyWith<$Res> {
  __$$VoucherImplCopyWithImpl(
      _$VoucherImpl _value, $Res Function(_$VoucherImpl) _then)
      : super(_value, _then);

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? title = null,
    Object? description = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? minOrderAmount = null,
    Object? expiresAt = null,
    Object? pointsCost = null,
    Object? maxDiscount = freezed,
    Object? isUsed = null,
  }) {
    return _then(_$VoucherImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discountType: null == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String,
      discountValue: null == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as int,
      minOrderAmount: null == minOrderAmount
          ? _value.minOrderAmount
          : minOrderAmount // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pointsCost: null == pointsCost
          ? _value.pointsCost
          : pointsCost // ignore: cast_nullable_to_non_nullable
              as int,
      maxDiscount: freezed == maxDiscount
          ? _value.maxDiscount
          : maxDiscount // ignore: cast_nullable_to_non_nullable
              as int?,
      isUsed: null == isUsed
          ? _value.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$VoucherImpl extends _Voucher {
  const _$VoucherImpl(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      required this.discountType,
      required this.discountValue,
      required this.minOrderAmount,
      required this.expiresAt,
      required this.pointsCost,
      this.maxDiscount,
      this.isUsed = false})
      : super._();

  factory _$VoucherImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String title;
  @override
  final String description;

  /// Either `'percentage'` or `'fixed'`.
  @override
  final String discountType;

  /// Percentage value (e.g. 20 for 20%) or fixed amount in VND.
  @override
  final int discountValue;

  /// Minimum order amount (VND) required to apply the voucher.
  @override
  final int minOrderAmount;

  /// Voucher expiration date.
  @override
  final DateTime expiresAt;

  /// Loyalty points required to redeem this voucher.
  @override
  final int pointsCost;

  /// Maximum discount cap in VND (only relevant for percentage type).
  @override
  final int? maxDiscount;

  /// Whether the user has already used this voucher.
  @override
  @JsonKey()
  final bool isUsed;

  @override
  String toString() {
    return 'Voucher(id: $id, code: $code, title: $title, description: $description, discountType: $discountType, discountValue: $discountValue, minOrderAmount: $minOrderAmount, expiresAt: $expiresAt, pointsCost: $pointsCost, maxDiscount: $maxDiscount, isUsed: $isUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.minOrderAmount, minOrderAmount) ||
                other.minOrderAmount == minOrderAmount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.pointsCost, pointsCost) ||
                other.pointsCost == pointsCost) &&
            (identical(other.maxDiscount, maxDiscount) ||
                other.maxDiscount == maxDiscount) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      title,
      description,
      discountType,
      discountValue,
      minOrderAmount,
      expiresAt,
      pointsCost,
      maxDiscount,
      isUsed);

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      __$$VoucherImplCopyWithImpl<_$VoucherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherImplToJson(
      this,
    );
  }
}

abstract class _Voucher extends Voucher {
  const factory _Voucher(
      {required final int id,
      required final String code,
      required final String title,
      required final String description,
      required final String discountType,
      required final int discountValue,
      required final int minOrderAmount,
      required final DateTime expiresAt,
      required final int pointsCost,
      final int? maxDiscount,
      final bool isUsed}) = _$VoucherImpl;
  const _Voucher._() : super._();

  factory _Voucher.fromJson(Map<String, dynamic> json) = _$VoucherImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get title;
  @override
  String get description;

  /// Either `'percentage'` or `'fixed'`.
  @override
  String get discountType;

  /// Percentage value (e.g. 20 for 20%) or fixed amount in VND.
  @override
  int get discountValue;

  /// Minimum order amount (VND) required to apply the voucher.
  @override
  int get minOrderAmount;

  /// Voucher expiration date.
  @override
  DateTime get expiresAt;

  /// Loyalty points required to redeem this voucher.
  @override
  int get pointsCost;

  /// Maximum discount cap in VND (only relevant for percentage type).
  @override
  int? get maxDiscount;

  /// Whether the user has already used this voucher.
  @override
  bool get isUsed;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
