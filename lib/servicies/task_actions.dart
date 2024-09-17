import 'package:flutter/material.dart';
import 'add_task.dart';

class TaskActions {
  final AddTask taskService;

  TaskActions({required this.taskService});

  Future<void> onAddTask(
      BuildContext context,
      TextEditingController controller,
      bool isFirebaseInitialized) async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String task = controller.text.trim();
    if (!isFirebaseInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(
            'Firebase is not initialized!'),
        ),
      );
      return;
    }
    if (task.isNotEmpty) {
      try {
        await taskService.addTask(task);
        navigator.pop();
        controller.clear();
      }
      catch (e) {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error adding item: $e')),);
      }
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Task cannot be empty!',
           style: TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.w500,
             fontSize: 30,
           ),
         ),
       ),
     );
    }
  }
}


