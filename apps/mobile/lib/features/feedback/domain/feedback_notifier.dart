import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/feedback_repository.dart';
import 'feedback_state.dart';

/// Manages feedback submission state.
class FeedbackNotifier extends StateNotifier<FeedbackState> {
  FeedbackNotifier({required FeedbackRepository feedbackRepository})
      : _feedbackRepository = feedbackRepository,
        super(const FeedbackInitial());

  final FeedbackRepository _feedbackRepository;

  /// Submit feedback for a completed order.
  Future<void> submitFeedback({
    required int orderId,
    required int rating,
    required String comment,
    List<String> tags = const [],
  }) async {
    state = const FeedbackLoading();
    try {
      await _feedbackRepository.submitFeedback(
        orderId: orderId,
        rating: rating,
        comment: comment,
        tags: tags,
      );
      state = const FeedbackSubmitted();
    } catch (e) {
      state = FeedbackError(message: e.toString());
    }
  }

  /// Reset state back to initial (e.g. when navigating away).
  void reset() {
    state = const FeedbackInitial();
  }
}

final feedbackNotifierProvider =
    StateNotifierProvider.autoDispose<FeedbackNotifier, FeedbackState>((ref) {
  final repo = ref.watch(feedbackRepositoryProvider);
  return FeedbackNotifier(feedbackRepository: repo);
});
