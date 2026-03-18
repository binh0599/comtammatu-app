// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/loyalty/data/loyalty_repository.dart';
import 'package:comtammatu/features/loyalty/domain/loyalty_notifier.dart';
import 'package:comtammatu/features/loyalty/domain/loyalty_state.dart';
import 'package:comtammatu/models/loyalty_dashboard.dart';
import 'package:comtammatu/models/loyalty_member.dart';
import 'package:comtammatu/models/point_transaction.dart';
import 'package:comtammatu/models/promotion.dart';
import 'package:comtammatu/models/tier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoyaltyRepository extends Mock implements LoyaltyRepository {}

LoyaltyDashboard _sampleDashboard() {
  return LoyaltyDashboard(
    member: LoyaltyMember(
      id: 1,
      fullName: 'Nguyễn Văn A',
      phone: '0901234567',
      totalPoints: 2000,
      availablePoints: 1500,
      lifetimePoints: 5000,
      version: 42,
    ),
    tier: const Tier(
      id: 2,
      name: 'Vàng',
      tierCode: 'gold',
      pointMultiplier: 1.5,
      cashbackPercent: 3.0,
      benefits: ['Nhân x1.5 điểm', 'Cashback 3%'],
    ),
    recentTransactions: [
      PointTransaction(
        id: 100,
        type: 'earn',
        points: 50,
        balanceAfter: 1500,
        description: 'Đặt hàng #456',
        createdAt: DateTime(2026, 3, 18),
      ),
    ],
    activePromotions: [
      Promotion(
        id: 10,
        name: 'Double Points Weekend',
        description: 'Nhân đôi điểm cuối tuần',
        cashbackType: 'percent',
        cashbackValue: 5.0,
        startDate: DateTime(2026, 3, 15),
        endDate: DateTime(2026, 3, 31),
        eligible: true,
      ),
    ],
    stats: const LoyaltyStats(
      totalCheckinsThisMonth: 5,
      totalOrdersThisMonth: 3,
      streakDays: 7,
    ),
  );
}

void main() {
  late MockLoyaltyRepository mockRepo;
  late LoyaltyNotifier notifier;

  setUp(() {
    mockRepo = MockLoyaltyRepository();
    notifier = LoyaltyNotifier(loyaltyRepository: mockRepo);
  });

  group('LoyaltyNotifier', () {
    test('initial state is LoyaltyInitial', () {
      expect(notifier.state, isA<LoyaltyInitial>());
    });

    test('loadDashboard success → LoyaltyLoaded', () async {
      when(() => mockRepo.getDashboard())
          .thenAnswer((_) async => _sampleDashboard());

      await notifier.loadDashboard();

      expect(notifier.state, isA<LoyaltyLoaded>());
      final loaded = notifier.state as LoyaltyLoaded;
      expect(loaded.dashboard.member.fullName, 'Nguyễn Văn A');
      expect(loaded.dashboard.member.availablePoints, 1500);
    });

    test('loadDashboard failure → LoyaltyError', () async {
      when(() => mockRepo.getDashboard()).thenThrow(Exception('Network error'));

      await notifier.loadDashboard();

      expect(notifier.state, isA<LoyaltyError>());
    });

    test('redeemPoints success → reloads dashboard', () async {
      when(() => mockRepo.getDashboard())
          .thenAnswer((_) async => _sampleDashboard());
      when(() => mockRepo.redeemPoints(rewardId: 201, points: 500))
          .thenAnswer((_) async => const RedemptionResult(
                redemptionId: 6001,
                pointsDeducted: 500,
                newBalance: 1000,
              ));

      await notifier.loadDashboard();
      final result = await notifier.redeemPoints(rewardId: 201, points: 500);

      expect(result.redemptionId, 6001);
      expect(result.pointsDeducted, 500);
      // Dashboard should be reloaded (getDashboard called twice)
      verify(() => mockRepo.getDashboard()).called(2);
    });

    test('redeemPoints failure → rethrows', () async {
      when(() => mockRepo.getDashboard())
          .thenAnswer((_) async => _sampleDashboard());
      when(() => mockRepo.redeemPoints(rewardId: 201, points: 500))
          .thenThrow(Exception('INSUFFICIENT_POINTS'));

      await notifier.loadDashboard();

      expect(
        () => notifier.redeemPoints(rewardId: 201, points: 500),
        throwsException,
      );
    });
  });

  group('RedemptionResult', () {
    test('fromJson parses full response', () {
      final json = {
        'redemption_id': 6001,
        'points_deducted': 500,
        'new_balance': 1000.0,
        'reward': {
          'id': 201,
          'name': 'Cơm tấm sườn bì chả miễn phí',
          'description': 'Tặng 1 suất cơm tấm',
          'points_required': 500,
          'voucher_code': 'RDM-2026-6001',
          'expires_at': '2026-03-25T23:59:59.000Z',
        },
        'version': 44,
      };

      final result = RedemptionResult.fromJson(json);

      expect(result.redemptionId, 6001);
      expect(result.pointsDeducted, 500);
      expect(result.newBalance, 1000.0);
      expect(result.reward, isNotNull);
      expect(result.reward!.name, 'Cơm tấm sườn bì chả miễn phí');
      expect(result.reward!.voucherCode, 'RDM-2026-6001');
      expect(result.version, 44);
    });

    test('fromJson handles minimal response', () {
      final json = {
        'redemption_id': 6002,
        'points_deducted': 100,
        'new_balance': 1400.0,
      };

      final result = RedemptionResult.fromJson(json);

      expect(result.redemptionId, 6002);
      expect(result.reward, isNull);
    });
  });
}
