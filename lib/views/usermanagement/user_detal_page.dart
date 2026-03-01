import 'package:core_demo_slot5/domain/entities/managed_user.dart';
import 'package:core_demo_slot5/viewmodels/usermanagment/users_viewmodel.dart';
import 'package:core_demo_slot5/views/usermanagement/user_form_page.dart';
import 'package:core_demo_slot5/views/usermanagement/user_management_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatelessWidget {
  final ManagedUser user;

  const UserDetailPage({super.key, required this.user});

  // Hàm hiển thị hộp thoại xác nhận xóa
  Future<void> _confirmDelete(BuildContext context, ManagedUser currentUser) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa người dùng "${currentUser.fullName}" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final vm = context.read<UsersViewmodel>();
      await vm.delete(currentUser.id);
      
      if (context.mounted) {
        if (vm.error == null) {
          Navigator.pop(context); // Quay lại trang danh sách
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã xóa người dùng thành công')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${vm.error}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng Consumer để lắng nghe thay đổi từ ViewModel
    return Consumer<UsersViewmodel>(
      builder: (context, vm, child) {
        // Tìm kiếm thông tin người dùng mới nhất trong danh sách của ViewModel bằng ID
        // Nếu không tìm thấy (vừa bị xóa), sử dụng dữ liệu cũ làm mặc định
        final currentUser = vm.users.firstWhere(
          (u) => u.id == user.id,
          orElse: () => user,
        );

        return Scaffold(
          backgroundColor: const Color(0xFFF0F4F8),
          appBar: const ManagementAppBar(
            title: 'Chi tiết người dùng',
            subtitle: 'Xem thông tin ・ Sửa ・ Xóa',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildUserDetailCard(currentUser),
          ),
          bottomNavigationBar: _buildActionButtons(context, currentUser),
        );
      },
    );
  }

  Widget _buildUserDetailCard(ManagedUser currentUser) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentUser.fullName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A5FAD),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Ngày sinh:', currentUser.dob),
            const SizedBox(height: 8),
            _buildDetailRow('Địa chỉ:', currentUser.address),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ManagedUser currentUser) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _confirmDelete(context, currentUser),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Xóa', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserFormPage(user: currentUser),
                  ),
                );
              },
              icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 20),
              label: const Text('Sửa', style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A5FAD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
