import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cơm Tấm Má Tư'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get home;

  /// No description provided for @menu.
  ///
  /// In vi, this message translates to:
  /// **'Thực đơn'**
  String get menu;

  /// No description provided for @cart.
  ///
  /// In vi, this message translates to:
  /// **'Giỏ hàng'**
  String get cart;

  /// No description provided for @orders.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng'**
  String get orders;

  /// No description provided for @loyalty.
  ///
  /// In vi, this message translates to:
  /// **'Tích điểm'**
  String get loyalty;

  /// No description provided for @profile.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get profile;

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @register.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// No description provided for @loading.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In vi, this message translates to:
  /// **'Đã xảy ra lỗi'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get retry;

  /// No description provided for @noData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get noData;

  /// No description provided for @noConnection.
  ///
  /// In vi, this message translates to:
  /// **'Không có kết nối mạng'**
  String get noConnection;

  /// No description provided for @offlineMode.
  ///
  /// In vi, this message translates to:
  /// **'Chế độ ngoại tuyến'**
  String get offlineMode;

  /// No description provided for @addToCart.
  ///
  /// In vi, this message translates to:
  /// **'Thêm vào giỏ hàng'**
  String get addToCart;

  /// No description provided for @checkout.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán'**
  String get checkout;

  /// No description provided for @totalPoints.
  ///
  /// In vi, this message translates to:
  /// **'Tổng điểm'**
  String get totalPoints;

  /// No description provided for @availablePoints.
  ///
  /// In vi, this message translates to:
  /// **'Điểm khả dụng'**
  String get availablePoints;

  /// No description provided for @memberTier.
  ///
  /// In vi, this message translates to:
  /// **'Hạng thành viên'**
  String get memberTier;

  /// No description provided for @checkIn.
  ///
  /// In vi, this message translates to:
  /// **'Điểm danh'**
  String get checkIn;

  /// No description provided for @delivery.
  ///
  /// In vi, this message translates to:
  /// **'Giao hàng'**
  String get delivery;

  /// No description provided for @storeLocator.
  ///
  /// In vi, this message translates to:
  /// **'Tìm cửa hàng'**
  String get storeLocator;

  /// No description provided for @notifications.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settings;

  /// No description provided for @vouchers.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi'**
  String get vouchers;

  /// No description provided for @feedback.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá'**
  String get feedback;

  /// No description provided for @dashboard.
  ///
  /// In vi, this message translates to:
  /// **'Bảng điều khiển'**
  String get dashboard;

  /// No description provided for @staffManagement.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý nhân viên'**
  String get staffManagement;

  /// No description provided for @inventory.
  ///
  /// In vi, this message translates to:
  /// **'Kho hàng'**
  String get inventory;

  /// No description provided for @savedAddresses.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ đã lưu'**
  String get savedAddresses;

  /// No description provided for @editProfile.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa hồ sơ'**
  String get editProfile;

  /// No description provided for @orderHistory.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử đơn hàng'**
  String get orderHistory;

  /// No description provided for @deliveryTracking.
  ///
  /// In vi, this message translates to:
  /// **'Theo dõi giao hàng'**
  String get deliveryTracking;

  /// No description provided for @redeemPoints.
  ///
  /// In vi, this message translates to:
  /// **'Đổi điểm'**
  String get redeemPoints;

  /// No description provided for @earnPoints.
  ///
  /// In vi, this message translates to:
  /// **'Tích điểm'**
  String get earnPoints;

  /// No description provided for @scanQR.
  ///
  /// In vi, this message translates to:
  /// **'Quét mã QR'**
  String get scanQR;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get edit;

  /// No description provided for @search.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In vi, this message translates to:
  /// **'Lọc'**
  String get filter;

  /// No description provided for @sortBy.
  ///
  /// In vi, this message translates to:
  /// **'Sắp xếp theo'**
  String get sortBy;

  /// No description provided for @all.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get all;

  /// No description provided for @today.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In vi, this message translates to:
  /// **'Tuần này'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In vi, this message translates to:
  /// **'Tháng này'**
  String get thisMonth;

  /// No description provided for @totalRevenue.
  ///
  /// In vi, this message translates to:
  /// **'Tổng doanh thu'**
  String get totalRevenue;

  /// No description provided for @totalOrders.
  ///
  /// In vi, this message translates to:
  /// **'Tổng đơn hàng'**
  String get totalOrders;

  /// No description provided for @newMembers.
  ///
  /// In vi, this message translates to:
  /// **'Thành viên mới'**
  String get newMembers;

  /// No description provided for @lowStock.
  ///
  /// In vi, this message translates to:
  /// **'Sắp hết hàng'**
  String get lowStock;

  /// No description provided for @restock.
  ///
  /// In vi, this message translates to:
  /// **'Nhập hàng'**
  String get restock;

  /// No description provided for @welcomeBack.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng trở lại!'**
  String get welcomeBack;

  /// No description provided for @seeAll.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get seeAll;

  /// No description provided for @noNotifications.
  ///
  /// In vi, this message translates to:
  /// **'Không có thông báo nào'**
  String get noNotifications;

  /// No description provided for @noOrders.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chưa có đơn hàng nào'**
  String get noOrders;

  /// No description provided for @emptyCart.
  ///
  /// In vi, this message translates to:
  /// **'Giỏ hàng trống'**
  String get emptyCart;

  /// No description provided for @continueOrdering.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục đặt hàng'**
  String get continueOrdering;

  /// No description provided for @orderSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đặt hàng thành công!'**
  String get orderSuccess;

  /// No description provided for @pointsEarned.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã nhận được {points} điểm'**
  String pointsEarned(int points);

  /// No description provided for @itemCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} món'**
  String itemCount(int count);

  /// No description provided for @priceFormat.
  ///
  /// In vi, this message translates to:
  /// **'{price}đ'**
  String priceFormat(String price);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
