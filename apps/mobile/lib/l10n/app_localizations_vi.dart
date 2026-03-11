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
}
