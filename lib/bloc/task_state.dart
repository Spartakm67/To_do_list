// part of 'task_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_todo/servicies/add_task.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<List> tasks;//? type

  TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final String error;

  TaskError(this.error);

  @override
  List<Object?> get props => [error];
}
