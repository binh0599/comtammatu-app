import 'package:comtammatu/features/auth/domain/auth_notifier.dart';
import 'package:comtammatu/features/auth/domain/auth_state.dart';
import 'package:comtammatu/features/loyalty/data/loyalty_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comtammatu/features/loyalty/domain/loyalty_notifier.dart';
import 'package:comtammatu/features/loyalty/domain/loyalty_state.dart';
import 'package:comtammatu/models/loyalty_dashboard.dart';
import 'package:comtammatu/models/loyalty_member.dart';
import 'package:comtammatu/models/point_transaction.dart';
import 'package:comtammatu/models/promotion.dart';
import 'package:comtammatu/models/tier.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import 'patrol_base.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockLoyaltyRepository extends Mock implements LoyaltyRepository {}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

supa.User _fakeUser() => supa.User(
      id: 'test-user-id-001',
      appMetadata: {'user_role': 'customer'},
      userMetadata: {'full_name': 'Test User', 'role': 'customer'},
      aud: 'authenticated',
      createdAt: DateTime(2024, 1, 1).toIso8601String(),
    );

/// Builds a sample [LoyaltyDashboard] for the loaded state.
LoyaltyDashboard _fakeDashboard() => LoyaltyDashboard(
      member: const LoyaltyMember(
        id: 1,
        fullName: 'Test User',
        phone: '0901234567',
        totalPoints: 500,
        availablePoints: 250,
        lifetimePoints: 500,
        version: 1,
      ),
      tier: const Tier(
        id: 1,
        name: 'Đồng',
        tierCode: 'bronze',
        pointMultiplier: 1.0,
        cashbackPercent: 0.0,
        benefits: ['Giảm 5% đơn hàng', 'Tích điểm x1'],
        nextTier: TierProgress(
          name: 'Bạc',
          tierCode: 'silver',
          minPoints: 500,
          pointsNeeded: 250,
          progressPercent: 50,
        ),
      ),
      recentTransactions: [
        PointTransaction(
          id: 1,
          type: 'earn',
          points: 50,
          balanceAfter: 250,
          description: 'Tích điểm đơn hàng #123',
          createdAt: DateTime(2024, 12, 1),
        ),
        PointTransaction(
          id: 2,
          type: 'redeem',
          points: -20,
          balanceAfter: 200,
          description: 'Đổi voucher giảm giá',
          createdAt: DateTime(2024, 11, 28),
        ),
      ],
      activePromotions: [
        Promotion(
          id: 1,
          name: 'Khuyến mãi test',
          description: 'Giảm 10%',
          cashbackType: 'percent',
          cashbackValue: 10,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2027, 12, 31),
          eligible: true,
        ),
      ],
      stats: const LoyaltyStats(
        totalCheckinsThisMonth: 5,
        totalOrdersThisMonth: 3,
        streakDays: 3,
      ),
    );

/// Helper to build authenticated app with loyalty mocks pre-loaded.
Widget _buildLoyaltyTestApp({
  required SharedPreferences prefs,
  required MockAuthRepository mockAuthRepo,
  required MockLoyaltyRepository mockLoyaltyRepo,
}) {
  return buildTestApp(
    prefs: prefs,
    authRepo: mockAuthRepo,
    extraOverrides: [
      authNotifierProvider.overrideWith((ref) {
        final notifier = AuthNotifier(authRepository: mockAuthRepo);
        notifier.state = Authenticated(user: _fakeUser());
        return notifier;
      }),
      loyaltyRepositoryProvider.overrideWithValue(mockLoyaltyRepo),
      loyaltyNotifierProvider.overrideWith((ref) {
        final notifier = LoyaltyNotifier(loyaltyRepository: mockLoyaltyRepo);
        notifier.state = LoyaltyLoaded(dashboard: _fakeDashboard());
        return notifier;
      }),
    ],
  );
}

void main() {
  patrolTest(
    'Loyalty — displays points, tier, and transaction history',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();
      final mockLoyaltyRepo = MockLoyaltyRepository();

      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());
      when(() => mockLoyaltyRepo.getDashboard())
          .thenAnswer((_) async => _fakeDashboard());

      await $.pumpWidgetAndSettle(
        _buildLoyaltyTestApp(
          prefs: prefs,
          mockAuthRepo: mockAuthRepo,
          mockLoyaltyRepo: mockLoyaltyRepo,
        ),
      );

      // Wait for splash → home
      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to loyalty tab ("Tích điểm")
      await $('Tích điểm').tap();
      await $.pumpAndSettle();

      // Verify points balance is displayed
      expect($('250'), findsOneWidget);

      // Verify tier info
      expect(find.textContaining('Đồng'), findsWidgets);

      // Verify action buttons exist
      expect($('Đổi điểm'), findsOneWidget);
      expect($('Check-in'), findsOneWidget);

      // Verify transaction history
      expect(find.textContaining('Tích điểm đơn hàng #123'), findsOneWidget);
      expect(find.textContaining('Đổi voucher giảm giá'), findsOneWidget);
    },
  );

  patrolTest(
    'Loyalty — check-in button navigates to QR scanner screen',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();
      final mockLoyaltyRepo = MockLoyaltyRepository();

      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());
      when(() => mockLoyaltyRepo.getDashboard())
          .thenAnswer((_) async => _fakeDashboard());

      await $.pumpWidgetAndSettle(
        _buildLoyaltyTestApp(
          prefs: prefs,
          mockAuthRepo: mockAuthRepo,
          mockLoyaltyRepo: mockLoyaltyRepo,
        ),
      );

      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to loyalty tab
      await $('Tích điểm').tap();
      await $.pumpAndSettle();

      // Tap "Check-in" action button
      await $('Check-in').tap();
      await $.pumpAndSettle();

      // Verify we navigated to the checkin screen
      expect($('Quét mã QR tại quầy'), findsOneWidget);
      expect(
        $('Đưa camera vào mã QR tại cửa hàng\nđể tích điểm thưởng'),
        findsOneWidget,
      );

      // Note: MobileScanner requires camera permission on real devices.
      // Use $.native.grantPermissionWhenInUse() for native permission dialogs.
    },
  );

  patrolTest(
    'Loyalty — earn points and redeem points navigation',
    config: patrolTesterConfig,
    ($) async {
      final prefs = await createTestPrefs();
      final mockAuthRepo = defaultMockAuthRepo();
      final mockLoyaltyRepo = MockLoyaltyRepository();

      when(() => mockAuthRepo.getCurrentUser()).thenReturn(_fakeUser());
      when(() => mockLoyaltyRepo.getDashboard())
          .thenAnswer((_) async => _fakeDashboard());

      await $.pumpWidgetAndSettle(
        _buildLoyaltyTestApp(
          prefs: prefs,
          mockAuthRepo: mockAuthRepo,
          mockLoyaltyRepo: mockLoyaltyRepo,
        ),
      );

      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Navigate to loyalty tab
      await $('Tích điểm').tap();
      await $.pumpAndSettle();

      // Tap "Đổi điểm" (redeem points) action button
      await $('Đổi điểm').tap();
      await $.pumpAndSettle();

      // Should navigate to redeem points screen — verify by presence of
      // a back button (means we pushed a new route)
      expect($(Icons.arrow_back), findsWidgets);
    },
  );
}
