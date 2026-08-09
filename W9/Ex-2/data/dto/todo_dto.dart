import 'dart:convert';

import '../../models/todo.dart';

class TodoDto {
  static const id = "id";
  static const title = "title";
  static const completed = "completed";

  static Todo fromJson(String id, Map<String, dynamic> json) {
    assert(
      json.containsKey(title) && json[title] is String,
      'Missing or invalid title',
    );
    assert(
      json.containsKey(completed) && json[completed] is bool,
      'Missing or invalid completed status',
    );

    return Todo(
      id: id,
      title: json[title] as String,
      completed: json[completed] as bool,
    );
  }

  static Map<String, dynamic> toJson(Todo todo) {
    return {title: todo.title, completed: todo.completed};
  }
}

void main() {
  const jsonString = "";

  final Map<String, dynamic> data = jsonDecode(jsonString);

  data.entries.map((entry) {
    final id = entry.key;
    final json = entry.value as Map<String, dynamic>;

    return TodoDto.fromJson(id, json);
  }).toList();
}
