import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? _userToDo;
  List todoList = [];

  bool _isFirebaseInitialized = false;

  Future<void> initFirebase() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      setState(() {
        _isFirebaseInitialized = true; // database initialization is complete
      });
      // print("Firebase initialized successfully");
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }


  @override
  void initState() {
    super.initState();

    initFirebase();

    todoList.addAll([
      'Call nine-one-one',
      'Launch project',
      'Keep-in-touch',
       'Call home',
    ]);
  }

  void _menuOpen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Menu'),),
            body: Row(
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => true);
                }, child: const Text('To the main page')),
                const Padding(padding: EdgeInsets.only(left: 15)),
                const Text('New menu')
              ],
            )
          );
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: const Text('To do list',
        style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.w700,
          fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _menuOpen,
              icon: const Icon(Icons.menu_outlined))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('items')
              .orderBy('timestamp', descending: false)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return const Text('No data!');
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: Card(
                        child: ListTile(
                          title: Text(snapshot.data!.docs[index].get('item')),
                          trailing: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('items').
                                doc(snapshot.data!.docs[index].id).delete();
                              },
                              icon: Icon(
                                Icons.delete_sweep,
                                color: Colors.cyan[200],
                              )),
                        ),
                      ),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance.collection('items').
                        doc(snapshot.data!.docs[index].id).delete();
                      },
                    );
                  }
              );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add element'),
                content: TextField(
                  onChanged: (String? value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      if (!_isFirebaseInitialized) {
                        print('Firebase is not initialized!');
                        return;
                      }

                      if (_userToDo != null && _userToDo!.isNotEmpty) {
                        try {
                          final navigator = Navigator.of(context);
                          // print('Navigator context');
                          await FirebaseFirestore.instance.collection('items')
                              .add({
                            'item': _userToDo,
                            'timestamp': FieldValue.serverTimestamp(),
                              });
                          // print('Data added');
                         navigator.pop();
                        }
                        catch (e) {
                          print('Error: catch $e');
                        }
                      } else {
                        print('Error: The task is empty!');
                      }
                    },
                      child: const Text('Add'),
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