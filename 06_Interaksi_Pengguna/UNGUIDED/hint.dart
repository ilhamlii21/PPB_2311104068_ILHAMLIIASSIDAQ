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
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your name",
                ),
              ),
              // const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your password",
                ),
              ),
              // const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {}); // biar text di bawah ikut update
                },
                child: Text("Submit"),
              ),
              // const SizedBox(height: 16),
              Text(nameController.text),
              Text(passwordController.text),
            ],
          ),
        ),
      ),
    );
  }
}
