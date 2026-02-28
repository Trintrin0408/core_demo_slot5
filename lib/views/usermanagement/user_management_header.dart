import 'package:flutter/material.dart';

class ManagementAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;

  const ManagementAppBar({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A5FAD),
      elevation: 0,
      leading: const BackButton(color: Colors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      // Canh giữa toàn bộ khối title
      centerTitle: true,

      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,

            style: const TextStyle(

              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
