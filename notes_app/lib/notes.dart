class Note {
  final DateTime date;
  final String title;
  final int priority;
  final String body;

  Note(
      {required this.title,
      required this.body,
      required this.date,
      required this.priority});

  @override
  String toString() {
    return 'Note(title: $title, body: $body, date: $date, priorty:$priority)';
  }
}

final exampleNote = Note(
    title: 'Creating a new notes',
    body: 'We need to be able to create, edit and update',
    date: DateTime.now(),
    priority: 1);
