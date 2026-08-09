import 'package:flutter/material.dart';
import 'ui/screens/groceries/grocery_screen.dart';
import 'models/grocery.dart';
import 'data/mock_grocery_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<GroceryItem> _groceryItems = [...allGroceryItems];

  void _addGroceryItem(GroceryItem item) {
    setState(() {
      _groceryItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: GroceryScreen(
        groceryItems: _groceryItems,
        onAddItem: _addGroceryItem,
      ),
    );
  }
}
