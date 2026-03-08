import '../../../models/loyalty_dashboard.dart';

/// State for the loyalty feature.
sealed class LoyaltyState {
  const LoyaltyState();
}

class LoyaltyInitial extends LoyaltyState {
  const LoyaltyInitial();
}

class LoyaltyLoading extends LoyaltyState {
  const LoyaltyLoading();
}

class LoyaltyLoaded extends LoyaltyState {
  const LoyaltyLoaded({required this.dashboard});
  final LoyaltyDashboard dashboard;
}

class LoyaltyError extends LoyaltyState {
  const LoyaltyError({required this.message});
  final String message;
}
