import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository {
  // Getting all tasks method
  Stream<QuerySnapshot> fetchTasks() {
    return FirebaseFirestore.instance
        .collection('items')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Deleting task method
  Future<void> deleteTask(String id) async {
    await FirebaseFirestore.instance.collection('items').doc(id).delete();
  }

  // Method for the task editing
  // void editTask(BuildContext context, String id, String task) {
  //   // Code
  // }
}