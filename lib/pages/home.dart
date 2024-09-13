import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
      // print("Firebase initialized successfully");
    } catch (e) {
      print("Error initializing Firebase: $e");
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
                        print('Firebase is not initialized!');
                        return;
                      }
                      //_userToDo != null && _userToDo!.isNotEmpty
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
                          // print('Error: catch $e');
                          scaffoldMessenger.showSnackBar(
                              SnackBar(content: Text('Error adding item: $e')),);
                        }
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('Task cannot be empty!')),);
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