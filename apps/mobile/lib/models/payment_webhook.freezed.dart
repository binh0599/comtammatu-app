// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_webhook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentWebhook _$PaymentWebhookFromJson(Map<String, dynamic> json) {
  return _PaymentWebhook.fromJson(json);
}

/// @nodoc
mixin _$PaymentWebhook {
  String get provider => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get externalRef => throw _privateConstructorUsedError;
  Map<String, dynamic>? get headers => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  bool? get signatureValid => throw _privateConstructorUsedError;
  int? get httpStatus => throw _privateConstructorUsedError;
  bool get processed => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int? get paymentId => throw _privateConstructorUsedError;
  int? get orderId => throw _privateConstructorUsedError;
  DateTime? get receivedAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentWebhook to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentWebhook
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentWebhookCopyWith<PaymentWebhook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentWebhookCopyWith<$Res> {
  factory $PaymentWebhookCopyWith(
          PaymentWebhook value, $Res Function(PaymentWebhook) then) =
      _$PaymentWebhookCopyWithImpl<$Res, PaymentWebhook>;
  @useResult
  $Res call(
      {String provider,
      String eventType,
      Map<String, dynamic> payload,
      int? id,
      String? externalRef,
      Map<String, dynamic>? headers,
      String? signature,
      bool? signatureValid,
      int? httpStatus,
      bool processed,
      String? errorMessage,
      int? paymentId,
      int? orderId,
      DateTime? receivedAt});
}

/// @nodoc
class _$PaymentWebhookCopyWithImpl<$Res, $Val extends PaymentWebhook>
    implements $PaymentWebhookCopyWith<$Res> {
  _$PaymentWebhookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentWebhook
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? eventType = null,
    Object? payload = null,
    Object? id = freezed,
    Object? externalRef = freezed,
    Object? headers = freezed,
    Object? signature = freezed,
    Object? signatureValid = freezed,
    Object? httpStatus = freezed,
    Object? processed = null,
    Object? errorMessage = freezed,
    Object? paymentId = freezed,
    Object? orderId = freezed,
    Object? receivedAt = freezed,
  }) {
    return _then(_value.copyWith(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalRef: freezed == externalRef
          ? _value.externalRef
          : externalRef // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      signatureValid: freezed == signatureValid
          ? _value.signatureValid
          : signatureValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      httpStatus: freezed == httpStatus
          ? _value.httpStatus
          : httpStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      processed: null == processed
          ? _value.processed
          : processed // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentId: freezed == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentWebhookImplCopyWith<$Res>
    implements $PaymentWebhookCopyWith<$Res> {
  factory _$$PaymentWebhookImplCopyWith(_$PaymentWebhookImpl value,
          $Res Function(_$PaymentWebhookImpl) then) =
      __$$PaymentWebhookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String provider,
      String eventType,
      Map<String, dynamic> payload,
      int? id,
      String? externalRef,
      Map<String, dynamic>? headers,
      String? signature,
      bool? signatureValid,
      int? httpStatus,
      bool processed,
      String? errorMessage,
      int? paymentId,
      int? orderId,
      DateTime? receivedAt});
}

/// @nodoc
class __$$PaymentWebhookImplCopyWithImpl<$Res>
    extends _$PaymentWebhookCopyWithImpl<$Res, _$PaymentWebhookImpl>
    implements _$$PaymentWebhookImplCopyWith<$Res> {
  __$$PaymentWebhookImplCopyWithImpl(
      _$PaymentWebhookImpl _value, $Res Function(_$PaymentWebhookImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentWebhook
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? eventType = null,
    Object? payload = null,
    Object? id = freezed,
    Object? externalRef = freezed,
    Object? headers = freezed,
    Object? signature = freezed,
    Object? signatureValid = freezed,
    Object? httpStatus = freezed,
    Object? processed = null,
    Object? errorMessage = freezed,
    Object? paymentId = freezed,
    Object? orderId = freezed,
    Object? receivedAt = freezed,
  }) {
    return _then(_$PaymentWebhookImpl(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      externalRef: freezed == externalRef
          ? _value.externalRef
          : externalRef // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      signatureValid: freezed == signatureValid
          ? _value.signatureValid
          : signatureValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      httpStatus: freezed == httpStatus
          ? _value.httpStatus
          : httpStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      processed: null == processed
          ? _value.processed
          : processed // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentId: freezed == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PaymentWebhookImpl extends _PaymentWebhook {
  const _$PaymentWebhookImpl(
      {required this.provider,
      required this.eventType,
      required final Map<String, dynamic> payload,
      this.id,
      this.externalRef,
      final Map<String, dynamic>? headers,
      this.signature,
      this.signatureValid,
      this.httpStatus,
      this.processed = false,
      this.errorMessage,
      this.paymentId,
      this.orderId,
      this.receivedAt})
      : _payload = payload,
        _headers = headers,
        super._();

  factory _$PaymentWebhookImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentWebhookImplFromJson(json);

  @override
  final String provider;
  @override
  final String eventType;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final int? id;
  @override
  final String? externalRef;
  final Map<String, dynamic>? _headers;
  @override
  Map<String, dynamic>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? signature;
  @override
  final bool? signatureValid;
  @override
  final int? httpStatus;
  @override
  @JsonKey()
  final bool processed;
  @override
  final String? errorMessage;
  @override
  final int? paymentId;
  @override
  final int? orderId;
  @override
  final DateTime? receivedAt;

  @override
  String toString() {
    return 'PaymentWebhook(provider: $provider, eventType: $eventType, payload: $payload, id: $id, externalRef: $externalRef, headers: $headers, signature: $signature, signatureValid: $signatureValid, httpStatus: $httpStatus, processed: $processed, errorMessage: $errorMessage, paymentId: $paymentId, orderId: $orderId, receivedAt: $receivedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentWebhookImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.externalRef, externalRef) ||
                other.externalRef == externalRef) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.signatureValid, signatureValid) ||
                other.signatureValid == signatureValid) &&
            (identical(other.httpStatus, httpStatus) ||
                other.httpStatus == httpStatus) &&
            (identical(other.processed, processed) ||
                other.processed == processed) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      provider,
      eventType,
      const DeepCollectionEquality().hash(_payload),
      id,
      externalRef,
      const DeepCollectionEquality().hash(_headers),
      signature,
      signatureValid,
      httpStatus,
      processed,
      errorMessage,
      paymentId,
      orderId,
      receivedAt);

  /// Create a copy of PaymentWebhook
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentWebhookImplCopyWith<_$PaymentWebhookImpl> get copyWith =>
      __$$PaymentWebhookImplCopyWithImpl<_$PaymentWebhookImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentWebhookImplToJson(
      this,
    );
  }
}

abstract class _PaymentWebhook extends PaymentWebhook {
  const factory _PaymentWebhook(
      {required final String provider,
      required final String eventType,
      required final Map<String, dynamic> payload,
      final int? id,
      final String? externalRef,
      final Map<String, dynamic>? headers,
      final String? signature,
      final bool? signatureValid,
      final int? httpStatus,
      final bool processed,
      final String? errorMessage,
      final int? paymentId,
      final int? orderId,
      final DateTime? receivedAt}) = _$PaymentWebhookImpl;
  const _PaymentWebhook._() : super._();

  factory _PaymentWebhook.fromJson(Map<String, dynamic> json) =
      _$PaymentWebhookImpl.fromJson;

  @override
  String get provider;
  @override
  String get eventType;
  @override
  Map<String, dynamic> get payload;
  @override
  int? get id;
  @override
  String? get externalRef;
  @override
  Map<String, dynamic>? get headers;
  @override
  String? get signature;
  @override
  bool? get signatureValid;
  @override
  int? get httpStatus;
  @override
  bool get processed;
  @override
  String? get errorMessage;
  @override
  int? get paymentId;
  @override
  int? get orderId;
  @override
  DateTime? get receivedAt;

  /// Create a copy of PaymentWebhook
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentWebhookImplCopyWith<_$PaymentWebhookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
