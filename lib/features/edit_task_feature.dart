import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditFeature {
  final TextEditingController _editController = TextEditingController();

  Future<void> editTask(BuildContext context, String docId, String currentTask) async {
    _editController.text = currentTask;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(hintText: 'Edit your task'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                String updatedTask = _editController.text.trim();
                if (updatedTask.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance.collection('items').doc(docId).update({
                      'item': updatedTask,
                    });
                    navigator.pop();
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text('Error updating task: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task cannot be empty!')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
  void dispose() {
    _editController.dispose();
  }
}