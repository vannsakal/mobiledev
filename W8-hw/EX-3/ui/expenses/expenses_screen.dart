import 'package:flutter/material.dart';

import '../../data/expenses_data.dart';
import '../../models/expense.dart';
import 'expenses_form.dart';
import 'expenses_tile.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  void onAddPressed(BuildContext context) async {
    // use Navigator.push  
    Expense? newExpense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (context) => const ExpenseForm()),
    );

    if (newExpense != null) {
      setState(() {
        allExpenses.add(newExpense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: allExpenses.length,
          itemBuilder: (context, i) => ExpenseTile(expense: allExpenses[i]),
        ),
      ),
    );
  }
}
