import 'package:flutter/material.dart';
import 'package:todolist/app/home/viewmodel/home_viewmodel.dart';
import 'package:todolist/app/home/widgets/card_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel viewModel = HomeViewModel();

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
            child: ListView.builder(
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
