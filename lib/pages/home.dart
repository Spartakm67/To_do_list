import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'package:flutter_todo/widgets/widgets.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AddTask taskService = AddTask();
  final TaskActions taskActions = TaskActions(taskService: AddTask());
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
      body: _isFirebaseInitialized
          ? const TodoList() // Render TodoList only if Firebase is initialized
          : const Center(child: CircularProgressIndicator()), // Show loader until Firebase is initialized

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
                        await taskActions.onAddTask(
                          context,
                          _controller,
                          _isFirebaseInitialized,
                      );
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