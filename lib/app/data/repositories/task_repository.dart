import 'package:todolist/app/data/database/database.dart';
import 'package:todolist/app/task/model/task_model.dart';

class TaskRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertTask(Task task) async {
    return await _databaseHelper.insertTask(task);
  }

  Future<List<Task>> getTasks() async {
    return await _databaseHelper.getTasks();
  }

  Future<int> updateTask(Task task) async {
    return await _databaseHelper.updateTask(task);
  }

  Future<int> deleteTask(int id) async {
    return await _databaseHelper.deleteTask(id);
  }

  Future<int> deleteAllTasks() async {
    return await _databaseHelper.deleteAllTasks();
  }
}
