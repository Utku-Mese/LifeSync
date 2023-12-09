import 'package:flutter/material.dart';

class ShowSnackBar {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static void showSnackBar(String? message) {
    if (message == null) return;

    

    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
