import 'package:core_demo_slot5/views/usermanagement/user_management_header.dart'; // Import header mới
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final Map<String, String> user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      // Sử dụng AppBar chung
      appBar: const ManagementAppBar(
        title: 'Chi tiết người dùng',
        subtitle: 'Xem thông tin ・ Sửa ・ Xóa',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildUserDetailCard(),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  Widget _buildUserDetailCard() {
    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Giúp Card co lại vừa với nội dung
          children: [
            Text(
              user['name']!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A5FAD),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Ngày sinh:', user['dob']!),
            const SizedBox(height: 8),
            _buildDetailRow('Địa chỉ:', user['address']!),
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

  Widget _buildActionButtons() {
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
              onPressed: () {},
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
              onPressed: () {},
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
