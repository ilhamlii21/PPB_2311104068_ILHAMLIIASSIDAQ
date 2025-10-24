import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

String nama = "";
int password = 0;
int currentIndex = 0;

List<Widget> pages = [
  const Text("Home"),
  const Text("Search"),
  const Text("Settings"),
];

int? item = 1;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text("Dropdown Button"),
            DropdownButton<int>(
              value: item,
              items: [
                DropdownMenuItem(value: 1, child: Text("Jakarta")),
                DropdownMenuItem(value: 2, child: Text("Bandung")),
                DropdownMenuItem(value: 3, child: Text("Surabaya")),
              ],
              onChanged: (value) {
                setState(() {
                  item = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
