import 'package:core_demo_slot5/views/usermanagement/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:core_demo_slot5/views/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Đặt màu nền cho Scaffold, đây sẽ là màu của "khung viền"
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        // 2. Padding tạo ra độ dày cho "khung viền"
        padding: const EdgeInsets.fromLTRB(12, 32, 12, 12),
        child: ClipRRect(
          // 3. Bo tròn các góc của nội dung và "khung viền"
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            // Container chứa nội dung chính, không cần margin nữa
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE3F2FD),
                  Colors.white,
                ],
                stops: [0.0, 0.7],
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false, // Tắt nút back
                  backgroundColor: const Color(0xFF1A5FAD),
                  elevation: 0,
                  toolbarHeight: 80,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  title: const Text(
                    'Hệ thống quản lý cá nhân',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  centerTitle: true,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Xin chào bạn đến với hệ thống quản lý cá nhân',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF1A5FAD),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 30, ),
                          _buildMenuItem(
                            context,
                            icon: Icons.manage_accounts_outlined,
                            title: 'Quản lý người dùng',
                            iconColor: const Color(0xFF1A5FAD),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UserManagementPage()),
                              );
                            },
                          ),
                          _buildMenuItem(
                            context,
                            iconWidget: Image.asset('assets/icons/remind.png', width: 29, height: 29), // Example with local asset
                            title: 'Quản lý nhắc việc',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context,
                            icon: Icons.shopping_cart_outlined,
                            title: 'Đặt hàng',
                            iconColor: const Color(0xFF1A5FAD),
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context,
                            icon: Icons.map_outlined,
                            title: 'Xem Bản Đồ',
                            iconColor: const Color(0xFF1A5FAD),
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context,
                            iconWidget: const FlutterLogo(size: 28),
                            title: 'Tổng quan Flutter',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context,
                            iconWidget:  Image.asset('assets/icons/switch.png', width: 29, height: 29),
                            title: 'Đăng xuất',
                            iconColor: Colors.red.shade700,
                            onTap: () {
                              // Quay về trang Login và xóa hết các trang trước đó
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    Widget? iconWidget,
    Color? iconColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      shadowColor: Colors.blue.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              if (iconWidget != null)
                SizedBox(width: 36, height: 32, child: iconWidget)
              else if (icon != null)
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A5FAD),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
