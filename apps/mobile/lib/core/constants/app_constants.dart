class AppConstants {
  AppConstants._();

  // Supabase
  static const String supabaseUrl =
      'https://zrlriuednoaqrsvnjjyo.supabase.co';
  static const String supabaseAnonKey = ''; // Set via env or config

  // API
  static const String apiBaseUrl =
      'https://zrlriuednoaqrsvnjjyo.supabase.co/functions/v1';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Timeouts (milliseconds)
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 15000;

  // Cache
  static const int cacheMaxAge = 300; // 5 minutes in seconds
  static const int offlineCacheMaxAge = 86400; // 24 hours in seconds

  // App Info
  static const String appName = 'Cơm Tấm Má Tư';
  static const String appScheme = 'comtammatu';

  // Loyalty
  static const int pointsPerVnd = 1000; // 1 point per 1000 VND spent
  static const int checkInPoints = 10;

  // Tiers
  static const int bronzeThreshold = 0;
  static const int silverThreshold = 500;
  static const int goldThreshold = 2000;
  static const int diamondThreshold = 5000;
}
