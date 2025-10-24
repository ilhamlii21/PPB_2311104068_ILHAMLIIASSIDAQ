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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
