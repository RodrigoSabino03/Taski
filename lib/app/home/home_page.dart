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
  late List<Task> _tasks;  

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModel(TaskRepository());
    _loadTasks();  
  }

  void _loadTasks() async {
    _tasks = await _homeViewModel.getAllTasks();
    setState(() {});  
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
            "You've completed ${_tasks.where((task) => task.isDone).length} out of ${_tasks.length} tasks.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _tasks.isEmpty
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
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];

                      return CardWidget(
                        name: task.name,
                        isDone: task.isDone,
                        index: index,
                        onToggle: () async {
                          await _homeViewModel.toggleTaskStatus(index);
                          _loadTasks(); 
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
