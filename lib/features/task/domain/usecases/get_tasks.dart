import '../repositories/task_repository.dart';
import '../entities/task.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<TaskEntity>> call() async {
    return await repository.getTasks();
  }
}
