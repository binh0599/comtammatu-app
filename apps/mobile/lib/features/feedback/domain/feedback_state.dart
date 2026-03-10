/// State for the feedback submission feature.
sealed class FeedbackState {
  const FeedbackState();
}

class FeedbackInitial extends FeedbackState {
  const FeedbackInitial();
}

class FeedbackLoading extends FeedbackState {
  const FeedbackLoading();
}

class FeedbackSubmitted extends FeedbackState {
  const FeedbackSubmitted();
}

class FeedbackError extends FeedbackState {
  const FeedbackError({required this.message});
  final String message;
}
