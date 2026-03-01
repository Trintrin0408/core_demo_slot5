import 'package:core_demo_slot5/domain/entities/managed_user.dart';
import 'package:flutter/material.dart';

class UserItemCard extends StatelessWidget {
  final ManagedUser user; // Thay đổi từ Map sang ManagedUser
  final VoidCallback onTap;

  const UserItemCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : '?',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A5FAD),
            ),
          ),
        ),
        title: Text(
          user.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A5FAD),
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${user.dob} ・ ${user.address}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
