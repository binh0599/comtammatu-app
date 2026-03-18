// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_batch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettlementBatch _$SettlementBatchFromJson(Map<String, dynamic> json) {
  return _SettlementBatch.fromJson(json);
}

/// @nodoc
mixin _$SettlementBatch {
  int get branchId => throw _privateConstructorUsedError;
  DateTime get settlementDate => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  int? get posSessionId => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  int get totalSales => throw _privateConstructorUsedError;
  int get totalRefunds => throw _privateConstructorUsedError;
  int get totalFees => throw _privateConstructorUsedError;
  int get netAmount => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reconciledBy => throw _privateConstructorUsedError;
  DateTime? get reconciledAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SettlementBatch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettlementBatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettlementBatchCopyWith<SettlementBatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettlementBatchCopyWith<$Res> {
  factory $SettlementBatchCopyWith(
          SettlementBatch value, $Res Function(SettlementBatch) then) =
      _$SettlementBatchCopyWithImpl<$Res, SettlementBatch>;
  @useResult
  $Res call(
      {int branchId,
      DateTime settlementDate,
      String method,
      int? id,
      int? posSessionId,
      String? provider,
      int totalSales,
      int totalRefunds,
      int totalFees,
      int netAmount,
      int transactionCount,
      String status,
      String? reconciledBy,
      DateTime? reconciledAt,
      String? notes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$SettlementBatchCopyWithImpl<$Res, $Val extends SettlementBatch>
    implements $SettlementBatchCopyWith<$Res> {
  _$SettlementBatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettlementBatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? branchId = null,
    Object? settlementDate = null,
    Object? method = null,
    Object? id = freezed,
    Object? posSessionId = freezed,
    Object? provider = freezed,
    Object? totalSales = null,
    Object? totalRefunds = null,
    Object? totalFees = null,
    Object? netAmount = null,
    Object? transactionCount = null,
    Object? status = null,
    Object? reconciledBy = freezed,
    Object? reconciledAt = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int,
      settlementDate: null == settlementDate
          ? _value.settlementDate
          : settlementDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      posSessionId: freezed == posSessionId
          ? _value.posSessionId
          : posSessionId // ignore: cast_nullable_to_non_nullable
              as int?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as int,
      totalRefunds: null == totalRefunds
          ? _value.totalRefunds
          : totalRefunds // ignore: cast_nullable_to_non_nullable
              as int,
      totalFees: null == totalFees
          ? _value.totalFees
          : totalFees // ignore: cast_nullable_to_non_nullable
              as int,
      netAmount: null == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as int,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reconciledBy: freezed == reconciledBy
          ? _value.reconciledBy
          : reconciledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reconciledAt: freezed == reconciledAt
          ? _value.reconciledAt
          : reconciledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettlementBatchImplCopyWith<$Res>
    implements $SettlementBatchCopyWith<$Res> {
  factory _$$SettlementBatchImplCopyWith(_$SettlementBatchImpl value,
          $Res Function(_$SettlementBatchImpl) then) =
      __$$SettlementBatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int branchId,
      DateTime settlementDate,
      String method,
      int? id,
      int? posSessionId,
      String? provider,
      int totalSales,
      int totalRefunds,
      int totalFees,
      int netAmount,
      int transactionCount,
      String status,
      String? reconciledBy,
      DateTime? reconciledAt,
      String? notes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$SettlementBatchImplCopyWithImpl<$Res>
    extends _$SettlementBatchCopyWithImpl<$Res, _$SettlementBatchImpl>
    implements _$$SettlementBatchImplCopyWith<$Res> {
  __$$SettlementBatchImplCopyWithImpl(
      _$SettlementBatchImpl _value, $Res Function(_$SettlementBatchImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettlementBatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? branchId = null,
    Object? settlementDate = null,
    Object? method = null,
    Object? id = freezed,
    Object? posSessionId = freezed,
    Object? provider = freezed,
    Object? totalSales = null,
    Object? totalRefunds = null,
    Object? totalFees = null,
    Object? netAmount = null,
    Object? transactionCount = null,
    Object? status = null,
    Object? reconciledBy = freezed,
    Object? reconciledAt = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SettlementBatchImpl(
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int,
      settlementDate: null == settlementDate
          ? _value.settlementDate
          : settlementDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      posSessionId: freezed == posSessionId
          ? _value.posSessionId
          : posSessionId // ignore: cast_nullable_to_non_nullable
              as int?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as int,
      totalRefunds: null == totalRefunds
          ? _value.totalRefunds
          : totalRefunds // ignore: cast_nullable_to_non_nullable
              as int,
      totalFees: null == totalFees
          ? _value.totalFees
          : totalFees // ignore: cast_nullable_to_non_nullable
              as int,
      netAmount: null == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as int,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reconciledBy: freezed == reconciledBy
          ? _value.reconciledBy
          : reconciledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reconciledAt: freezed == reconciledAt
          ? _value.reconciledAt
          : reconciledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SettlementBatchImpl extends _SettlementBatch {
  const _$SettlementBatchImpl(
      {required this.branchId,
      required this.settlementDate,
      required this.method,
      this.id,
      this.posSessionId,
      this.provider,
      this.totalSales = 0,
      this.totalRefunds = 0,
      this.totalFees = 0,
      this.netAmount = 0,
      this.transactionCount = 0,
      this.status = 'open',
      this.reconciledBy,
      this.reconciledAt,
      this.notes,
      this.createdAt,
      this.updatedAt})
      : super._();

  factory _$SettlementBatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettlementBatchImplFromJson(json);

  @override
  final int branchId;
  @override
  final DateTime settlementDate;
  @override
  final String method;
  @override
  final int? id;
  @override
  final int? posSessionId;
  @override
  final String? provider;
  @override
  @JsonKey()
  final int totalSales;
  @override
  @JsonKey()
  final int totalRefunds;
  @override
  @JsonKey()
  final int totalFees;
  @override
  @JsonKey()
  final int netAmount;
  @override
  @JsonKey()
  final int transactionCount;
  @override
  @JsonKey()
  final String status;
  @override
  final String? reconciledBy;
  @override
  final DateTime? reconciledAt;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SettlementBatch(branchId: $branchId, settlementDate: $settlementDate, method: $method, id: $id, posSessionId: $posSessionId, provider: $provider, totalSales: $totalSales, totalRefunds: $totalRefunds, totalFees: $totalFees, netAmount: $netAmount, transactionCount: $transactionCount, status: $status, reconciledBy: $reconciledBy, reconciledAt: $reconciledAt, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettlementBatchImpl &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.settlementDate, settlementDate) ||
                other.settlementDate == settlementDate) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.posSessionId, posSessionId) ||
                other.posSessionId == posSessionId) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalRefunds, totalRefunds) ||
                other.totalRefunds == totalRefunds) &&
            (identical(other.totalFees, totalFees) ||
                other.totalFees == totalFees) &&
            (identical(other.netAmount, netAmount) ||
                other.netAmount == netAmount) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reconciledBy, reconciledBy) ||
                other.reconciledBy == reconciledBy) &&
            (identical(other.reconciledAt, reconciledAt) ||
                other.reconciledAt == reconciledAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      branchId,
      settlementDate,
      method,
      id,
      posSessionId,
      provider,
      totalSales,
      totalRefunds,
      totalFees,
      netAmount,
      transactionCount,
      status,
      reconciledBy,
      reconciledAt,
      notes,
      createdAt,
      updatedAt);

  /// Create a copy of SettlementBatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettlementBatchImplCopyWith<_$SettlementBatchImpl> get copyWith =>
      __$$SettlementBatchImplCopyWithImpl<_$SettlementBatchImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettlementBatchImplToJson(
      this,
    );
  }
}

abstract class _SettlementBatch extends SettlementBatch {
  const factory _SettlementBatch(
      {required final int branchId,
      required final DateTime settlementDate,
      required final String method,
      final int? id,
      final int? posSessionId,
      final String? provider,
      final int totalSales,
      final int totalRefunds,
      final int totalFees,
      final int netAmount,
      final int transactionCount,
      final String status,
      final String? reconciledBy,
      final DateTime? reconciledAt,
      final String? notes,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$SettlementBatchImpl;
  const _SettlementBatch._() : super._();

  factory _SettlementBatch.fromJson(Map<String, dynamic> json) =
      _$SettlementBatchImpl.fromJson;

  @override
  int get branchId;
  @override
  DateTime get settlementDate;
  @override
  String get method;
  @override
  int? get id;
  @override
  int? get posSessionId;
  @override
  String? get provider;
  @override
  int get totalSales;
  @override
  int get totalRefunds;
  @override
  int get totalFees;
  @override
  int get netAmount;
  @override
  int get transactionCount;
  @override
  String get status;
  @override
  String? get reconciledBy;
  @override
  DateTime? get reconciledAt;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of SettlementBatch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettlementBatchImplCopyWith<_$SettlementBatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
