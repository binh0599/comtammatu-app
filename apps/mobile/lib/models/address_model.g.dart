// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      label: json['label'] as String,
      addressLine: json['address_line'] as String,
      ward: json['ward'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      id: (json['id'] as num?)?.toInt(),
      isDefault: json['is_default'] as bool? ?? false,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'address_line': instance.addressLine,
      'ward': instance.ward,
      'district': instance.district,
      'city': instance.city,
      'id': instance.id,
      'is_default': instance.isDefault,
      'lat': instance.lat,
      'lng': instance.lng,
    };
