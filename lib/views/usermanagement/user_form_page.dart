import 'package:core_demo_slot5/domain/entities/managed_user.dart';
// Sửa import: usermanagment (không có chữ e)
import 'package:core_demo_slot5/viewmodels/usermanagment/users_viewmodel.dart';
import 'package:core_demo_slot5/views/usermanagement/user_management_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFormPage extends StatefulWidget {
  final ManagedUser? user; 
  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.fullName;
      _dateController.text = widget.user!.dob;
      _addressController.text = widget.user!.address;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _save(BuildContext context) async {
    final name = _nameController.text.trim();
    final dob = _dateController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || dob.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    final vm = context.read<UsersViewmodel>();
    
    if (widget.user == null) {
      await vm.add(name, dob, address);
    } else {
      await vm.update(widget.user!.id, name, dob, address);
    }

    if (vm.error == null) {
      if (mounted) Navigator.of(context).pop();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${vm.error}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: ManagementAppBar(
        title: widget.user == null ? 'Thêm người dùng' : 'Sửa người dùng',
        subtitle: 'Nhập thông tin và bấm Lưu',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(label: 'Họ và tên', controller: _nameController),
            const SizedBox(height: 16),
            _buildDateField(context, label: 'Ngày sinh'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Địa chỉ', controller: _addressController, maxLines: 3),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, {required String label}) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_outlined),
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Hủy'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Consumer<UsersViewmodel>(
              builder: (context, vm, child) {
                return ElevatedButton(
                  onPressed: vm.loading ? null : () => _save(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A5FAD),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: vm.loading 
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Lưu', style: TextStyle(fontSize: 16)),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
