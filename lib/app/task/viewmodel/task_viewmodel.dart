import 'dart:math';
import 'package:todolist/app/task/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';

class TaskViewModel {
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> tasks = [];
  String title = '';

  Future<List<Task>> fetchTasks() async {
    tasks = await _taskRepository.getTasks();
    return tasks;
  }

  Future<List<Task>> getCompletedTasks() async {
    final allTasks = await fetchTasks();
    return allTasks.where((task) => task.isDone).toList();
  }

  Future<List<Task>> getActiveTasks() async {
    final allTasks = await fetchTasks();
    return allTasks.where((task) => !task.isDone).toList();
  }

Future<void> addTask() async {
  if (title.isNotEmpty) {
    final newTaskId = tasks.length;
    final newTask = Task(name: title, isDone: false, id: newTaskId);
    await _taskRepository.insertTask(newTask);
    await fetchTasks();
  } else {
    throw Exception("Task title cannot be empty");
  }
}


  void updateTitle(String newTitle) {
    title = newTitle;
  }

  void clearForm() {
    title = '';
  }

  Future<void> toggleTaskStatus(int taskId) async {
    final task = tasks.firstWhere((t) => t.id == taskId);
    task.isDone = !task.isDone;
    await _taskRepository.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await _taskRepository.deleteTask(taskId);
    await fetchTasks();
  }

  Future<void> deleteAllTasks() async {
    await _taskRepository.deleteAllTasks();
    await fetchTasks();
  }
}
