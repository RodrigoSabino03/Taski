import 'package:flutter/material.dart';
import 'package:todolist/app/task/viewmodel/task_viewmodel.dart';

class TaskModal extends StatelessWidget {
  final TaskViewModel taskViewModel;

  TaskModal({required this.taskViewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Add New Task',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
              TextButton(
                onPressed: () {
                  taskViewModel.clearForm();
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),

          ]),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => taskViewModel.updateTitle(value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (taskViewModel.title.isNotEmpty) {
                    await taskViewModel.addTask();
                    taskViewModel.clearForm();
                    Navigator.pop(context, true);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Task title cannot be empty."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Create Task'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
