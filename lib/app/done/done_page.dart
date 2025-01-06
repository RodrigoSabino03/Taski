import 'package:flutter/material.dart';
import 'package:todolist/app/create/widgets/create_modal.dart';
import 'package:todolist/app/task/model/task_model.dart';
import 'package:todolist/app/done/widgets/card_widget.dart';
import 'package:todolist/app/task/viewmodel/task_viewmodel.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  late TaskViewModel _taskViewModel;

  late Future<List<Task>> _tasksFuture;
  @override
  void initState() {
    super.initState();
    _taskViewModel = TaskViewModel();
    _tasksFuture = _taskViewModel.fetchTasks();
  }

  void _deleteCompletedTask(int taskId) async {
    await _taskViewModel.deleteTask(taskId);
    setState(() {});
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _tasksFuture = _taskViewModel.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Completed Tasks", style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed: () async {
                  await _taskViewModel.deleteAllTasks();
                  setState(() {});
                },
                child: Text("Delete All"),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Task>>(
                future: _taskViewModel.getCompletedTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.note_alt, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "No tasks available. Add some tasks!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  TaskModal(taskViewModel: _taskViewModel),
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
                    );
                  }

                  final completedTasks = snapshot.data!;

                  return ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      final task = completedTasks[index];

                      return CardWidget(
                        name: task.name,
                        index: index,
                        onDelete: () => _deleteCompletedTask(task.id),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
