import 'package:flutter/material.dart';
import 'package:projects/W8-hw/EX-4/data/expenses_repository.dart';
import '../../models/expense.dart';
import 'expenses_tile.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense>? expenses;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() async {
    List<Expense> loadedData = await ExpensesRepository.fetchExpenses();
    setState(() {
      expenses = loadedData;
    });
  }

  Widget get content {
    if (expenses == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (expenses!.isEmpty) {
      return const Center(child: Text("No expenses found."));
    }

    return ListView.builder(
      itemCount: expenses!.length,
      itemBuilder: (context, i) => ExpenseTile(expense: expenses![i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: Padding(padding: const EdgeInsets.all(20.0), child: content),
    );
  }
}
