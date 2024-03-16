import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joshua_notes_flutter/views/create_note/create_note_page.dart';
import 'package:joshua_notes_flutter/views/home/home_page.dart';
import 'package:joshua_notes_flutter/views/splash/splash_page.dart';

enum Routes {
  root('/'),
  homePage('/home'),
  createNotePage('create-note'),
  ;

  const Routes(this.path);
  final String path;
}

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.root.path,
    routes: [
      GoRoute(
        path: Routes.root.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: Routes.homePage.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: HomePage(),
        ),
        routes: [
          GoRoute(
            name: Routes.createNotePage.name,
            path: Routes.createNotePage.path,
            pageBuilder: (context, state) => const MaterialPage(
              child: CreateNotePage(),
            ),
          ),
        ],
      ),
    ],
  );
}
