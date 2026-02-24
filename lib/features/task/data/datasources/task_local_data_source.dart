import 'package:hive/hive.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final String boxName = 'tasks';

  Future<Box<TaskModel>> _openBox() async {
    return await Hive.openBox<TaskModel>(boxName);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final box = await _openBox();
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks from local storage: $e');
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      final box = await _openBox();
      await box.put(task.id, task);
    } catch (e) {
      throw Exception('Failed to add task to local storage: $e');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      final box = await _openBox();
      await box.put(task.id, task);
    } catch (e) {
      throw Exception('Failed to update task in local storage: $e');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      final box = await _openBox();
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete task from local storage: $e');
    }
  }
}
