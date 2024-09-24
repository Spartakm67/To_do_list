import 'package:flutter/material.dart';

class AddTaskDialogStyle {
  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.teal,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static const ButtonStyle addButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.tealAccent),
  );

  static const TextStyle addButtonTextStyle = TextStyle(
    color: Colors.deepOrangeAccent,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
}