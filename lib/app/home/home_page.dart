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
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: FutureBuilder<List<Task>>(
        future: _homeViewModel.getActiveTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No tasks available. Add some tasks!"));
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
    );
  }
}
