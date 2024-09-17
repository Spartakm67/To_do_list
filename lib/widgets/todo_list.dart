import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/features/features.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('items')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data!'));
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(snapshot.data!.docs[index].id),
              child: Card(
                child: ListTile(
                  title: Text(snapshot.data!.docs[index].get('item')),
                  trailing: Row (
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          final editFeature = EditFeature();
                          editFeature.editTask(
                              context,
                              snapshot.data!.docs[index].id,
                              // _editTask(snapshot.data!.docs[index].id,
                              snapshot.data!.docs[index].get('item'));
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').
                          doc(snapshot.data!.docs[index].id).delete();
                        },
                        icon: Icon(
                          Icons.delete_sweep,
                          color: Colors.cyan[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onDismissed: (direction) {
                FirebaseFirestore.instance.collection('items').
                doc(snapshot.data!.docs[index].id).delete();
              },
            );
          },
        );
      },
    );
  }

}