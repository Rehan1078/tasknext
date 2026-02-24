import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTaskStatusEvent extends TaskEvent {
  final TaskEntity task;

  const ToggleTaskStatusEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class FilterTasksEvent extends TaskEvent {
  final bool? isCompleted;

  const FilterTasksEvent(this.isCompleted);

  @override
  List<Object?> get props => [isCompleted];
}

class SearchTasksEvent extends TaskEvent {
  final String query;

  const SearchTasksEvent(this.query);

  @override
  List<Object?> get props => [query];
}
