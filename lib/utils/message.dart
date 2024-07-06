import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void ShowSnackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}
