// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkin_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return _Branch.fromJson(json);
}

/// @nodoc
mixin _$Branch {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  /// Serializes this Branch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchCopyWith<Branch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchCopyWith<$Res> {
  factory $BranchCopyWith(Branch value, $Res Function(Branch) then) =
      _$BranchCopyWithImpl<$Res, Branch>;
  @useResult
  $Res call({int id, String name, String address});
}

/// @nodoc
class _$BranchCopyWithImpl<$Res, $Val extends Branch>
    implements $BranchCopyWith<$Res> {
  _$BranchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchImplCopyWith<$Res> implements $BranchCopyWith<$Res> {
  factory _$$BranchImplCopyWith(
          _$BranchImpl value, $Res Function(_$BranchImpl) then) =
      __$$BranchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String address});
}

/// @nodoc
class __$$BranchImplCopyWithImpl<$Res>
    extends _$BranchCopyWithImpl<$Res, _$BranchImpl>
    implements _$$BranchImplCopyWith<$Res> {
  __$$BranchImplCopyWithImpl(
      _$BranchImpl _value, $Res Function(_$BranchImpl) _then)
      : super(_value, _then);

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_$BranchImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$BranchImpl implements _Branch {
  const _$BranchImpl(
      {required this.id, required this.name, required this.address});

  factory _$BranchImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String address;

  @override
  String toString() {
    return 'Branch(id: $id, name: $name, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address);

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      __$$BranchImplCopyWithImpl<_$BranchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchImplToJson(
      this,
    );
  }
}

abstract class _Branch implements Branch {
  const factory _Branch(
      {required final int id,
      required final String name,
      required final String address}) = _$BranchImpl;

  factory _Branch.fromJson(Map<String, dynamic> json) = _$BranchImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get address;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckinStreak _$CheckinStreakFromJson(Map<String, dynamic> json) {
  return _CheckinStreak.fromJson(json);
}

/// @nodoc
mixin _$CheckinStreak {
  int get current => throw _privateConstructorUsedError;
  int get bonus => throw _privateConstructorUsedError;
  int get nextMilestone => throw _privateConstructorUsedError;
  int get nextMilestoneBonus => throw _privateConstructorUsedError;

  /// Serializes this CheckinStreak to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckinStreak
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckinStreakCopyWith<CheckinStreak> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckinStreakCopyWith<$Res> {
  factory $CheckinStreakCopyWith(
          CheckinStreak value, $Res Function(CheckinStreak) then) =
      _$CheckinStreakCopyWithImpl<$Res, CheckinStreak>;
  @useResult
  $Res call(
      {int current, int bonus, int nextMilestone, int nextMilestoneBonus});
}

/// @nodoc
class _$CheckinStreakCopyWithImpl<$Res, $Val extends CheckinStreak>
    implements $CheckinStreakCopyWith<$Res> {
  _$CheckinStreakCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckinStreak
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? bonus = null,
    Object? nextMilestone = null,
    Object? nextMilestoneBonus = null,
  }) {
    return _then(_value.copyWith(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as int,
      nextMilestone: null == nextMilestone
          ? _value.nextMilestone
          : nextMilestone // ignore: cast_nullable_to_non_nullable
              as int,
      nextMilestoneBonus: null == nextMilestoneBonus
          ? _value.nextMilestoneBonus
          : nextMilestoneBonus // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckinStreakImplCopyWith<$Res>
    implements $CheckinStreakCopyWith<$Res> {
  factory _$$CheckinStreakImplCopyWith(
          _$CheckinStreakImpl value, $Res Function(_$CheckinStreakImpl) then) =
      __$$CheckinStreakImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int current, int bonus, int nextMilestone, int nextMilestoneBonus});
}

/// @nodoc
class __$$CheckinStreakImplCopyWithImpl<$Res>
    extends _$CheckinStreakCopyWithImpl<$Res, _$CheckinStreakImpl>
    implements _$$CheckinStreakImplCopyWith<$Res> {
  __$$CheckinStreakImplCopyWithImpl(
      _$CheckinStreakImpl _value, $Res Function(_$CheckinStreakImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckinStreak
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? bonus = null,
    Object? nextMilestone = null,
    Object? nextMilestoneBonus = null,
  }) {
    return _then(_$CheckinStreakImpl(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as int,
      nextMilestone: null == nextMilestone
          ? _value.nextMilestone
          : nextMilestone // ignore: cast_nullable_to_non_nullable
              as int,
      nextMilestoneBonus: null == nextMilestoneBonus
          ? _value.nextMilestoneBonus
          : nextMilestoneBonus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CheckinStreakImpl implements _CheckinStreak {
  const _$CheckinStreakImpl(
      {required this.current,
      required this.bonus,
      required this.nextMilestone,
      required this.nextMilestoneBonus});

  factory _$CheckinStreakImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckinStreakImplFromJson(json);

  @override
  final int current;
  @override
  final int bonus;
  @override
  final int nextMilestone;
  @override
  final int nextMilestoneBonus;

  @override
  String toString() {
    return 'CheckinStreak(current: $current, bonus: $bonus, nextMilestone: $nextMilestone, nextMilestoneBonus: $nextMilestoneBonus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckinStreakImpl &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.nextMilestone, nextMilestone) ||
                other.nextMilestone == nextMilestone) &&
            (identical(other.nextMilestoneBonus, nextMilestoneBonus) ||
                other.nextMilestoneBonus == nextMilestoneBonus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, current, bonus, nextMilestone, nextMilestoneBonus);

  /// Create a copy of CheckinStreak
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckinStreakImplCopyWith<_$CheckinStreakImpl> get copyWith =>
      __$$CheckinStreakImplCopyWithImpl<_$CheckinStreakImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckinStreakImplToJson(
      this,
    );
  }
}

abstract class _CheckinStreak implements CheckinStreak {
  const factory _CheckinStreak(
      {required final int current,
      required final int bonus,
      required final int nextMilestone,
      required final int nextMilestoneBonus}) = _$CheckinStreakImpl;

  factory _CheckinStreak.fromJson(Map<String, dynamic> json) =
      _$CheckinStreakImpl.fromJson;

  @override
  int get current;
  @override
  int get bonus;
  @override
  int get nextMilestone;
  @override
  int get nextMilestoneBonus;

  /// Create a copy of CheckinStreak
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckinStreakImplCopyWith<_$CheckinStreakImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckinResult _$CheckinResultFromJson(Map<String, dynamic> json) {
  return _CheckinResult.fromJson(json);
}

/// @nodoc
mixin _$CheckinResult {
  int get checkinId => throw _privateConstructorUsedError;
  Branch get branch => throw _privateConstructorUsedError;
  double get pointsEarned => throw _privateConstructorUsedError;
  double get newBalance => throw _privateConstructorUsedError;
  CheckinStreak get streak => throw _privateConstructorUsedError;
  DateTime get checkedInAt => throw _privateConstructorUsedError;

  /// Serializes this CheckinResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckinResultCopyWith<CheckinResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckinResultCopyWith<$Res> {
  factory $CheckinResultCopyWith(
          CheckinResult value, $Res Function(CheckinResult) then) =
      _$CheckinResultCopyWithImpl<$Res, CheckinResult>;
  @useResult
  $Res call(
      {int checkinId,
      Branch branch,
      double pointsEarned,
      double newBalance,
      CheckinStreak streak,
      DateTime checkedInAt});

  $BranchCopyWith<$Res> get branch;
  $CheckinStreakCopyWith<$Res> get streak;
}

/// @nodoc
class _$CheckinResultCopyWithImpl<$Res, $Val extends CheckinResult>
    implements $CheckinResultCopyWith<$Res> {
  _$CheckinResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkinId = null,
    Object? branch = null,
    Object? pointsEarned = null,
    Object? newBalance = null,
    Object? streak = null,
    Object? checkedInAt = null,
  }) {
    return _then(_value.copyWith(
      checkinId: null == checkinId
          ? _value.checkinId
          : checkinId // ignore: cast_nullable_to_non_nullable
              as int,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as Branch,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as double,
      newBalance: null == newBalance
          ? _value.newBalance
          : newBalance // ignore: cast_nullable_to_non_nullable
              as double,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as CheckinStreak,
      checkedInAt: null == checkedInAt
          ? _value.checkedInAt
          : checkedInAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BranchCopyWith<$Res> get branch {
    return $BranchCopyWith<$Res>(_value.branch, (value) {
      return _then(_value.copyWith(branch: value) as $Val);
    });
  }

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckinStreakCopyWith<$Res> get streak {
    return $CheckinStreakCopyWith<$Res>(_value.streak, (value) {
      return _then(_value.copyWith(streak: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckinResultImplCopyWith<$Res>
    implements $CheckinResultCopyWith<$Res> {
  factory _$$CheckinResultImplCopyWith(
          _$CheckinResultImpl value, $Res Function(_$CheckinResultImpl) then) =
      __$$CheckinResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int checkinId,
      Branch branch,
      double pointsEarned,
      double newBalance,
      CheckinStreak streak,
      DateTime checkedInAt});

  @override
  $BranchCopyWith<$Res> get branch;
  @override
  $CheckinStreakCopyWith<$Res> get streak;
}

/// @nodoc
class __$$CheckinResultImplCopyWithImpl<$Res>
    extends _$CheckinResultCopyWithImpl<$Res, _$CheckinResultImpl>
    implements _$$CheckinResultImplCopyWith<$Res> {
  __$$CheckinResultImplCopyWithImpl(
      _$CheckinResultImpl _value, $Res Function(_$CheckinResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkinId = null,
    Object? branch = null,
    Object? pointsEarned = null,
    Object? newBalance = null,
    Object? streak = null,
    Object? checkedInAt = null,
  }) {
    return _then(_$CheckinResultImpl(
      checkinId: null == checkinId
          ? _value.checkinId
          : checkinId // ignore: cast_nullable_to_non_nullable
              as int,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as Branch,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as double,
      newBalance: null == newBalance
          ? _value.newBalance
          : newBalance // ignore: cast_nullable_to_non_nullable
              as double,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as CheckinStreak,
      checkedInAt: null == checkedInAt
          ? _value.checkedInAt
          : checkedInAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CheckinResultImpl implements _CheckinResult {
  const _$CheckinResultImpl(
      {required this.checkinId,
      required this.branch,
      required this.pointsEarned,
      required this.newBalance,
      required this.streak,
      required this.checkedInAt});

  factory _$CheckinResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckinResultImplFromJson(json);

  @override
  final int checkinId;
  @override
  final Branch branch;
  @override
  final double pointsEarned;
  @override
  final double newBalance;
  @override
  final CheckinStreak streak;
  @override
  final DateTime checkedInAt;

  @override
  String toString() {
    return 'CheckinResult(checkinId: $checkinId, branch: $branch, pointsEarned: $pointsEarned, newBalance: $newBalance, streak: $streak, checkedInAt: $checkedInAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckinResultImpl &&
            (identical(other.checkinId, checkinId) ||
                other.checkinId == checkinId) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            (identical(other.newBalance, newBalance) ||
                other.newBalance == newBalance) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.checkedInAt, checkedInAt) ||
                other.checkedInAt == checkedInAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, checkinId, branch, pointsEarned,
      newBalance, streak, checkedInAt);

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckinResultImplCopyWith<_$CheckinResultImpl> get copyWith =>
      __$$CheckinResultImplCopyWithImpl<_$CheckinResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckinResultImplToJson(
      this,
    );
  }
}

abstract class _CheckinResult implements CheckinResult {
  const factory _CheckinResult(
      {required final int checkinId,
      required final Branch branch,
      required final double pointsEarned,
      required final double newBalance,
      required final CheckinStreak streak,
      required final DateTime checkedInAt}) = _$CheckinResultImpl;

  factory _CheckinResult.fromJson(Map<String, dynamic> json) =
      _$CheckinResultImpl.fromJson;

  @override
  int get checkinId;
  @override
  Branch get branch;
  @override
  double get pointsEarned;
  @override
  double get newBalance;
  @override
  CheckinStreak get streak;
  @override
  DateTime get checkedInAt;

  /// Create a copy of CheckinResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckinResultImplCopyWith<_$CheckinResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
