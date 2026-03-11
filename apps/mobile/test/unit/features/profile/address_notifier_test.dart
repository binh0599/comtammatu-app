// ignore_for_file: cascade_invocations

import 'package:comtammatu/features/profile/data/address_repository.dart';
import 'package:comtammatu/features/profile/domain/address_notifier.dart';
import 'package:comtammatu/models/address_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

Address _address({
  int id = 1,
  String label = 'home',
  bool isDefault = false,
}) {
  return Address(
    id: id,
    label: label,
    addressLine: '123 Nguyễn Huệ',
    ward: 'Phường Bến Nghé',
    district: 'Quận 1',
    city: 'TP. Hồ Chí Minh',
    isDefault: isDefault,
  );
}

void main() {
  late AddressNotifier notifier;
  late MockAddressRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(_address());
  });

  setUp(() {
    mockRepo = MockAddressRepository();
    notifier = AddressNotifier(addressRepository: mockRepo);
  });

  group('AddressNotifier', () {
    test('initial state is empty, not loading, no error', () {
      expect(notifier.state.addresses, isEmpty);
      expect(notifier.state.isLoading, isFalse);
      expect(notifier.state.error, isNull);
    });

    group('loadAddresses', () {
      test('loads addresses from repository', () async {
        when(() => mockRepo.getAddresses())
            .thenAnswer((_) async => [_address(), _address(id: 2)]);

        await notifier.loadAddresses();

        expect(notifier.state.addresses, hasLength(2));
        expect(notifier.state.isLoading, isFalse);
        expect(notifier.state.error, isNull);
      });

      test('sets isLoading during fetch', () async {
        var wasLoading = false;

        notifier.addListener((state) {
          if (state.isLoading) wasLoading = true;
        });

        when(() => mockRepo.getAddresses()).thenAnswer((_) async => []);

        await notifier.loadAddresses();

        expect(wasLoading, isTrue);
        expect(notifier.state.isLoading, isFalse);
      });

      test('sets error on failure', () async {
        when(() => mockRepo.getAddresses())
            .thenThrow(Exception('Connection failed'));

        await notifier.loadAddresses();

        expect(notifier.state.error, contains('Connection failed'));
        expect(notifier.state.isLoading, isFalse);
      });
    });

    group('addAddress', () {
      test('appends new address to state', () async {
        final newAddress = _address(id: 5);
        when(() => mockRepo.createAddress(any()))
            .thenAnswer((_) async => newAddress);

        await notifier.addAddress(newAddress);

        expect(notifier.state.addresses, hasLength(1));
        expect(notifier.state.addresses.first.id, 5);
      });

      test('sets error on failure', () async {
        when(() => mockRepo.createAddress(any()))
            .thenThrow(Exception('Server error'));

        await notifier.addAddress(_address());

        expect(notifier.state.error, contains('Server error'));
      });
    });

    group('updateAddress', () {
      test('replaces updated address in state', () async {
        // Pre-populate with two addresses
        when(() => mockRepo.getAddresses())
            .thenAnswer((_) async => [_address(), _address(id: 2)]);
        await notifier.loadAddresses();

        final updated = _address(label: 'work');
        when(() => mockRepo.updateAddress(any()))
            .thenAnswer((_) async => updated);

        await notifier.updateAddress(updated);

        expect(notifier.state.addresses.first.label, 'work');
        expect(notifier.state.addresses, hasLength(2));
      });

      test('sets error on failure', () async {
        when(() => mockRepo.updateAddress(any()))
            .thenThrow(Exception('Not found'));

        await notifier.updateAddress(_address());

        expect(notifier.state.error, contains('Not found'));
      });
    });

    group('deleteAddress', () {
      test('removes address from state', () async {
        when(() => mockRepo.getAddresses())
            .thenAnswer((_) async => [_address(), _address(id: 2)]);
        await notifier.loadAddresses();

        when(() => mockRepo.deleteAddress(1)).thenAnswer((_) async {});

        await notifier.deleteAddress(1);

        expect(notifier.state.addresses, hasLength(1));
        expect(notifier.state.addresses.first.id, 2);
      });

      test('sets error on failure', () async {
        when(() => mockRepo.deleteAddress(any()))
            .thenThrow(Exception('Cannot delete'));

        await notifier.deleteAddress(99);

        expect(notifier.state.error, contains('Cannot delete'));
      });
    });

    group('setDefault', () {
      test('marks target as default and others as not default', () async {
        when(() => mockRepo.getAddresses()).thenAnswer(
          (_) async => [
            _address(isDefault: true),
            _address(id: 2),
          ],
        );
        await notifier.loadAddresses();

        when(() => mockRepo.setDefault(2)).thenAnswer((_) async {});

        await notifier.setDefault(2);

        final addresses = notifier.state.addresses;
        expect(addresses.firstWhere((a) => a.id == 1).isDefault, isFalse);
        expect(addresses.firstWhere((a) => a.id == 2).isDefault, isTrue);
      });

      test('sets error on failure', () async {
        when(() => mockRepo.setDefault(any()))
            .thenThrow(Exception('Unauthorized'));

        await notifier.setDefault(1);

        expect(notifier.state.error, contains('Unauthorized'));
      });
    });
  });
}
