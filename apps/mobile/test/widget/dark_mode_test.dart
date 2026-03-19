import 'package:comtammatu/core/theme/app_colors.dart';
import 'package:comtammatu/core/theme/app_theme.dart';
import 'package:comtammatu/core/theme/app_typography.dart';
import 'package:comtammatu/shared/widgets/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dark theme configuration', () {
    test('dark theme has correct brightness', () {
      final theme = AppTheme.dark;
      expect(theme.brightness, Brightness.dark);
    });

    test('dark theme uses dark scaffold background', () {
      final theme = AppTheme.dark;
      expect(theme.scaffoldBackgroundColor, AppColors.darkBackground);
    });

    test('dark theme uses dark surface for cards', () {
      final theme = AppTheme.dark;
      expect(theme.cardTheme.color, AppColors.darkSurface);
    });

    test('dark theme uses dark surface for app bar', () {
      final theme = AppTheme.dark;
      expect(theme.appBarTheme.backgroundColor, AppColors.darkSurface);
    });

    test('dark theme uses dark text theme', () {
      final theme = AppTheme.dark;
      expect(theme.textTheme.bodyLarge?.color, AppColors.darkTextPrimary);
    });

    test('dark theme preserves primary brand color', () {
      final theme = AppTheme.dark;
      expect(theme.colorScheme.primary, AppColors.primary);
    });

    test('dark text theme has sufficient contrast', () {
      // Dark text primary on dark background should have good contrast
      // darkTextPrimary: 0xFFE8E4E0, darkBackground: 0xFF121212
      // Relative luminance check — light text on dark bg
      expect(AppColors.darkTextPrimary.computeLuminance(),
          greaterThan(AppColors.darkBackground.computeLuminance()));
    });

    test('dark text secondary is readable on dark surface', () {
      expect(AppColors.darkTextSecondary.computeLuminance(),
          greaterThan(AppColors.darkSurface.computeLuminance()));
    });
  });

  group('Light theme configuration', () {
    test('light theme has correct brightness', () {
      final theme = AppTheme.light;
      expect(theme.brightness, Brightness.light);
    });

    test('light theme preserves primary brand color', () {
      final theme = AppTheme.light;
      expect(theme.colorScheme.primary, AppColors.primary);
    });
  });

  group('AppTypography dark text theme', () {
    test('dark text theme display styles use darkTextPrimary', () {
      final dark = AppTypography.darkTextTheme;
      expect(dark.displayLarge?.color, AppColors.darkTextPrimary);
      expect(dark.displayMedium?.color, AppColors.darkTextPrimary);
      expect(dark.displaySmall?.color, AppColors.darkTextPrimary);
    });

    test('dark text theme body styles use correct dark colors', () {
      final dark = AppTypography.darkTextTheme;
      expect(dark.bodyLarge?.color, AppColors.darkTextPrimary);
      expect(dark.bodyMedium?.color, AppColors.darkTextPrimary);
      expect(dark.bodySmall?.color, AppColors.darkTextSecondary);
    });

    test('dark and light text themes have same font sizes', () {
      final light = AppTypography.textTheme;
      final dark = AppTypography.darkTextTheme;
      expect(dark.bodyLarge?.fontSize, light.bodyLarge?.fontSize);
      expect(dark.titleMedium?.fontSize, light.titleMedium?.fontSize);
      expect(dark.headlineSmall?.fontSize, light.headlineSmall?.fontSize);
    });
  });

  group('Skeleton widgets render in dark theme', () {
    testWidgets('SkeletonShimmer renders in dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(
            body: SkeletonShimmer(
              child: SkeletonLine(width: 100, height: 14),
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonShimmer), findsOneWidget);
      expect(find.byType(SkeletonLine), findsOneWidget);
    });

    testWidgets('SkeletonCircle renders in dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(
            body: SkeletonShimmer(child: SkeletonCircle(size: 40)),
          ),
        ),
      );

      expect(find.byType(SkeletonCircle), findsOneWidget);
    });

    testWidgets('SkeletonCard renders in dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(
            body: SkeletonShimmer(child: SkeletonCard(height: 100)),
          ),
        ),
      );

      expect(find.byType(SkeletonCard), findsOneWidget);
    });

    testWidgets('MenuItemSkeleton renders without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: MenuItemSkeleton()),
        ),
      );

      expect(find.byType(MenuItemSkeleton), findsOneWidget);
    });

    testWidgets('LoyaltySkeleton renders without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: LoyaltySkeleton()),
        ),
      );

      expect(find.byType(LoyaltySkeleton), findsOneWidget);
    });

    testWidgets('ProfileSkeleton renders without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: ProfileSkeleton()),
        ),
      );

      expect(find.byType(ProfileSkeleton), findsOneWidget);
    });

    testWidgets('StoreLocatorSkeleton renders without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: StoreLocatorSkeleton()),
        ),
      );

      expect(find.byType(StoreLocatorSkeleton), findsOneWidget);
    });

    testWidgets('CartSkeleton renders without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: CartSkeleton()),
        ),
      );

      expect(find.byType(CartSkeleton), findsOneWidget);
    });
  });

  group('Skeleton widgets render in light theme', () {
    testWidgets('SkeletonShimmer renders in light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: SkeletonShimmer(
              child: SkeletonLine(width: 100, height: 14),
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonShimmer), findsOneWidget);
    });

    testWidgets('MenuItemSkeleton renders in light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: MenuItemSkeleton()),
        ),
      );

      expect(find.byType(MenuItemSkeleton), findsOneWidget);
    });
  });
}
