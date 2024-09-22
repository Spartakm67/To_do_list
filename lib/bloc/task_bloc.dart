import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository = TaskRepository();
  final TaskActions taskActions = TaskActions(taskService: AddTask());

  TaskBloc() : super(TaskInitial()) {
    on<LoadTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onFetchTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = taskRepository.fetchTasks();
      emit(TaskLoaded(tasks as List<Map<String, dynamic>>));
    } catch (e) {
      emit(TaskError('Failed to fetch tasks'));
    }
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskActions.onAddTask(event.context, event.controller, event.isFirebaseInitialized);
      add(LoadTasksEvent());
    } catch (e) {
      emit(TaskError('Failed to add task'));
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.deleteTask(event.taskId);
      add(LoadTasksEvent()); // Fetch tasks again after deleting
    } catch (e) {
      emit(TaskError('Failed to delete task'));
    }
  }
}
