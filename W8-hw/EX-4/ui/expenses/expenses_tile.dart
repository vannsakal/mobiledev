import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile({super.key, required this.expense});
  final formatter = DateFormat.yMd();

  final Expense expense;

  // We format the date DD/MM/YYYY
  String get dateFormat => formatter.format(expense.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(expense.title),
          subtitle: Text(dateFormat),
          leading: Icon(expense.category.icon),
          trailing: Text("${expense.amount.toString()} \$"),
        ),
      ),
    );
  }
}
