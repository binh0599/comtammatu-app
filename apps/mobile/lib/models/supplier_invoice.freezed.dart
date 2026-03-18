// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupplierInvoice _$SupplierInvoiceFromJson(Map<String, dynamic> json) {
  return _SupplierInvoice.fromJson(json);
}

/// @nodoc
mixin _$SupplierInvoice {
  int get brandId => throw _privateConstructorUsedError;
  int get supplierId => throw _privateConstructorUsedError;
  String get invoiceNumber => throw _privateConstructorUsedError;
  DateTime get invoiceDate => throw _privateConstructorUsedError;
  int get subtotal => throw _privateConstructorUsedError;
  int get vatAmount => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  int? get poId => throw _privateConstructorUsedError;
  int? get grnId => throw _privateConstructorUsedError;
  double get vatRate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get matchStatus => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SupplierInvoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierInvoiceCopyWith<SupplierInvoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierInvoiceCopyWith<$Res> {
  factory $SupplierInvoiceCopyWith(
          SupplierInvoice value, $Res Function(SupplierInvoice) then) =
      _$SupplierInvoiceCopyWithImpl<$Res, SupplierInvoice>;
  @useResult
  $Res call(
      {int brandId,
      int supplierId,
      String invoiceNumber,
      DateTime invoiceDate,
      int subtotal,
      int vatAmount,
      int totalAmount,
      int? id,
      int? poId,
      int? grnId,
      double vatRate,
      String status,
      String matchStatus,
      DateTime? dueDate,
      DateTime? paidAt,
      String? notes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$SupplierInvoiceCopyWithImpl<$Res, $Val extends SupplierInvoice>
    implements $SupplierInvoiceCopyWith<$Res> {
  _$SupplierInvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? supplierId = null,
    Object? invoiceNumber = null,
    Object? invoiceDate = null,
    Object? subtotal = null,
    Object? vatAmount = null,
    Object? totalAmount = null,
    Object? id = freezed,
    Object? poId = freezed,
    Object? grnId = freezed,
    Object? vatRate = null,
    Object? status = null,
    Object? matchStatus = null,
    Object? dueDate = freezed,
    Object? paidAt = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      brandId: null == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      vatAmount: null == vatAmount
          ? _value.vatAmount
          : vatAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      poId: freezed == poId
          ? _value.poId
          : poId // ignore: cast_nullable_to_non_nullable
              as int?,
      grnId: freezed == grnId
          ? _value.grnId
          : grnId // ignore: cast_nullable_to_non_nullable
              as int?,
      vatRate: null == vatRate
          ? _value.vatRate
          : vatRate // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      matchStatus: null == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SupplierInvoiceImplCopyWith<$Res>
    implements $SupplierInvoiceCopyWith<$Res> {
  factory _$$SupplierInvoiceImplCopyWith(_$SupplierInvoiceImpl value,
          $Res Function(_$SupplierInvoiceImpl) then) =
      __$$SupplierInvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int brandId,
      int supplierId,
      String invoiceNumber,
      DateTime invoiceDate,
      int subtotal,
      int vatAmount,
      int totalAmount,
      int? id,
      int? poId,
      int? grnId,
      double vatRate,
      String status,
      String matchStatus,
      DateTime? dueDate,
      DateTime? paidAt,
      String? notes,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$SupplierInvoiceImplCopyWithImpl<$Res>
    extends _$SupplierInvoiceCopyWithImpl<$Res, _$SupplierInvoiceImpl>
    implements _$$SupplierInvoiceImplCopyWith<$Res> {
  __$$SupplierInvoiceImplCopyWithImpl(
      _$SupplierInvoiceImpl _value, $Res Function(_$SupplierInvoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SupplierInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? supplierId = null,
    Object? invoiceNumber = null,
    Object? invoiceDate = null,
    Object? subtotal = null,
    Object? vatAmount = null,
    Object? totalAmount = null,
    Object? id = freezed,
    Object? poId = freezed,
    Object? grnId = freezed,
    Object? vatRate = null,
    Object? status = null,
    Object? matchStatus = null,
    Object? dueDate = freezed,
    Object? paidAt = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SupplierInvoiceImpl(
      brandId: null == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      vatAmount: null == vatAmount
          ? _value.vatAmount
          : vatAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      poId: freezed == poId
          ? _value.poId
          : poId // ignore: cast_nullable_to_non_nullable
              as int?,
      grnId: freezed == grnId
          ? _value.grnId
          : grnId // ignore: cast_nullable_to_non_nullable
              as int?,
      vatRate: null == vatRate
          ? _value.vatRate
          : vatRate // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      matchStatus: null == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
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
class _$SupplierInvoiceImpl extends _SupplierInvoice {
  const _$SupplierInvoiceImpl(
      {required this.brandId,
      required this.supplierId,
      required this.invoiceNumber,
      required this.invoiceDate,
      required this.subtotal,
      required this.vatAmount,
      required this.totalAmount,
      this.id,
      this.poId,
      this.grnId,
      this.vatRate = 10,
      this.status = 'pending',
      this.matchStatus = 'unmatched',
      this.dueDate,
      this.paidAt,
      this.notes,
      this.createdAt,
      this.updatedAt})
      : super._();

  factory _$SupplierInvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierInvoiceImplFromJson(json);

  @override
  final int brandId;
  @override
  final int supplierId;
  @override
  final String invoiceNumber;
  @override
  final DateTime invoiceDate;
  @override
  final int subtotal;
  @override
  final int vatAmount;
  @override
  final int totalAmount;
  @override
  final int? id;
  @override
  final int? poId;
  @override
  final int? grnId;
  @override
  @JsonKey()
  final double vatRate;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String matchStatus;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? paidAt;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SupplierInvoice(brandId: $brandId, supplierId: $supplierId, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, subtotal: $subtotal, vatAmount: $vatAmount, totalAmount: $totalAmount, id: $id, poId: $poId, grnId: $grnId, vatRate: $vatRate, status: $status, matchStatus: $matchStatus, dueDate: $dueDate, paidAt: $paidAt, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierInvoiceImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.invoiceDate, invoiceDate) ||
                other.invoiceDate == invoiceDate) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.vatAmount, vatAmount) ||
                other.vatAmount == vatAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.poId, poId) || other.poId == poId) &&
            (identical(other.grnId, grnId) || other.grnId == grnId) &&
            (identical(other.vatRate, vatRate) || other.vatRate == vatRate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.matchStatus, matchStatus) ||
                other.matchStatus == matchStatus) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
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
      brandId,
      supplierId,
      invoiceNumber,
      invoiceDate,
      subtotal,
      vatAmount,
      totalAmount,
      id,
      poId,
      grnId,
      vatRate,
      status,
      matchStatus,
      dueDate,
      paidAt,
      notes,
      createdAt,
      updatedAt);

  /// Create a copy of SupplierInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierInvoiceImplCopyWith<_$SupplierInvoiceImpl> get copyWith =>
      __$$SupplierInvoiceImplCopyWithImpl<_$SupplierInvoiceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierInvoiceImplToJson(
      this,
    );
  }
}

abstract class _SupplierInvoice extends SupplierInvoice {
  const factory _SupplierInvoice(
      {required final int brandId,
      required final int supplierId,
      required final String invoiceNumber,
      required final DateTime invoiceDate,
      required final int subtotal,
      required final int vatAmount,
      required final int totalAmount,
      final int? id,
      final int? poId,
      final int? grnId,
      final double vatRate,
      final String status,
      final String matchStatus,
      final DateTime? dueDate,
      final DateTime? paidAt,
      final String? notes,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$SupplierInvoiceImpl;
  const _SupplierInvoice._() : super._();

  factory _SupplierInvoice.fromJson(Map<String, dynamic> json) =
      _$SupplierInvoiceImpl.fromJson;

  @override
  int get brandId;
  @override
  int get supplierId;
  @override
  String get invoiceNumber;
  @override
  DateTime get invoiceDate;
  @override
  int get subtotal;
  @override
  int get vatAmount;
  @override
  int get totalAmount;
  @override
  int? get id;
  @override
  int? get poId;
  @override
  int? get grnId;
  @override
  double get vatRate;
  @override
  String get status;
  @override
  String get matchStatus;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get paidAt;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of SupplierInvoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierInvoiceImplCopyWith<_$SupplierInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
