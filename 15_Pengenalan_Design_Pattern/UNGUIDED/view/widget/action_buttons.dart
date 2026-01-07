import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unguidedlimabelas/viewmodel/mahasiswa_viewmodel.dart';

class ActionButtons extends StatelessWidget {
  final MahasiswaViewModel viewModel;

  const ActionButtons({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Obx(
            () => ElevatedButton(
              onPressed: viewModel.isLoading.value
                  ? null
                  : () {
                      if (viewModel.isEditMode.value) {
                        viewModel.updateData();
                      } else {
                        viewModel.addData();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: viewModel.isEditMode.value
                    ? Colors.green
                    : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    viewModel.isEditMode.value
                        ? Icons.update
                        : Icons.add_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    viewModel.isEditMode.value ? 'UPDATE' : 'TAMBAH',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Obx(
          () => ElevatedButton(
            onPressed: viewModel.isLoading.value
                ? null
                : () => viewModel.fetchData(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
            child: const Row(
              children: [
                Icon(Icons.refresh, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'GET',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
