import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBarMsg(String message, {Color? color, Duration? duration}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}
