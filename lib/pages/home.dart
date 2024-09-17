import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo/features/features.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'package:flutter_todo/widgets/widgets.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  bool _isFirebaseInitialized = false;

  Future<void> initFirebase() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      setState(() {
        _isFirebaseInitialized = true; // database initialization is complete
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Firebase initialized successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing Firebase: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    initFirebase();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
        appBar: CustomAppBar(
            title: 'To do list',
            onMenuPressed: () => menuOpen(context),
      ),
      body: StreamBuilder(
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add element',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                content: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Enter a task',
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
                      final navigator = Navigator.of(context);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      String task = _controller.text.trim();

                      if (!_isFirebaseInitialized) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(
                              'Firebase is not initialized!')),
                        );
                        return;
                      }
                      if (task.isNotEmpty) {
                        try {
                          await FirebaseFirestore.instance.collection('items')
                              .add({
                            'item': task,
                            'timestamp': FieldValue.serverTimestamp(),
                              });
                          // print('Data added');
                         navigator.pop();
                         _controller.clear();
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
                          )),);
                      }
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
            });
          },
          backgroundColor: Colors.greenAccent,
          shape: const CircleBorder(),
        child: const Icon(
            Icons.add_box,
            color: Colors.white,
        ),
      ),
    );
  }
}