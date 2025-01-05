import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';

class HomeViewModel {
  final TaskRepository _taskRepository;

  HomeViewModel(this._taskRepository);

  Future<List<Task>> getActiveTasks() async {
    final tasks = await _taskRepository.getTasks();
    return tasks.where((task) => !task.isDone).toList();
  }

  Future<List<Task>> getAllTasks() async {
    return await _taskRepository.getTasks();
  }

  Future<void> addTask(String taskName) async {
    final newTask = Task(id: 0, name: taskName);  
    await _taskRepository.insertTask(newTask);
  }

  // Método para alternar o status de conclusão de uma tarefa
  Future<void> toggleTaskStatus(int index) async {
    final tasks = await _taskRepository.getTasks(); // Carregar todas as tarefas
    final task = tasks[index];
    task.isDone = !task.isDone;  // Inverter o status da tarefa
    await _taskRepository.updateTask(task);  // Atualizar a tarefa no repositório
  }
}

