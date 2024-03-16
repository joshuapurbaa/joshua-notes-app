import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joshua_notes_client/joshua_notes_client.dart';
import 'package:joshua_notes_flutter/controllers/note_provider/note_provider.dart';
import 'package:joshua_notes_flutter/core/app_route.dart';
import 'package:joshua_notes_flutter/core/constants/rooutes.dart';
import 'package:joshua_notes_flutter/core/utils/app_snackbar.dart';
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
    _getData();
  }

  void _getData() {
    Future.microtask(() {
      _getAllNotes();
    });
  }

  Future<void> _getAllNotes() async {
    final noteProv = context.read<NoteProvider>();
    try {
      await noteProv.getNotes();
    } catch (e) {
      appSnackBar(
        context: context,
        message: 'Gagal mendapatkan data notes',
        isError: true,
      );
    }
  }

  Future<void> _deleteNote(int id) async {
    final noteProv = context.read<NoteProvider>();
    try {
      final res = await noteProv.deleteNote(
        id: id,
      );

      if (res) {
        appSnackBar(
          context: context,
          message: 'Berhasil menghapus note dengan id $id',
          isError: false,
        );
        _getData();
      }
    } catch (e) {
      appSnackBar(
        context: context,
        message: 'Gagal menghapus note',
        isError: true,
      );
    }
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
  }

  void _showEditNoteDialog({required Note note}) async {
    final noteProv = context.read<NoteProvider>();

    String prevTitle = note.title;
    String prevContent = note.content;

    titleController.text = note.title;
    contentController.text = note.content;

    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (prevTitle == titleController.text &&
                    prevContent == contentController.text) {
                  Navigator.pop(context, false);
                  return;
                }

                final res = await noteProv.updateNote(
                  id: note.id!,
                  title: titleController.text,
                  content: contentController.text,
                );

                if (res) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _getData();
      appSnackBar(
        context: context,
        message: 'Berhasil mengubah note',
        isError: false,
      );
    } else if (result == false) {
      return;
    } else {
      appSnackBar(
        context: context,
        message: 'Gagal mengubah note',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notes',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Consumer<NoteProvider>(
                    builder: (context, noteProv, child) {
                      if (noteProv.notes.isEmpty) {
                        return const Center(
                          child: Text('No notes'),
                        );
                      }

                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: noteProv.notes.length,
                        itemBuilder: (context, index) {
                          final note = noteProv.notes[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(note.title),
                                      Text(note.content),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        _showEditNoteDialog(
                                          note: note,
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteNote(note.id!);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        // Mengurutkan daftar secara terbalik
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () async {
                final result = await context.pushNamed(
                  Routes.createNotePage.name,
                );

                if (result == true) {
                  _getData();
                }
              },
              child: const Text('Add Note'),
            ),
          ),
        ));
  }
}
