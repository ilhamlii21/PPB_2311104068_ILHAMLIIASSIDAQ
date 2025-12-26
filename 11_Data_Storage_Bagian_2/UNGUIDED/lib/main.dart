import 'package:flutter/material.dart';
import 'package:unguided/connection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConnection.init();

  final table = SupabaseConnection.client.from('perpustakaan');

  // INSERT Contoh Data
  await table.insert({
    'judul': 'Bumi',
    'penulis': 'Tere Liye',
    'tahun_terbit': 2014,
    'genre': 'Fantasi',
  });

  // READ Data
  final data = await table.select();

  print("=== Data Buku ===");
  for (var row in data) {
    print(row);
  }

  runApp(const Placeholder());
}
