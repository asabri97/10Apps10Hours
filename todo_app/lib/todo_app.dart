import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_model.dart';
import 'package:todo_app/todo_notifier.dart';

enum Action { edit, delete }

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todoNotifier = Provider.of<TodoNotifier>(context);
    return Theme(
      data: ThemeData(primarySwatch: Colors.cyan),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: Column(
          children: [
            for (var todo in todoNotifier.currentTodos)
              CheckboxListTile(
                  secondary: PopupMenuButton<Action>(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                            value: Action.edit, child: Text('Edit')),
                        const PopupMenuItem(
                            value: Action.delete, child: Text('Delete'))
                      ];
                    },
                    onSelected: (value) {
                      final todoController =
                          TextEditingController(text: todo.task);
                      TextEditingController(text: todo.task);
                      switch (value) {
                        case Action.delete:
                          todoNotifier.removeTodo(todo);
                          break;
                        case Action.edit:
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return SimpleDialog(
                                    contentPadding: const EdgeInsets.all(15),
                                    children: [
                                      Text(
                                        'Update Todo',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      TextField(
                                        controller: todoController,
                                        decoration: const InputDecoration(
                                            hintText: 'Do 10 push ups'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          todoNotifier.updateTodoTask(
                                              todoController.text,
                                              todo: todo);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Update'),
                                      )
                                    ],
                                  );
                                });
                              });

                          break;
                        default:
                      }
                    },
                  ),
                  title: Text(
                    todo.task,
                    style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  value: todo.isDone,
                  onChanged: ((value) {
                    todoNotifier.updateTodo(todo);
                  }))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final todoController = TextEditingController();
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return SimpleDialog(
                      contentPadding: const EdgeInsets.all(15),
                      children: [
                        Text(
                          'Add Todo',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TextField(
                          controller: todoController,
                          decoration:
                              const InputDecoration(hintText: 'Do 10 push ups'),
                        ),
                        OutlinedButton(
                            onPressed: () {
                              todoNotifier
                                  .addTodo(Todo(task: todoController.text));
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.add))
                      ],
                    );
                  });
                });
          },
          child: const Icon(Icons.edit_outlined),
        ),
      ),
    );
  }
}
