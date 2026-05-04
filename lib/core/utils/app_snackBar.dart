import 'package:flutter/material.dart';

class AppSnackBar {

  static void showError(BuildContext context, String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.withAlpha(230),
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: Duration(milliseconds:600),
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}