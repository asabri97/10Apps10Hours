import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';

class TodoNotifier extends ChangeNotifier {
  List<Todo> currentTodos = todos;

  void addTodo(Todo todo) {
    currentTodos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = currentTodos.indexOf(todo);
    final isDone = currentTodos.elementAt(index).isDone;
    currentTodos.elementAt(index).isDone = !isDone;
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final index = currentTodos.indexOf(todo);
    currentTodos.removeAt(index);
    notifyListeners();
  }

  void updateTodoTask(String updatedTask, {required Todo todo}) {
    final index = currentTodos.indexOf(todo);
    currentTodos.elementAt(index).task = updatedTask;
    notifyListeners();
  }
}
