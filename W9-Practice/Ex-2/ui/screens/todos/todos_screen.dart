import 'package:flutter/material.dart';

import '../../../data/repository/todo_repository.dart';
import '../../../models/todo.dart';
import '../../theme/app_screen.dart';
import '../../utils/async_data.dart';
import 'todo_card.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  AsyncData<List<Todo>> asyncData = AsyncData.notstarted();

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  void _fetchTodos() async {
    setState(() => asyncData = AsyncData.loading());
    try {
      List<Todo> todos = await TodoRepository.global.getTodos();
      setState(() => asyncData = AsyncData.success(todos));
    } catch (e) {
      setState(() => asyncData = AsyncData.error(e.toString()));
    }
  }

  void onUpdateCompleted(Todo todo) async {
    if (asyncData.status != AsyncStatus.success || asyncData.value == null)
      return;

    final updatedStatus = !todo.completed;
    List<Todo> currentTodos = List.from(asyncData.value!);
    int index = currentTodos.indexWhere((element) => element.id == todo.id);

    if (index != -1) {
      currentTodos[index] = currentTodos[index].copyWith(updatedStatus);
      setState(() => asyncData = AsyncData.success(currentTodos));
    }

    try {
      await TodoRepository.global.updateCompleted(todo.id, updatedStatus);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update status on server: $e")),
      );
      _fetchTodos(); 
    }
  }

  Widget get content => switch (asyncData.status) {
    AsyncStatus.notstarted => Text(
      "Tap to refresh",
      style: AppTheme.paragraph.copyWith(color: AppTheme.redColor),
    ),
    AsyncStatus.loading => const CircularProgressIndicator(),
    AsyncStatus.success => _buildTodos(),
    AsyncStatus.error => _buildError(),
  };

  Widget _buildTodos() {
    List<Todo> todos = asyncData.value!;
    if (todos.isEmpty) {
      return Text(
        "No todos found! Add some in your Firebase console.",
        style: AppTheme.paragraph,
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) =>
          TodoCard(todo: todos[index], onTap: onUpdateCompleted),
    );
  }

  Widget _buildError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, color: AppTheme.redColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                asyncData.error!,
                style: AppTheme.paragraph.copyWith(color: AppTheme.redColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: _fetchTodos,
          child: const Text("Retry Connection"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text("Welcome !", style: AppTheme.heading),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchTodos),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: content),
      ),
    );
  }
}
