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

  @override
  String get authLoginSubtitle => 'Login to earn points and order food';

  @override
  String get authPhone => 'Phone number';

  @override
  String get authPhoneHint => '0901234567';

  @override
  String get authPhoneRequired => 'Please enter your phone number';

  @override
  String get authPhoneInvalid => 'Invalid phone number';

  @override
  String get authPassword => 'Password';

  @override
  String get authPasswordHint => 'Enter password';

  @override
  String get authPasswordRequired => 'Please enter your password';

  @override
  String get authPasswordMinLength => 'Password must be at least 6 characters';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authLoginFailed => 'Login failed. Please try again.';

  @override
  String get authNoAccount => 'Don\'t have an account? ';

  @override
  String get authRegisterNow => 'Register now';

  @override
  String get authCreateAccount => 'Create a new account';

  @override
  String get authRegisterSubtitle => 'Register to earn points and get offers';

  @override
  String get authFullName => 'Full name';

  @override
  String get authFullNameHint => 'Nguyễn Văn A';

  @override
  String get authFullNameRequired => 'Please enter your full name';

  @override
  String get authFullNameMinLength => 'Name must be at least 2 characters';

  @override
  String get authPasswordHintShort => 'At least 6 characters';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authConfirmPasswordHint => 'Re-enter password';

  @override
  String get authConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get authPasswordMismatch => 'Passwords do not match';

  @override
  String get authReferralCode => 'Referral code (optional)';

  @override
  String get authReferralCodeHint => 'Enter referral code if you have one';

  @override
  String get authRegisterFailed => 'Registration failed. Please try again.';

  @override
  String get authHasAccount => 'Already have an account? ';

  @override
  String get authOtpTitle => 'OTP Verification';

  @override
  String get authOtpEnterCode => 'Enter verification code';

  @override
  String get authOtpSentTo => 'OTP code has been sent to\n';

  @override
  String get authOtpRequired => 'Please enter the complete OTP code';

  @override
  String get authOtpInvalid => 'Invalid OTP code. Please try again.';

  @override
  String authOtpResendCountdown(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get authOtpResend => 'Resend OTP';

  @override
  String get authOtpResent => 'OTP code resent';

  @override
  String get homeQuickActions => 'Quick actions';

  @override
  String get homeAccumulatedPoints => 'Accumulated points';

  @override
  String get homeAvailablePoints => 'available points';

  @override
  String get homePromotionsForYou => 'Promotions for you';

  @override
  String get homeLoadingPromotions => 'Loading promotions...';

  @override
  String get homeNoPromotions => 'No promotions available';

  @override
  String get homeEligible => 'Eligible';

  @override
  String get homeRecentTransactions => 'Recent transactions';

  @override
  String homePointsToNextTier(String points, String tierName) {
    return '$points more points to reach $tierName';
  }

  @override
  String get menuSearchHint => 'Search for dishes...';

  @override
  String get menuNoResults => 'No dishes found';

  @override
  String get menuOffline => 'Offline';

  @override
  String get menuHotBadge => 'Hot';

  @override
  String get menuAdd => 'Add';

  @override
  String menuAddedToCart(String name) {
    return 'Added $name to cart';
  }

  @override
  String get menuCategoryComTam => 'Broken rice';

  @override
  String get menuCategorySides => 'Sides';

  @override
  String get menuCategoryDrinks => 'Drinks';

  @override
  String get menuCategoryDesserts => 'Desserts';

  @override
  String get cartClearAll => 'Clear all';

  @override
  String get cartEmptyMessage => 'Add dishes from the menu\nto start ordering!';

  @override
  String get cartViewMenu => 'View menu';

  @override
  String get cartDeliveryAddress => 'Delivery address';

  @override
  String get cartNoAddress => 'No address selected';

  @override
  String get cartSelectAddress => 'Select address';

  @override
  String get cartPaymentMethod => 'Payment method';

  @override
  String get cartPaymentCod => 'Cash on delivery';

  @override
  String get cartPaymentMomo => 'MoMo Wallet';

  @override
  String get cartPaymentZalopay => 'ZaloPay';

  @override
  String get cartOrderDetails => 'Order details';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartDeliveryFee => 'Delivery fee';

  @override
  String get cartDiscount => 'Discount';

  @override
  String get cartTotal => 'Total';

  @override
  String get cartPlaceOrder => 'Place order';

  @override
  String get cartNoteHint => 'Note (e.g.: less onion, extra fish sauce...)';

  @override
  String get orderCannotLoad => 'Cannot load orders';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get orderStatusDelivering => 'Delivering';

  @override
  String get orderStatusPickedUp => 'Picked up';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusConfirmed => 'Confirmed';

  @override
  String get orderStatusPreparing => 'Preparing';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get orderFilterDelivering => 'Delivering';

  @override
  String get orderFilterDelivered => 'Delivered';

  @override
  String get orderFilterCancelled => 'Cancelled';

  @override
  String get orderEmptyAll => 'No orders yet';

  @override
  String get orderEmptyDelivering => 'No active deliveries';

  @override
  String get orderEmptyDelivered => 'No completed orders';

  @override
  String get orderEmptyCancelled => 'No cancelled orders';

  @override
  String get orderEmptyHint => 'Order from the menu\nto get started!';

  @override
  String orderNumber(String orderId) {
    return 'Order #$orderId';
  }

  @override
  String orderPointsEarned(int points) {
    return '+$points points';
  }

  @override
  String get orderTrack => 'Track';

  @override
  String get orderRate => 'Rate';

  @override
  String get orderReorder => 'Reorder';

  @override
  String get orderReorderAdding => 'Adding items to cart...';

  @override
  String get loyaltyCannotLoad => 'Cannot load loyalty data';

  @override
  String get loyaltyPointsSuffix => 'points';

  @override
  String loyaltyTierName(String name) {
    return '$name tier';
  }

  @override
  String loyaltyPointsNeeded(int points, String tierName) {
    return 'Need $points more points to reach $tierName';
  }

  @override
  String get loyaltyCurrentBenefits => 'Current benefits';

  @override
  String get loyaltyTransactionHistory => 'Transaction history';

  @override
  String get loyaltyNoTransactions => 'No transactions yet';

  @override
  String loyaltyPointsFormat(String sign, int points) {
    return '$sign$points points';
  }

  @override
  String get profileUser => 'User';

  @override
  String profilePointsAccumulated(int points) {
    return '$points accumulated points';
  }

  @override
  String get profileOffers => 'Offers';

  @override
  String get profileStores => 'Stores';

  @override
  String get profileEditInfo => 'Edit information';

  @override
  String get profileMyOffers => 'My offers';

  @override
  String get profileSupport => 'Support';

  @override
  String get profileHotline => 'Contact hotline: 1900 1234';

  @override
  String get profileLogoutConfirm => 'Are you sure you want to logout?';

  @override
  String profileAppVersion(String version) {
    return 'Cơm Tấm Má Tư v$version';
  }

  @override
  String get editProfileTitle => 'Edit profile';

  @override
  String get editProfileName => 'Full name';

  @override
  String get editProfileNameHint => 'Enter full name';

  @override
  String get editProfileNameRequired => 'Please enter your full name';

  @override
  String get editProfileEmail => 'Email';

  @override
  String get editProfileEmailHint => 'Enter email';

  @override
  String get editProfileEmailInvalid => 'Invalid email';

  @override
  String get editProfileDob => 'Date of birth';

  @override
  String get editProfileDobHint => 'Select date of birth';

  @override
  String get editProfileDobCancel => 'Cancel';

  @override
  String get editProfileDobConfirm => 'Select';

  @override
  String get editProfileGender => 'Gender';

  @override
  String get editProfileGenderMale => 'Male';

  @override
  String get editProfileGenderFemale => 'Female';

  @override
  String get editProfileGenderOther => 'Other';

  @override
  String get editProfileSave => 'Save changes';

  @override
  String get editProfileSuccess => 'Profile updated successfully';

  @override
  String get editProfileFeatureInDev => 'Feature in development';

  @override
  String get addressCannotLoad => 'Cannot load addresses';

  @override
  String get addressEmpty => 'No saved addresses';

  @override
  String get addressDeleteTitle => 'Delete address';

  @override
  String get addressDeleteConfirm =>
      'Are you sure you want to delete this address?';

  @override
  String get addressDefault => 'Default';

  @override
  String get addressSetDefault => 'Set as default';

  @override
  String get addressAddNew => 'Add new address';

  @override
  String get addressEditTitle => 'Edit address';

  @override
  String get addressTypeLabel => 'Address type';

  @override
  String get addressTypeHome => 'Home';

  @override
  String get addressTypeWork => 'Work';

  @override
  String get addressTypeOther => 'Other';

  @override
  String get addressStreet => 'Address';

  @override
  String get addressStreetHint => 'House number, street name';

  @override
  String get addressStreetRequired => 'Please enter an address';

  @override
  String get addressWard => 'Ward';

  @override
  String get addressWardHint => 'Enter ward';

  @override
  String get addressWardRequired => 'Please enter ward';

  @override
  String get addressDistrict => 'District';

  @override
  String get addressDistrictHint => 'Enter district';

  @override
  String get addressDistrictRequired => 'Please enter district';

  @override
  String get addressCity => 'City';

  @override
  String get addressCityHint => 'Enter city';

  @override
  String get addressCityRequired => 'Please enter city';

  @override
  String get addressUpdate => 'Update';

  @override
  String get addressAdd => 'Add';

  @override
  String get storeNoResults => 'No stores found';

  @override
  String get storeMapPlaceholder => 'Store map';

  @override
  String get storeMapSubtitle => 'Google Maps integration will display here';

  @override
  String storeOpeningHours(String open, String close) {
    return 'Hours: $open - $close';
  }

  @override
  String get storeDirections => 'Directions';

  @override
  String get storeSortedByDistance => 'Sorted by nearest distance';

  @override
  String get storeNearMe => 'Near me';

  @override
  String get voucherAvailable => 'Available';

  @override
  String get voucherMine => 'Mine';

  @override
  String get voucherRedeemConfirmTitle => 'Confirm redeem voucher';

  @override
  String voucherRedeemConfirmMessage(String points) {
    return 'You will use $points points to redeem this voucher.';
  }

  @override
  String get voucherRedeemNow => 'Redeem now';

  @override
  String voucherRedeemSuccess(String title) {
    return 'Successfully redeemed \"$title\" voucher!';
  }

  @override
  String voucherRedeemFailed(String error) {
    return 'Failed to redeem voucher: $error';
  }

  @override
  String voucherCodeCopied(String code) {
    return 'Code \"$code\" copied. Apply when ordering!';
  }

  @override
  String get voucherEmptyAvailable =>
      'No vouchers to redeem.\nCheck back later!';

  @override
  String get voucherEmptyMine =>
      'You have no vouchers.\nRedeem points to get offers!';

  @override
  String voucherDiscountPercent(String value) {
    return '$value% off';
  }

  @override
  String voucherDiscountFixed(String value) {
    return '$value₫ off';
  }

  @override
  String voucherMinOrder(String amount) {
    return 'Min order: $amount₫';
  }

  @override
  String voucherExpiry(String date) {
    return 'Exp: $date';
  }

  @override
  String get voucherUse => 'Use';

  @override
  String get notifReadAll => 'Read all';

  @override
  String get notifCannotLoad => 'Cannot load notifications';

  @override
  String get notifDeleted => 'Notification deleted';

  @override
  String get notifUndo => 'Undo';

  @override
  String get notifJustNow => 'Just now';

  @override
  String notifMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String notifHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get notifYesterday => 'Yesterday';

  @override
  String get notifDayBeforeYesterday => '2 days ago';

  @override
  String notifDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get feedbackTitle => 'Rate your order';

  @override
  String feedbackOrderId(String orderId) {
    return 'Order #$orderId';
  }

  @override
  String get feedbackShareExperience => 'Tell us about your experience';

  @override
  String get feedbackHowWouldYouRate => 'How would you rate?';

  @override
  String get feedbackWhatDidYouLike => 'What did you like?';

  @override
  String get feedbackAdditionalComments => 'Additional comments';

  @override
  String get feedbackCommentHint => 'Share your experience...';

  @override
  String get feedbackSubmit => 'Submit feedback';

  @override
  String get feedbackThankYou => 'Thank you!';

  @override
  String get feedbackSuccessMessage =>
      'Your feedback has been submitted.\nCơm Tấm Má Tư always listens to serve you better!';

  @override
  String get feedbackBack => 'Go back';

  @override
  String get feedbackSelectRating => 'Please select a star rating';

  @override
  String get feedbackTagDelicious => 'Delicious';

  @override
  String get feedbackTagFast => 'Fast';

  @override
  String get feedbackTagClean => 'Clean';

  @override
  String get feedbackTagFriendly => 'Friendly';

  @override
  String get feedbackTagFairPrice => 'Fair price';

  @override
  String get feedbackTagLargePortions => 'Large portions';

  @override
  String get feedbackRatingTerrible => 'Terrible';

  @override
  String get feedbackRatingBad => 'Bad';

  @override
  String get feedbackRatingAverage => 'Average';

  @override
  String get feedbackRatingGood => 'Good';

  @override
  String get feedbackRatingExcellent => 'Excellent';

  @override
  String get deliveryCannotLoad => 'Cannot load delivery info';

  @override
  String get deliveryStatusWaiting => 'Waiting for driver';

  @override
  String get deliveryStatusAccepted => 'Order accepted';

  @override
  String get deliveryStatusPickedUp => 'Picked up';

  @override
  String get deliveryStatusOnTheWay => 'On the way';

  @override
  String get deliveryStatusArrived => 'Arrived';

  @override
  String get deliveryStatusCompleted => 'Completed';

  @override
  String get deliveryOrderStatus => 'Order status';

  @override
  String get deliveryDriver => 'Driver';

  @override
  String get deliveryUpdating => 'Updating...';

  @override
  String get deliveryMapPlaceholder => 'Delivery map';

  @override
  String get deliveryEstimatedTime => 'Estimated time';

  @override
  String deliveryMinutesLeft(int minutes) {
    return 'About $minutes min remaining';
  }

  @override
  String get deliveryArriving => 'Arriving';

  @override
  String get deliveryOrderCode => 'Order code';

  @override
  String get deliveryStatus => 'Status';

  @override
  String get deliveryOrderInfo => 'Order information';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }
}
