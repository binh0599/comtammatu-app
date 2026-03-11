import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../models/address_model.dart';

/// Repository for CRUD operations on user saved addresses.
class AddressRepository {
  const AddressRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Fetches all saved addresses for the current user.
  Future<List<Address>> getAddresses() async {
    return _apiClient.get<List<Address>>(
      '/addresses',
      fromJson: (json) {
        final list = json as List<dynamic>;
        return list
            .map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Creates a new address. Returns the created address with server-assigned id.
  Future<Address> createAddress(Address address) async {
    return _apiClient.post<Address>(
      '/addresses',
      data: address.toJson()..remove('id'),
      fromJson: (json) => Address.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Updates an existing address. Returns the updated address.
  Future<Address> updateAddress(Address address) async {
    return _apiClient.put<Address>(
      '/addresses',
      data: address.toJson(),
      fromJson: (json) => Address.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Deletes an address by id.
  Future<void> deleteAddress(int addressId) async {
    await _apiClient.delete<void>('/addresses?id=$addressId');
  }

  /// Sets the given address as the default.
  Future<void> setDefault(int addressId) async {
    await _apiClient.post<void>(
      '/addresses/set-default',
      data: {'address_id': addressId},
    );
  }
}

/// Riverpod provider for [AddressRepository].
final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AddressRepository(apiClient: apiClient);
});
