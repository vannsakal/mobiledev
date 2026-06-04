import 'package:flutter/material.dart';

enum Product {
  dart(
    title: 'Dart',
    description: 'The best object language',
    imagePath: 'assets/W4-assets/ex3/dart.png',
  ),
  flutter(
    title: 'Flutter',
    description: 'The best mobile widget library',
    imagePath: 'assets/W4-assets/ex3/flutter.png',
  ),
  firebase(
    title: 'Firebase',
    description: 'The best cloud database',
    imagePath: 'assets/W4-assets/ex3/firebase.png',
  );

  final String title;
  final String description;
  final String imagePath;

  const Product({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductCard(product: Product.dart),
              SizedBox(height: 12),
              ProductCard(product: Product.flutter),
              SizedBox(height: 12),
              ProductCard(product: Product.firebase),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imagePath,
              height: 50,
              width: 50,
              fit:  BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}