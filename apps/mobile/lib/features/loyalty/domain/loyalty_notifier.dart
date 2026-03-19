import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/reward_model.dart';
import '../data/loyalty_repository.dart';
import 'loyalty_state.dart';

/// Manages loyalty dashboard state.
class LoyaltyNotifier extends StateNotifier<LoyaltyState> {
  LoyaltyNotifier({required LoyaltyRepository loyaltyRepository})
      : _loyaltyRepository = loyaltyRepository,
        super(const LoyaltyInitial());

  final LoyaltyRepository _loyaltyRepository;

  /// Fetch loyalty dashboard data.
  Future<void> loadDashboard() async {
    state = const LoyaltyLoading();
    try {
      final dashboard = await _loyaltyRepository.getDashboard();
      state = LoyaltyLoaded(dashboard: dashboard);
    } catch (e) {
      state = LoyaltyError(message: e.toString());
    }
  }

  /// Verify check-in at a branch.
  Future<void> checkIn({
    required int branchId,
    String? qrCode,
    double? latitude,
    double? longitude,
  }) async {
    try {
      await _loyaltyRepository.verifyCheckin(
        branchId: branchId,
        qrCode: qrCode,
        latitude: latitude,
        longitude: longitude,
      );
      // Reload dashboard to reflect new points
      await loadDashboard();
    } catch (e) {
      // Keep current state but surface error
      rethrow;
    }
  }

  /// Redeem points for a reward (per API Contract §2.3).
  Future<RedemptionResult> redeemPoints({
    required int rewardId,
    required int points,
  }) async {
    try {
      final result = await _loyaltyRepository.redeemPoints(
        rewardId: rewardId,
        points: points,
      );
      await loadDashboard();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}

final loyaltyNotifierProvider =
    StateNotifierProvider.autoDispose<LoyaltyNotifier, LoyaltyState>((ref) {
  final repo = ref.watch(loyaltyRepositoryProvider);
  return LoyaltyNotifier(loyaltyRepository: repo);
});

/// Provider that fetches available rewards for redemption.
final availableRewardsProvider = FutureProvider.autoDispose<List<Reward>>((ref) async {
  final repo = ref.watch(loyaltyRepositoryProvider);
  return repo.getAvailableRewards();
});
