// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grn_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GrnItem _$GrnItemFromJson(Map<String, dynamic> json) {
  return _GrnItem.fromJson(json);
}

/// @nodoc
mixin _$GrnItem {
  int get grnId => throw _privateConstructorUsedError;
  int get ingredientId => throw _privateConstructorUsedError;
  double get quantityReceived => throw _privateConstructorUsedError;
  double get unitCost => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  double get quantityOrdered => throw _privateConstructorUsedError;
  double get quantityRejected => throw _privateConstructorUsedError;
  String? get batchRef => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this GrnItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GrnItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GrnItemCopyWith<GrnItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrnItemCopyWith<$Res> {
  factory $GrnItemCopyWith(GrnItem value, $Res Function(GrnItem) then) =
      _$GrnItemCopyWithImpl<$Res, GrnItem>;
  @useResult
  $Res call(
      {int grnId,
      int ingredientId,
      double quantityReceived,
      double unitCost,
      int? id,
      double quantityOrdered,
      double quantityRejected,
      String? batchRef,
      DateTime? expiryDate,
      String? notes});
}

/// @nodoc
class _$GrnItemCopyWithImpl<$Res, $Val extends GrnItem>
    implements $GrnItemCopyWith<$Res> {
  _$GrnItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GrnItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grnId = null,
    Object? ingredientId = null,
    Object? quantityReceived = null,
    Object? unitCost = null,
    Object? id = freezed,
    Object? quantityOrdered = null,
    Object? quantityRejected = null,
    Object? batchRef = freezed,
    Object? expiryDate = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      grnId: null == grnId
          ? _value.grnId
          : grnId // ignore: cast_nullable_to_non_nullable
              as int,
      ingredientId: null == ingredientId
          ? _value.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as int,
      quantityReceived: null == quantityReceived
          ? _value.quantityReceived
          : quantityReceived // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      quantityOrdered: null == quantityOrdered
          ? _value.quantityOrdered
          : quantityOrdered // ignore: cast_nullable_to_non_nullable
              as double,
      quantityRejected: null == quantityRejected
          ? _value.quantityRejected
          : quantityRejected // ignore: cast_nullable_to_non_nullable
              as double,
      batchRef: freezed == batchRef
          ? _value.batchRef
          : batchRef // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GrnItemImplCopyWith<$Res> implements $GrnItemCopyWith<$Res> {
  factory _$$GrnItemImplCopyWith(
          _$GrnItemImpl value, $Res Function(_$GrnItemImpl) then) =
      __$$GrnItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int grnId,
      int ingredientId,
      double quantityReceived,
      double unitCost,
      int? id,
      double quantityOrdered,
      double quantityRejected,
      String? batchRef,
      DateTime? expiryDate,
      String? notes});
}

/// @nodoc
class __$$GrnItemImplCopyWithImpl<$Res>
    extends _$GrnItemCopyWithImpl<$Res, _$GrnItemImpl>
    implements _$$GrnItemImplCopyWith<$Res> {
  __$$GrnItemImplCopyWithImpl(
      _$GrnItemImpl _value, $Res Function(_$GrnItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of GrnItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grnId = null,
    Object? ingredientId = null,
    Object? quantityReceived = null,
    Object? unitCost = null,
    Object? id = freezed,
    Object? quantityOrdered = null,
    Object? quantityRejected = null,
    Object? batchRef = freezed,
    Object? expiryDate = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$GrnItemImpl(
      grnId: null == grnId
          ? _value.grnId
          : grnId // ignore: cast_nullable_to_non_nullable
              as int,
      ingredientId: null == ingredientId
          ? _value.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as int,
      quantityReceived: null == quantityReceived
          ? _value.quantityReceived
          : quantityReceived // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      quantityOrdered: null == quantityOrdered
          ? _value.quantityOrdered
          : quantityOrdered // ignore: cast_nullable_to_non_nullable
              as double,
      quantityRejected: null == quantityRejected
          ? _value.quantityRejected
          : quantityRejected // ignore: cast_nullable_to_non_nullable
              as double,
      batchRef: freezed == batchRef
          ? _value.batchRef
          : batchRef // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$GrnItemImpl extends _GrnItem {
  const _$GrnItemImpl(
      {required this.grnId,
      required this.ingredientId,
      required this.quantityReceived,
      required this.unitCost,
      this.id,
      this.quantityOrdered = 0,
      this.quantityRejected = 0,
      this.batchRef,
      this.expiryDate,
      this.notes})
      : super._();

  factory _$GrnItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$GrnItemImplFromJson(json);

  @override
  final int grnId;
  @override
  final int ingredientId;
  @override
  final double quantityReceived;
  @override
  final double unitCost;
  @override
  final int? id;
  @override
  @JsonKey()
  final double quantityOrdered;
  @override
  @JsonKey()
  final double quantityRejected;
  @override
  final String? batchRef;
  @override
  final DateTime? expiryDate;
  @override
  final String? notes;

  @override
  String toString() {
    return 'GrnItem(grnId: $grnId, ingredientId: $ingredientId, quantityReceived: $quantityReceived, unitCost: $unitCost, id: $id, quantityOrdered: $quantityOrdered, quantityRejected: $quantityRejected, batchRef: $batchRef, expiryDate: $expiryDate, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrnItemImpl &&
            (identical(other.grnId, grnId) || other.grnId == grnId) &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.quantityReceived, quantityReceived) ||
                other.quantityReceived == quantityReceived) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quantityOrdered, quantityOrdered) ||
                other.quantityOrdered == quantityOrdered) &&
            (identical(other.quantityRejected, quantityRejected) ||
                other.quantityRejected == quantityRejected) &&
            (identical(other.batchRef, batchRef) ||
                other.batchRef == batchRef) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      grnId,
      ingredientId,
      quantityReceived,
      unitCost,
      id,
      quantityOrdered,
      quantityRejected,
      batchRef,
      expiryDate,
      notes);

  /// Create a copy of GrnItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GrnItemImplCopyWith<_$GrnItemImpl> get copyWith =>
      __$$GrnItemImplCopyWithImpl<_$GrnItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GrnItemImplToJson(
      this,
    );
  }
}

abstract class _GrnItem extends GrnItem {
  const factory _GrnItem(
      {required final int grnId,
      required final int ingredientId,
      required final double quantityReceived,
      required final double unitCost,
      final int? id,
      final double quantityOrdered,
      final double quantityRejected,
      final String? batchRef,
      final DateTime? expiryDate,
      final String? notes}) = _$GrnItemImpl;
  const _GrnItem._() : super._();

  factory _GrnItem.fromJson(Map<String, dynamic> json) = _$GrnItemImpl.fromJson;

  @override
  int get grnId;
  @override
  int get ingredientId;
  @override
  double get quantityReceived;
  @override
  double get unitCost;
  @override
  int? get id;
  @override
  double get quantityOrdered;
  @override
  double get quantityRejected;
  @override
  String? get batchRef;
  @override
  DateTime? get expiryDate;
  @override
  String? get notes;

  /// Create a copy of GrnItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GrnItemImplCopyWith<_$GrnItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
