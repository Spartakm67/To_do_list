// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_todo/servicies/servicies.dart';
// import 'task_event.dart';
// import 'task_state.dart';
//
// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   final TaskActions taskService;
//
//   TaskBloc(this.taskService) : super(TaskInitial()) {
//     on<FetchTasksEvent>(_onFetchTasks);
//     on<AddTaskEvent>(_onAddTask);
//     on<DeleteTaskEvent>(_onDeleteTask);
//   }
//
//   void _onFetchTasks(FetchTasksEvent event, Emitter<TaskState> emit) async {
//     emit(TaskLoading());
//     try {
//       final tasks = await taskService.fetchTasks();
//       emit(TaskLoaded(tasks));
//     } catch (e) {
//       emit(TaskError('Failed to fetch tasks'));
//     }
//   }
//
//   void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
//     try {
//       await taskService.addTask(event.task);
//       add(FetchTasksEvent()); // Fetch tasks again after adding
//     } catch (e) {
//       emit(TaskError('Failed to add task'));
//     }
//   }
//
//   void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
//     try {
//       await taskService.deleteTask(event.taskId);
//       add(FetchTasksEvent()); // Fetch tasks again after deleting
//     } catch (e) {
//       emit(TaskError('Failed to delete task'));
//     }
//   }
// }
