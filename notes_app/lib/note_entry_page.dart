import 'package:flutter/material.dart';
import 'package:notes_app/note_notifier.dart';
import 'package:notes_app/notes.dart';
import 'package:provider/provider.dart';

class NoteEntryPage extends StatelessWidget {
  final Note? note;
  final int? noteIndex;
  const NoteEntryPage({super.key, this.note, this.noteIndex});

  @override
  Widget build(BuildContext context) {
    final noteNotifier = Provider.of<NoteNotifier>(context);
    final priority = ValueNotifier(note?.priority ?? 0);
    TextEditingController noteTitle =
        TextEditingController(text: note?.title ?? "");
    TextEditingController noteBody =
        TextEditingController(text: note?.body ?? "");
    return Theme(
      data: ThemeData(primarySwatch: Colors.blue),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Title'),
                controller: noteTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Body'),
                controller: noteBody,
                maxLines: null,
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  value: priority.value,
                  icon: const Text('Priority'),
                  items: List.generate(
                      3,
                      (index) => DropdownMenuItem(
                          value: index, child: Text(index.toString()))),
                  onChanged: (value) {
                    priority.value = value!;
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newNote = Note(
                title: noteTitle.text,
                body: noteBody.text,
                date: DateTime.now(),
                priority: priority.value);
            if (note != null && noteIndex != null) {
              noteNotifier.updateNote(noteIndex!, newNote);
            } else {
              noteNotifier.addNote(newNote);
            }
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
