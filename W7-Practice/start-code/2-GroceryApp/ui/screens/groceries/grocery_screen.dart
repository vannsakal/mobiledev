import 'package:flutter/material.dart';
import '../../../models/grocery.dart';
import 'grocery_form.dart';
import 'grocery_tile.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({
    super.key,
    required this.groceryItems,
    required this.onAddItem,
  });

  final List<GroceryItem> groceryItems;
  final void Function(GroceryItem item) onAddItem;

  void onCreate(BuildContext context) async {
    final newItem = await showModalBottomSheet<GroceryItem>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const GroceryForm(),
    );

    if (newItem != null) {
      onAddItem(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => GroceryTile(item: groceryItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => onCreate(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
