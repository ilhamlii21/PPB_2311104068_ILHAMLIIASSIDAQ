import 'package:get/get.dart';
import '../models/note_model.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var nextId = 1.obs;

  void addNote(String title, String description) {
    notes.add(Note(id: nextId.value, title: title, description: description));
    nextId++;
    Get.back(); 
    Get.snackbar('Berhasil', 'Catatan telah ditambahkan');
  }

  void removeNote(int id) {
    notes.removeWhere((note) => note.id == id);
    Get.snackbar('Berhasil', 'Catatan telah dihapus');
  }
}