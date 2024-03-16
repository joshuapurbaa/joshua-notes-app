import 'package:joshua_notes_server/src/generated/protocol.dart';
import 'package:serverpod/server.dart';

class NotesEndpoint extends Endpoint {
  Future<void> createNote(Session session, Note note) async {
    await Note.db.insertRow(session, note);
  }

  Future<List<Note>> getNotes(Session session) async {
    return await Note.db.find(
      session,
      orderBy: (t) => t.id,
    );
  }

  Future<void> deleteNote(Session session, Note note) async {
    await Note.db.deleteRow(session, note);
  }
}
