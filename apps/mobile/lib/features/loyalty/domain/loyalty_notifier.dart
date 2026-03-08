import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    required String qrPayload,
    required String deviceFingerprint,
    double? latitude,
    double? longitude,
  }) async {
    try {
      await _loyaltyRepository.verifyCheckIn(
        qrPayload: qrPayload,
        deviceFingerprint: deviceFingerprint,
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

  /// Redeem points for a reward.
  Future<void> redeemPoints({
    required int rewardId,
    required int points,
  }) async {
    try {
      await _loyaltyRepository.redeemPoints(
        rewardId: rewardId,
        points: points,
      );
      await loadDashboard();
    } catch (e) {
      rethrow;
    }
  }
}

final loyaltyNotifierProvider =
    StateNotifierProvider<LoyaltyNotifier, LoyaltyState>((ref) {
  final repo = ref.watch(loyaltyRepositoryProvider);
  return LoyaltyNotifier(loyaltyRepository: repo);
});
