import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/entities/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  List<TaskEntity> _allTasks = [];

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskStatusEvent>(_onToggleTaskStatus);
    on<FilterTasksEvent>(_onFilterTasks);
    on<SearchTasksEvent>(_onSearchTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      _allTasks = await getTasks();
      emit(TaskLoaded(_allTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await addTask(event.task);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await updateTask(event.task);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await deleteTask(event.id);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onToggleTaskStatus(ToggleTaskStatusEvent event, Emitter<TaskState> emit) async {
    try {
      final updatedTask = TaskEntity(
        id: event.task.id,
        title: event.task.title,
        description: event.task.description,
        dueDate: event.task.dueDate,
        isCompleted: !event.task.isCompleted,
      );
      await updateTask(updatedTask);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) {
    if (event.isCompleted == null) {
      emit(TaskLoaded(_allTasks));
    } else {
      final filteredTasks = _allTasks
          .where((task) => task.isCompleted == event.isCompleted)
          .toList();
      emit(TaskLoaded(filteredTasks));
    }
  }

  void _onSearchTasks(SearchTasksEvent event, Emitter<TaskState> emit) {
    if (event.query.isEmpty) {
      emit(TaskLoaded(_allTasks));
    } else {
      final filteredTasks = _allTasks
          .where((task) =>
              task.title.toLowerCase().contains(event.query.toLowerCase()) ||
              task.description.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(TaskLoaded(filteredTasks));
    }
  }
}
