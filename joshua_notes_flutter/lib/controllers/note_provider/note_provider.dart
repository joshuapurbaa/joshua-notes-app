import 'package:flutter/material.dart';
import 'package:joshua_notes_client/joshua_notes_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

enum GetAllNotesState { loading, loaded, error, none }

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  GetAllNotesState _getAllNotesState = GetAllNotesState.none;
  GetAllNotesState get getAllNotesState => _getAllNotesState;

  Future<void> getNotes() async {
    _getAllNotesState = GetAllNotesState.loading;
    notifyListeners();
    try {
      _notes = await client.notes.getNotes();
      _getAllNotesState = GetAllNotesState.loaded;
      notifyListeners();
    } catch (e) {
      _getAllNotesState = GetAllNotesState.error;
      notifyListeners();
    }
  }

  Future<bool> createNote({
    required String title,
    required String content,
  }) async {
    Note note = Note(
      title: title,
      content: content,
    );

    try {
      await client.notes.createNote(
        note,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    Note note = Note(
      id: id,
      title: title,
      content: content,
    );

    try {
      await client.notes.updateNote(
        note,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNote({
    required int id,
  }) async {
    try {
      await client.notes.deleteNote(
        id,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
