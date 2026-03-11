import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class Address with _$Address {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Address({
    required String label, // 'home' | 'work' | 'other'
    required String addressLine,
    required String ward,
    required String district,
    required String city,
    int? id,
    @Default(false) bool isDefault,
    double? lat,
    double? lng,
  }) = _Address;

  const Address._();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// Full formatted address string.
  String get fullAddress => '$addressLine, $ward, $district, $city';

  /// Vietnamese display label.
  String get displayLabel {
    switch (label) {
      case 'home':
        return 'Nhà';
      case 'work':
        return 'Công ty';
      default:
        return 'Khác';
    }
  }
}
