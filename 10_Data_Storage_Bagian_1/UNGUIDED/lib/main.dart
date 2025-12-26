import 'package:flutter/material.dart';
import 'databaseHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> datamahasiswa;

  @override
  void initState() {
    super.initState();
    datamahasiswa = DatabaseHelper().read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaf5ff),

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "SQLite Biodata Mahasiswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InputPage()),
          );
          setState(() {
            datamahasiswa = DatabaseHelper().read();
          });
        },
      ),

      body: FutureBuilder(
        future: datamahasiswa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final m = data[index];

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m['nama'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("NIM : ${m['nim']}"),
                      Text("Alamat : ${m['alamat']}"),
                      Text("Hobi : ${m['hobi']}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final namaC = TextEditingController();
  final nimC = TextEditingController();
  final alamatC = TextEditingController();
  final hobiC = TextEditingController();

  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaf5ff),

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Tambah Biodata Mahasiswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: namaC,
              decoration: inputStyle("Nama", Icons.person),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: nimC,
              decoration: inputStyle("NIM", Icons.format_list_numbered),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: alamatC,
              decoration: inputStyle("Alamat", Icons.home),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: hobiC,
              decoration: inputStyle("Hobi", Icons.sports_esports),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper().create({
                  "nama": namaC.text,
                  "nim": nimC.text,
                  "alamat": alamatC.text,
                  "hobi": hobiC.text,
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
