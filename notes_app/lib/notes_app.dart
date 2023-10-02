import 'package:flutter/material.dart';
import 'package:notes_app/note_entry_page.dart';
import 'package:notes_app/note_notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final noteNotifier = Provider.of<NoteNotifier>(context);
    return Theme(
      data: ThemeData(primarySwatch: Colors.green),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: Column(
          children: [
            for (var note in noteNotifier.currentNotes)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NoteEntryPage(
                          note: note,
                          noteIndex: noteNotifier.currentNotes.indexOf(note));
                    }));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.yellowAccent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(note.title),
                            Row(
                              children: [
                                Text('!' * note.priority),
                                IconButton(
                                    onPressed: () {
                                      noteNotifier.deleteNote(noteNotifier
                                          .currentNotes
                                          .indexOf(note));
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            )
                          ],
                        ),
                        Text(note.body),
                        Text(convertToDate(note.date))
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NoteEntryPage();
            }));
          },
          child: const Icon(Icons.edit_attributes_outlined),
        ),
      ),
    );
  }
}

final dateFormat = DateFormat().add_yMMMMd();
String convertToDate(DateTime date) {
  return dateFormat.format(date);
}
