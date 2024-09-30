import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/features/features.dart';
import 'package:flutter_todo/bloc/bloc.dart';

class TaskItem extends StatelessWidget {
  final Map<String, dynamic> task;
  final int index;

  const TaskItem({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}