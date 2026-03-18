// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Cơm Tấm Má Tư';

  @override
  String get home => 'Trang chủ';

  @override
  String get menu => 'Thực đơn';

  @override
  String get cart => 'Giỏ hàng';

  @override
  String get orders => 'Đơn hàng';

  @override
  String get loyalty => 'Tích điểm';

  @override
  String get profile => 'Tài khoản';

  @override
  String get login => 'Đăng nhập';

  @override
  String get register => 'Đăng ký';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get loading => 'Đang tải...';

  @override
  String get error => 'Đã xảy ra lỗi';

  @override
  String get retry => 'Thử lại';

  @override
  String get noData => 'Không có dữ liệu';

  @override
  String get noConnection => 'Không có kết nối mạng';

  @override
  String get offlineMode => 'Chế độ ngoại tuyến';

  @override
  String get addToCart => 'Thêm vào giỏ hàng';

  @override
  String get checkout => 'Thanh toán';

  @override
  String get totalPoints => 'Tổng điểm';

  @override
  String get availablePoints => 'Điểm khả dụng';

  @override
  String get memberTier => 'Hạng thành viên';

  @override
  String get checkIn => 'Điểm danh';

  @override
  String get delivery => 'Giao hàng';

  @override
  String get storeLocator => 'Tìm cửa hàng';

  @override
  String get notifications => 'Thông báo';

  @override
  String get settings => 'Cài đặt';

  @override
  String get vouchers => 'Ưu đãi';

  @override
  String get feedback => 'Đánh giá';

  @override
  String get dashboard => 'Bảng điều khiển';

  @override
  String get staffManagement => 'Quản lý nhân viên';

  @override
  String get inventory => 'Kho hàng';

  @override
  String get savedAddresses => 'Địa chỉ đã lưu';

  @override
  String get editProfile => 'Chỉnh sửa hồ sơ';

  @override
  String get orderHistory => 'Lịch sử đơn hàng';

  @override
  String get deliveryTracking => 'Theo dõi giao hàng';

  @override
  String get redeemPoints => 'Đổi điểm';

  @override
  String get earnPoints => 'Tích điểm';

  @override
  String get scanQR => 'Quét mã QR';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get edit => 'Sửa';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get filter => 'Lọc';

  @override
  String get sortBy => 'Sắp xếp theo';

  @override
  String get all => 'Tất cả';

  @override
  String get today => 'Hôm nay';

  @override
  String get thisWeek => 'Tuần này';

  @override
  String get thisMonth => 'Tháng này';

  @override
  String get totalRevenue => 'Tổng doanh thu';

  @override
  String get totalOrders => 'Tổng đơn hàng';

  @override
  String get newMembers => 'Thành viên mới';

  @override
  String get lowStock => 'Sắp hết hàng';

  @override
  String get restock => 'Nhập hàng';

  @override
  String get welcomeBack => 'Chào mừng trở lại!';

  @override
  String get seeAll => 'Xem tất cả';

  @override
  String get noNotifications => 'Không có thông báo nào';

  @override
  String get noOrders => 'Bạn chưa có đơn hàng nào';

  @override
  String get emptyCart => 'Giỏ hàng trống';

  @override
  String get continueOrdering => 'Tiếp tục đặt hàng';

  @override
  String get orderSuccess => 'Đặt hàng thành công!';

  @override
  String pointsEarned(int points) {
    return 'Bạn đã nhận được $points điểm';
  }

  @override
  String itemCount(int count) {
    return '$count món';
  }

  @override
  String priceFormat(String price) {
    return '$priceđ';
  }

  @override
  String get authLoginSubtitle => 'Đăng nhập để tích điểm và đặt hàng';

  @override
  String get authPhone => 'Số điện thoại';

  @override
  String get authPhoneHint => '0901234567';

  @override
  String get authPhoneRequired => 'Vui lòng nhập số điện thoại';

  @override
  String get authPhoneInvalid => 'Số điện thoại không hợp lệ';

  @override
  String get authPassword => 'Mật khẩu';

  @override
  String get authPasswordHint => 'Nhập mật khẩu';

  @override
  String get authPasswordRequired => 'Vui lòng nhập mật khẩu';

  @override
  String get authPasswordMinLength => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get authForgotPassword => 'Quên mật khẩu?';

  @override
  String get authLoginFailed => 'Đăng nhập thất bại. Vui lòng thử lại.';

  @override
  String get authNoAccount => 'Chưa có tài khoản? ';

  @override
  String get authRegisterNow => 'Đăng ký ngay';

  @override
  String get authCreateAccount => 'Tạo tài khoản mới';

  @override
  String get authRegisterSubtitle => 'Đăng ký để tích điểm và nhận ưu đãi';

  @override
  String get authFullName => 'Họ và tên';

  @override
  String get authFullNameHint => 'Nguyễn Văn A';

  @override
  String get authFullNameRequired => 'Vui lòng nhập họ và tên';

  @override
  String get authFullNameMinLength => 'Họ tên phải có ít nhất 2 ký tự';

  @override
  String get authPasswordHintShort => 'Ít nhất 6 ký tự';

  @override
  String get authConfirmPassword => 'Xác nhận mật khẩu';

  @override
  String get authConfirmPasswordHint => 'Nhập lại mật khẩu';

  @override
  String get authConfirmPasswordRequired => 'Vui lòng xác nhận mật khẩu';

  @override
  String get authPasswordMismatch => 'Mật khẩu không khớp';

  @override
  String get authReferralCode => 'Mã giới thiệu (không bắt buộc)';

  @override
  String get authReferralCodeHint => 'Nhập mã giới thiệu nếu có';

  @override
  String get authRegisterFailed => 'Đăng ký thất bại. Vui lòng thử lại.';

  @override
  String get authHasAccount => 'Đã có tài khoản? ';

  @override
  String get authOtpTitle => 'Xác thực OTP';

  @override
  String get authOtpEnterCode => 'Nhập mã xác thực';

  @override
  String get authOtpSentTo => 'Mã OTP đã được gửi đến số\n';

  @override
  String get authOtpRequired => 'Vui lòng nhập đầy đủ mã OTP';

  @override
  String get authOtpInvalid => 'Mã OTP không hợp lệ. Vui lòng thử lại.';

  @override
  String authOtpResendCountdown(int seconds) {
    return 'Gửi lại mã sau ${seconds}s';
  }

  @override
  String get authOtpResend => 'Gửi lại mã OTP';

  @override
  String get authOtpResent => 'Đã gửi lại mã OTP';

  @override
  String get homeQuickActions => 'Thao tác nhanh';

  @override
  String get homeAccumulatedPoints => 'Điểm tích lũy';

  @override
  String get homeAvailablePoints => 'điểm khả dụng';

  @override
  String get homePromotionsForYou => 'Ưu đãi dành cho bạn';

  @override
  String get homeLoadingPromotions => 'Đang tải ưu đãi...';

  @override
  String get homeNoPromotions => 'Chưa có ưu đãi nào';

  @override
  String get homeEligible => 'Đủ điều kiện';

  @override
  String get homeRecentTransactions => 'Giao dịch gần đây';

  @override
  String homePointsToNextTier(String points, String tierName) {
    return 'Còn $points điểm nữa lên hạng $tierName';
  }

  @override
  String get menuSearchHint => 'Tìm món ăn...';

  @override
  String get menuNoResults => 'Không tìm thấy món ăn';

  @override
  String get menuOffline => 'Ngoại tuyến';

  @override
  String get menuHotBadge => 'Hot';

  @override
  String get menuAdd => 'Thêm';

  @override
  String menuAddedToCart(String name) {
    return 'Đã thêm $name vào giỏ hàng';
  }

  @override
  String get menuCategoryComTam => 'Cơm tấm';

  @override
  String get menuCategorySides => 'Món thêm';

  @override
  String get menuCategoryDrinks => 'Nước uống';

  @override
  String get menuCategoryDesserts => 'Tráng miệng';

  @override
  String get cartClearAll => 'Xóa tất cả';

  @override
  String get cartEmptyMessage =>
      'Hãy thêm món ăn từ thực đơn\nđể bắt đầu đặt hàng nhé!';

  @override
  String get cartViewMenu => 'Xem thực đơn';

  @override
  String get cartDeliveryAddress => 'Địa chỉ giao hàng';

  @override
  String get cartNoAddress => 'Chưa chọn địa chỉ';

  @override
  String get cartSelectAddress => 'Chọn địa chỉ';

  @override
  String get cartPaymentMethod => 'Phương thức thanh toán';

  @override
  String get cartPaymentCod => 'Thanh toán khi nhận hàng';

  @override
  String get cartPaymentMomo => 'Ví MoMo';

  @override
  String get cartPaymentZalopay => 'ZaloPay';

  @override
  String get cartOrderDetails => 'Chi tiết đơn hàng';

  @override
  String get cartSubtotal => 'Tạm tính';

  @override
  String get cartDeliveryFee => 'Phí giao hàng';

  @override
  String get cartDiscount => 'Giảm giá';

  @override
  String get cartTotal => 'Tổng cộng';

  @override
  String get cartPlaceOrder => 'Đặt hàng';

  @override
  String get cartNoteHint => 'Ghi chú (vd: ít hành, thêm nước mắm...)';

  @override
  String get orderCannotLoad => 'Không thể tải đơn hàng';

  @override
  String get orderStatusDelivered => 'Hoàn thành';

  @override
  String get orderStatusDelivering => 'Đang giao';

  @override
  String get orderStatusPickedUp => 'Đã lấy hàng';

  @override
  String get orderStatusPending => 'Chờ xác nhận';

  @override
  String get orderStatusConfirmed => 'Đã xác nhận';

  @override
  String get orderStatusPreparing => 'Đang chuẩn bị';

  @override
  String get orderStatusCancelled => 'Đã hủy';

  @override
  String get orderFilterDelivering => 'Đang giao';

  @override
  String get orderFilterDelivered => 'Hoàn thành';

  @override
  String get orderFilterCancelled => 'Đã hủy';

  @override
  String get orderEmptyAll => 'Chưa có đơn hàng nào';

  @override
  String get orderEmptyDelivering => 'Không có đơn đang giao';

  @override
  String get orderEmptyDelivered => 'Chưa có đơn hoàn thành';

  @override
  String get orderEmptyCancelled => 'Không có đơn đã hủy';

  @override
  String get orderEmptyHint => 'Hãy đặt món từ thực đơn\nđể bắt đầu nhé!';

  @override
  String orderNumber(String orderId) {
    return 'Đơn #$orderId';
  }

  @override
  String orderPointsEarned(int points) {
    return '+$points điểm';
  }

  @override
  String get orderTrack => 'Theo dõi';

  @override
  String get orderRate => 'Đánh giá';

  @override
  String get orderReorder => 'Đặt lại';

  @override
  String get orderReorderAdding => 'Đang thêm các món vào giỏ hàng...';

  @override
  String get loyaltyCannotLoad => 'Không thể tải dữ liệu tích điểm';

  @override
  String get loyaltyPointsSuffix => 'điểm';

  @override
  String loyaltyTierName(String name) {
    return 'Hạng $name';
  }

  @override
  String loyaltyPointsNeeded(int points, String tierName) {
    return 'Cần thêm $points điểm để lên hạng $tierName';
  }

  @override
  String get loyaltyCurrentBenefits => 'Quyền lợi hiện tại';

  @override
  String get loyaltyTransactionHistory => 'Lịch sử giao dịch';

  @override
  String get loyaltyNoTransactions => 'Chưa có giao dịch nào';

  @override
  String loyaltyPointsFormat(String sign, int points) {
    return '$sign$points điểm';
  }

  @override
  String get profileUser => 'Người dùng';

  @override
  String profilePointsAccumulated(int points) {
    return '$points điểm tích lũy';
  }

  @override
  String get profileOffers => 'Ưu đãi';

  @override
  String get profileStores => 'Cửa hàng';

  @override
  String get profileEditInfo => 'Chỉnh sửa thông tin';

  @override
  String get profileMyOffers => 'Ưu đãi của tôi';

  @override
  String get profileSupport => 'Hỗ trợ';

  @override
  String get profileHotline => 'Liên hệ hotline: 1900 1234';

  @override
  String get profileLogoutConfirm => 'Bạn có chắc chắn muốn đăng xuất không?';

  @override
  String profileAppVersion(String version) {
    return 'Cơm Tấm Má Tư v$version';
  }

  @override
  String get editProfileTitle => 'Chỉnh sửa thông tin';

  @override
  String get editProfileName => 'Họ tên';

  @override
  String get editProfileNameHint => 'Nhập họ tên';

  @override
  String get editProfileNameRequired => 'Vui lòng nhập họ tên';

  @override
  String get editProfileEmail => 'Email';

  @override
  String get editProfileEmailHint => 'Nhập email';

  @override
  String get editProfileEmailInvalid => 'Email không hợp lệ';

  @override
  String get editProfileDob => 'Ngày sinh';

  @override
  String get editProfileDobHint => 'Chọn ngày sinh';

  @override
  String get editProfileDobCancel => 'Hủy';

  @override
  String get editProfileDobConfirm => 'Chọn';

  @override
  String get editProfileGender => 'Giới tính';

  @override
  String get editProfileGenderMale => 'Nam';

  @override
  String get editProfileGenderFemale => 'Nữ';

  @override
  String get editProfileGenderOther => 'Khác';

  @override
  String get editProfileSave => 'Lưu thay đổi';

  @override
  String get editProfileSuccess => 'Cập nhật thông tin thành công';

  @override
  String get editProfileFeatureInDev => 'Chức năng đang phát triển';

  @override
  String get addressCannotLoad => 'Không thể tải địa chỉ';

  @override
  String get addressEmpty => 'Bạn chưa lưu địa chỉ nào';

  @override
  String get addressDeleteTitle => 'Xóa địa chỉ';

  @override
  String get addressDeleteConfirm =>
      'Bạn có chắc chắn muốn xóa địa chỉ này không?';

  @override
  String get addressDefault => 'Mặc định';

  @override
  String get addressSetDefault => 'Đặt làm mặc định';

  @override
  String get addressAddNew => 'Thêm địa chỉ mới';

  @override
  String get addressEditTitle => 'Chỉnh sửa địa chỉ';

  @override
  String get addressTypeLabel => 'Loại địa chỉ';

  @override
  String get addressTypeHome => 'Nhà';

  @override
  String get addressTypeWork => 'Công ty';

  @override
  String get addressTypeOther => 'Khác';

  @override
  String get addressStreet => 'Địa chỉ';

  @override
  String get addressStreetHint => 'Số nhà, tên đường';

  @override
  String get addressStreetRequired => 'Vui lòng nhập địa chỉ';

  @override
  String get addressWard => 'Phường/Xã';

  @override
  String get addressWardHint => 'Nhập phường/xã';

  @override
  String get addressWardRequired => 'Vui lòng nhập phường/xã';

  @override
  String get addressDistrict => 'Quận/Huyện';

  @override
  String get addressDistrictHint => 'Nhập quận/huyện';

  @override
  String get addressDistrictRequired => 'Vui lòng nhập quận/huyện';

  @override
  String get addressCity => 'Thành phố';

  @override
  String get addressCityHint => 'Nhập thành phố';

  @override
  String get addressCityRequired => 'Vui lòng nhập thành phố';

  @override
  String get addressUpdate => 'Cập nhật';

  @override
  String get addressAdd => 'Thêm';

  @override
  String get storeNoResults => 'Không tìm thấy cửa hàng';

  @override
  String get storeMapPlaceholder => 'Bản đồ cửa hàng';

  @override
  String get storeMapSubtitle => 'Tích hợp Google Maps sẽ hiển thị ở đây';

  @override
  String storeOpeningHours(String open, String close) {
    return 'Giờ mở cửa: $open - $close';
  }

  @override
  String get storeDirections => 'Chỉ đường';

  @override
  String get storeSortedByDistance => 'Đã sắp xếp theo khoảng cách gần nhất';

  @override
  String get storeNearMe => 'Gần tôi';

  @override
  String get voucherAvailable => 'Có sẵn';

  @override
  String get voucherMine => 'Của tôi';

  @override
  String get voucherRedeemConfirmTitle => 'Xác nhận đổi voucher';

  @override
  String voucherRedeemConfirmMessage(String points) {
    return 'Bạn sẽ sử dụng $points điểm để đổi voucher này.';
  }

  @override
  String get voucherRedeemNow => 'Đổi ngay';

  @override
  String voucherRedeemSuccess(String title) {
    return 'Đổi voucher \"$title\" thành công!';
  }

  @override
  String voucherRedeemFailed(String error) {
    return 'Đổi voucher thất bại: $error';
  }

  @override
  String voucherCodeCopied(String code) {
    return 'Mã \"$code\" đã được sao chép. Áp dụng khi đặt hàng!';
  }

  @override
  String get voucherEmptyAvailable =>
      'Chưa có voucher nào để đổi.\nHãy quay lại sau nhé!';

  @override
  String get voucherEmptyMine =>
      'Bạn chưa có voucher nào.\nĐổi điểm để nhận ưu đãi ngay!';

  @override
  String voucherDiscountPercent(String value) {
    return 'Giảm $value%';
  }

  @override
  String voucherDiscountFixed(String value) {
    return 'Giảm $value₫';
  }

  @override
  String voucherMinOrder(String amount) {
    return 'Đơn tối thiểu: $amount₫';
  }

  @override
  String voucherExpiry(String date) {
    return 'HSD: $date';
  }

  @override
  String get voucherUse => 'Sử dụng';

  @override
  String get notifPermissionTitle => 'Bật thông báo';

  @override
  String get notifPermissionDescription =>
      'Nhận thông báo để không bỏ lỡ ưu đãi và cập nhật đơn hàng';

  @override
  String get notifPermissionBenefitOrders =>
      'Cập nhật trạng thái đơn hàng theo thời gian thực';

  @override
  String get notifPermissionBenefitPromotions =>
      'Thông báo ưu đãi và khuyến mãi mới';

  @override
  String get notifPermissionBenefitPoints =>
      'Nhắc nhở tích điểm và phần thưởng';

  @override
  String get notifPermissionEnable => 'Bật thông báo';

  @override
  String get notifPermissionSkip => 'Để sau';

  @override
  String get notifReadAll => 'Đọc tất cả';

  @override
  String get notifCannotLoad => 'Không thể tải thông báo';

  @override
  String get notifDeleted => 'Đã xóa thông báo';

  @override
  String get notifUndo => 'Hoàn tác';

  @override
  String get notifJustNow => 'Vừa xong';

  @override
  String notifMinutesAgo(int minutes) {
    return '$minutes phút trước';
  }

  @override
  String notifHoursAgo(int hours) {
    return '$hours giờ trước';
  }

  @override
  String get notifYesterday => 'Hôm qua';

  @override
  String get notifDayBeforeYesterday => 'Hôm kia';

  @override
  String notifDaysAgo(int days) {
    return '$days ngày trước';
  }

  @override
  String get earnPointsTitle => 'Cách tích điểm';

  @override
  String get earnPointsCurrentPoints => 'Điểm hiện có';

  @override
  String earnPointsTierMultiplier(String tierName, String multiplier) {
    return 'Hạng $tierName · x$multiplier';
  }

  @override
  String get earnPointsMethods => 'Các cách tích điểm';

  @override
  String get earnPointsCheckin => 'Điểm danh tại quán';

  @override
  String get earnPointsCheckinDesc =>
      'Quét mã QR tại quầy mỗi lần đến ăn. Nhận 10 điểm/lần điểm danh.';

  @override
  String get earnPointsOrder => 'Đặt hàng';

  @override
  String get earnPointsOrderDesc =>
      'Mỗi đơn hàng được tích 1 điểm cho mỗi 10.000đ. Hạng cao hơn có nhân điểm.';

  @override
  String get earnPointsStreak => 'Chuỗi điểm danh';

  @override
  String get earnPointsStreakDesc =>
      'Điểm danh liên tiếp 7 ngày nhận bonus 50 điểm. 30 ngày nhận 200 điểm.';

  @override
  String get earnPointsPromo => 'Khuyến mãi đặc biệt';

  @override
  String get earnPointsPromoDesc =>
      'Theo dõi mục Voucher để nhận điểm thưởng từ các chương trình khuyến mãi.';

  @override
  String get earnPointsCheckinNow => 'Điểm danh ngay';

  @override
  String get earnPointsMyQR => 'Mã QR của tôi';

  @override
  String get earnPointsShowQR => 'Đưa mã này cho nhân viên để tích điểm';

  @override
  String get redeemPointsTitle => 'Đổi điểm';

  @override
  String get redeemPointsAvailable => 'Điểm có thể đổi';

  @override
  String get redeemPointsSuffix => 'điểm';

  @override
  String get redeemPointsRewards => 'Phần thưởng';

  @override
  String get redeemPointsRedeem => 'Đổi';

  @override
  String get redeemPointsConfirmTitle => 'Xác nhận đổi điểm';

  @override
  String redeemPointsConfirmMessage(int points, String name) {
    return 'Bạn muốn dùng $points điểm để đổi \"$name\"?';
  }

  @override
  String redeemPointsSuccess(String name) {
    return 'Đổi thành công: $name';
  }

  @override
  String redeemPointsFailed(String error) {
    return 'Đổi điểm thất bại: $error';
  }

  @override
  String get redeemPointsInsufficient => 'Không đủ điểm để đổi phần thưởng này';

  @override
  String get redeemPointsNoRewards => 'Chưa có phần thưởng nào';

  @override
  String get feedbackTitle => 'Đánh giá đơn hàng';

  @override
  String feedbackOrderId(String orderId) {
    return 'Đơn hàng #$orderId';
  }

  @override
  String get feedbackShareExperience =>
      'Hãy cho chúng tôi biết trải nghiệm của bạn';

  @override
  String get feedbackHowWouldYouRate => 'Bạn đánh giá thế nào?';

  @override
  String get feedbackWhatDidYouLike => 'Điều gì bạn thích?';

  @override
  String get feedbackAdditionalComments => 'Nhận xét thêm';

  @override
  String get feedbackCommentHint => 'Chia sẻ trải nghiệm của bạn...';

  @override
  String get feedbackSubmit => 'Gửi đánh giá';

  @override
  String get feedbackThankYou => 'Cảm ơn bạn!';

  @override
  String get feedbackSuccessMessage =>
      'Đánh giá của bạn đã được gửi thành công.\nCơm Tấm Má Tư luôn lắng nghe để phục vụ bạn tốt hơn!';

  @override
  String get feedbackBack => 'Quay lại';

  @override
  String get feedbackSelectRating => 'Vui lòng chọn số sao đánh giá';

  @override
  String get feedbackTagDelicious => 'Ngon';

  @override
  String get feedbackTagFast => 'Nhanh';

  @override
  String get feedbackTagClean => 'Sạch sẽ';

  @override
  String get feedbackTagFriendly => 'Thân thiện';

  @override
  String get feedbackTagFairPrice => 'Giá hợp lý';

  @override
  String get feedbackTagLargePortions => 'Phần lượng nhiều';

  @override
  String get feedbackRatingTerrible => 'Rất tệ';

  @override
  String get feedbackRatingBad => 'Tệ';

  @override
  String get feedbackRatingAverage => 'Bình thường';

  @override
  String get feedbackRatingGood => 'Tốt';

  @override
  String get feedbackRatingExcellent => 'Tuyệt vời';

  @override
  String get deliveryCannotLoad => 'Không thể tải thông tin giao hàng';

  @override
  String get deliveryStatusWaiting => 'Chờ tài xế';

  @override
  String get deliveryStatusAccepted => 'Đã nhận đơn';

  @override
  String get deliveryStatusPickedUp => 'Đã lấy hàng';

  @override
  String get deliveryStatusOnTheWay => 'Đang giao';

  @override
  String get deliveryStatusArrived => 'Đã đến';

  @override
  String get deliveryStatusCompleted => 'Hoàn thành';

  @override
  String get deliveryOrderStatus => 'Trạng thái đơn hàng';

  @override
  String get deliveryDriver => 'Tài xế';

  @override
  String get deliveryUpdating => 'Đang cập nhật...';

  @override
  String get deliveryMapPlaceholder => 'Bản đồ giao hàng';

  @override
  String get deliveryEstimatedTime => 'Thời gian dự kiến';

  @override
  String deliveryMinutesLeft(int minutes) {
    return 'Còn khoảng $minutes phút';
  }

  @override
  String get deliveryArriving => 'Đang đến nơi';

  @override
  String get deliveryOrderCode => 'Mã đơn hàng';

  @override
  String get deliveryStatus => 'Trạng thái';

  @override
  String get deliveryOrderInfo => 'Thông tin đơn hàng';

  @override
  String errorWithMessage(String message) {
    return 'Lỗi: $message';
  }
}
