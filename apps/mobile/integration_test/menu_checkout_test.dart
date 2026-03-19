import 'package:comtammatu/features/auth/domain/auth_notifier.dart';
import 'package:comtammatu/features/auth/domain/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import 'patrol_base.dart';

/// Helper: creates a fake [supa.User] for authenticated E2E tests.
supa.User _fakeUser() => supa.User(
      id: 'test-user-id-001',
      appMetadata: {'user_role': 'customer'},
      userMetadata: {'full_name': 'Test User', 'role': 'customer'},
      aud: 'authenticated',
      createdAt: DateTime(2024, 1, 1).toIso8601String(),
    );

void main() {
  patrolTest(
    'Menu — displays menu items and can add item to cart',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();

      // Override auth to be authenticated so we can navigate to menu
      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());

      await $.pumpWidgetAndSettle(
        buildTestApp(
          prefs: prefs,
          authRepo: mockAuthRepo,
          extraOverrides: [
            authNotifierProvider.overrideWith((ref) {
              final notifier = AuthNotifier(authRepository: mockAuthRepo);
              // Force authenticated state
              notifier.state = Authenticated(user: _fakeUser());
              return notifier;
            }),
          ],
        ),
      );

      // Wait for splash screen animation + navigation (2.5s delay)
      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to menu tab via bottom navigation
      await $('Thực đơn').tap();
      await $.pumpAndSettle();

      // Verify menu screen is shown with sample data
      // The menu screen has category chips and menu item cards
      expect($('Cơm tấm sườn bì chả'), findsOneWidget);
      expect($('Cơm tấm sườn nướng'), findsOneWidget);

      // Verify category chips are displayed
      expect($('Tất cả'), findsOneWidget);

      // Tap "Thêm" button on the first menu item to add to cart
      // Each menu item card has an "Thêm" button
      await $('Thêm').first.tap();
      await $.pumpAndSettle();

      // Should show a snackbar confirming item added
      // The snackbar text format is: "Đã thêm {item.name} vào giỏ hàng"
      expect(find.textContaining('Đã thêm'), findsOneWidget);
    },
  );

  patrolTest(
    'Menu — category filter works',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();

      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());

      await $.pumpWidgetAndSettle(
        buildTestApp(
          prefs: prefs,
          authRepo: mockAuthRepo,
          extraOverrides: [
            authNotifierProvider.overrideWith((ref) {
              final notifier = AuthNotifier(authRepository: mockAuthRepo);
              notifier.state = Authenticated(user: _fakeUser());
              return notifier;
            }),
          ],
        ),
      );

      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to menu tab
      await $('Thực đơn').tap();
      await $.pumpAndSettle();

      // Tap on "Nước uống" category
      await $('Nước uống').tap();
      await $.pumpAndSettle();

      // Should show drinks but not com tam items
      expect($('Trà đá'), findsOneWidget);
      expect($('Nước ngọt'), findsOneWidget);
      // Com tam items should not be visible when filtered
      expect($('Cơm tấm sườn bì chả'), findsNothing);
    },
  );

  patrolTest(
    'Menu — search filters items',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();

      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());

      await $.pumpWidgetAndSettle(
        buildTestApp(
          prefs: prefs,
          authRepo: mockAuthRepo,
          extraOverrides: [
            authNotifierProvider.overrideWith((ref) {
              final notifier = AuthNotifier(authRepository: mockAuthRepo);
              notifier.state = Authenticated(user: _fakeUser());
              return notifier;
            }),
          ],
        ),
      );

      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to menu tab
      await $('Thực đơn').tap();
      await $.pumpAndSettle();

      // Type in search field
      final searchField = $(TextField).first;
      await searchField.enterText('sườn bì chả');
      await $.pumpAndSettle();

      // Should filter to only matching items
      expect($('Cơm tấm sườn bì chả'), findsOneWidget);
      expect($('Trà đá'), findsNothing);
    },
  );

  patrolTest(
    'Cart — empty state shows message and menu link',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();

      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());

      await $.pumpWidgetAndSettle(
        buildTestApp(
          prefs: prefs,
          authRepo: mockAuthRepo,
          extraOverrides: [
            authNotifierProvider.overrideWith((ref) {
              final notifier = AuthNotifier(authRepository: mockAuthRepo);
              notifier.state = Authenticated(user: _fakeUser());
              return notifier;
            }),
          ],
        ),
      );

      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to cart tab
      await $('Giỏ hàng').tap();
      await $.pumpAndSettle();

      // Cart should be empty — verify empty state UI
      expect($(Icons.shopping_cart_outlined), findsOneWidget);
      // The "Xem thực đơn" button should be visible
      expect($('Xem thực đơn'), findsOneWidget);
    },
  );
}
