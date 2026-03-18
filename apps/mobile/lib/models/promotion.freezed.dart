// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promotion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return _Promotion.fromJson(json);
}

/// @nodoc
mixin _$Promotion {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get cashbackType => throw _privateConstructorUsedError;
  int get cashbackValue => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  bool get eligible => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Promotion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotionCopyWith<Promotion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionCopyWith<$Res> {
  factory $PromotionCopyWith(Promotion value, $Res Function(Promotion) then) =
      _$PromotionCopyWithImpl<$Res, Promotion>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String cashbackType,
      int cashbackValue,
      DateTime startDate,
      DateTime endDate,
      bool eligible,
      String? imageUrl});
}

/// @nodoc
class _$PromotionCopyWithImpl<$Res, $Val extends Promotion>
    implements $PromotionCopyWith<$Res> {
  _$PromotionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? cashbackType = null,
    Object? cashbackValue = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? eligible = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      cashbackType: null == cashbackType
          ? _value.cashbackType
          : cashbackType // ignore: cast_nullable_to_non_nullable
              as String,
      cashbackValue: null == cashbackValue
          ? _value.cashbackValue
          : cashbackValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eligible: null == eligible
          ? _value.eligible
          : eligible // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromotionImplCopyWith<$Res>
    implements $PromotionCopyWith<$Res> {
  factory _$$PromotionImplCopyWith(
          _$PromotionImpl value, $Res Function(_$PromotionImpl) then) =
      __$$PromotionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String cashbackType,
      int cashbackValue,
      DateTime startDate,
      DateTime endDate,
      bool eligible,
      String? imageUrl});
}

/// @nodoc
class __$$PromotionImplCopyWithImpl<$Res>
    extends _$PromotionCopyWithImpl<$Res, _$PromotionImpl>
    implements _$$PromotionImplCopyWith<$Res> {
  __$$PromotionImplCopyWithImpl(
      _$PromotionImpl _value, $Res Function(_$PromotionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? cashbackType = null,
    Object? cashbackValue = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? eligible = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PromotionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      cashbackType: null == cashbackType
          ? _value.cashbackType
          : cashbackType // ignore: cast_nullable_to_non_nullable
              as String,
      cashbackValue: null == cashbackValue
          ? _value.cashbackValue
          : cashbackValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eligible: null == eligible
          ? _value.eligible
          : eligible // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PromotionImpl extends _Promotion {
  const _$PromotionImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.cashbackType,
      required this.cashbackValue,
      required this.startDate,
      required this.endDate,
      required this.eligible,
      this.imageUrl})
      : super._();

  factory _$PromotionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotionImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String cashbackType;
  @override
  final int cashbackValue;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final bool eligible;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Promotion(id: $id, name: $name, description: $description, cashbackType: $cashbackType, cashbackValue: $cashbackValue, startDate: $startDate, endDate: $endDate, eligible: $eligible, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cashbackType, cashbackType) ||
                other.cashbackType == cashbackType) &&
            (identical(other.cashbackValue, cashbackValue) ||
                other.cashbackValue == cashbackValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.eligible, eligible) ||
                other.eligible == eligible) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      cashbackType, cashbackValue, startDate, endDate, eligible, imageUrl);

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotionImplCopyWith<_$PromotionImpl> get copyWith =>
      __$$PromotionImplCopyWithImpl<_$PromotionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotionImplToJson(
      this,
    );
  }
}

abstract class _Promotion extends Promotion {
  const factory _Promotion(
      {required final int id,
      required final String name,
      required final String description,
      required final String cashbackType,
      required final int cashbackValue,
      required final DateTime startDate,
      required final DateTime endDate,
      required final bool eligible,
      final String? imageUrl}) = _$PromotionImpl;
  const _Promotion._() : super._();

  factory _Promotion.fromJson(Map<String, dynamic> json) =
      _$PromotionImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get cashbackType;
  @override
  int get cashbackValue;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  bool get eligible;
  @override
  String? get imageUrl;

  /// Create a copy of Promotion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotionImplCopyWith<_$PromotionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
