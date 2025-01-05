import 'package:todolist/app/data/repositories/task_repository.dart';
import 'package:todolist/app/home/model/task_model.dart';

class HomeViewModel {
  final TaskRepository _taskRepository;

  HomeViewModel(this._taskRepository);

  List<Task> get tasks => _taskRepository.tasks;

  int get tasksDone =>
      _taskRepository.tasks.where((task) => task.isDone).length;

  int get tasksRemaining => _taskRepository.tasks.length - tasksDone;

  void toggleTaskStatus(int index) {
    _taskRepository.tasks[index].isDone = !_taskRepository.tasks[index].isDone;
  }
}
