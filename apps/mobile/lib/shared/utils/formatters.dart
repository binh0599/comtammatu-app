import 'package:intl/intl.dart';

/// Utility class for Vietnamese currency, date, and number formatting.
class Formatters {
  Formatters._();

  /// Vietnamese Dong currency formatter.
  static final _currencyFormat = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
    decimalDigits: 0,
  );

  /// Format amount as Vietnamese currency (e.g., 150.000đ).
  static String currency(num amount) {
    return _currencyFormat.format(amount);
  }

  /// Format number with dot separators (e.g., 1.000.000).
  static String number(num value) {
    return NumberFormat('#,###', 'vi_VN').format(value);
  }

  /// Format date as dd/MM/yyyy (Vietnamese standard).
  static String date(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  /// Format date and time as dd/MM/yyyy HH:mm.
  static String dateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  /// Format time as HH:mm.
  static String time(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Format relative time (e.g., "2 phút trước", "Hôm qua").
  static String relativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return date(dateTime);
    }
  }

  /// Format phone number with spaces (e.g., 0901 234 567).
  static String phone(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    }
    return phoneNumber;
  }

  /// Format loyalty points (e.g., 1.500 điểm).
  static String points(int points) {
    return '${number(points)} điểm';
  }

  /// Alias for number() — used across screens.
  static String formatNumber(num value) => number(value);

  /// Alias for dateTime() — used across screens.
  static String formatDateTime(DateTime dt) => dateTime(dt);

  /// Alias for currency() — used across screens.
  static String formatCurrency(num amount) => currency(amount);
}
