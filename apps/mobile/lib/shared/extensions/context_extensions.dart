import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Convenient extensions on BuildContext for common lookups.
extension ContextExtensions on BuildContext {
  /// Access the current ThemeData.
  ThemeData get theme => Theme.of(this);

  /// Access the current TextTheme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Access the current ColorScheme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access the localized strings.
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Access the MediaQuery data.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen width.
  double get screenWidth => mediaQuery.size.width;

  /// Screen height.
  double get screenHeight => mediaQuery.size.height;

  /// Whether the device is in dark mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Show a snackbar with the given message.
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Show an error snackbar.
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
      ),
    );
  }

  /// Show a success snackbar.
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
