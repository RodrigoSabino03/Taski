import 'package:flutter/material.dart';
import 'package:todolist/app/create/widgets/create_modal.dart';
import 'package:todolist/app/task/model/task_model.dart';
import 'package:todolist/app/home/widgets/card_widget.dart';
import 'package:todolist/app/task/viewmodel/task_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TaskViewModel _taskViewModel;

  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _taskViewModel = TaskViewModel();
    _tasksFuture = _taskViewModel.fetchTasks();
  }

  void _toggleTaskStatus(int index, Task task) async {
    await _taskViewModel.toggleTaskStatus(index);
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _tasksFuture = _taskViewModel.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Welcome, ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: "John",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const TextSpan(
                    text: ".",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
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
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.5,
                child: TaskModal(taskViewModel: _taskViewModel),
              );
            },
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
