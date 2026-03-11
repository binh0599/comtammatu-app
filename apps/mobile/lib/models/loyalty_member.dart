import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_member.freezed.dart';
part 'loyalty_member.g.dart';

@freezed
class LoyaltyMember with _$LoyaltyMember {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LoyaltyMember({
    required int id,
    required String fullName,
    required String phone,
    required double totalPoints,
    required double availablePoints,
    required double lifetimePoints,
    required int version,
    String? avatarUrl,
  }) = _LoyaltyMember;

  factory LoyaltyMember.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyMemberFromJson(json);
}
