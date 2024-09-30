import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/bloc/bloc.dart';
import 'task_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(

        buildWhen: (previous, current) {
          if (current is TaskLoading) {
          // if (current is TaskLoading || current is TaskError) {
            return false;
          }
          if (previous is TaskLoaded && current is TaskLoaded) {
            return previous.tasks != current.tasks;
          }
          return true;
        },

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
              return TaskItem(
                task: tasks[index],
                index: index,
              );
            },
          );
        }
        if (state is TaskInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('No data!'));
      },
    );
  }
}

