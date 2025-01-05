import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModel(TaskRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, Rodrigo.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            FutureBuilder<List<Task>>(
              future: _homeViewModel.getActiveTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text(
                    "You've completed 0 tasks out of 0 tasks. 0 tasks remaining.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  );
                }

                final tasks = snapshot.data!;
                final tasksDone = tasks.where((task) => task.isDone).length;
                final tasksRemaining = tasks.length - tasksDone;

                return Text(
                  "You've completed $tasksDone out of ${tasks.length} tasks. $tasksRemaining tasks remaining.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                );
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: _homeViewModel.getActiveTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_alt, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "No tasks available. Add some tasks!",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/create');
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(5, 40),
                              backgroundColor: Colors.blue.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.blue[800]),
                                SizedBox(width: 8),
                                Text(
                                  "Add Task",
                                  style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                                ),
                              ],
                            ),
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
                        onToggle: () {
                          setState(() {
                            _homeViewModel.toggleTaskStatus(index);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}
