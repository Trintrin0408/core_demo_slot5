import 'package:core_demo_slot5/views/usermanagement/user_form_page.dart';
import 'package:core_demo_slot5/views/usermanagement/user_detal_page.dart';
import 'package:core_demo_slot5/views/usermanagement/user_item_card.dart';
import 'package:core_demo_slot5/views/usermanagement/user_management_header.dart'; // Import header mới
import 'package:flutter/material.dart';

// Dữ liệu giả lập cho danh sách người dùng
const List<Map<String, String>> _users = [
  {
    'name': 'Nguyễn Văn A',
    'dob': '01/01/1990',
    'address': '123 Đường A, Phường B, Quận T',
  },
  {
    'name': 'Trần Thị B',
    'dob': '10/03/1992',
    'address': '21 Nguyễn Trãi, Hà Nội',
  },
  {
    'name': 'Lê Văn C',
    'dob': '08/08/1995',
    'address': '30 Xã Đàn, Hà Nội',
  },
];

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      // Sử dụng AppBar chung
      appBar: const ManagementAppBar(
        title: 'Quản lý người dùng',
        subtitle: 'Danh sách・Thêm/Sửa/Xóa',
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return UserItemCard(
            user: user,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage(user: user),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserFormPage()),
          );
        },
        backgroundColor: const Color(0xFF1A5FAD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
