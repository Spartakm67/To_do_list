import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/features/features.dart';
import 'package:flutter_todo/bloc/bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(

      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is TaskLoaded) {
          final tasks = state.tasks;
            if (tasks.isEmpty) {
                return const Center(child: Text('No tasks available!'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task['id']),
                child: Card(
                  child: ListTile(
                    title: Text('${index + 1}. ${task['item']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            final editFeature = EditFeature();
                            editFeature.editTask(
                              context,
                              task['id'],
                              task['item'],
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<TaskBloc>().add(DeleteTaskEvent(task['id']));
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
                  context.read<TaskBloc>().add(DeleteTaskEvent(task['id']));
                },
              );
            },
          );
        }
      return const Center(child: Text('No data!'));
     },
   );
  }
}