import 'package:hive/hive.dart';
import 'package:notes_app/models/note.dart';

class NotesRepository {
  final Box<Note> _notesBox = Hive.box<Note>('notesBox');

  List<Note> getAllNotes() {
    return _notesBox.values.toList();
  }

  Future<void> addNote(Note note) async {
    await _notesBox.put(note.id, note);
  }
  
  Future<void> updateNote(Note note) async {
    await _notesBox.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await _notesBox.delete(id);
  }
}
