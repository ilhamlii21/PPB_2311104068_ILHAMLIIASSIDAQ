import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodel/mahasiswa_viewmodel.dart';

class MahasiswaForm extends StatelessWidget {
  final MahasiswaViewModel viewModel;

  const MahasiswaForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Obx(
              () => Text(
                viewModel.isEditMode.value
                    ? 'Edit Data'
                    : 'Tambah Data Baru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),

            const SizedBox(height: 16),

     
            _buildTextField(
              label: 'Nama',
              icon: Icons.person,
              controller: viewModel.nameController,
            ),

            const SizedBox(height: 12),

        
            _buildTextField(
              label: 'NIM',
              icon: Icons.badge,
              controller: viewModel.nimController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.blue[600]),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.blue[600]!,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
