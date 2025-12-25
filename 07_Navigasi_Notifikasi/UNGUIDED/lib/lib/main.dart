import 'package:flutter/material.dart';
import '/models/product.dart';

import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: const HomeScreen(),
      routes: {
        '/detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Product;
          return ProductDetailScreen(product: args);
        }
      },
    );
  }
}