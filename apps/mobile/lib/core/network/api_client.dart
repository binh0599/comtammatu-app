import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';
import 'api_exception.dart';

/// Dio-based API client with auth, idempotency, and error handling.
class ApiClient {
  ApiClient({required Dio dio, required SupabaseClient supabase})
      : _dio = dio,
        _supabase = supabase {
    _dio.options
      ..baseUrl = AppConstants.apiBaseUrl
      ..connectTimeout =
          const Duration(milliseconds: AppConstants.connectTimeout)
      ..receiveTimeout =
          const Duration(milliseconds: AppConstants.receiveTimeout)
      ..sendTimeout = const Duration(milliseconds: AppConstants.sendTimeout);

    _dio.interceptors.addAll([
      _AuthInterceptor(supabase: _supabase),
      _IdempotencyInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  final Dio _dio;
  final SupabaseClient _supabase;

  /// GET request with response envelope parsing.
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJson,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return _parseResponse(response, fromJson);
  }

  /// POST request with idempotency key.
  Future<T> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic json)? fromJson,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: data,
    );
    return _parseResponse(response, fromJson);
  }

  /// PUT request.
  Future<T> put<T>(
    String path, {
    dynamic data,
    T Function(dynamic json)? fromJson,
  }) async {
    final response = await _dio.put<Map<String, dynamic>>(
      path,
      data: data,
    );
    return _parseResponse(response, fromJson);
  }

  /// PATCH request.
  Future<T> patch<T>(
    String path, {
    dynamic data,
    T Function(dynamic json)? fromJson,
  }) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      path,
      data: data,
    );
    return _parseResponse(response, fromJson);
  }

  /// DELETE request.
  Future<T> delete<T>(
    String path, {
    T Function(dynamic json)? fromJson,
  }) async {
    final response = await _dio.delete<Map<String, dynamic>>(path);
    return _parseResponse(response, fromJson);
  }

  /// Parse response envelope: { success, data, error }.
  T _parseResponse<T>(
    Response<Map<String, dynamic>> response,
    T Function(dynamic json)? fromJson,
  ) {
    final body = response.data;
    if (body == null) {
      throw ApiException.unknown('Empty response body');
    }

    final success = body['success'] as bool? ?? false;
    if (!success) {
      final error = body['error'] as Map<String, dynamic>?;
      if (error != null) {
        throw ApiException.fromJson(error, statusCode: response.statusCode);
      }
      throw ApiException.unknown();
    }

    final data = body['data'];
    if (fromJson != null) {
      return fromJson(data);
    }
    return data as T;
  }
}

/// Adds Bearer token from Supabase auth session.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor({required SupabaseClient supabase}) : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      options.headers['Authorization'] = 'Bearer ${session.accessToken}';
    }

    // Add standard headers
    options.headers['X-App-Version'] = '1.0.0';
    options.headers['X-Platform'] = 'mobile';

    handler.next(options);
  }
}

/// Adds X-Idempotency-Key for POST requests (UUID v4).
class _IdempotencyInterceptor extends Interceptor {
  static const _uuid = Uuid();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'POST') {
      options.headers['X-Idempotency-Key'] = _uuid.v4();
    }
    handler.next(options);
  }
}

/// Maps Dio errors to ApiException.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final ApiException apiException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        apiException = ApiException.timeout();
      case DioExceptionType.connectionError:
        apiException = ApiException.network();
      case DioExceptionType.badResponse:
        apiException = _handleBadResponse(err.response);
      default:
        apiException = ApiException.unknown(err.message);
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: apiException,
        type: err.type,
        response: err.response,
      ),
    );
  }

  ApiException _handleBadResponse(Response<dynamic>? response) {
    if (response == null) {
      return ApiException.unknown();
    }

    final statusCode = response.statusCode;
    final data = response.data;

    if (data is Map<String, dynamic>) {
      final error = data['error'] as Map<String, dynamic>?;
      if (error != null) {
        return ApiException.fromJson(error, statusCode: statusCode);
      }
    }

    switch (statusCode) {
      case 401:
        return ApiException.unauthorized();
      case 403:
        return ApiException.forbidden();
      case 404:
        return ApiException.notFound();
      case 429:
        return ApiException.rateLimited();
      default:
        return ApiException(
          code: 'HTTP_$statusCode',
          message: 'Lỗi máy chủ ($statusCode)',
          statusCode: statusCode,
        );
    }
  }
}

/// Riverpod provider for ApiClient.
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = Dio();
  final supabase = Supabase.instance.client;
  return ApiClient(dio: dio, supabase: supabase);
});
