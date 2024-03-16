import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joshua_notes_flutter/core/app_route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _splashDelayed();
  }

  void _splashDelayed() {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(Routes.homePage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 157, 196, 255),
      body: Center(
        child: Text(
          'Welcome to Joshua Notes!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
