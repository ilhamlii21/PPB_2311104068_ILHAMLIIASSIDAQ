import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/mahasiswa_viewmodel.dart';
import 'widget/mahasiswa_form.dart';
import 'widget/action_buttons.dart';
import 'widget/mahasiswa_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MahasiswaViewModel viewModel =
      Get.put(MahasiswaViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        title: const Text(
          'FORM MODUL 15',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          Obx(
            () => viewModel.isEditMode.value
                ? IconButton(
                    onPressed: viewModel.cancelEdit,
                    icon: const Icon(Icons.close),
                    tooltip: 'Batal Edit',
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MahasiswaForm(viewModel: viewModel),

            const SizedBox(height: 20),

            // Action Buttons
            ActionButtons(viewModel: viewModel),

            const SizedBox(height: 20),

            // List Header
            _buildListHeader(),

            const SizedBox(height: 10),

            // List
            Expanded(
              child: MahasiswaList(viewModel: viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daftar Mahasiswa',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Obx(
          () => Text(
            'Total: ${viewModel.totalMahasiswa}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue[600],
            ),
          ),
        ),
      ],
    );
  }
}
