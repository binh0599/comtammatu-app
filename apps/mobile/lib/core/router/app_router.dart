import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/auth_notifier.dart';
import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/menu/presentation/menu_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/loyalty/presentation/loyalty_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/profile_edit_screen.dart';
import '../../features/profile/presentation/saved_addresses_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/delivery/presentation/delivery_tracking_screen.dart';
import '../../features/stores/presentation/store_locator_screen.dart';
import '../../features/order/presentation/order_history_screen.dart';
import '../../features/feedback/presentation/feedback_screen.dart';
import '../../features/voucher/presentation/voucher_screen.dart';
import '../../features/notifications/presentation/notification_inbox_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/staff/presentation/staff_management_screen.dart';
import '../../features/inventory/presentation/inventory_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

/// Route paths as constants
class AppRoutes {
  AppRoutes._();

  // Splash
  static const String splash = '/splash';

  // Customer routes
  static const String home = '/';
  static const String menu = '/menu';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String loyalty = '/loyalty';
  static const String delivery = '/delivery';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String savedAddresses = '/profile/addresses';
  static const String settings = '/settings';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String notifications = '/notifications';
  static const String storeLocator = '/store-locator';
  static const String feedback = '/feedback';
  static const String vouchers = '/vouchers';

  // Management routes (owner/manager)
  static const String dashboard = '/dashboard';
  static const String staffManagement = '/staff';
  static const String inventory = '/inventory';
}

/// Navigation shell for customer bottom navigation bar
class _ScaffoldWithNavBar extends StatelessWidget {
  const _ScaffoldWithNavBar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_outlined),
            activeIcon: Icon(Icons.restaurant_menu),
            label: 'Thực đơn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            activeIcon: Icon(Icons.star),
            label: 'Tích điểm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.menu)) return 1;
    if (location.startsWith(AppRoutes.cart)) return 2;
    if (location.startsWith(AppRoutes.loyalty)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    if (location.startsWith(AppRoutes.orders)) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.menu);
      case 2:
        context.go(AppRoutes.cart);
      case 3:
        context.go(AppRoutes.loyalty);
      case 4:
        context.go(AppRoutes.profile);
    }
  }
}

/// Navigation shell for management bottom navigation bar (owner/manager)
class _AdminScaffoldWithNavBar extends StatelessWidget {
  const _AdminScaffoldWithNavBar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Bảng điều khiển',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Nhân viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Kho hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.staffManagement)) return 1;
    if (location.startsWith(AppRoutes.inventory)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.dashboard);
      case 1:
        context.go(AppRoutes.staffManagement);
      case 2:
        context.go(AppRoutes.inventory);
      case 3:
        context.go(AppRoutes.profile);
    }
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isSplash = state.uri.path == AppRoutes.splash;
      if (isSplash) return null; // Allow splash through

      final authState = ref.read(authNotifierProvider);
      final isLoggedIn = authState is Authenticated;
      final isAuthRoute = state.uri.path == AppRoutes.login ||
          state.uri.path == AppRoutes.register ||
          state.uri.path == AppRoutes.otp;

      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && isAuthRoute) return AppRoutes.home;
      return null;
    },
    routes: [
      // Splash screen
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes (outside shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        name: 'otp',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          final type = state.uri.queryParameters['type'] ?? 'signup';
          return OtpScreen(phone: phone, type: type);
        },
      ),

      // Customer app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => _ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.menu,
            name: 'menu',
            builder: (context, state) => const MenuScreen(),
          ),
          GoRoute(
            path: AppRoutes.cart,
            name: 'cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: AppRoutes.orders,
            name: 'orders',
            builder: (context, state) => const OrderHistoryScreen(),
          ),
          GoRoute(
            path: AppRoutes.loyalty,
            name: 'loyalty',
            builder: (context, state) => const LoyaltyScreen(),
          ),
          GoRoute(
            path: AppRoutes.delivery,
            name: 'delivery',
            redirect: (context, state) {
              if (state.uri.path == AppRoutes.delivery) {
                return AppRoutes.orders;
              }
              return null;
            },
            builder: (context, state) =>
                const DeliveryTrackingScreen(orderId: ''),
            routes: [
              GoRoute(
                path: ':orderId',
                name: 'deliveryTracking',
                builder: (context, state) {
                  final orderId = state.pathParameters['orderId'] ?? '';
                  return DeliveryTrackingScreen(orderId: orderId);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'profileEdit',
                builder: (context, state) => const ProfileEditScreen(),
              ),
              GoRoute(
                path: 'addresses',
                name: 'savedAddresses',
                builder: (context, state) => const SavedAddressesScreen(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.notifications,
            name: 'notifications',
            builder: (context, state) => const NotificationInboxScreen(),
          ),
          GoRoute(
            path: AppRoutes.storeLocator,
            name: 'storeLocator',
            builder: (context, state) => const StoreLocatorScreen(),
          ),
          GoRoute(
            path: AppRoutes.feedback,
            name: 'feedback',
            builder: (context, state) {
              final orderId =
                  int.tryParse(state.uri.queryParameters['orderId'] ?? '') ??
                      0;
              return FeedbackScreen(orderId: orderId);
            },
          ),
          GoRoute(
            path: AppRoutes.vouchers,
            name: 'vouchers',
            builder: (context, state) => const VoucherScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),

      // Management shell with admin navigation (owner/manager)
      ShellRoute(
        builder: (context, state, child) =>
            _AdminScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.staffManagement,
            name: 'staffManagement',
            builder: (context, state) => const StaffManagementScreen(),
          ),
          GoRoute(
            path: AppRoutes.inventory,
            name: 'inventory',
            builder: (context, state) => const InventoryScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Không tìm thấy trang',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Về trang chủ'),
            ),
          ],
        ),
      ),
    ),
  );
});
