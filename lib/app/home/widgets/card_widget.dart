import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final bool isDone;
  final int index;
  final VoidCallback onToggle;

  const CardWidget({
    required this.name,
    required this.isDone,
    required this.index,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        trailing: IconButton(
          icon: Icon(
            isDone ? Icons.check_circle : Icons.check_circle_outline_outlined,
            color: isDone ? Colors.green : Colors.grey,
          ),
          onPressed: onToggle, 
        ),
      ),
    );
  }
}
