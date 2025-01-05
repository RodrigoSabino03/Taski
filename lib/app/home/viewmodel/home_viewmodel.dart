import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';

class HomeViewModel {
  final TaskRepository _taskRepository;

  HomeViewModel(this._taskRepository);

  Future<List<Task>> getActiveTasks() async {
    final tasks = await _taskRepository.getTasks();
    return tasks.where((task) => !task.isDone).toList();
  }

  Future<void> addTask(String taskName) async {
    final newTask = Task(id: 0, name: taskName);  
    await _taskRepository.insertTask(newTask);
  }

  Future<void> toggleTaskStatus(int index) async {
    final tasks = await getActiveTasks();
    final task = tasks[index];
    task.isDone = !task.isDone;
    await _taskRepository.updateTask(task);
  }
}
