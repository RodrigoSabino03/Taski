import 'package:flutter/material.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';
import 'package:todolist/app/home/viewmodel/home_viewmodel.dart';
import 'package:todolist/app/home/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskRepository _taskRepository = TaskRepository();
  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(_taskRepository);
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
          Text(
            "You've completed ${viewModel.tasksDone} out of ${viewModel.tasks.length} tasks. ${viewModel.tasksRemaining} tasks remaining.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Expanded(
            child: viewModel.tasks.isEmpty
                ? Center(
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
                          onPressed: () {},
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
                              Icon(
                                Icons.add,
                                color: Colors.blue[800],
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Add Task",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[800],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.tasks.length,
                    itemBuilder: (context, index) {
                      final task = viewModel.tasks[index];

                      return CardWidget(
                        name: task.name,
                        isDone: task.isDone,
                        index: index,
                        onToggle: () {
                          setState(() {
                            viewModel.toggleTaskStatus(index);
                          });
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
