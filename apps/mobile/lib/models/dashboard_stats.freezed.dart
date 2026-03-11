// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyRevenue _$DailyRevenueFromJson(Map<String, dynamic> json) {
  return _DailyRevenue.fromJson(json);
}

/// @nodoc
mixin _$DailyRevenue {
  String get day => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  /// Serializes this DailyRevenue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyRevenue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyRevenueCopyWith<DailyRevenue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRevenueCopyWith<$Res> {
  factory $DailyRevenueCopyWith(
          DailyRevenue value, $Res Function(DailyRevenue) then) =
      _$DailyRevenueCopyWithImpl<$Res, DailyRevenue>;
  @useResult
  $Res call({String day, int amount});
}

/// @nodoc
class _$DailyRevenueCopyWithImpl<$Res, $Val extends DailyRevenue>
    implements $DailyRevenueCopyWith<$Res> {
  _$DailyRevenueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyRevenue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyRevenueImplCopyWith<$Res>
    implements $DailyRevenueCopyWith<$Res> {
  factory _$$DailyRevenueImplCopyWith(
          _$DailyRevenueImpl value, $Res Function(_$DailyRevenueImpl) then) =
      __$$DailyRevenueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, int amount});
}

/// @nodoc
class __$$DailyRevenueImplCopyWithImpl<$Res>
    extends _$DailyRevenueCopyWithImpl<$Res, _$DailyRevenueImpl>
    implements _$$DailyRevenueImplCopyWith<$Res> {
  __$$DailyRevenueImplCopyWithImpl(
      _$DailyRevenueImpl _value, $Res Function(_$DailyRevenueImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyRevenue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? amount = null,
  }) {
    return _then(_$DailyRevenueImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DailyRevenueImpl implements _DailyRevenue {
  const _$DailyRevenueImpl({this.day = '', this.amount = 0});

  factory _$DailyRevenueImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRevenueImplFromJson(json);

  @override
  @JsonKey()
  final String day;
  @override
  @JsonKey()
  final int amount;

  @override
  String toString() {
    return 'DailyRevenue(day: $day, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRevenueImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, amount);

  /// Create a copy of DailyRevenue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRevenueImplCopyWith<_$DailyRevenueImpl> get copyWith =>
      __$$DailyRevenueImplCopyWithImpl<_$DailyRevenueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRevenueImplToJson(
      this,
    );
  }
}

abstract class _DailyRevenue implements DailyRevenue {
  const factory _DailyRevenue({final String day, final int amount}) =
      _$DailyRevenueImpl;

  factory _DailyRevenue.fromJson(Map<String, dynamic> json) =
      _$DailyRevenueImpl.fromJson;

  @override
  String get day;
  @override
  int get amount;

  /// Create a copy of DailyRevenue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyRevenueImplCopyWith<_$DailyRevenueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PopularItem _$PopularItemFromJson(Map<String, dynamic> json) {
  return _PopularItem.fromJson(json);
}

/// @nodoc
mixin _$PopularItem {
  String get name => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get revenue => throw _privateConstructorUsedError;

  /// Serializes this PopularItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopularItemCopyWith<PopularItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularItemCopyWith<$Res> {
  factory $PopularItemCopyWith(
          PopularItem value, $Res Function(PopularItem) then) =
      _$PopularItemCopyWithImpl<$Res, PopularItem>;
  @useResult
  $Res call({String name, int count, int revenue});
}

/// @nodoc
class _$PopularItemCopyWithImpl<$Res, $Val extends PopularItem>
    implements $PopularItemCopyWith<$Res> {
  _$PopularItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
    Object? revenue = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PopularItemImplCopyWith<$Res>
    implements $PopularItemCopyWith<$Res> {
  factory _$$PopularItemImplCopyWith(
          _$PopularItemImpl value, $Res Function(_$PopularItemImpl) then) =
      __$$PopularItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int count, int revenue});
}

/// @nodoc
class __$$PopularItemImplCopyWithImpl<$Res>
    extends _$PopularItemCopyWithImpl<$Res, _$PopularItemImpl>
    implements _$$PopularItemImplCopyWith<$Res> {
  __$$PopularItemImplCopyWithImpl(
      _$PopularItemImpl _value, $Res Function(_$PopularItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
    Object? revenue = null,
  }) {
    return _then(_$PopularItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PopularItemImpl implements _PopularItem {
  const _$PopularItemImpl({this.name = '', this.count = 0, this.revenue = 0});

  factory _$PopularItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PopularItemImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final int revenue;

  @override
  String toString() {
    return 'PopularItem(name: $name, count: $count, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, count, revenue);

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularItemImplCopyWith<_$PopularItemImpl> get copyWith =>
      __$$PopularItemImplCopyWithImpl<_$PopularItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PopularItemImplToJson(
      this,
    );
  }
}

abstract class _PopularItem implements PopularItem {
  const factory _PopularItem(
      {final String name,
      final int count,
      final int revenue}) = _$PopularItemImpl;

  factory _PopularItem.fromJson(Map<String, dynamic> json) =
      _$PopularItemImpl.fromJson;

  @override
  String get name;
  @override
  int get count;
  @override
  int get revenue;

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularItemImplCopyWith<_$PopularItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) {
  return _DashboardStats.fromJson(json);
}

/// @nodoc
mixin _$DashboardStats {
  int get todayRevenue => throw _privateConstructorUsedError;
  int get todayOrders => throw _privateConstructorUsedError;
  int get avgOrderValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_count')
  int get completedOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelled_count')
  int get cancelledOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_count')
  int get pendingOrders => throw _privateConstructorUsedError;
  List<DailyRevenue> get weeklyRevenue => throw _privateConstructorUsedError;
  List<PopularItem> get popularItems => throw _privateConstructorUsedError;
  int get customerCount => throw _privateConstructorUsedError;
  int get newCustomersToday => throw _privateConstructorUsedError;

  /// Serializes this DashboardStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStatsCopyWith<DashboardStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStatsCopyWith<$Res> {
  factory $DashboardStatsCopyWith(
          DashboardStats value, $Res Function(DashboardStats) then) =
      _$DashboardStatsCopyWithImpl<$Res, DashboardStats>;
  @useResult
  $Res call(
      {int todayRevenue,
      int todayOrders,
      int avgOrderValue,
      @JsonKey(name: 'completed_count') int completedOrders,
      @JsonKey(name: 'cancelled_count') int cancelledOrders,
      @JsonKey(name: 'pending_count') int pendingOrders,
      List<DailyRevenue> weeklyRevenue,
      List<PopularItem> popularItems,
      int customerCount,
      int newCustomersToday});
}

/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res, $Val extends DashboardStats>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todayRevenue = null,
    Object? todayOrders = null,
    Object? avgOrderValue = null,
    Object? completedOrders = null,
    Object? cancelledOrders = null,
    Object? pendingOrders = null,
    Object? weeklyRevenue = null,
    Object? popularItems = null,
    Object? customerCount = null,
    Object? newCustomersToday = null,
  }) {
    return _then(_value.copyWith(
      todayRevenue: null == todayRevenue
          ? _value.todayRevenue
          : todayRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      todayOrders: null == todayOrders
          ? _value.todayOrders
          : todayOrders // ignore: cast_nullable_to_non_nullable
              as int,
      avgOrderValue: null == avgOrderValue
          ? _value.avgOrderValue
          : avgOrderValue // ignore: cast_nullable_to_non_nullable
              as int,
      completedOrders: null == completedOrders
          ? _value.completedOrders
          : completedOrders // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledOrders: null == cancelledOrders
          ? _value.cancelledOrders
          : cancelledOrders // ignore: cast_nullable_to_non_nullable
              as int,
      pendingOrders: null == pendingOrders
          ? _value.pendingOrders
          : pendingOrders // ignore: cast_nullable_to_non_nullable
              as int,
      weeklyRevenue: null == weeklyRevenue
          ? _value.weeklyRevenue
          : weeklyRevenue // ignore: cast_nullable_to_non_nullable
              as List<DailyRevenue>,
      popularItems: null == popularItems
          ? _value.popularItems
          : popularItems // ignore: cast_nullable_to_non_nullable
              as List<PopularItem>,
      customerCount: null == customerCount
          ? _value.customerCount
          : customerCount // ignore: cast_nullable_to_non_nullable
              as int,
      newCustomersToday: null == newCustomersToday
          ? _value.newCustomersToday
          : newCustomersToday // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStatsImplCopyWith<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  factory _$$DashboardStatsImplCopyWith(_$DashboardStatsImpl value,
          $Res Function(_$DashboardStatsImpl) then) =
      __$$DashboardStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int todayRevenue,
      int todayOrders,
      int avgOrderValue,
      @JsonKey(name: 'completed_count') int completedOrders,
      @JsonKey(name: 'cancelled_count') int cancelledOrders,
      @JsonKey(name: 'pending_count') int pendingOrders,
      List<DailyRevenue> weeklyRevenue,
      List<PopularItem> popularItems,
      int customerCount,
      int newCustomersToday});
}

/// @nodoc
class __$$DashboardStatsImplCopyWithImpl<$Res>
    extends _$DashboardStatsCopyWithImpl<$Res, _$DashboardStatsImpl>
    implements _$$DashboardStatsImplCopyWith<$Res> {
  __$$DashboardStatsImplCopyWithImpl(
      _$DashboardStatsImpl _value, $Res Function(_$DashboardStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todayRevenue = null,
    Object? todayOrders = null,
    Object? avgOrderValue = null,
    Object? completedOrders = null,
    Object? cancelledOrders = null,
    Object? pendingOrders = null,
    Object? weeklyRevenue = null,
    Object? popularItems = null,
    Object? customerCount = null,
    Object? newCustomersToday = null,
  }) {
    return _then(_$DashboardStatsImpl(
      todayRevenue: null == todayRevenue
          ? _value.todayRevenue
          : todayRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      todayOrders: null == todayOrders
          ? _value.todayOrders
          : todayOrders // ignore: cast_nullable_to_non_nullable
              as int,
      avgOrderValue: null == avgOrderValue
          ? _value.avgOrderValue
          : avgOrderValue // ignore: cast_nullable_to_non_nullable
              as int,
      completedOrders: null == completedOrders
          ? _value.completedOrders
          : completedOrders // ignore: cast_nullable_to_non_nullable
              as int,
      cancelledOrders: null == cancelledOrders
          ? _value.cancelledOrders
          : cancelledOrders // ignore: cast_nullable_to_non_nullable
              as int,
      pendingOrders: null == pendingOrders
          ? _value.pendingOrders
          : pendingOrders // ignore: cast_nullable_to_non_nullable
              as int,
      weeklyRevenue: null == weeklyRevenue
          ? _value._weeklyRevenue
          : weeklyRevenue // ignore: cast_nullable_to_non_nullable
              as List<DailyRevenue>,
      popularItems: null == popularItems
          ? _value._popularItems
          : popularItems // ignore: cast_nullable_to_non_nullable
              as List<PopularItem>,
      customerCount: null == customerCount
          ? _value.customerCount
          : customerCount // ignore: cast_nullable_to_non_nullable
              as int,
      newCustomersToday: null == newCustomersToday
          ? _value.newCustomersToday
          : newCustomersToday // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DashboardStatsImpl implements _DashboardStats {
  const _$DashboardStatsImpl(
      {this.todayRevenue = 0,
      this.todayOrders = 0,
      this.avgOrderValue = 0,
      @JsonKey(name: 'completed_count') this.completedOrders = 0,
      @JsonKey(name: 'cancelled_count') this.cancelledOrders = 0,
      @JsonKey(name: 'pending_count') this.pendingOrders = 0,
      final List<DailyRevenue> weeklyRevenue = const [],
      final List<PopularItem> popularItems = const [],
      this.customerCount = 0,
      this.newCustomersToday = 0})
      : _weeklyRevenue = weeklyRevenue,
        _popularItems = popularItems;

  factory _$DashboardStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardStatsImplFromJson(json);

  @override
  @JsonKey()
  final int todayRevenue;
  @override
  @JsonKey()
  final int todayOrders;
  @override
  @JsonKey()
  final int avgOrderValue;
  @override
  @JsonKey(name: 'completed_count')
  final int completedOrders;
  @override
  @JsonKey(name: 'cancelled_count')
  final int cancelledOrders;
  @override
  @JsonKey(name: 'pending_count')
  final int pendingOrders;
  final List<DailyRevenue> _weeklyRevenue;
  @override
  @JsonKey()
  List<DailyRevenue> get weeklyRevenue {
    if (_weeklyRevenue is EqualUnmodifiableListView) return _weeklyRevenue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyRevenue);
  }

  final List<PopularItem> _popularItems;
  @override
  @JsonKey()
  List<PopularItem> get popularItems {
    if (_popularItems is EqualUnmodifiableListView) return _popularItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularItems);
  }

  @override
  @JsonKey()
  final int customerCount;
  @override
  @JsonKey()
  final int newCustomersToday;

  @override
  String toString() {
    return 'DashboardStats(todayRevenue: $todayRevenue, todayOrders: $todayOrders, avgOrderValue: $avgOrderValue, completedOrders: $completedOrders, cancelledOrders: $cancelledOrders, pendingOrders: $pendingOrders, weeklyRevenue: $weeklyRevenue, popularItems: $popularItems, customerCount: $customerCount, newCustomersToday: $newCustomersToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStatsImpl &&
            (identical(other.todayRevenue, todayRevenue) ||
                other.todayRevenue == todayRevenue) &&
            (identical(other.todayOrders, todayOrders) ||
                other.todayOrders == todayOrders) &&
            (identical(other.avgOrderValue, avgOrderValue) ||
                other.avgOrderValue == avgOrderValue) &&
            (identical(other.completedOrders, completedOrders) ||
                other.completedOrders == completedOrders) &&
            (identical(other.cancelledOrders, cancelledOrders) ||
                other.cancelledOrders == cancelledOrders) &&
            (identical(other.pendingOrders, pendingOrders) ||
                other.pendingOrders == pendingOrders) &&
            const DeepCollectionEquality()
                .equals(other._weeklyRevenue, _weeklyRevenue) &&
            const DeepCollectionEquality()
                .equals(other._popularItems, _popularItems) &&
            (identical(other.customerCount, customerCount) ||
                other.customerCount == customerCount) &&
            (identical(other.newCustomersToday, newCustomersToday) ||
                other.newCustomersToday == newCustomersToday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      todayRevenue,
      todayOrders,
      avgOrderValue,
      completedOrders,
      cancelledOrders,
      pendingOrders,
      const DeepCollectionEquality().hash(_weeklyRevenue),
      const DeepCollectionEquality().hash(_popularItems),
      customerCount,
      newCustomersToday);

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      __$$DashboardStatsImplCopyWithImpl<_$DashboardStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardStatsImplToJson(
      this,
    );
  }
}

abstract class _DashboardStats implements DashboardStats {
  const factory _DashboardStats(
      {final int todayRevenue,
      final int todayOrders,
      final int avgOrderValue,
      @JsonKey(name: 'completed_count') final int completedOrders,
      @JsonKey(name: 'cancelled_count') final int cancelledOrders,
      @JsonKey(name: 'pending_count') final int pendingOrders,
      final List<DailyRevenue> weeklyRevenue,
      final List<PopularItem> popularItems,
      final int customerCount,
      final int newCustomersToday}) = _$DashboardStatsImpl;

  factory _DashboardStats.fromJson(Map<String, dynamic> json) =
      _$DashboardStatsImpl.fromJson;

  @override
  int get todayRevenue;
  @override
  int get todayOrders;
  @override
  int get avgOrderValue;
  @override
  @JsonKey(name: 'completed_count')
  int get completedOrders;
  @override
  @JsonKey(name: 'cancelled_count')
  int get cancelledOrders;
  @override
  @JsonKey(name: 'pending_count')
  int get pendingOrders;
  @override
  List<DailyRevenue> get weeklyRevenue;
  @override
  List<PopularItem> get popularItems;
  @override
  int get customerCount;
  @override
  int get newCustomersToday;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
