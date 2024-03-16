import 'package:flutter/material.dart';
import 'package:joshua_notes_flutter/controllers/note_provider/note_provider.dart';
import 'package:joshua_notes_flutter/core/app_route.dart';
import 'package:joshua_notes_flutter/core/constants/rooutes.dart';
import 'package:joshua_notes_flutter/views/create_note/create_note_page.dart';
import 'package:joshua_notes_flutter/views/home/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Joshua Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppRoute.router,
    );
  }
}
