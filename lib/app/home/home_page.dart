import 'package:flutter/material.dart';
import 'package:todolist/app/create/viewmodel/create_viewmodel.dart';
import 'package:todolist/app/create/widgets/create_modal.dart';
import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';
import 'package:todolist/app/home/viewmodel/home_viewmodel.dart';
import 'package:todolist/app/home/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _homeViewModel;
  late TaskViewModel _taskViewModel;
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModel(TaskRepository());
    _taskViewModel = TaskViewModel(); // Inicializando o TaskViewModel
    _tasksFuture = _homeViewModel.getAllTasks();
  }

  void _toggleTaskStatus(int index, Task task) async {
    await _homeViewModel.toggleTaskStatus(index);
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _tasksFuture = _homeViewModel.getAllTasks();
    });
  }

  Future<void> _loadTasks() async {
    await _homeViewModel.getAllTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Rodrigo.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Task>>(
              future: _tasksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Text(
                    "You've completed 0 tasks out of 0 tasks.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  );
                }

                final tasks = snapshot.data!;
                final tasksDone = tasks.where((task) => task.isDone).length;
                final tasksRemaining = tasks.length - tasksDone;

                return Text(
                  "You've completed $tasksDone out of ${tasks.length} tasks. $tasksRemaining tasks remaining.",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: _tasksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.note_alt,
                              size: 50, color: Colors.grey),
                          const SizedBox(height: 10),
                          const Text(
                            "No tasks available. Add some tasks!",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  final tasks = snapshot.data!;

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return CardWidget(
                        name: task.name,
                        isDone: task.isDone,
                        index: index,
                        onToggle: () => _toggleTaskStatus(index, task),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => TaskModal(taskViewModel: _taskViewModel),
          );

          if (result == true) {
            _refreshTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
