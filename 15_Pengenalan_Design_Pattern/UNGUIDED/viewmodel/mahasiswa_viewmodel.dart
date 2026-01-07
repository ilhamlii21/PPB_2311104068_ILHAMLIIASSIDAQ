import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/mahasiswa_model.dart';
import '../service/api_service.dart';

class MahasiswaViewModel extends GetxController {
  final ApiService _apiService = ApiService();

  final RxList<Mahasiswa> mahasiswaList = <Mahasiswa>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isEditMode = false.obs;
  final RxString selectedId = ''.obs;
  final RxString errorMessage = ''.obs;

  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController nimController =
      TextEditingController();

  int get totalMahasiswa => mahasiswaList.length;

  bool get hasError => errorMessage.isNotEmpty;

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      nimController.text.isNotEmpty;

  @override
  void onClose() {
    nameController.dispose();
    nimController.dispose();
    super.onClose();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await _apiService.fetchMahasiswa();
      mahasiswaList.assignAll(data);

      showSuccessSnackbar('Data berhasil diambil');
    } catch (e) {
      errorMessage(e.toString());
      showErrorSnackbar('Gagal mengambil data');
    } finally {
      isLoading(false);
    }
  }


  Future<void> addData() async {
    if (!isFormValid) {
      showWarningSnackbar('Nama dan NIM tidak boleh kosong');
      return;
    }

    try {
      isLoading(true);
      errorMessage('');

      await _apiService.addMahasiswa(
        nameController.text,
        nimController.text,
      );

      await fetchData();
      clearForm();

      showSuccessSnackbar('Data berhasil ditambahkan');
    } catch (e) {
      errorMessage(e.toString());
      showErrorSnackbar('Gagal menambah data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateData() async {
    if (selectedId.isEmpty) return;

    if (!isFormValid) {
      showWarningSnackbar('Nama dan NIM tidak boleh kosong');
      return;
    }

    try {
      isLoading(true);
      errorMessage('');

      await _apiService.updateMahasiswa(
        selectedId.value,
        nameController.text,
        nimController.text,
      );

      await fetchData();
      cancelEdit();

      showSuccessSnackbar('Data berhasil diperbarui');
    } catch (e) {
      errorMessage(e.toString());
      showErrorSnackbar('Gagal memperbarui data');
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteData(String id) async {
    try {
      isLoading(true);
      errorMessage('');

      await _apiService.deleteMahasiswa(id);
      await fetchData();

      showSuccessSnackbar('Data berhasil dihapus');
    } catch (e) {
      errorMessage(e.toString());
      showErrorSnackbar('Gagal menghapus data');
    } finally {
      isLoading(false);
    }
  }


  void setEditMode(Mahasiswa mahasiswa) {
    isEditMode(true);
    selectedId(mahasiswa.id);
    nameController.text = mahasiswa.name;
    nimController.text = mahasiswa.nim;
  }

  void cancelEdit() {
    isEditMode(false);
    selectedId('');
    clearForm();
  }


  void clearForm() {
    nameController.clear();
    nimController.clear();
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void showWarningSnackbar(String message) {
    Get.snackbar(
      'Peringatan',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void updateMahasiswa() {}

  void addMahasiswa() {}
}
