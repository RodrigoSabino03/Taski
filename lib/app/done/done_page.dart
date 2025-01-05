import 'package:flutter/material.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';
import 'package:todolist/app/done/viewmodel/done_viewmodel.dart';
import 'package:todolist/app/done/widgets/card_widget.dart';
import 'package:todolist/app/home/model/task_model.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  final TaskRepository taskRepository = TaskRepository();

  late final DoneViewModel doneViewModel;

  @override
  void initState() {
    super.initState();
    doneViewModel =
        DoneViewModel(taskRepository); 
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> completedTasks = doneViewModel.completedTasks;

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
                onPressed: () {
                  setState(() {
                    doneViewModel.deleteAll();
                  });
                },
                child: Text("Delete all"),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: completedTasks.isEmpty
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
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      final task = completedTasks[index];

                      return CardWidget(
                        name: task.name,
                        index: index,
                        onDelete: () {
                          setState(() {
                            doneViewModel.delete(index);
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
