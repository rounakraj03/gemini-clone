import 'package:flutter/material.dart';

class scaffoldMessenger {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar({required String text, Color? backgroundColor}) {
    final scaffoldMessenger = scaffoldMessengerKey.currentState;
    scaffoldMessenger?.showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? Colors.deepPurple.shade200,
        content: Text(text),
      ),
    );
  }
}
