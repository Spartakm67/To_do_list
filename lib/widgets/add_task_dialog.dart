import 'package:flutter/material.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'package:flutter_todo/style/style.dart';

class AddTaskDialog extends StatelessWidget {
   final TextEditingController controller;
   final bool isFirebaseInitialized;
   final TaskActions taskActions;

   const AddTaskDialog({
     super.key,
     required this.controller,
     required this.isFirebaseInitialized,
     required this.taskActions,
});

@override
Widget build(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'Add element',
      style: AddTaskDialogStyle.titleTextStyle,
        ),
    content: TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter a task',
        hintStyle: AddTaskDialogStyle.hintTextStyle,
      ),
    ),
    actions: [
      ElevatedButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final result = await taskActions.onAddTask(
            controller,
            isFirebaseInitialized,
          );
          if (result == null) {
            navigator.pop(result);
          } else {
            scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Center(
                heightFactor: SnackBarStyle.heightFactor,
                child: Text(
                result,
                style: SnackBarStyle.snackBarTextStyle,
                textAlign: TextAlign.center,
                  ),
                ),
              backgroundColor: SnackBarStyle.backgroundColor,
              duration: SnackBarStyle.displayDuration,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent,
        ),
        child: const Text(
          'Add',
          style: AddTaskDialogStyle.addButtonTextStyle,
        ),
      )
    ],
  );
 }
}