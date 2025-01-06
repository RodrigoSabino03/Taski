import 'package:flutter/material.dart';
import 'package:todolist/app/create/widgets/create_modal.dart';
import 'package:todolist/app/task/model/task_model.dart';
import 'package:todolist/app/done/widgets/card_widget.dart';
import 'package:todolist/app/task/viewmodel/task_viewmodel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TaskViewModel _taskViewModel;
  List<Task> _completedTasks = [];
  List<Task> _filteredTasks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _taskViewModel = TaskViewModel();
    _loadTasks();
  }

  void _loadTasks() async {
    final tasks = await _taskViewModel.fetchTasks();
    setState(() {
      _completedTasks = tasks;
      _filteredTasks = tasks;
    });
  }

  void _searchTasks(String query) {
    setState(() {
      _searchQuery = query;
      _filteredTasks = _completedTasks
          .where(
              (task) => task.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _deleteCompletedTask(int taskId) async {
    await _taskViewModel.deleteTask(taskId);
    _loadTasks();
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: _searchTasks,
            decoration: InputDecoration(
              labelText: 'Search tasks...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16),
          _filteredTasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_alt, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "No tasks available matching the search!",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      ElevatedButton(
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
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blue[800]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = _filteredTasks[index];

                      return CardWidget(
                        name: task.name,
                        index: index,
                        onDelete: () => _deleteCompletedTask(task.id),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
