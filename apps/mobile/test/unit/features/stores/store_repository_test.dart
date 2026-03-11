// ignore_for_file: cascade_invocations

import 'package:comtammatu/core/cache/cache_service.dart';
import 'package:comtammatu/core/network/api_client.dart';
import 'package:comtammatu/features/stores/data/models/store_model.dart';
import 'package:comtammatu/features/stores/data/store_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockCacheService extends Mock implements CacheService {}

/// Sample store JSON as returned by CacheService.
List<Map<String, dynamic>> _sampleCachedStoreJson() {
  return [
    {
      'id': 1,
      'name': 'Com Tam Ma Tu - Quang Trung',
      'code': 'QT01',
      'address': '123 Quang Trung, Go Vap, TP.HCM',
      'phone': '028-1234-5678',
      'latitude': 10.8326,
      'longitude': 106.6581,
      'operating_hours': {'open_time': '06:00', 'close_time': '22:00'},
      'is_active': true,
    },
    {
      'id': 2,
      'name': 'Com Tam Ma Tu - Nguyen Oanh',
      'code': 'NO02',
      'address': '456 Nguyen Oanh, Go Vap, TP.HCM',
      'phone': '028-8765-4321',
      'latitude': 10.8400,
      'longitude': 106.6700,
      'operating_hours': {'open_time': '06:00', 'close_time': '21:30'},
      'is_active': true,
    },
    {
      'id': 3,
      'name': 'Com Tam Ma Tu - Le Van Sy',
      'code': 'LVS03',
      'address': '789 Le Van Sy, Q3, TP.HCM',
      'phone': '028-1111-2222',
      'latitude': 10.7900,
      'longitude': 106.6650,
      'operating_hours': {'open_time': '06:30', 'close_time': '22:00'},
      'is_active': true,
    },
  ];
}

/// Sample StoreInfo list matching the JSON above.
List<StoreInfo> _sampleStores() {
  return _sampleCachedStoreJson().map(StoreInfo.fromJson).toList();
}

/// Helper to stub [ApiClient.get] for `/stores` without query params.
When<Future<List<StoreInfo>>> _stubGetStores(MockApiClient mock) {
  return when(
    () => mock.get<List<StoreInfo>>(
      '/stores',
      fromJson: any(named: 'fromJson'),
    ),
  );
}

/// Helper to stub [ApiClient.get] for `/stores` with query params (nearby).
When<Future<List<StoreInfo>>> _stubGetNearbyStores(MockApiClient mock) {
  return when(
    () => mock.get<List<StoreInfo>>(
      '/stores',
      queryParameters: any(named: 'queryParameters'),
      fromJson: any(named: 'fromJson'),
    ),
  );
}

void main() {
  late MockApiClient mockApiClient;
  late MockCacheService mockCacheService;
  late StoreRepository repository;

  setUpAll(() {
    registerFallbackValue(Duration.zero);
    registerFallbackValue(<Map<String, dynamic>>[]);
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(
      (dynamic json) => <StoreInfo>[],
    );
  });

  setUp(() {
    mockApiClient = MockApiClient();
    mockCacheService = MockCacheService();
    repository = StoreRepository(
      apiClient: mockApiClient,
      cacheService: mockCacheService,
    );
  });

  group('StoreRepository', () {
    group('getStores', () {
      test('returns cached stores when cache is valid', () async {
        // Arrange
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(true);
        when(() => mockCacheService.getCachedStores())
            .thenReturn(_sampleCachedStoreJson());

        // Act
        final result = await repository.getStores();

        // Assert
        expect(result, hasLength(3));
        expect(result[0].name, equals('Com Tam Ma Tu - Quang Trung'));
        expect(result[1].name, equals('Com Tam Ma Tu - Nguyen Oanh'));
        expect(result[2].name, equals('Com Tam Ma Tu - Le Van Sy'));

        // Verify API was never called
        verifyNever(
          () => mockApiClient.get<List<StoreInfo>>(
            '/stores',
            fromJson: any(named: 'fromJson'),
          ),
        );
      });

      test('fetches from API when cache is expired and updates cache',
          () async {
        // Arrange
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(false);
        when(() => mockCacheService.cacheStores(any()))
            .thenAnswer((_) async {});

        final apiStores = _sampleStores();
        _stubGetStores(mockApiClient)
            .thenAnswer((_) async => apiStores);

        // Act
        final result = await repository.getStores();

        // Assert
        expect(result, hasLength(3));
        expect(result[0].id, equals(1));

        // Verify cache was updated
        verify(() => mockCacheService.cacheStores(any())).called(1);
      });

      test('falls back to stale cache on network error', () async {
        // Arrange: cache expired, API fails, stale cache available
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(false);
        _stubGetStores(mockApiClient)
            .thenThrow(Exception('Network error'));
        when(() => mockCacheService.getCachedStores())
            .thenReturn(_sampleCachedStoreJson());

        // Act
        final result = await repository.getStores();

        // Assert: returns stale cached data
        expect(result, hasLength(3));
        expect(result[0].name, equals('Com Tam Ma Tu - Quang Trung'));
      });

      test('fetches from API when cache is valid but empty', () async {
        // Arrange
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(true);
        when(() => mockCacheService.getCachedStores()).thenReturn([]);
        when(() => mockCacheService.cacheStores(any()))
            .thenAnswer((_) async {});

        final apiStores = _sampleStores();
        _stubGetStores(mockApiClient)
            .thenAnswer((_) async => apiStores);

        // Act
        final result = await repository.getStores();

        // Assert
        expect(result, hasLength(3));
      });

      test('throws when both network and stale cache fail', () async {
        // Arrange
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(false);
        _stubGetStores(mockApiClient)
            .thenThrow(Exception('Network error'));
        when(() => mockCacheService.getCachedStores()).thenReturn([]);

        // Act & Assert
        expect(
          () => repository.getStores(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getNearbyStores', () {
      test('returns stores from API sorted by distance', () async {
        final apiStores = _sampleStores();
        _stubGetNearbyStores(mockApiClient)
            .thenAnswer((_) async => apiStores);

        // Act
        final result = await repository.getNearbyStores(10.83, 106.66);

        // Assert
        expect(result, hasLength(3));
      });

      test('falls back to cached stores sorted by distance on API error',
          () async {
        // Arrange: API fails, cached stores available
        _stubGetNearbyStores(mockApiClient)
            .thenThrow(Exception('Network error'));
        when(() => mockCacheService.getCachedStores())
            .thenReturn(_sampleCachedStoreJson());

        // Act: query from a point closest to store #3 (Le Van Sy)
        // Store 3: lat=10.79, lng=106.665
        // Store 1: lat=10.8326, lng=106.6581
        // Store 2: lat=10.84, lng=106.67
        final result = await repository.getNearbyStores(10.79, 106.665);

        // Assert: stores sorted by distance, store 3 should be first
        expect(result, hasLength(3));
        expect(result[0].id, equals(3)); // Le Van Sy - closest
        expect(result[1].id, equals(1)); // Quang Trung
        expect(result[2].id, equals(2)); // Nguyen Oanh - farthest
      });

      test('throws when both API and cache fail for nearby stores', () async {
        // Arrange
        _stubGetNearbyStores(mockApiClient)
            .thenThrow(Exception('Network error'));
        when(() => mockCacheService.getCachedStores()).thenReturn([]);

        // Act & Assert
        expect(
          () => repository.getNearbyStores(10.83, 106.66),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
