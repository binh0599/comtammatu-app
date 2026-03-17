import 'dart:async';

import 'package:comtammatu/features/auth/data/auth_repository.dart';
import 'package:comtammatu/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthResponse, AuthState;

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    // Stub methods that AuthNotifier._init() calls
    when(() => mockAuthRepo.getCurrentUser()).thenReturn(null);
    when(() => mockAuthRepo.onAuthStateChange())
        .thenAnswer((_) => const Stream<AuthState>.empty());
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepo),
      ],
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen', () {
    testWidgets('renders brand title "Cơm Tấm Má Tư"', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text('Cơm Tấm Má Tư'), findsOneWidget);
    });

    testWidgets('renders phone and password fields', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text('Số điện thoại'), findsOneWidget);
      expect(find.text('Mật khẩu'), findsOneWidget);
    });

    testWidgets('shows validation errors when fields empty and button tapped',
        (tester) async {
      await tester.pumpWidget(buildSubject());

      // Tap login button without filling fields
      await tester.tap(find.text('Đăng nhập'));
      await tester.pumpAndSettle();

      expect(find.text('Vui lòng nhập số điện thoại'), findsOneWidget);
      expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
    });

    testWidgets('shows validation error for short phone number (<10 chars)',
        (tester) async {
      await tester.pumpWidget(buildSubject());

      // Enter a short phone number
      await tester.enterText(
        find.byType(TextFormField).first,
        '0901',
      );
      await tester.tap(find.text('Đăng nhập'));
      await tester.pumpAndSettle();

      expect(find.text('Số điện thoại không hợp lệ'), findsOneWidget);
    });

    testWidgets('shows validation error for short password (<6 chars)',
        (tester) async {
      await tester.pumpWidget(buildSubject());

      // Enter valid phone but short password
      await tester.enterText(
        find.byType(TextFormField).first,
        '0901234567',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        '123',
      );
      await tester.tap(find.text('Đăng nhập'));
      await tester.pumpAndSettle();

      expect(find.text('Mật khẩu phải có ít nhất 6 ký tự'), findsOneWidget);
    });

    testWidgets('login button shows loading state during submission',
        (tester) async {
      // Use a Completer so the Future never completes (no pending timers)
      final completer = Completer<AuthResponse>();

      when(() => mockAuthRepo.signIn(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildSubject());

      // Fill in valid fields
      await tester.enterText(
        find.byType(TextFormField).first,
        '0901234567',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'password123',
      );

      // Tap login
      await tester.tap(find.text('Đăng nhập'));
      await tester.pump(); // Start the async call — don't pumpAndSettle

      // Should show a CircularProgressIndicator (loading state)
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete the future to avoid dangling async work
      completer.completeError(Exception('cancelled'));
      await tester.pump();
    });
  });
}
