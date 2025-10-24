import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(length: 3, child: Scaffold(
        appBar: TabBar(tabs: [
          Tab(icon: Icon(Icons.home),),
          Tab(icon: Icon(Icons.menu),),
          Tab(icon: Icon(Icons.settings),),
        ]),
        body: TabBarView(children: [
          Text("Home"),
          Text("Menu"),
          Text("Settings"),
        ],),
      ))
);
  }
}
