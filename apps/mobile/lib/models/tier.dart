import 'package:freezed_annotation/freezed_annotation.dart';

part 'tier.freezed.dart';
part 'tier.g.dart';

@freezed
class TierProgress with _$TierProgress {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TierProgress({
    required String name,
    required String tierCode,
    required int minPoints,
    required int pointsNeeded,
    required double progressPercent,
  }) = _TierProgress;

  factory TierProgress.fromJson(Map<String, dynamic> json) =>
      _$TierProgressFromJson(json);
}

@freezed
class Tier with _$Tier {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Tier({
    required int id,
    required String name,
    required String tierCode,
    required double pointMultiplier,
    required double cashbackPercent,
    required List<String> benefits,
    TierProgress? nextTier,
  }) = _Tier;

  factory Tier.fromJson(Map<String, dynamic> json) => _$TierFromJson(json);
}
