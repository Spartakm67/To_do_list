import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
        appBar: CustomAppBar(
            title: 'To do list',
            onMenuPressed: () => menuOpen(context),
      ),
      body: const TodoList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskDialog(
                    controller: _controller,
                    isFirebaseInitialized: true,
                    taskActions: taskActions,
                  );
                },
            );
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