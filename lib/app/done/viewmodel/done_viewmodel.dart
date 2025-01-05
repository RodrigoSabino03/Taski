// done_view_model.dart
import 'package:todolist/app/data/repositories/task_repository.dart';
import 'package:todolist/app/home/model/task_model.dart';


class DoneViewModel {
  final TaskRepository _taskRepository;

  DoneViewModel(this._taskRepository);

  // Get only completed tasks
  List<Task> get completedTasks =>
      _taskRepository.tasks.where((task) => task.isDone).toList();

  // Delete a specific task
  void delete(int index) {
    _taskRepository.deleteTask(index);
  }

  // Delete all tasks
  void deleteAll() {
    _taskRepository.deleteAllTasks();
  }
}
