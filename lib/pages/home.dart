import 'package:flutter/material.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'package:flutter_todo/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/bloc/bloc.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskActions taskActions = TaskActions(taskService: AddTask());
    final TextEditingController controller = TextEditingController();

    return BlocProvider(
      create: (_) => TaskBloc()..add(LoadTasksEvent()),
      child: Scaffold(
      backgroundColor: Colors.grey[500],
        appBar: CustomAppBar(
            title: 'To do & list',
            onMenuPressed: () => menuOpen(context),
      ),
      body: BlocListener<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is TaskError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            child: const TodoList(),
        ),
      floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskDialog(
                    controller: controller,
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
      ),
    );
  }
}