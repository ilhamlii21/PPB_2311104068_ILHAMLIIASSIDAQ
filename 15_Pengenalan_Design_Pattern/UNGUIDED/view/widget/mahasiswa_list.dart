import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/mahasiswa_model.dart';
import '../../viewmodel/mahasiswa_viewmodel.dart';

class MahasiswaList extends StatelessWidget {
  final MahasiswaViewModel viewModel;

  const MahasiswaList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading.value) {
        return _buildLoadingIndicator();
      }

      if (viewModel.mahasiswaList.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        itemCount: viewModel.mahasiswaList.length,
        itemBuilder: (context, index) {
          final mahasiswa = viewModel.mahasiswaList[index];
          return _buildListItem(mahasiswa);
        },
      );
    });
  }


  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 16),
          Text(
            'Memuat data...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada data',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tekan tombol GET untuk mengambil data',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildListItem(Mahasiswa mahasiswa) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.person,
                color: Colors.blue[600],
              ),
            ),

            const SizedBox(width: 16),

      
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mahasiswa.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mahasiswa.nim,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (mahasiswa.createdAt != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Ditambahkan: ${mahasiswa.createdAt!.toLocal().toString().split('.')[0]}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                ],
              ),
            ),

     
            Row(
              children: [
                IconButton(
                  onPressed: () => viewModel.setEditMode(mahasiswa),
                  icon: Icon(Icons.edit, color: Colors.green[600]),
                  tooltip: 'Edit',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showDeleteDialog(mahasiswa),
                  icon: Icon(Icons.delete, color: Colors.red[600]),
                  tooltip: 'Hapus',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _showDeleteDialog(Mahasiswa mahasiswa) {
    Get.defaultDialog(
      title: 'Konfirmasi Hapus',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
      content: Column(
        children: [
          const Text('Apakah Anda yakin ingin menghapus data ini?'),
          const SizedBox(height: 8),
          Text(
            '${mahasiswa.name} (${mahasiswa.nim})',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          viewModel.deleteData(mahasiswa.id);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
        child: const Text(
          'HAPUS',
          style: TextStyle(color: Colors.white),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('BATAL'),
      ),
    );
  }
}
