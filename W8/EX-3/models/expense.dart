import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food(icon: Icons.food_bank),
  travel(icon: Icons.airplane_ticket),
  leisure(icon: Icons.piano),
  work(icon: Icons.computer);

  final IconData icon;

  const Category({required this.icon});
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
