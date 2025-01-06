import 'dart:math';
import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';

class TaskViewModel {
  final TaskRepository _repository = TaskRepository();
  List<Task> tasks = [];
  String title = '';

  Future<void> fetchTasks() async {
    tasks = await _repository.getTasks();
  }

  Future<void> addTask() async {
    if (title.isNotEmpty) {
      final random = Random();
      final randomId = random.nextInt(90000) + 10000; 
      final newTask = Task(name: title, isDone: false, id: randomId);
      await _repository.insertTask(newTask);
      await fetchTasks();
    }
  }

  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
    await fetchTasks();
  }

  void updateTitle(String newTitle) {
    title = newTitle;
  }

  void clearForm() {
    title = '';
  }
}
