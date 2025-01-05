// task_repository.dart
import 'package:todolist/app/home/model/task_model.dart';

class TaskRepository {
  // Shared list of tasks
  List<Task> tasks = [
    Task(name: "Task 1", isDone: true),
    Task(name: "Task 2", isDone: false),
    Task(name: "Task 3", isDone: false),
    Task(name: "Task 4", isDone: true),
    Task(name: "Task 5", isDone: false),
    Task(name: "Task 6", isDone: false),
    Task(name: "Task 7", isDone: false),
  ];

  // Method to delete a task by index
  void deleteTask(int index) {
    tasks.removeAt(index);
  }

  // Method to delete all tasks
  void deleteAllTasks() {
    tasks.clear();
  }
}
