// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cơm Tấm Má Tư';

  @override
  String get home => 'Home';

  @override
  String get menu => 'Menu';

  @override
  String get cart => 'Cart';

  @override
  String get orders => 'Orders';

  @override
  String get loyalty => 'Loyalty';

  @override
  String get profile => 'Profile';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Logout';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get noData => 'No data available';

  @override
  String get noConnection => 'No internet connection';

  @override
  String get offlineMode => 'Offline mode';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get checkout => 'Checkout';

  @override
  String get totalPoints => 'Total points';

  @override
  String get availablePoints => 'Available points';

  @override
  String get memberTier => 'Member tier';

  @override
  String get checkIn => 'Check in';

  @override
  String get delivery => 'Delivery';

  @override
  String get storeLocator => 'Store locator';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String get vouchers => 'Vouchers';

  @override
  String get feedback => 'Feedback';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get staffManagement => 'Staff Management';

  @override
  String get inventory => 'Inventory';

  @override
  String get savedAddresses => 'Saved Addresses';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get orderHistory => 'Order History';

  @override
  String get deliveryTracking => 'Delivery Tracking';

  @override
  String get redeemPoints => 'Redeem Points';

  @override
  String get earnPoints => 'Earn Points';

  @override
  String get scanQR => 'Scan QR';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get sortBy => 'Sort by';

  @override
  String get all => 'All';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This week';

  @override
  String get thisMonth => 'This month';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get totalOrders => 'Total Orders';

  @override
  String get newMembers => 'New Members';

  @override
  String get lowStock => 'Low Stock';

  @override
  String get restock => 'Restock';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get seeAll => 'See all';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get noOrders => 'You have no orders yet';

  @override
  String get emptyCart => 'Cart is empty';

  @override
  String get continueOrdering => 'Continue ordering';

  @override
  String get orderSuccess => 'Order placed successfully!';

  @override
  String pointsEarned(int points) {
    return 'You earned $points points';
  }

  @override
  String itemCount(int count) {
    return '$count items';
  }

  @override
  String priceFormat(String price) {
    return '$priceđ';
  }
}
