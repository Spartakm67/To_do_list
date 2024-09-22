import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final BuildContext context;
  final TextEditingController controller;
  final bool isFirebaseInitialized;

  AddTaskEvent(this.context, this.controller, this.isFirebaseInitialized);

  @override
  List<Object> get props => [context, controller, isFirebaseInitialized];
}

class UpdateTaskEvent extends TaskEvent {
  final String updatedId;
  final String updatedTask;

  UpdateTaskEvent(this.updatedId, this.updatedTask);

  @override
  List<Object> get props => [updatedId, updatedTask];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}


