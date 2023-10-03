import 'package:flutter/material.dart';

class TodoEntryPage extends StatelessWidget {
  const TodoEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit_outlined),
      ),
    );
  }
}
