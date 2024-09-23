import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/servicies/servicies.dart';
import 'task_event.dart';
import 'task_state.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository = TaskRepository();
  final TaskActions taskActions = TaskActions(taskService: AddTask());


  TaskBloc() : super(const TaskInitial()) {
    on<LoadTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onFetchTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    try {
      final tasksStream = taskRepository.fetchTasks();
      await for (final tasks in tasksStream) {

        emit(TaskLoaded(tasks));
      }
    } catch (e) {
      emit(const TaskError('Failed to fetch tasks'));
    }
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final result = await taskActions.onAddTask(event.controller, event.isFirebaseInitialized);

     if (result != null) {
       emit(TaskError(result));
     } else {
       add(LoadTasksEvent());
     }
    } catch (e) {
      emit(const TaskError('Failed to add task'));
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.deleteTask(event.taskId);
      add(LoadTasksEvent()); // Fetch tasks again after deleting
    } catch (e) {
      emit(const TaskError('Failed to delete task'));
    }
  }
}
