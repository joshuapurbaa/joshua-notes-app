import 'package:flutter/material.dart';
import 'package:joshua_notes_flutter/controllers/note_provider/note_provider.dart';
import 'package:provider/provider.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Future<void> _createNote() async {
    final prov = context.read<NoteProvider>();
    try {
      final res = await prov.createNote(
        title: _titleController.text,
        content: _contentController.text,
      );

      if (res) {
        const ScaffoldMessenger(
          child: SnackBar(
            content: Text('Note created'),
          ),
        );
      }
    } catch (e) {
      print('Error creating note: $e');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          print('Popped :: CreateNotePage');
          final prov = context.read<NoteProvider>();
          prov.getNotes();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Create a new note',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _createNote();
                },
                child: const Text('Create Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
