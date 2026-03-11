// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/menu/data/menu_repository.dart';
import 'package:comtammatu/features/menu/domain/menu_notifier.dart';
import 'package:comtammatu/features/menu/domain/menu_state.dart';
import 'package:comtammatu/models/menu_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMenuRepository extends Mock implements MenuRepository {}

List<MenuCategory> _sampleCategories() {
  return [
    const MenuCategory(
      name: 'Com tam',
      items: [
        MenuItem(
            id: 1, name: 'Com tam suon', price: 45000, category: 'Com tam'),
        MenuItem(id: 2, name: 'Com tam bi', price: 40000, category: 'Com tam'),
      ],
    ),
    const MenuCategory(
      name: 'Nuoc uong',
      items: [
        MenuItem(id: 3, name: 'Tra da', price: 5000, category: 'Nuoc uong'),
        MenuItem(
            id: 4, name: 'Ca phe sua', price: 20000, category: 'Nuoc uong'),
      ],
    ),
  ];
}

void main() {
  late MenuNotifier notifier;
  late MockMenuRepository mockRepo;

  setUp(() {
    mockRepo = MockMenuRepository();
    notifier = MenuNotifier(menuRepository: mockRepo);
  });

  group('MenuNotifier', () {
    test('initial state is MenuInitial', () {
      expect(notifier.state, isA<MenuInitial>());
    });

    group('loadMenu', () {
      test('transitions to MenuLoading then MenuLoaded on success', () async {
        final categories = _sampleCategories();
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => categories);

        final states = <MenuState>[];
        notifier.addListener(states.add);

        await notifier.loadMenu(branchId: 1);

        // addListener fires immediately with current state, then transitions
        // MenuInitial -> MenuLoading -> MenuLoaded
        expect(states.length, greaterThanOrEqualTo(3));
        expect(states[0], isA<MenuInitial>());
        expect(states[1], isA<MenuLoading>());
        expect(states[2], isA<MenuLoaded>());

        final loaded = states[2] as MenuLoaded;
        expect(loaded.categories, hasLength(2));
        expect(loaded.selectedCategory, isNull);
        expect(loaded.searchQuery, '');
      });

      test('transitions to MenuError on failure', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenThrow(Exception('Network error'));

        final states = <MenuState>[];
        notifier.addListener(states.add);

        await notifier.loadMenu(branchId: 1);

        expect(states.length, greaterThanOrEqualTo(3));
        expect(states[0], isA<MenuInitial>());
        expect(states[1], isA<MenuLoading>());
        expect(states[2], isA<MenuError>());

        final error = states[2] as MenuError;
        expect(error.message, contains('Network error'));
      });
    });

    group('selectCategory', () {
      test('sets selectedCategory on loaded state', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => _sampleCategories());
        await notifier.loadMenu(branchId: 1);

        notifier.selectCategory('Nuoc uong');

        final loaded = notifier.state as MenuLoaded;
        expect(loaded.selectedCategory, 'Nuoc uong');
        expect(loaded.filteredItems, hasLength(2));
        expect(loaded.filteredItems.first.name, 'Tra da');
      });

      test('clears category filter when set to null', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => _sampleCategories());
        await notifier.loadMenu(branchId: 1);

        notifier.selectCategory('Nuoc uong');
        notifier.selectCategory(null);

        final loaded = notifier.state as MenuLoaded;
        expect(loaded.selectedCategory, isNull);
        expect(loaded.filteredItems, hasLength(4));
      });

      test('does nothing when state is not MenuLoaded', () {
        notifier.selectCategory('Nuoc uong');
        expect(notifier.state, isA<MenuInitial>());
      });
    });

    group('search', () {
      test('filters items by name', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => _sampleCategories());
        await notifier.loadMenu(branchId: 1);

        notifier.search('suon');

        final loaded = notifier.state as MenuLoaded;
        expect(loaded.searchQuery, 'suon');
        expect(loaded.filteredItems, hasLength(1));
        expect(loaded.filteredItems.first.name, 'Com tam suon');
      });

      test('search is case insensitive', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => _sampleCategories());
        await notifier.loadMenu(branchId: 1);

        notifier.search('CA PHE');

        final loaded = notifier.state as MenuLoaded;
        expect(loaded.filteredItems, hasLength(1));
        expect(loaded.filteredItems.first.name, 'Ca phe sua');
      });

      test('clears search when empty string', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => _sampleCategories());
        await notifier.loadMenu(branchId: 1);

        notifier.search('suon');
        notifier.search('');

        final loaded = notifier.state as MenuLoaded;
        expect(loaded.filteredItems, hasLength(4));
      });

      test('combines category filter with search', () async {
        when(() => mockRepo.getMenu(branchId: 1))
            .thenAnswer((_) async => _sampleCategories());
        await notifier.loadMenu(branchId: 1);

        notifier.selectCategory('Com tam');
        notifier.search('bi');

        final loaded = notifier.state as MenuLoaded;
        expect(loaded.filteredItems, hasLength(1));
        expect(loaded.filteredItems.first.name, 'Com tam bi');
      });

      test('does nothing when state is not MenuLoaded', () {
        notifier.search('test');
        expect(notifier.state, isA<MenuInitial>());
      });
    });
  });
}
