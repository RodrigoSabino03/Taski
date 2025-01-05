import "package:todolist/app/home/model/home_model.dart";
class HomeViewModel {
  List<Task> tasks = [
    Task(name: "Task 1", isDone: true),
    Task(name: "Task 2", isDone: false),

  ];

  int get tasksDone => tasks.where((task) => task.isDone).length;
  int get tasksRemaining => tasks.length - tasksDone;

  void toggleTaskStatus(int index) {
    tasks[index].isDone = !tasks[index].isDone;
  }
}
