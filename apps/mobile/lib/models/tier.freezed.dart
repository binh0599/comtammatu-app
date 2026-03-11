// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TierProgress _$TierProgressFromJson(Map<String, dynamic> json) {
  return _TierProgress.fromJson(json);
}

/// @nodoc
mixin _$TierProgress {
  String get name => throw _privateConstructorUsedError;
  String get tierCode => throw _privateConstructorUsedError;
  double get minPoints => throw _privateConstructorUsedError;
  double get pointsNeeded => throw _privateConstructorUsedError;
  double get progressPercent => throw _privateConstructorUsedError;

  /// Serializes this TierProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TierProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TierProgressCopyWith<TierProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TierProgressCopyWith<$Res> {
  factory $TierProgressCopyWith(
          TierProgress value, $Res Function(TierProgress) then) =
      _$TierProgressCopyWithImpl<$Res, TierProgress>;
  @useResult
  $Res call(
      {String name,
      String tierCode,
      double minPoints,
      double pointsNeeded,
      double progressPercent});
}

/// @nodoc
class _$TierProgressCopyWithImpl<$Res, $Val extends TierProgress>
    implements $TierProgressCopyWith<$Res> {
  _$TierProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TierProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tierCode = null,
    Object? minPoints = null,
    Object? pointsNeeded = null,
    Object? progressPercent = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tierCode: null == tierCode
          ? _value.tierCode
          : tierCode // ignore: cast_nullable_to_non_nullable
              as String,
      minPoints: null == minPoints
          ? _value.minPoints
          : minPoints // ignore: cast_nullable_to_non_nullable
              as double,
      pointsNeeded: null == pointsNeeded
          ? _value.pointsNeeded
          : pointsNeeded // ignore: cast_nullable_to_non_nullable
              as double,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TierProgressImplCopyWith<$Res>
    implements $TierProgressCopyWith<$Res> {
  factory _$$TierProgressImplCopyWith(
          _$TierProgressImpl value, $Res Function(_$TierProgressImpl) then) =
      __$$TierProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String tierCode,
      double minPoints,
      double pointsNeeded,
      double progressPercent});
}

/// @nodoc
class __$$TierProgressImplCopyWithImpl<$Res>
    extends _$TierProgressCopyWithImpl<$Res, _$TierProgressImpl>
    implements _$$TierProgressImplCopyWith<$Res> {
  __$$TierProgressImplCopyWithImpl(
      _$TierProgressImpl _value, $Res Function(_$TierProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of TierProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tierCode = null,
    Object? minPoints = null,
    Object? pointsNeeded = null,
    Object? progressPercent = null,
  }) {
    return _then(_$TierProgressImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tierCode: null == tierCode
          ? _value.tierCode
          : tierCode // ignore: cast_nullable_to_non_nullable
              as String,
      minPoints: null == minPoints
          ? _value.minPoints
          : minPoints // ignore: cast_nullable_to_non_nullable
              as double,
      pointsNeeded: null == pointsNeeded
          ? _value.pointsNeeded
          : pointsNeeded // ignore: cast_nullable_to_non_nullable
              as double,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TierProgressImpl implements _TierProgress {
  const _$TierProgressImpl(
      {required this.name,
      required this.tierCode,
      required this.minPoints,
      required this.pointsNeeded,
      required this.progressPercent});

  factory _$TierProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$TierProgressImplFromJson(json);

  @override
  final String name;
  @override
  final String tierCode;
  @override
  final double minPoints;
  @override
  final double pointsNeeded;
  @override
  final double progressPercent;

  @override
  String toString() {
    return 'TierProgress(name: $name, tierCode: $tierCode, minPoints: $minPoints, pointsNeeded: $pointsNeeded, progressPercent: $progressPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TierProgressImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tierCode, tierCode) ||
                other.tierCode == tierCode) &&
            (identical(other.minPoints, minPoints) ||
                other.minPoints == minPoints) &&
            (identical(other.pointsNeeded, pointsNeeded) ||
                other.pointsNeeded == pointsNeeded) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, tierCode, minPoints, pointsNeeded, progressPercent);

  /// Create a copy of TierProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TierProgressImplCopyWith<_$TierProgressImpl> get copyWith =>
      __$$TierProgressImplCopyWithImpl<_$TierProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TierProgressImplToJson(
      this,
    );
  }
}

abstract class _TierProgress implements TierProgress {
  const factory _TierProgress(
      {required final String name,
      required final String tierCode,
      required final double minPoints,
      required final double pointsNeeded,
      required final double progressPercent}) = _$TierProgressImpl;

  factory _TierProgress.fromJson(Map<String, dynamic> json) =
      _$TierProgressImpl.fromJson;

  @override
  String get name;
  @override
  String get tierCode;
  @override
  double get minPoints;
  @override
  double get pointsNeeded;
  @override
  double get progressPercent;

  /// Create a copy of TierProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TierProgressImplCopyWith<_$TierProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tier _$TierFromJson(Map<String, dynamic> json) {
  return _Tier.fromJson(json);
}

/// @nodoc
mixin _$Tier {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get tierCode => throw _privateConstructorUsedError;
  double get pointMultiplier => throw _privateConstructorUsedError;
  double get cashbackPercent => throw _privateConstructorUsedError;
  List<String> get benefits => throw _privateConstructorUsedError;
  TierProgress? get nextTier => throw _privateConstructorUsedError;

  /// Serializes this Tier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TierCopyWith<Tier> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TierCopyWith<$Res> {
  factory $TierCopyWith(Tier value, $Res Function(Tier) then) =
      _$TierCopyWithImpl<$Res, Tier>;
  @useResult
  $Res call(
      {int id,
      String name,
      String tierCode,
      double pointMultiplier,
      double cashbackPercent,
      List<String> benefits,
      TierProgress? nextTier});

  $TierProgressCopyWith<$Res>? get nextTier;
}

/// @nodoc
class _$TierCopyWithImpl<$Res, $Val extends Tier>
    implements $TierCopyWith<$Res> {
  _$TierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tierCode = null,
    Object? pointMultiplier = null,
    Object? cashbackPercent = null,
    Object? benefits = null,
    Object? nextTier = freezed,
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
      tierCode: null == tierCode
          ? _value.tierCode
          : tierCode // ignore: cast_nullable_to_non_nullable
              as String,
      pointMultiplier: null == pointMultiplier
          ? _value.pointMultiplier
          : pointMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      cashbackPercent: null == cashbackPercent
          ? _value.cashbackPercent
          : cashbackPercent // ignore: cast_nullable_to_non_nullable
              as double,
      benefits: null == benefits
          ? _value.benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nextTier: freezed == nextTier
          ? _value.nextTier
          : nextTier // ignore: cast_nullable_to_non_nullable
              as TierProgress?,
    ) as $Val);
  }

  /// Create a copy of Tier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TierProgressCopyWith<$Res>? get nextTier {
    if (_value.nextTier == null) {
      return null;
    }

    return $TierProgressCopyWith<$Res>(_value.nextTier!, (value) {
      return _then(_value.copyWith(nextTier: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TierImplCopyWith<$Res> implements $TierCopyWith<$Res> {
  factory _$$TierImplCopyWith(
          _$TierImpl value, $Res Function(_$TierImpl) then) =
      __$$TierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String tierCode,
      double pointMultiplier,
      double cashbackPercent,
      List<String> benefits,
      TierProgress? nextTier});

  @override
  $TierProgressCopyWith<$Res>? get nextTier;
}

/// @nodoc
class __$$TierImplCopyWithImpl<$Res>
    extends _$TierCopyWithImpl<$Res, _$TierImpl>
    implements _$$TierImplCopyWith<$Res> {
  __$$TierImplCopyWithImpl(_$TierImpl _value, $Res Function(_$TierImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tierCode = null,
    Object? pointMultiplier = null,
    Object? cashbackPercent = null,
    Object? benefits = null,
    Object? nextTier = freezed,
  }) {
    return _then(_$TierImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tierCode: null == tierCode
          ? _value.tierCode
          : tierCode // ignore: cast_nullable_to_non_nullable
              as String,
      pointMultiplier: null == pointMultiplier
          ? _value.pointMultiplier
          : pointMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      cashbackPercent: null == cashbackPercent
          ? _value.cashbackPercent
          : cashbackPercent // ignore: cast_nullable_to_non_nullable
              as double,
      benefits: null == benefits
          ? _value._benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nextTier: freezed == nextTier
          ? _value.nextTier
          : nextTier // ignore: cast_nullable_to_non_nullable
              as TierProgress?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TierImpl implements _Tier {
  const _$TierImpl(
      {required this.id,
      required this.name,
      required this.tierCode,
      required this.pointMultiplier,
      required this.cashbackPercent,
      required final List<String> benefits,
      this.nextTier})
      : _benefits = benefits;

  factory _$TierImpl.fromJson(Map<String, dynamic> json) =>
      _$$TierImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String tierCode;
  @override
  final double pointMultiplier;
  @override
  final double cashbackPercent;
  final List<String> _benefits;
  @override
  List<String> get benefits {
    if (_benefits is EqualUnmodifiableListView) return _benefits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_benefits);
  }

  @override
  final TierProgress? nextTier;

  @override
  String toString() {
    return 'Tier(id: $id, name: $name, tierCode: $tierCode, pointMultiplier: $pointMultiplier, cashbackPercent: $cashbackPercent, benefits: $benefits, nextTier: $nextTier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tierCode, tierCode) ||
                other.tierCode == tierCode) &&
            (identical(other.pointMultiplier, pointMultiplier) ||
                other.pointMultiplier == pointMultiplier) &&
            (identical(other.cashbackPercent, cashbackPercent) ||
                other.cashbackPercent == cashbackPercent) &&
            const DeepCollectionEquality().equals(other._benefits, _benefits) &&
            (identical(other.nextTier, nextTier) ||
                other.nextTier == nextTier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      tierCode,
      pointMultiplier,
      cashbackPercent,
      const DeepCollectionEquality().hash(_benefits),
      nextTier);

  /// Create a copy of Tier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TierImplCopyWith<_$TierImpl> get copyWith =>
      __$$TierImplCopyWithImpl<_$TierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TierImplToJson(
      this,
    );
  }
}

abstract class _Tier implements Tier {
  const factory _Tier(
      {required final int id,
      required final String name,
      required final String tierCode,
      required final double pointMultiplier,
      required final double cashbackPercent,
      required final List<String> benefits,
      final TierProgress? nextTier}) = _$TierImpl;

  factory _Tier.fromJson(Map<String, dynamic> json) = _$TierImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get tierCode;
  @override
  double get pointMultiplier;
  @override
  double get cashbackPercent;
  @override
  List<String> get benefits;
  @override
  TierProgress? get nextTier;

  /// Create a copy of Tier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TierImplCopyWith<_$TierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
