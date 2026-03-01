
import 'package:core_demo_slot5/viewmodels/usermanagment/users_viewmodel.dart';
import 'package:core_demo_slot5/views/usermanagement/user_form_page.dart';
import 'package:core_demo_slot5/views/usermanagement/user_detal_page.dart';
import 'package:core_demo_slot5/views/usermanagement/user_item_card.dart';
import 'package:core_demo_slot5/views/usermanagement/user_management_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  void initState() {
    super.initState();
    // Tải dữ liệu từ database ngay khi trang được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersViewmodel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: const ManagementAppBar(
        title: 'Quản lý người dùng',
        subtitle: 'Danh sách・Thêm/Sửa/Xóa',
      ),
      body: Consumer<UsersViewmodel>(
        builder: (context, vm, child) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lỗi: ${vm.error}', style: const TextStyle(color: Colors.red)),
                  ElevatedButton(
                    onPressed: () => vm.init(),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (vm.users.isEmpty) {
            return const Center(child: Text('Chưa có người dùng nào.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: vm.users.length,
            itemBuilder: (context, index) {
              final user = vm.users[index];
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
