import 'package:freezed_annotation/freezed_annotation.dart';

part 'einvoice_provider.freezed.dart';
part 'einvoice_provider.g.dart';

@freezed
class EinvoiceProvider with _$EinvoiceProvider {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EinvoiceProvider({
    required int brandId,
    required String provider,
    int? id,
    String? apiEndpoint,
    String? vaultRef,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EinvoiceProvider;

  const EinvoiceProvider._();

  factory EinvoiceProvider.fromJson(Map<String, dynamic> json) =>
      _$EinvoiceProviderFromJson(json);

  bool get isViettel => provider == 'viettel';
  bool get isVnpt => provider == 'vnpt';
  bool get isBkav => provider == 'bkav';
}
