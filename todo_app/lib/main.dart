import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_app.dart';
import 'package:todo_app/todo_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoNotifier>(
        create: (context) => TodoNotifier(),
        child: const MaterialApp(title: 'Todo App', home: TodoApp()));
  }
}
