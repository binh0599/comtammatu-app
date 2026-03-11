import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/address_model.dart';
import '../data/address_repository.dart';

/// Immutable state for the address list feature.
class AddressState {
  const AddressState({
    this.addresses = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Address> addresses;
  final bool isLoading;
  final String? error;

  AddressState copyWith({
    List<Address>? addresses,
    bool? isLoading,
    String? error,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Manages saved addresses state via [AddressRepository].
class AddressNotifier extends StateNotifier<AddressState> {
  AddressNotifier({required AddressRepository addressRepository})
      : _addressRepository = addressRepository,
        super(const AddressState());

  final AddressRepository _addressRepository;

  /// Loads all addresses from the API.
  Future<void> loadAddresses() async {
    state = state.copyWith(isLoading: true);
    try {
      final addresses = await _addressRepository.getAddresses();
      state = state.copyWith(isLoading: false, addresses: addresses);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Adds a new address via the API and appends it to state.
  Future<void> addAddress(Address address) async {
    try {
      final newAddress = await _addressRepository.createAddress(address);
      state = state.copyWith(
        addresses: [...state.addresses, newAddress],
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Updates an existing address via the API and replaces it in state.
  Future<void> updateAddress(Address address) async {
    try {
      final updated = await _addressRepository.updateAddress(address);
      state = state.copyWith(
        addresses: state.addresses
            .map((a) => a.id == updated.id ? updated : a)
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Deletes an address by id via the API and removes it from state.
  Future<void> deleteAddress(int addressId) async {
    try {
      await _addressRepository.deleteAddress(addressId);
      state = state.copyWith(
        addresses: state.addresses.where((a) => a.id != addressId).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Sets the given address as default and updates all addresses in state.
  Future<void> setDefault(int addressId) async {
    try {
      await _addressRepository.setDefault(addressId);
      state = state.copyWith(
        addresses: state.addresses.map((a) {
          return a.copyWith(isDefault: a.id == addressId);
        }).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// Riverpod provider for [AddressNotifier].
final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  final repo = ref.watch(addressRepositoryProvider);
  return AddressNotifier(addressRepository: repo);
});
