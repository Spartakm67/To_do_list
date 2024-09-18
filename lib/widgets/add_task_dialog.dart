import 'package:flutter/material.dart';
import 'package:flutter_todo/servicies/servicies.dart';

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
      style: TextStyle(
        color: Colors.teal,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      ),
    ),
    content: TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter a task',
        hintStyle: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
    ),
    actions: [
      ElevatedButton(
        onPressed: () async {
          await taskActions.onAddTask(
            context,
            controller,
            isFirebaseInitialized,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent,
        ),
        child: const Text('Add',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      )
    ],
  );
 }




}