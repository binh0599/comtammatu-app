import 'package:freezed_annotation/freezed_annotation.dart';

part 'einvoice_config.freezed.dart';
part 'einvoice_config.g.dart';

@freezed
class EinvoiceConfig with _$EinvoiceConfig {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EinvoiceConfig({
    required int brandId,
    required int providerId,
    required String taxCode,
    int? id,
    String? serialPrefix,
    @Default('01GTKT') String templateCode,
    @Default(false) bool autoSubmit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EinvoiceConfig;

  const EinvoiceConfig._();

  factory EinvoiceConfig.fromJson(Map<String, dynamic> json) =>
      _$EinvoiceConfigFromJson(json);
}
