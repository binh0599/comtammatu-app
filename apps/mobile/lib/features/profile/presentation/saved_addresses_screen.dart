import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/address_model.dart';
import '../../../shared/widgets/empty_view.dart';
import '../domain/address_notifier.dart';

// -- Screen ---------------------------------------------------------------

/// Saved addresses screen with list, add/edit dialog, and delete actions.
class SavedAddressesScreen extends ConsumerStatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  ConsumerState<SavedAddressesScreen> createState() =>
      _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends ConsumerState<SavedAddressesScreen> {
  @override
  void initState() {
    super.initState();
    // Load addresses from the API on first build
    Future.microtask(
      () => ref.read(addressNotifierProvider.notifier).loadAddresses(),
    );
  }

  void _setDefault(Address address) {
    if (address.id == null) return;
    ref.read(addressNotifierProvider.notifier).setDefault(address.id!);
  }

  void _deleteAddress(Address address) {
    if (address.id == null) return;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa địa chỉ'),
        content: const Text('Bạn có chắc chắn muốn xóa địa chỉ này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref
                  .read(addressNotifierProvider.notifier)
                  .deleteAddress(address.id!);
            },
            child: const Text(
              'Xóa',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog({Address? address}) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _AddEditAddressDialog(
        address: address,
        onSave: (newAddress) {
          final notifier = ref.read(addressNotifierProvider.notifier);
          if (address != null) {
            // Editing — preserve id and isDefault from original
            notifier.updateAddress(newAddress.copyWith(
              id: address.id,
              isDefault: address.isDefault,
            ));
          } else {
            notifier.addAddress(newAddress);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(addressNotifierProvider);
    final addresses = addressState.addresses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa chỉ đã lưu'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEditDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _buildBody(addressState, addresses),
    );
  }

  Widget _buildBody(AddressState state, List<Address> addresses) {
    if (state.isLoading && addresses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && addresses.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Không thể tải địa chỉ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  ref.read(addressNotifierProvider.notifier).loadAddresses(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (addresses.isEmpty) {
      return const EmptyView(
        icon: Icons.location_off_outlined,
        message: 'Bạn chưa lưu địa chỉ nào',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final address = addresses[index];
        return _AddressCard(
          address: address,
          onEdit: () => _showAddEditDialog(address: address),
          onDelete: () => _deleteAddress(address),
          onSetDefault: () => _setDefault(address),
        );
      },
    );
  }
}

// -- Address card ---------------------------------------------------------

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: address.isDefault
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label chip + default badge
            Row(
              children: [
                _LabelChip(label: address.displayLabel),
                if (address.isDefault) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Mặc định',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
                const Spacer(),
                // Edit button
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: onEdit,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                  tooltip: 'Chỉnh sửa',
                ),
                // Delete button
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: AppColors.error,
                  ),
                  onPressed: onDelete,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                  tooltip: 'Xóa',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Full address
            Text(
              address.fullAddress,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
            ),

            // Set as default option
            if (!address.isDefault) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onSetDefault,
                child: Text(
                  'Đặt làm mặc định',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// -- Label chip -----------------------------------------------------------

class _LabelChip extends StatelessWidget {
  const _LabelChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// -- Add/Edit dialog ------------------------------------------------------

class _AddEditAddressDialog extends StatefulWidget {
  const _AddEditAddressDialog({
    required this.onSave,
    this.address,
  });

  final Address? address;
  final ValueChanged<Address> onSave;

  @override
  State<_AddEditAddressDialog> createState() => _AddEditAddressDialogState();
}

class _AddEditAddressDialogState extends State<_AddEditAddressDialog> {
  final _formKey = GlobalKey<FormState>();

  late String _selectedLabel;
  late final TextEditingController _addressLineController;
  late final TextEditingController _wardController;
  late final TextEditingController _districtController;
  late final TextEditingController _cityController;

  bool get _isEditing => widget.address != null;

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.address?.label ?? 'home';
    _addressLineController =
        TextEditingController(text: widget.address?.addressLine ?? '');
    _wardController = TextEditingController(text: widget.address?.ward ?? '');
    _districtController =
        TextEditingController(text: widget.address?.district ?? '');
    _cityController =
        TextEditingController(text: widget.address?.city ?? 'TP. Hồ Chí Minh');
  }

  @override
  void dispose() {
    _addressLineController.dispose();
    _wardController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(
        Address(
          label: _selectedLabel,
          addressLine: _addressLineController.text.trim(),
          ward: _wardController.text.trim(),
          district: _districtController.text.trim(),
          city: _cityController.text.trim(),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Chỉnh sửa địa chỉ' : 'Thêm địa chỉ mới'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Label selector
              DropdownButtonFormField<String>(
                initialValue: _selectedLabel,
                decoration: const InputDecoration(
                  labelText: 'Loại địa chỉ',
                  prefixIcon: Icon(Icons.label_outline),
                ),
                items: const [
                  DropdownMenuItem(value: 'home', child: Text('Nhà')),
                  DropdownMenuItem(value: 'work', child: Text('Công ty')),
                  DropdownMenuItem(value: 'other', child: Text('Khác')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedLabel = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Address line
              TextFormField(
                controller: _addressLineController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                  hintText: 'Số nhà, tên đường',
                  prefixIcon: Icon(Icons.home_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Ward
              TextFormField(
                controller: _wardController,
                decoration: const InputDecoration(
                  labelText: 'Phường/Xã',
                  hintText: 'Nhập phường/xã',
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập phường/xã';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // District
              TextFormField(
                controller: _districtController,
                decoration: const InputDecoration(
                  labelText: 'Quận/Huyện',
                  hintText: 'Nhập quận/huyện',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập quận/huyện';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Thành phố',
                  hintText: 'Nhập thành phố',
                  prefixIcon: Icon(Icons.apartment_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập thành phố';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _onSave,
          child: Text(_isEditing ? 'Cập nhật' : 'Thêm'),
        ),
      ],
    );
  }
}
