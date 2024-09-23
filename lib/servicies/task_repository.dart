import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> fetchTasks() {
    return _firestore.collection('items')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'item': doc['item'],
        };
      }).toList();
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('items').doc(taskId).delete();
  }
}
