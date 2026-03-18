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

  /// No description provided for @authLoginSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập để tích điểm và đặt hàng'**
  String get authLoginSubtitle;

  /// No description provided for @authPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get authPhone;

  /// No description provided for @authPhoneHint.
  ///
  /// In vi, this message translates to:
  /// **'0901234567'**
  String get authPhoneHint;

  /// No description provided for @authPhoneRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập số điện thoại'**
  String get authPhoneRequired;

  /// No description provided for @authPhoneInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không hợp lệ'**
  String get authPhoneInvalid;

  /// No description provided for @authPassword.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get authPassword;

  /// No description provided for @authPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu'**
  String get authPasswordHint;

  /// No description provided for @authPasswordRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mật khẩu'**
  String get authPasswordRequired;

  /// No description provided for @authPasswordMinLength.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải có ít nhất 6 ký tự'**
  String get authPasswordMinLength;

  /// No description provided for @authForgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get authForgotPassword;

  /// No description provided for @authLoginFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thất bại. Vui lòng thử lại.'**
  String get authLoginFailed;

  /// No description provided for @authNoAccount.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản? '**
  String get authNoAccount;

  /// No description provided for @authRegisterNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký ngay'**
  String get authRegisterNow;

  /// No description provided for @authCreateAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản mới'**
  String get authCreateAccount;

  /// No description provided for @authRegisterSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký để tích điểm và nhận ưu đãi'**
  String get authRegisterSubtitle;

  /// No description provided for @authFullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get authFullName;

  /// No description provided for @authFullNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Văn A'**
  String get authFullNameHint;

  /// No description provided for @authFullNameRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập họ và tên'**
  String get authFullNameRequired;

  /// No description provided for @authFullNameMinLength.
  ///
  /// In vi, this message translates to:
  /// **'Họ tên phải có ít nhất 2 ký tự'**
  String get authFullNameMinLength;

  /// No description provided for @authPasswordHintShort.
  ///
  /// In vi, this message translates to:
  /// **'Ít nhất 6 ký tự'**
  String get authPasswordHintShort;

  /// No description provided for @authConfirmPassword.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu'**
  String get authConfirmPassword;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get authConfirmPasswordHint;

  /// No description provided for @authConfirmPasswordRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng xác nhận mật khẩu'**
  String get authConfirmPasswordRequired;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu không khớp'**
  String get authPasswordMismatch;

  /// No description provided for @authReferralCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã giới thiệu (không bắt buộc)'**
  String get authReferralCode;

  /// No description provided for @authReferralCodeHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã giới thiệu nếu có'**
  String get authReferralCodeHint;

  /// No description provided for @authRegisterFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại. Vui lòng thử lại.'**
  String get authRegisterFailed;

  /// No description provided for @authHasAccount.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản? '**
  String get authHasAccount;

  /// No description provided for @authOtpTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực OTP'**
  String get authOtpTitle;

  /// No description provided for @authOtpEnterCode.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã xác thực'**
  String get authOtpEnterCode;

  /// No description provided for @authOtpSentTo.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP đã được gửi đến số\n'**
  String get authOtpSentTo;

  /// No description provided for @authOtpRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập đầy đủ mã OTP'**
  String get authOtpRequired;

  /// No description provided for @authOtpInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP không hợp lệ. Vui lòng thử lại.'**
  String get authOtpInvalid;

  /// No description provided for @authOtpResendCountdown.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã sau {seconds}s'**
  String authOtpResendCountdown(int seconds);

  /// No description provided for @authOtpResend.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã OTP'**
  String get authOtpResend;

  /// No description provided for @authOtpResent.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi lại mã OTP'**
  String get authOtpResent;

  /// No description provided for @homeQuickActions.
  ///
  /// In vi, this message translates to:
  /// **'Thao tác nhanh'**
  String get homeQuickActions;

  /// No description provided for @homeAccumulatedPoints.
  ///
  /// In vi, this message translates to:
  /// **'Điểm tích lũy'**
  String get homeAccumulatedPoints;

  /// No description provided for @homeAvailablePoints.
  ///
  /// In vi, this message translates to:
  /// **'điểm khả dụng'**
  String get homeAvailablePoints;

  /// No description provided for @homePromotionsForYou.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi dành cho bạn'**
  String get homePromotionsForYou;

  /// No description provided for @homeLoadingPromotions.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải ưu đãi...'**
  String get homeLoadingPromotions;

  /// No description provided for @homeNoPromotions.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có ưu đãi nào'**
  String get homeNoPromotions;

  /// No description provided for @homeEligible.
  ///
  /// In vi, this message translates to:
  /// **'Đủ điều kiện'**
  String get homeEligible;

  /// No description provided for @homeRecentTransactions.
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch gần đây'**
  String get homeRecentTransactions;

  /// No description provided for @homePointsToNextTier.
  ///
  /// In vi, this message translates to:
  /// **'Còn {points} điểm nữa lên hạng {tierName}'**
  String homePointsToNextTier(String points, String tierName);

  /// No description provided for @menuSearchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm món ăn...'**
  String get menuSearchHint;

  /// No description provided for @menuNoResults.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy món ăn'**
  String get menuNoResults;

  /// No description provided for @menuOffline.
  ///
  /// In vi, this message translates to:
  /// **'Ngoại tuyến'**
  String get menuOffline;

  /// No description provided for @menuHotBadge.
  ///
  /// In vi, this message translates to:
  /// **'Hot'**
  String get menuHotBadge;

  /// No description provided for @menuAdd.
  ///
  /// In vi, this message translates to:
  /// **'Thêm'**
  String get menuAdd;

  /// No description provided for @menuAddedToCart.
  ///
  /// In vi, this message translates to:
  /// **'Đã thêm {name} vào giỏ hàng'**
  String menuAddedToCart(String name);

  /// No description provided for @menuCategoryComTam.
  ///
  /// In vi, this message translates to:
  /// **'Cơm tấm'**
  String get menuCategoryComTam;

  /// No description provided for @menuCategorySides.
  ///
  /// In vi, this message translates to:
  /// **'Món thêm'**
  String get menuCategorySides;

  /// No description provided for @menuCategoryDrinks.
  ///
  /// In vi, this message translates to:
  /// **'Nước uống'**
  String get menuCategoryDrinks;

  /// No description provided for @menuCategoryDesserts.
  ///
  /// In vi, this message translates to:
  /// **'Tráng miệng'**
  String get menuCategoryDesserts;

  /// No description provided for @cartClearAll.
  ///
  /// In vi, this message translates to:
  /// **'Xóa tất cả'**
  String get cartClearAll;

  /// No description provided for @cartEmptyMessage.
  ///
  /// In vi, this message translates to:
  /// **'Hãy thêm món ăn từ thực đơn\nđể bắt đầu đặt hàng nhé!'**
  String get cartEmptyMessage;

  /// No description provided for @cartViewMenu.
  ///
  /// In vi, this message translates to:
  /// **'Xem thực đơn'**
  String get cartViewMenu;

  /// No description provided for @cartDeliveryAddress.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ giao hàng'**
  String get cartDeliveryAddress;

  /// No description provided for @cartNoAddress.
  ///
  /// In vi, this message translates to:
  /// **'Chưa chọn địa chỉ'**
  String get cartNoAddress;

  /// No description provided for @cartSelectAddress.
  ///
  /// In vi, this message translates to:
  /// **'Chọn địa chỉ'**
  String get cartSelectAddress;

  /// No description provided for @cartPaymentMethod.
  ///
  /// In vi, this message translates to:
  /// **'Phương thức thanh toán'**
  String get cartPaymentMethod;

  /// No description provided for @cartPaymentCod.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán khi nhận hàng'**
  String get cartPaymentCod;

  /// No description provided for @cartPaymentMomo.
  ///
  /// In vi, this message translates to:
  /// **'Ví MoMo'**
  String get cartPaymentMomo;

  /// No description provided for @cartPaymentZalopay.
  ///
  /// In vi, this message translates to:
  /// **'ZaloPay'**
  String get cartPaymentZalopay;

  /// No description provided for @cartOrderDetails.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết đơn hàng'**
  String get cartOrderDetails;

  /// No description provided for @cartSubtotal.
  ///
  /// In vi, this message translates to:
  /// **'Tạm tính'**
  String get cartSubtotal;

  /// No description provided for @cartDeliveryFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí giao hàng'**
  String get cartDeliveryFee;

  /// No description provided for @cartDiscount.
  ///
  /// In vi, this message translates to:
  /// **'Giảm giá'**
  String get cartDiscount;

  /// No description provided for @cartTotal.
  ///
  /// In vi, this message translates to:
  /// **'Tổng cộng'**
  String get cartTotal;

  /// No description provided for @cartPlaceOrder.
  ///
  /// In vi, this message translates to:
  /// **'Đặt hàng'**
  String get cartPlaceOrder;

  /// No description provided for @cartNoteHint.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú (vd: ít hành, thêm nước mắm...)'**
  String get cartNoteHint;

  /// No description provided for @orderCannotLoad.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải đơn hàng'**
  String get orderCannotLoad;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusDelivering.
  ///
  /// In vi, this message translates to:
  /// **'Đang giao'**
  String get orderStatusDelivering;

  /// No description provided for @orderStatusPickedUp.
  ///
  /// In vi, this message translates to:
  /// **'Đã lấy hàng'**
  String get orderStatusPickedUp;

  /// No description provided for @orderStatusPending.
  ///
  /// In vi, this message translates to:
  /// **'Chờ xác nhận'**
  String get orderStatusPending;

  /// No description provided for @orderStatusConfirmed.
  ///
  /// In vi, this message translates to:
  /// **'Đã xác nhận'**
  String get orderStatusConfirmed;

  /// No description provided for @orderStatusPreparing.
  ///
  /// In vi, this message translates to:
  /// **'Đang chuẩn bị'**
  String get orderStatusPreparing;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In vi, this message translates to:
  /// **'Đã hủy'**
  String get orderStatusCancelled;

  /// No description provided for @orderFilterDelivering.
  ///
  /// In vi, this message translates to:
  /// **'Đang giao'**
  String get orderFilterDelivering;

  /// No description provided for @orderFilterDelivered.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get orderFilterDelivered;

  /// No description provided for @orderFilterCancelled.
  ///
  /// In vi, this message translates to:
  /// **'Đã hủy'**
  String get orderFilterCancelled;

  /// No description provided for @orderEmptyAll.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có đơn hàng nào'**
  String get orderEmptyAll;

  /// No description provided for @orderEmptyDelivering.
  ///
  /// In vi, this message translates to:
  /// **'Không có đơn đang giao'**
  String get orderEmptyDelivering;

  /// No description provided for @orderEmptyDelivered.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có đơn hoàn thành'**
  String get orderEmptyDelivered;

  /// No description provided for @orderEmptyCancelled.
  ///
  /// In vi, this message translates to:
  /// **'Không có đơn đã hủy'**
  String get orderEmptyCancelled;

  /// No description provided for @orderEmptyHint.
  ///
  /// In vi, this message translates to:
  /// **'Hãy đặt món từ thực đơn\nđể bắt đầu nhé!'**
  String get orderEmptyHint;

  /// No description provided for @orderNumber.
  ///
  /// In vi, this message translates to:
  /// **'Đơn #{orderId}'**
  String orderNumber(String orderId);

  /// No description provided for @orderPointsEarned.
  ///
  /// In vi, this message translates to:
  /// **'+{points} điểm'**
  String orderPointsEarned(int points);

  /// No description provided for @orderTrack.
  ///
  /// In vi, this message translates to:
  /// **'Theo dõi'**
  String get orderTrack;

  /// No description provided for @orderRate.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá'**
  String get orderRate;

  /// No description provided for @orderReorder.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại'**
  String get orderReorder;

  /// No description provided for @orderReorderAdding.
  ///
  /// In vi, this message translates to:
  /// **'Đang thêm các món vào giỏ hàng...'**
  String get orderReorderAdding;

  /// No description provided for @loyaltyCannotLoad.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải dữ liệu tích điểm'**
  String get loyaltyCannotLoad;

  /// No description provided for @loyaltyPointsSuffix.
  ///
  /// In vi, this message translates to:
  /// **'điểm'**
  String get loyaltyPointsSuffix;

  /// No description provided for @loyaltyTierName.
  ///
  /// In vi, this message translates to:
  /// **'Hạng {name}'**
  String loyaltyTierName(String name);

  /// No description provided for @loyaltyPointsNeeded.
  ///
  /// In vi, this message translates to:
  /// **'Cần thêm {points} điểm để lên hạng {tierName}'**
  String loyaltyPointsNeeded(int points, String tierName);

  /// No description provided for @loyaltyCurrentBenefits.
  ///
  /// In vi, this message translates to:
  /// **'Quyền lợi hiện tại'**
  String get loyaltyCurrentBenefits;

  /// No description provided for @loyaltyTransactionHistory.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử giao dịch'**
  String get loyaltyTransactionHistory;

  /// No description provided for @loyaltyNoTransactions.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có giao dịch nào'**
  String get loyaltyNoTransactions;

  /// No description provided for @loyaltyPointsFormat.
  ///
  /// In vi, this message translates to:
  /// **'{sign}{points} điểm'**
  String loyaltyPointsFormat(String sign, int points);

  /// No description provided for @profileUser.
  ///
  /// In vi, this message translates to:
  /// **'Người dùng'**
  String get profileUser;

  /// No description provided for @profilePointsAccumulated.
  ///
  /// In vi, this message translates to:
  /// **'{points} điểm tích lũy'**
  String profilePointsAccumulated(int points);

  /// No description provided for @profileOffers.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi'**
  String get profileOffers;

  /// No description provided for @profileStores.
  ///
  /// In vi, this message translates to:
  /// **'Cửa hàng'**
  String get profileStores;

  /// No description provided for @profileEditInfo.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin'**
  String get profileEditInfo;

  /// No description provided for @profileMyOffers.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi của tôi'**
  String get profileMyOffers;

  /// No description provided for @profileSupport.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ'**
  String get profileSupport;

  /// No description provided for @profileHotline.
  ///
  /// In vi, this message translates to:
  /// **'Liên hệ hotline: 1900 1234'**
  String get profileHotline;

  /// No description provided for @profileLogoutConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn đăng xuất không?'**
  String get profileLogoutConfirm;

  /// No description provided for @profileAppVersion.
  ///
  /// In vi, this message translates to:
  /// **'Cơm Tấm Má Tư v{version}'**
  String profileAppVersion(String version);

  /// No description provided for @editProfileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin'**
  String get editProfileTitle;

  /// No description provided for @editProfileName.
  ///
  /// In vi, this message translates to:
  /// **'Họ tên'**
  String get editProfileName;

  /// No description provided for @editProfileNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ tên'**
  String get editProfileNameHint;

  /// No description provided for @editProfileNameRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập họ tên'**
  String get editProfileNameRequired;

  /// No description provided for @editProfileEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get editProfileEmail;

  /// No description provided for @editProfileEmailHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email'**
  String get editProfileEmailHint;

  /// No description provided for @editProfileEmailInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Email không hợp lệ'**
  String get editProfileEmailInvalid;

  /// No description provided for @editProfileDob.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get editProfileDob;

  /// No description provided for @editProfileDobHint.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngày sinh'**
  String get editProfileDobHint;

  /// No description provided for @editProfileDobCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get editProfileDobCancel;

  /// No description provided for @editProfileDobConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Chọn'**
  String get editProfileDobConfirm;

  /// No description provided for @editProfileGender.
  ///
  /// In vi, this message translates to:
  /// **'Giới tính'**
  String get editProfileGender;

  /// No description provided for @editProfileGenderMale.
  ///
  /// In vi, this message translates to:
  /// **'Nam'**
  String get editProfileGenderMale;

  /// No description provided for @editProfileGenderFemale.
  ///
  /// In vi, this message translates to:
  /// **'Nữ'**
  String get editProfileGenderFemale;

  /// No description provided for @editProfileGenderOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get editProfileGenderOther;

  /// No description provided for @editProfileSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get editProfileSave;

  /// No description provided for @editProfileSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thông tin thành công'**
  String get editProfileSuccess;

  /// No description provided for @editProfileFeatureInDev.
  ///
  /// In vi, this message translates to:
  /// **'Chức năng đang phát triển'**
  String get editProfileFeatureInDev;

  /// No description provided for @addressCannotLoad.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải địa chỉ'**
  String get addressCannotLoad;

  /// No description provided for @addressEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chưa lưu địa chỉ nào'**
  String get addressEmpty;

  /// No description provided for @addressDeleteTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa địa chỉ'**
  String get addressDeleteTitle;

  /// No description provided for @addressDeleteConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa địa chỉ này không?'**
  String get addressDeleteConfirm;

  /// No description provided for @addressDefault.
  ///
  /// In vi, this message translates to:
  /// **'Mặc định'**
  String get addressDefault;

  /// No description provided for @addressSetDefault.
  ///
  /// In vi, this message translates to:
  /// **'Đặt làm mặc định'**
  String get addressSetDefault;

  /// No description provided for @addressAddNew.
  ///
  /// In vi, this message translates to:
  /// **'Thêm địa chỉ mới'**
  String get addressAddNew;

  /// No description provided for @addressEditTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa địa chỉ'**
  String get addressEditTitle;

  /// No description provided for @addressTypeLabel.
  ///
  /// In vi, this message translates to:
  /// **'Loại địa chỉ'**
  String get addressTypeLabel;

  /// No description provided for @addressTypeHome.
  ///
  /// In vi, this message translates to:
  /// **'Nhà'**
  String get addressTypeHome;

  /// No description provided for @addressTypeWork.
  ///
  /// In vi, this message translates to:
  /// **'Công ty'**
  String get addressTypeWork;

  /// No description provided for @addressTypeOther.
  ///
  /// In vi, this message translates to:
  /// **'Khác'**
  String get addressTypeOther;

  /// No description provided for @addressStreet.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ'**
  String get addressStreet;

  /// No description provided for @addressStreetHint.
  ///
  /// In vi, this message translates to:
  /// **'Số nhà, tên đường'**
  String get addressStreetHint;

  /// No description provided for @addressStreetRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập địa chỉ'**
  String get addressStreetRequired;

  /// No description provided for @addressWard.
  ///
  /// In vi, this message translates to:
  /// **'Phường/Xã'**
  String get addressWard;

  /// No description provided for @addressWardHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập phường/xã'**
  String get addressWardHint;

  /// No description provided for @addressWardRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập phường/xã'**
  String get addressWardRequired;

  /// No description provided for @addressDistrict.
  ///
  /// In vi, this message translates to:
  /// **'Quận/Huyện'**
  String get addressDistrict;

  /// No description provided for @addressDistrictHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập quận/huyện'**
  String get addressDistrictHint;

  /// No description provided for @addressDistrictRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập quận/huyện'**
  String get addressDistrictRequired;

  /// No description provided for @addressCity.
  ///
  /// In vi, this message translates to:
  /// **'Thành phố'**
  String get addressCity;

  /// No description provided for @addressCityHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập thành phố'**
  String get addressCityHint;

  /// No description provided for @addressCityRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập thành phố'**
  String get addressCityRequired;

  /// No description provided for @addressUpdate.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật'**
  String get addressUpdate;

  /// No description provided for @addressAdd.
  ///
  /// In vi, this message translates to:
  /// **'Thêm'**
  String get addressAdd;

  /// No description provided for @storeNoResults.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy cửa hàng'**
  String get storeNoResults;

  /// No description provided for @storeMapPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Bản đồ cửa hàng'**
  String get storeMapPlaceholder;

  /// No description provided for @storeMapSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tích hợp Google Maps sẽ hiển thị ở đây'**
  String get storeMapSubtitle;

  /// No description provided for @storeOpeningHours.
  ///
  /// In vi, this message translates to:
  /// **'Giờ mở cửa: {open} - {close}'**
  String storeOpeningHours(String open, String close);

  /// No description provided for @storeDirections.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ đường'**
  String get storeDirections;

  /// No description provided for @storeSortedByDistance.
  ///
  /// In vi, this message translates to:
  /// **'Đã sắp xếp theo khoảng cách gần nhất'**
  String get storeSortedByDistance;

  /// No description provided for @storeNearMe.
  ///
  /// In vi, this message translates to:
  /// **'Gần tôi'**
  String get storeNearMe;

  /// No description provided for @voucherAvailable.
  ///
  /// In vi, this message translates to:
  /// **'Có sẵn'**
  String get voucherAvailable;

  /// No description provided for @voucherMine.
  ///
  /// In vi, this message translates to:
  /// **'Của tôi'**
  String get voucherMine;

  /// No description provided for @voucherRedeemConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận đổi voucher'**
  String get voucherRedeemConfirmTitle;

  /// No description provided for @voucherRedeemConfirmMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn sẽ sử dụng {points} điểm để đổi voucher này.'**
  String voucherRedeemConfirmMessage(String points);

  /// No description provided for @voucherRedeemNow.
  ///
  /// In vi, this message translates to:
  /// **'Đổi ngay'**
  String get voucherRedeemNow;

  /// No description provided for @voucherRedeemSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đổi voucher \"{title}\" thành công!'**
  String voucherRedeemSuccess(String title);

  /// No description provided for @voucherRedeemFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đổi voucher thất bại: {error}'**
  String voucherRedeemFailed(String error);

  /// No description provided for @voucherCodeCopied.
  ///
  /// In vi, this message translates to:
  /// **'Mã \"{code}\" đã được sao chép. Áp dụng khi đặt hàng!'**
  String voucherCodeCopied(String code);

  /// No description provided for @voucherEmptyAvailable.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có voucher nào để đổi.\nHãy quay lại sau nhé!'**
  String get voucherEmptyAvailable;

  /// No description provided for @voucherEmptyMine.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chưa có voucher nào.\nĐổi điểm để nhận ưu đãi ngay!'**
  String get voucherEmptyMine;

  /// No description provided for @voucherDiscountPercent.
  ///
  /// In vi, this message translates to:
  /// **'Giảm {value}%'**
  String voucherDiscountPercent(String value);

  /// No description provided for @voucherDiscountFixed.
  ///
  /// In vi, this message translates to:
  /// **'Giảm {value}₫'**
  String voucherDiscountFixed(String value);

  /// No description provided for @voucherMinOrder.
  ///
  /// In vi, this message translates to:
  /// **'Đơn tối thiểu: {amount}₫'**
  String voucherMinOrder(String amount);

  /// No description provided for @voucherExpiry.
  ///
  /// In vi, this message translates to:
  /// **'HSD: {date}'**
  String voucherExpiry(String date);

  /// No description provided for @voucherUse.
  ///
  /// In vi, this message translates to:
  /// **'Sử dụng'**
  String get voucherUse;

  /// No description provided for @notifPermissionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bật thông báo'**
  String get notifPermissionTitle;

  /// No description provided for @notifPermissionDescription.
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo để không bỏ lỡ ưu đãi và cập nhật đơn hàng'**
  String get notifPermissionDescription;

  /// No description provided for @notifPermissionBenefitOrders.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật trạng thái đơn hàng theo thời gian thực'**
  String get notifPermissionBenefitOrders;

  /// No description provided for @notifPermissionBenefitPromotions.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo ưu đãi và khuyến mãi mới'**
  String get notifPermissionBenefitPromotions;

  /// No description provided for @notifPermissionBenefitPoints.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc nhở tích điểm và phần thưởng'**
  String get notifPermissionBenefitPoints;

  /// No description provided for @notifPermissionEnable.
  ///
  /// In vi, this message translates to:
  /// **'Bật thông báo'**
  String get notifPermissionEnable;

  /// No description provided for @notifPermissionSkip.
  ///
  /// In vi, this message translates to:
  /// **'Để sau'**
  String get notifPermissionSkip;

  /// No description provided for @notifReadAll.
  ///
  /// In vi, this message translates to:
  /// **'Đọc tất cả'**
  String get notifReadAll;

  /// No description provided for @notifCannotLoad.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải thông báo'**
  String get notifCannotLoad;

  /// No description provided for @notifDeleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa thông báo'**
  String get notifDeleted;

  /// No description provided for @notifUndo.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tác'**
  String get notifUndo;

  /// No description provided for @notifJustNow.
  ///
  /// In vi, this message translates to:
  /// **'Vừa xong'**
  String get notifJustNow;

  /// No description provided for @notifMinutesAgo.
  ///
  /// In vi, this message translates to:
  /// **'{minutes} phút trước'**
  String notifMinutesAgo(int minutes);

  /// No description provided for @notifHoursAgo.
  ///
  /// In vi, this message translates to:
  /// **'{hours} giờ trước'**
  String notifHoursAgo(int hours);

  /// No description provided for @notifYesterday.
  ///
  /// In vi, this message translates to:
  /// **'Hôm qua'**
  String get notifYesterday;

  /// No description provided for @notifDayBeforeYesterday.
  ///
  /// In vi, this message translates to:
  /// **'Hôm kia'**
  String get notifDayBeforeYesterday;

  /// No description provided for @notifDaysAgo.
  ///
  /// In vi, this message translates to:
  /// **'{days} ngày trước'**
  String notifDaysAgo(int days);

  /// No description provided for @earnPointsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cách tích điểm'**
  String get earnPointsTitle;

  /// No description provided for @earnPointsCurrentPoints.
  ///
  /// In vi, this message translates to:
  /// **'Điểm hiện có'**
  String get earnPointsCurrentPoints;

  /// No description provided for @earnPointsTierMultiplier.
  ///
  /// In vi, this message translates to:
  /// **'Hạng {tierName} · x{multiplier}'**
  String earnPointsTierMultiplier(String tierName, String multiplier);

  /// No description provided for @earnPointsMethods.
  ///
  /// In vi, this message translates to:
  /// **'Các cách tích điểm'**
  String get earnPointsMethods;

  /// No description provided for @earnPointsCheckin.
  ///
  /// In vi, this message translates to:
  /// **'Điểm danh tại quán'**
  String get earnPointsCheckin;

  /// No description provided for @earnPointsCheckinDesc.
  ///
  /// In vi, this message translates to:
  /// **'Quét mã QR tại quầy mỗi lần đến ăn. Nhận 10 điểm/lần điểm danh.'**
  String get earnPointsCheckinDesc;

  /// No description provided for @earnPointsOrder.
  ///
  /// In vi, this message translates to:
  /// **'Đặt hàng'**
  String get earnPointsOrder;

  /// No description provided for @earnPointsOrderDesc.
  ///
  /// In vi, this message translates to:
  /// **'Mỗi đơn hàng được tích 1 điểm cho mỗi 10.000đ. Hạng cao hơn có nhân điểm.'**
  String get earnPointsOrderDesc;

  /// No description provided for @earnPointsStreak.
  ///
  /// In vi, this message translates to:
  /// **'Chuỗi điểm danh'**
  String get earnPointsStreak;

  /// No description provided for @earnPointsStreakDesc.
  ///
  /// In vi, this message translates to:
  /// **'Điểm danh liên tiếp 7 ngày nhận bonus 50 điểm. 30 ngày nhận 200 điểm.'**
  String get earnPointsStreakDesc;

  /// No description provided for @earnPointsPromo.
  ///
  /// In vi, this message translates to:
  /// **'Khuyến mãi đặc biệt'**
  String get earnPointsPromo;

  /// No description provided for @earnPointsPromoDesc.
  ///
  /// In vi, this message translates to:
  /// **'Theo dõi mục Voucher để nhận điểm thưởng từ các chương trình khuyến mãi.'**
  String get earnPointsPromoDesc;

  /// No description provided for @earnPointsCheckinNow.
  ///
  /// In vi, this message translates to:
  /// **'Điểm danh ngay'**
  String get earnPointsCheckinNow;

  /// No description provided for @earnPointsMyQR.
  ///
  /// In vi, this message translates to:
  /// **'Mã QR của tôi'**
  String get earnPointsMyQR;

  /// No description provided for @earnPointsShowQR.
  ///
  /// In vi, this message translates to:
  /// **'Đưa mã này cho nhân viên để tích điểm'**
  String get earnPointsShowQR;

  /// No description provided for @redeemPointsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đổi điểm'**
  String get redeemPointsTitle;

  /// No description provided for @redeemPointsAvailable.
  ///
  /// In vi, this message translates to:
  /// **'Điểm có thể đổi'**
  String get redeemPointsAvailable;

  /// No description provided for @redeemPointsSuffix.
  ///
  /// In vi, this message translates to:
  /// **'điểm'**
  String get redeemPointsSuffix;

  /// No description provided for @redeemPointsRewards.
  ///
  /// In vi, this message translates to:
  /// **'Phần thưởng'**
  String get redeemPointsRewards;

  /// No description provided for @redeemPointsRedeem.
  ///
  /// In vi, this message translates to:
  /// **'Đổi'**
  String get redeemPointsRedeem;

  /// No description provided for @redeemPointsConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận đổi điểm'**
  String get redeemPointsConfirmTitle;

  /// No description provided for @redeemPointsConfirmMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn muốn dùng {points} điểm để đổi \"{name}\"?'**
  String redeemPointsConfirmMessage(int points, String name);

  /// No description provided for @redeemPointsSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đổi thành công: {name}'**
  String redeemPointsSuccess(String name);

  /// No description provided for @redeemPointsFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đổi điểm thất bại: {error}'**
  String redeemPointsFailed(String error);

  /// No description provided for @redeemPointsInsufficient.
  ///
  /// In vi, this message translates to:
  /// **'Không đủ điểm để đổi phần thưởng này'**
  String get redeemPointsInsufficient;

  /// No description provided for @redeemPointsNoRewards.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có phần thưởng nào'**
  String get redeemPointsNoRewards;

  /// No description provided for @feedbackTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá đơn hàng'**
  String get feedbackTitle;

  /// No description provided for @feedbackOrderId.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng #{orderId}'**
  String feedbackOrderId(String orderId);

  /// No description provided for @feedbackShareExperience.
  ///
  /// In vi, this message translates to:
  /// **'Hãy cho chúng tôi biết trải nghiệm của bạn'**
  String get feedbackShareExperience;

  /// No description provided for @feedbackHowWouldYouRate.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đánh giá thế nào?'**
  String get feedbackHowWouldYouRate;

  /// No description provided for @feedbackWhatDidYouLike.
  ///
  /// In vi, this message translates to:
  /// **'Điều gì bạn thích?'**
  String get feedbackWhatDidYouLike;

  /// No description provided for @feedbackAdditionalComments.
  ///
  /// In vi, this message translates to:
  /// **'Nhận xét thêm'**
  String get feedbackAdditionalComments;

  /// No description provided for @feedbackCommentHint.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ trải nghiệm của bạn...'**
  String get feedbackCommentHint;

  /// No description provided for @feedbackSubmit.
  ///
  /// In vi, this message translates to:
  /// **'Gửi đánh giá'**
  String get feedbackSubmit;

  /// No description provided for @feedbackThankYou.
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn!'**
  String get feedbackThankYou;

  /// No description provided for @feedbackSuccessMessage.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá của bạn đã được gửi thành công.\nCơm Tấm Má Tư luôn lắng nghe để phục vụ bạn tốt hơn!'**
  String get feedbackSuccessMessage;

  /// No description provided for @feedbackBack.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get feedbackBack;

  /// No description provided for @feedbackSelectRating.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn số sao đánh giá'**
  String get feedbackSelectRating;

  /// No description provided for @feedbackTagDelicious.
  ///
  /// In vi, this message translates to:
  /// **'Ngon'**
  String get feedbackTagDelicious;

  /// No description provided for @feedbackTagFast.
  ///
  /// In vi, this message translates to:
  /// **'Nhanh'**
  String get feedbackTagFast;

  /// No description provided for @feedbackTagClean.
  ///
  /// In vi, this message translates to:
  /// **'Sạch sẽ'**
  String get feedbackTagClean;

  /// No description provided for @feedbackTagFriendly.
  ///
  /// In vi, this message translates to:
  /// **'Thân thiện'**
  String get feedbackTagFriendly;

  /// No description provided for @feedbackTagFairPrice.
  ///
  /// In vi, this message translates to:
  /// **'Giá hợp lý'**
  String get feedbackTagFairPrice;

  /// No description provided for @feedbackTagLargePortions.
  ///
  /// In vi, this message translates to:
  /// **'Phần lượng nhiều'**
  String get feedbackTagLargePortions;

  /// No description provided for @feedbackRatingTerrible.
  ///
  /// In vi, this message translates to:
  /// **'Rất tệ'**
  String get feedbackRatingTerrible;

  /// No description provided for @feedbackRatingBad.
  ///
  /// In vi, this message translates to:
  /// **'Tệ'**
  String get feedbackRatingBad;

  /// No description provided for @feedbackRatingAverage.
  ///
  /// In vi, this message translates to:
  /// **'Bình thường'**
  String get feedbackRatingAverage;

  /// No description provided for @feedbackRatingGood.
  ///
  /// In vi, this message translates to:
  /// **'Tốt'**
  String get feedbackRatingGood;

  /// No description provided for @feedbackRatingExcellent.
  ///
  /// In vi, this message translates to:
  /// **'Tuyệt vời'**
  String get feedbackRatingExcellent;

  /// No description provided for @deliveryCannotLoad.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải thông tin giao hàng'**
  String get deliveryCannotLoad;

  /// No description provided for @deliveryStatusWaiting.
  ///
  /// In vi, this message translates to:
  /// **'Chờ tài xế'**
  String get deliveryStatusWaiting;

  /// No description provided for @deliveryStatusAccepted.
  ///
  /// In vi, this message translates to:
  /// **'Đã nhận đơn'**
  String get deliveryStatusAccepted;

  /// No description provided for @deliveryStatusPickedUp.
  ///
  /// In vi, this message translates to:
  /// **'Đã lấy hàng'**
  String get deliveryStatusPickedUp;

  /// No description provided for @deliveryStatusOnTheWay.
  ///
  /// In vi, this message translates to:
  /// **'Đang giao'**
  String get deliveryStatusOnTheWay;

  /// No description provided for @deliveryStatusArrived.
  ///
  /// In vi, this message translates to:
  /// **'Đã đến'**
  String get deliveryStatusArrived;

  /// No description provided for @deliveryStatusCompleted.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get deliveryStatusCompleted;

  /// No description provided for @deliveryOrderStatus.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái đơn hàng'**
  String get deliveryOrderStatus;

  /// No description provided for @deliveryDriver.
  ///
  /// In vi, this message translates to:
  /// **'Tài xế'**
  String get deliveryDriver;

  /// No description provided for @deliveryUpdating.
  ///
  /// In vi, this message translates to:
  /// **'Đang cập nhật...'**
  String get deliveryUpdating;

  /// No description provided for @deliveryMapPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Bản đồ giao hàng'**
  String get deliveryMapPlaceholder;

  /// No description provided for @deliveryEstimatedTime.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian dự kiến'**
  String get deliveryEstimatedTime;

  /// No description provided for @deliveryMinutesLeft.
  ///
  /// In vi, this message translates to:
  /// **'Còn khoảng {minutes} phút'**
  String deliveryMinutesLeft(int minutes);

  /// No description provided for @deliveryArriving.
  ///
  /// In vi, this message translates to:
  /// **'Đang đến nơi'**
  String get deliveryArriving;

  /// No description provided for @deliveryOrderCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã đơn hàng'**
  String get deliveryOrderCode;

  /// No description provided for @deliveryStatus.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái'**
  String get deliveryStatus;

  /// No description provided for @deliveryOrderInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin đơn hàng'**
  String get deliveryOrderInfo;

  /// No description provided for @errorWithMessage.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi: {message}'**
  String errorWithMessage(String message);
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
