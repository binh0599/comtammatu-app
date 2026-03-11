import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkin_result.freezed.dart';
part 'checkin_result.g.dart';

@freezed
class Branch with _$Branch {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Branch({
    required int id,
    required String name,
    required String address,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
}

@freezed
class CheckinStreak with _$CheckinStreak {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CheckinStreak({
    required int current,
    required int bonus,
    required int nextMilestone,
    required int nextMilestoneBonus,
  }) = _CheckinStreak;

  factory CheckinStreak.fromJson(Map<String, dynamic> json) =>
      _$CheckinStreakFromJson(json);
}

@freezed
class CheckinResult with _$CheckinResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CheckinResult({
    required int checkinId,
    required Branch branch,
    required double pointsEarned,
    required double newBalance,
    required CheckinStreak streak,
    required DateTime checkedInAt,
  }) = _CheckinResult;

  factory CheckinResult.fromJson(Map<String, dynamic> json) =>
      _$CheckinResultFromJson(json);
}
