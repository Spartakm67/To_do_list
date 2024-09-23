import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask {
  Future<void> addTask(String task) async {

    await FirebaseFirestore.instance.collection('items')
        .add({
      'item': task,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}