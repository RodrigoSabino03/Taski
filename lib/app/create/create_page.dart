// create_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/app/data/model/task_model.dart';
import 'package:todolist/app/data/repositories/task_repository.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _controller = TextEditingController();
  final TaskRepository _taskRepository = TaskRepository();

void _addTask() async {
  final taskName = _controller.text.trim();

  if (taskName.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Task name cannot be empty")),
    );
    return;
  }

  final random = Random();
  final randomId = random.nextInt(90000) + 10000; 

  Task newTask = Task(name: taskName, isDone: false, id: randomId);

  await _taskRepository.insertTask(newTask);

  _controller.clear();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Task added successfully")),
  );

  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTask,
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
