import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';

class DoneViewModel {
  final TaskRepository _taskRepository;

  DoneViewModel(this._taskRepository);

  Future<List<Task>> getCompletedTasks() async {
    final tasks = await _taskRepository.getTasks();
    return tasks.where((task) => task.isDone).toList();
  }

  Future<void> delete(int id) async {
    await _taskRepository.deleteTask(id);
  }

  Future<void> deleteAll() async {
    await _taskRepository.deleteAllTasks();
  }
}
