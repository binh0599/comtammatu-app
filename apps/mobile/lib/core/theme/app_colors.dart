import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors — Cơm Tấm Má Tư warm palette
  static const Color primary = Color(0xFFD4442A); // Đỏ truyền thống
  static const Color primaryLight = Color(0xFFE8735E);
  static const Color primaryDark = Color(0xFFA03320);
  static const Color secondary = Color(0xFFF5A623); // Vàng ấm
  static const Color secondaryLight = Color(0xFFFFCA57);
  static const Color secondaryDark = Color(0xFFC87E00);

  // Loyalty Tier Colors
  static const Color tierBronze = Color(0xFFCD7F32);
  static const Color tierSilver = Color(0xFFC0C0C0);
  static const Color tierGold = Color(0xFFFFD700);
  static const Color tierDiamond = Color(0xFFB9F2FF);

  // Semantic Colors
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);

  // -- Light Mode Colors --
  static const Color background = Color(0xFFFAF8F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0DCD7);
  static const Color divider = Color(0xFFEDE9E4);

  // Text Colors (Light)
  static const Color textPrimary = Color(0xFF1C1917);
  static const Color textSecondary = Color(0xFF78716C);
  static const Color textHint = Color(0xFFA8A29E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // -- Dark Mode Colors --
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color darkBorder = Color(0xFF3A3A3A);
  static const Color darkDivider = Color(0xFF2E2E2E);

  // Text Colors (Dark)
  static const Color darkTextPrimary = Color(0xFFE8E4E0);
  static const Color darkTextSecondary = Color(0xFFA8A29E);
  static const Color darkTextHint = Color(0xFF78716C);
  static const Color darkTextOnPrimary = Color(0xFFFFFFFF);

  // Semantic Colors (Dark — slightly brighter for dark backgrounds)
  static const Color darkSuccess = Color(0xFF4CAF50);
  static const Color darkWarning = Color(0xFFFFCA28);
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkInfo = Color(0xFF42A5F5);
}
