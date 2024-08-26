import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3)}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: backgroundColor,
    duration: duration,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
