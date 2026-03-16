// ignore_for_file: cascade_invocations

import 'package:comtammatu/core/cache/cache_service.dart';
import 'package:comtammatu/core/network/api_client.dart';
import 'package:comtammatu/features/menu/data/menu_repository.dart';
import 'package:comtammatu/models/menu_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockCacheService extends Mock implements CacheService {}

/// Sample cached menu items (flat list as stored by CacheService).
List<Map<String, dynamic>> _sampleCachedItems() {
  return [
    {
      'id': 1,
      'name': 'Com tam suon',
      'base_price': 45000,
      'price': 45000,
      'category': 'Com tam',
      'is_available': true,
    },
    {
      'id': 2,
      'name': 'Com tam bi',
      'base_price': 40000,
      'price': 40000,
      'category': 'Com tam',
      'is_available': true,
    },
    {
      'id': 3,
      'name': 'Tra da',
      'base_price': 5000,
      'price': 5000,
      'category': 'Nuoc uong',
      'is_available': true,
    },
  ];
}

/// Sample API response as parsed MenuCategory list.
List<MenuCategory> _sampleCategories() {
  return [
    const MenuCategory(
      name: 'Com tam',
      items: [
        MenuItem(
          id: 1,
          name: 'Com tam suon',
          price: 45000,
          category: 'Com tam',
        ),
        MenuItem(
          id: 2,
          name: 'Com tam bi',
          price: 40000,
          category: 'Com tam',
        ),
      ],
    ),
    const MenuCategory(
      name: 'Nuoc uong',
      items: [
        MenuItem(
          id: 3,
          name: 'Tra da',
          price: 5000,
          category: 'Nuoc uong',
        ),
      ],
    ),
  ];
}

/// Helper to stub [ApiClient.get] for the `/get-menu` endpoint.
///
/// Uses [thenAnswer] / [thenThrow] on the returned [When].
When<Future<List<MenuCategory>>> _stubGetMenu(MockApiClient mock) {
  return when(
    () => mock.get<List<MenuCategory>>(
      '/get-menu',
      queryParameters: any(named: 'queryParameters'),
      fromJson: any(named: 'fromJson'),
    ),
  );
}

void main() {
  late MockApiClient mockApiClient;
  late MockCacheService mockCacheService;
  late MenuRepository repository;

  setUpAll(() {
    registerFallbackValue(Duration.zero);
    registerFallbackValue(<Map<String, dynamic>>[]);
    registerFallbackValue(<String, dynamic>{});
    // Register a fallback for the fromJson callback parameter.
    registerFallbackValue(
      (dynamic json) => <MenuCategory>[],
    );
  });

  setUp(() {
    mockApiClient = MockApiClient();
    mockCacheService = MockCacheService();
    repository = MenuRepository(
      apiClient: mockApiClient,
      cacheService: mockCacheService,
    );
  });

  group('MenuRepository', () {
    group('getMenu', () {
      test('returns cached data when cache is valid', () async {
        // Arrange: cache is valid and has data
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(true);
        when(() => mockCacheService.getCachedMenu())
            .thenReturn(_sampleCachedItems());

        // Act
        final result = await repository.getMenu(branchId: 1);

        // Assert: returns parsed categories from cache
        expect(result, hasLength(2));
        expect(result[0].name, equals('Com tam'));
        expect(result[0].items, hasLength(2));
        expect(result[1].name, equals('Nuoc uong'));
        expect(result[1].items, hasLength(1));

        // Verify API was never called
        verifyNever(
          () => mockApiClient.get<List<MenuCategory>>(
            '/get-menu',
            queryParameters: any(named: 'queryParameters'),
            fromJson: any(named: 'fromJson'),
          ),
        );
      });

      test('fetches from API when cache is expired and updates cache',
          () async {
        // Arrange: cache is not valid
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(false);
        when(() => mockCacheService.cacheMenu(any())).thenAnswer((_) async {});

        final apiCategories = _sampleCategories();
        _stubGetMenu(mockApiClient).thenAnswer((_) async => apiCategories);

        // Act
        final result = await repository.getMenu(branchId: 1);

        // Assert: returns API data
        expect(result, equals(apiCategories));

        // Verify cache was updated
        verify(() => mockCacheService.cacheMenu(any())).called(1);
      });

      test('falls back to stale cache on network error', () async {
        // Arrange: cache is not valid, API fails, stale cache exists
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(false);
        _stubGetMenu(mockApiClient).thenThrow(Exception('Network error'));
        when(() => mockCacheService.getCachedMenuAsync())
            .thenAnswer((_) async => _sampleCachedItems());

        // Act
        final result = await repository.getMenu(branchId: 1);

        // Assert: returns parsed stale cache
        expect(result, hasLength(2));
        expect(result[0].name, equals('Com tam'));
        expect(result[0].items, hasLength(2));
      });

      test('fetches from API when cache is valid but empty', () async {
        // Arrange: cache valid but returns empty list
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(true);
        when(() => mockCacheService.getCachedMenu()).thenReturn([]);
        when(() => mockCacheService.cacheMenu(any())).thenAnswer((_) async {});

        final apiCategories = _sampleCategories();
        _stubGetMenu(mockApiClient).thenAnswer((_) async => apiCategories);

        // Act
        final result = await repository.getMenu(branchId: 1);

        // Assert: falls through to API
        expect(result, equals(apiCategories));
      });

      test('throws when both network and stale cache fail', () async {
        // Arrange: no valid cache, API fails, stale cache is empty
        when(() => mockCacheService.isCacheValid(any(), any()))
            .thenReturn(false);
        _stubGetMenu(mockApiClient).thenThrow(Exception('Network error'));
        when(() => mockCacheService.getCachedMenuAsync())
            .thenAnswer((_) async => []);

        // Act & Assert: rethrows the network error
        expect(
          () => repository.getMenu(branchId: 1),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('refreshMenu', () {
      test('bypasses cache and fetches directly from API', () async {
        // Arrange
        final apiCategories = _sampleCategories();
        _stubGetMenu(mockApiClient).thenAnswer((_) async => apiCategories);
        when(() => mockCacheService.cacheMenu(any())).thenAnswer((_) async {});

        // Act
        final result = await repository.refreshMenu(branchId: 1);

        // Assert
        expect(result, equals(apiCategories));

        // Verify cache was never checked for validity
        verifyNever(() => mockCacheService.isCacheValid(any(), any()));

        // Verify cache was updated with new data
        verify(() => mockCacheService.cacheMenu(any())).called(1);
      });

      test('throws on API error without cache fallback', () async {
        // Arrange: refreshMenu does not fall back to cache
        _stubGetMenu(mockApiClient).thenThrow(Exception('Server error'));

        // Act & Assert
        expect(
          () => repository.refreshMenu(branchId: 1),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
