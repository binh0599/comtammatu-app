// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loyalty_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoyaltyStats _$LoyaltyStatsFromJson(Map<String, dynamic> json) {
  return _LoyaltyStats.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyStats {
  int get totalCheckinsThisMonth => throw _privateConstructorUsedError;
  int get totalOrdersThisMonth => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;

  /// Serializes this LoyaltyStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyStatsCopyWith<LoyaltyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyStatsCopyWith<$Res> {
  factory $LoyaltyStatsCopyWith(
          LoyaltyStats value, $Res Function(LoyaltyStats) then) =
      _$LoyaltyStatsCopyWithImpl<$Res, LoyaltyStats>;
  @useResult
  $Res call(
      {int totalCheckinsThisMonth, int totalOrdersThisMonth, int streakDays});
}

/// @nodoc
class _$LoyaltyStatsCopyWithImpl<$Res, $Val extends LoyaltyStats>
    implements $LoyaltyStatsCopyWith<$Res> {
  _$LoyaltyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCheckinsThisMonth = null,
    Object? totalOrdersThisMonth = null,
    Object? streakDays = null,
  }) {
    return _then(_value.copyWith(
      totalCheckinsThisMonth: null == totalCheckinsThisMonth
          ? _value.totalCheckinsThisMonth
          : totalCheckinsThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      totalOrdersThisMonth: null == totalOrdersThisMonth
          ? _value.totalOrdersThisMonth
          : totalOrdersThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoyaltyStatsImplCopyWith<$Res>
    implements $LoyaltyStatsCopyWith<$Res> {
  factory _$$LoyaltyStatsImplCopyWith(
          _$LoyaltyStatsImpl value, $Res Function(_$LoyaltyStatsImpl) then) =
      __$$LoyaltyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalCheckinsThisMonth, int totalOrdersThisMonth, int streakDays});
}

/// @nodoc
class __$$LoyaltyStatsImplCopyWithImpl<$Res>
    extends _$LoyaltyStatsCopyWithImpl<$Res, _$LoyaltyStatsImpl>
    implements _$$LoyaltyStatsImplCopyWith<$Res> {
  __$$LoyaltyStatsImplCopyWithImpl(
      _$LoyaltyStatsImpl _value, $Res Function(_$LoyaltyStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoyaltyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCheckinsThisMonth = null,
    Object? totalOrdersThisMonth = null,
    Object? streakDays = null,
  }) {
    return _then(_$LoyaltyStatsImpl(
      totalCheckinsThisMonth: null == totalCheckinsThisMonth
          ? _value.totalCheckinsThisMonth
          : totalCheckinsThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      totalOrdersThisMonth: null == totalOrdersThisMonth
          ? _value.totalOrdersThisMonth
          : totalOrdersThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$LoyaltyStatsImpl implements _LoyaltyStats {
  const _$LoyaltyStatsImpl(
      {required this.totalCheckinsThisMonth,
      required this.totalOrdersThisMonth,
      required this.streakDays});

  factory _$LoyaltyStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyStatsImplFromJson(json);

  @override
  final int totalCheckinsThisMonth;
  @override
  final int totalOrdersThisMonth;
  @override
  final int streakDays;

  @override
  String toString() {
    return 'LoyaltyStats(totalCheckinsThisMonth: $totalCheckinsThisMonth, totalOrdersThisMonth: $totalOrdersThisMonth, streakDays: $streakDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyStatsImpl &&
            (identical(other.totalCheckinsThisMonth, totalCheckinsThisMonth) ||
                other.totalCheckinsThisMonth == totalCheckinsThisMonth) &&
            (identical(other.totalOrdersThisMonth, totalOrdersThisMonth) ||
                other.totalOrdersThisMonth == totalOrdersThisMonth) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalCheckinsThisMonth, totalOrdersThisMonth, streakDays);

  /// Create a copy of LoyaltyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyStatsImplCopyWith<_$LoyaltyStatsImpl> get copyWith =>
      __$$LoyaltyStatsImplCopyWithImpl<_$LoyaltyStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyStatsImplToJson(
      this,
    );
  }
}

abstract class _LoyaltyStats implements LoyaltyStats {
  const factory _LoyaltyStats(
      {required final int totalCheckinsThisMonth,
      required final int totalOrdersThisMonth,
      required final int streakDays}) = _$LoyaltyStatsImpl;

  factory _LoyaltyStats.fromJson(Map<String, dynamic> json) =
      _$LoyaltyStatsImpl.fromJson;

  @override
  int get totalCheckinsThisMonth;
  @override
  int get totalOrdersThisMonth;
  @override
  int get streakDays;

  /// Create a copy of LoyaltyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyStatsImplCopyWith<_$LoyaltyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoyaltyDashboard _$LoyaltyDashboardFromJson(Map<String, dynamic> json) {
  return _LoyaltyDashboard.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyDashboard {
  LoyaltyMember get member => throw _privateConstructorUsedError;
  Tier get tier => throw _privateConstructorUsedError;
  List<PointTransaction> get recentTransactions =>
      throw _privateConstructorUsedError;
  List<Promotion> get activePromotions => throw _privateConstructorUsedError;
  LoyaltyStats get stats => throw _privateConstructorUsedError;

  /// Serializes this LoyaltyDashboard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyDashboardCopyWith<LoyaltyDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyDashboardCopyWith<$Res> {
  factory $LoyaltyDashboardCopyWith(
          LoyaltyDashboard value, $Res Function(LoyaltyDashboard) then) =
      _$LoyaltyDashboardCopyWithImpl<$Res, LoyaltyDashboard>;
  @useResult
  $Res call(
      {LoyaltyMember member,
      Tier tier,
      List<PointTransaction> recentTransactions,
      List<Promotion> activePromotions,
      LoyaltyStats stats});

  $LoyaltyMemberCopyWith<$Res> get member;
  $TierCopyWith<$Res> get tier;
  $LoyaltyStatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$LoyaltyDashboardCopyWithImpl<$Res, $Val extends LoyaltyDashboard>
    implements $LoyaltyDashboardCopyWith<$Res> {
  _$LoyaltyDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? member = null,
    Object? tier = null,
    Object? recentTransactions = null,
    Object? activePromotions = null,
    Object? stats = null,
  }) {
    return _then(_value.copyWith(
      member: null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as LoyaltyMember,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as Tier,
      recentTransactions: null == recentTransactions
          ? _value.recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<PointTransaction>,
      activePromotions: null == activePromotions
          ? _value.activePromotions
          : activePromotions // ignore: cast_nullable_to_non_nullable
              as List<Promotion>,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as LoyaltyStats,
    ) as $Val);
  }

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoyaltyMemberCopyWith<$Res> get member {
    return $LoyaltyMemberCopyWith<$Res>(_value.member, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TierCopyWith<$Res> get tier {
    return $TierCopyWith<$Res>(_value.tier, (value) {
      return _then(_value.copyWith(tier: value) as $Val);
    });
  }

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoyaltyStatsCopyWith<$Res> get stats {
    return $LoyaltyStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoyaltyDashboardImplCopyWith<$Res>
    implements $LoyaltyDashboardCopyWith<$Res> {
  factory _$$LoyaltyDashboardImplCopyWith(_$LoyaltyDashboardImpl value,
          $Res Function(_$LoyaltyDashboardImpl) then) =
      __$$LoyaltyDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoyaltyMember member,
      Tier tier,
      List<PointTransaction> recentTransactions,
      List<Promotion> activePromotions,
      LoyaltyStats stats});

  @override
  $LoyaltyMemberCopyWith<$Res> get member;
  @override
  $TierCopyWith<$Res> get tier;
  @override
  $LoyaltyStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$LoyaltyDashboardImplCopyWithImpl<$Res>
    extends _$LoyaltyDashboardCopyWithImpl<$Res, _$LoyaltyDashboardImpl>
    implements _$$LoyaltyDashboardImplCopyWith<$Res> {
  __$$LoyaltyDashboardImplCopyWithImpl(_$LoyaltyDashboardImpl _value,
      $Res Function(_$LoyaltyDashboardImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? member = null,
    Object? tier = null,
    Object? recentTransactions = null,
    Object? activePromotions = null,
    Object? stats = null,
  }) {
    return _then(_$LoyaltyDashboardImpl(
      member: null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as LoyaltyMember,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as Tier,
      recentTransactions: null == recentTransactions
          ? _value._recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<PointTransaction>,
      activePromotions: null == activePromotions
          ? _value._activePromotions
          : activePromotions // ignore: cast_nullable_to_non_nullable
              as List<Promotion>,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as LoyaltyStats,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$LoyaltyDashboardImpl implements _LoyaltyDashboard {
  const _$LoyaltyDashboardImpl(
      {required this.member,
      required this.tier,
      required final List<PointTransaction> recentTransactions,
      required final List<Promotion> activePromotions,
      required this.stats})
      : _recentTransactions = recentTransactions,
        _activePromotions = activePromotions;

  factory _$LoyaltyDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyDashboardImplFromJson(json);

  @override
  final LoyaltyMember member;
  @override
  final Tier tier;
  final List<PointTransaction> _recentTransactions;
  @override
  List<PointTransaction> get recentTransactions {
    if (_recentTransactions is EqualUnmodifiableListView)
      return _recentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransactions);
  }

  final List<Promotion> _activePromotions;
  @override
  List<Promotion> get activePromotions {
    if (_activePromotions is EqualUnmodifiableListView)
      return _activePromotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activePromotions);
  }

  @override
  final LoyaltyStats stats;

  @override
  String toString() {
    return 'LoyaltyDashboard(member: $member, tier: $tier, recentTransactions: $recentTransactions, activePromotions: $activePromotions, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyDashboardImpl &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            const DeepCollectionEquality()
                .equals(other._recentTransactions, _recentTransactions) &&
            const DeepCollectionEquality()
                .equals(other._activePromotions, _activePromotions) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      member,
      tier,
      const DeepCollectionEquality().hash(_recentTransactions),
      const DeepCollectionEquality().hash(_activePromotions),
      stats);

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyDashboardImplCopyWith<_$LoyaltyDashboardImpl> get copyWith =>
      __$$LoyaltyDashboardImplCopyWithImpl<_$LoyaltyDashboardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyDashboardImplToJson(
      this,
    );
  }
}

abstract class _LoyaltyDashboard implements LoyaltyDashboard {
  const factory _LoyaltyDashboard(
      {required final LoyaltyMember member,
      required final Tier tier,
      required final List<PointTransaction> recentTransactions,
      required final List<Promotion> activePromotions,
      required final LoyaltyStats stats}) = _$LoyaltyDashboardImpl;

  factory _LoyaltyDashboard.fromJson(Map<String, dynamic> json) =
      _$LoyaltyDashboardImpl.fromJson;

  @override
  LoyaltyMember get member;
  @override
  Tier get tier;
  @override
  List<PointTransaction> get recentTransactions;
  @override
  List<Promotion> get activePromotions;
  @override
  LoyaltyStats get stats;

  /// Create a copy of LoyaltyDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyDashboardImplCopyWith<_$LoyaltyDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
