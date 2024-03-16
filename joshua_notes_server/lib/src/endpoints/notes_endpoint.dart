import 'package:joshua_notes_server/src/generated/protocol.dart';
import 'package:serverpod/server.dart';

class NotesEndpoint extends Endpoint {
  Future<void> createNote(Session session, Note note) async {
    await Note.db.insertRow(session, note);
  }
}
