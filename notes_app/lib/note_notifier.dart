import 'package:flutter/material.dart';
import 'package:notes_app/notes.dart';

class NoteNotifier extends ChangeNotifier {
  List<Note> currentNotes = [exampleNote, exampleNote];

  void addNote(Note note) {
    currentNotes.add(note);
    notifyListeners();
  }

  void updateNote(int index, Note note) {
    currentNotes[index] = note;
    notifyListeners();
  }

  void deleteNote(int index) {
    currentNotes.removeAt(index);
    notifyListeners();
  }
}
