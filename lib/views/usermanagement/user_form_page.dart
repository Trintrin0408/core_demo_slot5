import 'package:core_demo_slot5/views/usermanagement/user_management_header.dart'; // Import header mới
import 'package:flutter/material.dart';

// Chuyển thành StatefulWidget để quản lý trạng thái của các trường input
class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  // Controller để quản lý text và cập nhật ngày tháng
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  // Hàm để hiển thị Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Cho phép chọn từ năm 1900
      lastDate: DateTime.now(), // Không cho phép chọn ngày trong tương lai
    );
    if (picked != null) {
      setState(() {
        // Định dạng ngày tháng và cập nhật vào ô text
        _dateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      // Sử dụng AppBar chung
      appBar: const ManagementAppBar(
        title: 'Thêm / Sửa người dùng',
        subtitle: 'Nhập thông tin và bấm Lưu',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(label: 'Họ và tên'),
            const SizedBox(height: 16),
            _buildDateField(context, label: 'Ngày sinh'), // Sử dụng hàm mới
            const SizedBox(height: 16),
            _buildTextField(label: 'Địa chỉ', maxLines: 3),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildTextField({required String label, int maxLines = 1}) {
    return TextFormField(
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

  // Cập nhật hàm này để sử dụng Controller và gọi _selectDate
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
          onPressed: () => _selectDate(context), // Gọi hàm hiển thị lịch
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
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(), // Nút Hủy để quay lại
              child: const Text('Hủy'),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement save logic
                Navigator.of(context).pop(); // Quay lại sau khi lưu
              },
              child: const Text('Lưu', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A5FAD),
                foregroundColor: Colors.white,
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
