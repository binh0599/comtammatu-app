import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_model.freezed.dart';
part 'reward_model.g.dart';

/// Reward available for points redemption.
@freezed
class Reward with _$Reward {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Reward({
    required int id,
    required String name,
    required String description,

    /// Points required to redeem this reward.
    required int pointsRequired,

    /// Category: `'discount'`, `'free_item'`, `'free_delivery'`, etc.
    required String category,

    /// Whether this reward is currently available.
    @Default(true) bool isAvailable,

    /// Minimum tier required (e.g. `'bronze'`, `'silver'`, `'gold'`).
    String? minTier,

    /// URL of the reward image (optional).
    String? imageUrl,

    /// Stock remaining, null means unlimited.
    int? stockRemaining,
  }) = _Reward;

  const Reward._();

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  /// Icon based on category.
  String get categoryIcon {
    return switch (category) {
      'discount' => 'local_offer',
      'free_item' => 'restaurant',
      'free_delivery' => 'delivery_dining',
      'free_drink' => 'local_drink',
      _ => 'card_giftcard',
    };
  }
}
