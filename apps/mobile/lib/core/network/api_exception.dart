/// Exception class for API errors, matching the backend error contract.
class ApiException implements Exception {
  const ApiException({
    required this.code,
    required this.message,
    this.details,
    this.statusCode,
  });

  /// Error code from the API (e.g., 'AUTH_INVALID_TOKEN', 'VALIDATION_ERROR')
  final String code;

  /// Human-readable error message
  final String message;

  /// Optional additional details
  final dynamic details;

  /// HTTP status code
  final int? statusCode;

  factory ApiException.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    return ApiException(
      code: json['code'] as String? ?? 'UNKNOWN_ERROR',
      message: json['message'] as String? ?? 'Đã xảy ra lỗi không xác định',
      details: json['details'],
      statusCode: statusCode,
    );
  }

  factory ApiException.unknown([String? message]) {
    return ApiException(
      code: 'UNKNOWN_ERROR',
      message: message ?? 'Đã xảy ra lỗi không xác định',
    );
  }

  factory ApiException.network() {
    return const ApiException(
      code: 'NETWORK_ERROR',
      message: 'Không có kết nối mạng',
    );
  }

  factory ApiException.timeout() {
    return const ApiException(
      code: 'TIMEOUT_ERROR',
      message: 'Yêu cầu đã hết thời gian chờ',
    );
  }

  factory ApiException.unauthorized() {
    return const ApiException(
      code: 'AUTH_UNAUTHORIZED',
      message: 'Phiên đăng nhập đã hết hạn',
      statusCode: 401,
    );
  }

  factory ApiException.forbidden() {
    return const ApiException(
      code: 'AUTH_FORBIDDEN',
      message: 'Bạn không có quyền truy cập',
      statusCode: 403,
    );
  }

  factory ApiException.notFound() {
    return const ApiException(
      code: 'NOT_FOUND',
      message: 'Không tìm thấy dữ liệu',
      statusCode: 404,
    );
  }

  factory ApiException.rateLimited() {
    return const ApiException(
      code: 'RATE_LIMITED',
      message: 'Quá nhiều yêu cầu, vui lòng thử lại sau',
      statusCode: 429,
    );
  }

  bool get isAuthError =>
      code == 'AUTH_UNAUTHORIZED' || code == 'AUTH_FORBIDDEN';

  bool get isNetworkError => code == 'NETWORK_ERROR' || code == 'TIMEOUT_ERROR';

  @override
  String toString() => 'ApiException(code: $code, message: $message)';
}
