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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: FutureBuilder<List<Task>>(
        future: _doneViewModel.getCompletedTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No completed tasks available."));
          }

          final completedTasks = snapshot.data!;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Completed Tasks",
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _doneViewModel.deleteAll();
                      setState(() {});  // Atualiza a tela após a exclusão
                    },
                    child: Text("Delete All"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];

                    return CardWidget(
                      name: task.name,
                      index: index,
                      onDelete: () async {
                        await _doneViewModel.delete(task.id);
                        setState(() {});  // Atualiza a tela após a exclusão
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
