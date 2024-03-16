import 'package:flutter/material.dart';
import 'package:joshua_notes_flutter/controllers/note_provider/note_provider.dart';
import 'package:joshua_notes_flutter/core/constants/rooutes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _getAllNotes();
    });
  }

  Future<void> _getAllNotes() async {
    final noteProv = context.read<NoteProvider>();
    try {
      noteProv.getNotes();
    } catch (e) {
      print('Error getting notes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Joshua Notes'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Notes',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Consumer<NoteProvider>(
                    builder: (context, noteProv, child) {
                      return ListView.builder(
                        itemCount: noteProv.notes.length,
                        itemBuilder: (context, index) {
                          final note = noteProv.notes[index];
                          return ListTile(
                            title: Text(note.title),
                            subtitle: Text(note.content),
                          );
                        },
                        reverse: true, // Mengurutkan daftar secara terbalik
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.createNote,
              );
            },
            child: const Text('Add Note'),
          ),
        ));
  }
}
