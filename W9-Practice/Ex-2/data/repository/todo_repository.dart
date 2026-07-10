import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/todo.dart';
import '../dto/todo_dto.dart';
import 'repository_exception.dart';

class TodoRepository {
  static final global = TodoRepository();

  final String baseUrl = "https://todo-list-7ca89-default-rtdb.asia-southeast1.firebasedatabase.app/";

  Future<List<Todo>> getTodos() async {
    final url = Uri.parse('$baseUrl/todos.json');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw RepositoryException(
          "Failed to fetch todos: Status code ${response.statusCode}",
        );
      }

      if (response.body == 'null' || response.body.isEmpty) {
        return [];
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      final List<Todo> todos = data.entries.map((entry) {
        final id = entry.key;
        final json = entry.value as Map<String, dynamic>;
        return TodoDto.fromJson(id, json);
      }).toList();

      return todos;
    } catch (e) {
      if (e is RepositoryException) rethrow;
      throw RepositoryException("Network connection error: $e");
    }
  }

  Future<void> updateCompleted(String todoId, bool completed) async {
    final url = Uri.parse('$baseUrl/todos/$todoId.json');

    try {
      final response = await http.patch(
        url,
        body: jsonEncode({'completed': completed}),
      );

      if (response.statusCode != 200) {
        throw RepositoryException("Failed to sync change with Firebase.");
      }
    } catch (e) {
      throw RepositoryException("Network error while trying to save: $e");
    }
  }
}
