import 'package:flutter/material.dart';
import 'add_task.dart';

class TaskActions {
  final AddTask taskService;

  TaskActions({required this.taskService});

  Future<String?> onAddTask(

      TextEditingController controller,
      bool isFirebaseInitialized
      ) async {
    String task = controller.text.trim();
    if (!isFirebaseInitialized) {
      return 'Firebase is not initialized!';
    }
    if (task.isEmpty) {
      return 'Task cannot be empty!';
    }
      try {
        await taskService.addTask(task);
        controller.clear();
        return null;
      }
      catch (e) {
        return 'Error adding item: $e';
      }
    }
  }



