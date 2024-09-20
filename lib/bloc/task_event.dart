import 'package:equatable/equatable.dart';
// part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final String task;

  AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class FetchTasksEvent extends TaskEvent {}
