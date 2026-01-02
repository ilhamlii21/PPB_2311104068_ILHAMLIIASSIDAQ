import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';


class HomePage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Saya'),
        backgroundColor: Colors.blue[700],
      ),
      body: Obx(() => noteController.notes.isEmpty
          ? Center(
              child: Text(
                'Belum ada catatan.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: noteController.notes.length,
              itemBuilder: (context, index) {
                Note note = noteController.notes[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(note.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => noteController.removeNote(note.id),
                    ),
                  ),
                );
              },
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addNote'),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[700],
      ),
    );
  }
}