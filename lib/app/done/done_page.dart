import 'package:flutter/material.dart';
import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';
import 'package:todolist/app/done/viewmodel/done_viewmodel.dart';
import 'package:todolist/app/done/widgets/card_widget.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  late DoneViewModel _doneViewModel;

  @override
  void initState() {
    super.initState();
    _doneViewModel = DoneViewModel(TaskRepository());
  }

  void _deleteCompletedTask(int taskId) async {
    await _doneViewModel.delete(taskId);
    setState(() {}); 
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
                  await _doneViewModel.deleteAll();
                  setState(() {});  
                },
                child: Text("Delete All"),
              ),
            ],
          ),
          SizedBox(height: 16),

          FutureBuilder<List<Task>>(
            future: _doneViewModel.getCompletedTasks(),
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

              final completedTasks = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];

                    return CardWidget(
                      name: task.name,
                      index: index,
                      onDelete: () => _deleteCompletedTask(task.id),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
