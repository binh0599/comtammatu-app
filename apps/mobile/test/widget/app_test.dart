import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:comtammatu/features/home/presentation/home_screen.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('renders home screen with title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.text('Trang chủ'), findsOneWidget);
    });

    testWidgets('renders welcome card', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.text('Chào mừng bạn!'), findsOneWidget);
    });

    testWidgets('renders quick action buttons', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.text('Điểm danh'), findsOneWidget);
      expect(find.text('Đặt hàng'), findsOneWidget);
      expect(find.text('Giao hàng'), findsOneWidget);
      expect(find.text('Cửa hàng'), findsOneWidget);
    });
  });
}
