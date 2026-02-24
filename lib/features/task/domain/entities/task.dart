import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        isCompleted,
      ];
}
