import 'package:flutter/material.dart';

import '../../../models/todo.dart';
import '../../theme/app_screen.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo, required this.onTap});

  final Todo todo;
  final ValueChanged<Todo> onTap;

  TextDecoration? get textDecoration =>
      todo.completed ? TextDecoration.lineThrough : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(todo),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppTheme.yellowColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CheckBox(checked: todo.completed),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    todo.title,
                    style: AppTheme.paragraph.copyWith(
                      decoration: textDecoration,
                      color: todo.completed ? Colors.grey : AppTheme.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckBox extends StatelessWidget {
  const CheckBox({super.key, required this.checked});

  final bool checked;

  BoxBorder? get border =>
      checked ? null : Border.all(width: 2, color: Colors.grey);
  Color? get backgroundColor =>
      checked ? AppTheme.greenColor : Colors.transparent;
  Widget? get innerIcon =>
      checked ? const Icon(Icons.check, color: Colors.white, size: 20) : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: innerIcon,
    );
  }
}
