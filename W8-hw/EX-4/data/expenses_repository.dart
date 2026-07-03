import 'package:projects/W8-hw/EX-4/data/expenses_data.dart';
import '../models/expense.dart';

class ExpensesRepository {
  static Future<List<Expense>> fetchExpenses() async {
    await Future.delayed(const Duration(seconds: 5));
    return allExpenses;
  }
}
