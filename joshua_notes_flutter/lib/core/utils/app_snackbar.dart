import 'package:flutter/material.dart';

void appSnackBar({
  required BuildContext context,
  required String message,
  required bool isError,
}) {
  final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
