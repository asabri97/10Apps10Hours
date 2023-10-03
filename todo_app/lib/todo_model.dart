class Todo {
  String task;
  bool isDone;

  Todo({required this.task, this.isDone = false});
}

final todos = [Todo(task: 'Finish all 10 apps'), Todo(task: 'Exercise')];
