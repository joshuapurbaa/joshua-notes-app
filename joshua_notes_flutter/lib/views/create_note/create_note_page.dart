// ignore: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:joshua_notes_client/joshua_notes_client.dart';
import 'package:joshua_notes_flutter/controllers/note_provider/note_provider.dart';
import 'package:joshua_notes_flutter/core/utils/app_snackbar.dart';
import 'package:provider/provider.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key, this.note});
  final Note? note;

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool isUpdate = false;

  String updateOrCreateNote() {
    return isUpdate ? 'Update' : 'Create';
  }

  @override
  initState() {
    super.initState();
    if (widget.note != null) {
      setState(() {
        isUpdate = true;
      });
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  Future<void> _submitNote() async {
    final prov = context.read<NoteProvider>();
    try {
      if (isUpdate) {
        final res = await prov.updateNote(
          title: _titleController.text,
          content: _contentController.text,
        );

        if (res) {
          appSnackBar(
            context: context,
            message: 'Note updated',
            isError: false,
          );
        }
      } else {
        final res = await prov.createNote(
          title: _titleController.text,
          content: _contentController.text,
        );
        if (res) {
          appSnackBar(
            context: context,
            message: 'Note created',
            isError: false,
          );
        }
      }
    } catch (e) {
      appSnackBar(
        context: context,
        message: 'Failed to create or update note: $e',
        isError: true,
      );
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
          final prov = context.read<NoteProvider>();
          prov.getNotes();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${updateOrCreateNote()} Note'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _contentController.text.isEmpty) {
                  appSnackBar(
                    context: context,
                    message: 'Title and content cannot be empty',
                    isError: true,
                  );
                } else {
                  _submitNote();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${updateOrCreateNote()} a ${isUpdate ? '' : 'new'} note',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
