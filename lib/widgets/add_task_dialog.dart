import 'package:flutter/material.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'package:flutter_todo/style/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/bloc/bloc.dart';

class AddTaskDialog extends StatelessWidget {
   final TextEditingController controller;
   final bool isFirebaseInitialized;
   final TaskActions taskActions;

   const AddTaskDialog({
     super.key,
     required this.controller,
     required this.isFirebaseInitialized,
     required this.taskActions,
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add element',
        style: AddTaskDialogStyle.titleTextStyle,
      ),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Enter a task',
          hintStyle: AddTaskDialogStyle.hintTextStyle,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            final scaffoldMessenger = ScaffoldMessenger.of(context);

            // Adding the task
            final result = await taskActions.onAddTask(
              controller,
              isFirebaseInitialized,
            );

            // Checking for context.mounted
            if (!context.mounted) return;

            if (result != null) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Center(
                    heightFactor: SnackBarStyle.heightFactor,
                    child: Text(
                      result,
                      style: SnackBarStyle.snackBarTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  backgroundColor: SnackBarStyle.backgroundColor,
                  duration: SnackBarStyle.displayDuration,
                ),
              );
            } else {
              // Closing the dialog first
              navigator.pop();

              // After closing add tasks to Bloc
              BlocProvider.of<TaskBloc>(context, listen: false).add(
                AddTaskEvent(controller, true),
              );
              controller.clear();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent,
          ),
          child: const Text(
            'Add',
            style: AddTaskDialogStyle.addButtonTextStyle,
          ),
        )
      ],
    );
  }
}