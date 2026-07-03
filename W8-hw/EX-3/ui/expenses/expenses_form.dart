import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // added error var
  String? _amountError;

  // fn for error checking
  void _validateAmount(String value) {
    if (value.isEmpty) {
      setState(() {
        _amountError = null;
      });
      return;
    }

    final parsedAmount = double.tryParse(value);
    if (parsedAmount == null || parsedAmount < 0 || parsedAmount > 100) {
      setState(() {
        _amountError = 'Please enter a number between 0 to 100';
      });
    } else {
      setState(() {
        _amountError = null;
      });
    }
  }

  void onCheckPressed() {
    // validation error
    if (_amountError != null || _amountController.text.isEmpty) {
      return;
    }

    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    Expense newExpense = Expense(
      amount: amount,
      title: title,
      category: Category.food,
      date: DateTime.now(),
    );

    Navigator.pop<Expense>(context, newExpense);
  }

  void onCancelPressed() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              maxLength: 50,
              // onChanged
              onChanged: _validateAmount,
              decoration: InputDecoration(
                prefix: const Text("\$ "),
                label: const Text('Quantity'),
                // errorText
                errorText: _amountError,
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onCancelPressed,
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: onCheckPressed,
                  child: const Text("Add Item"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
