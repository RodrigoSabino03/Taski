import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final bool isDone;
  final int index;
  final VoidCallback onToggle;

  const CardWidget({
    Key? key,
    required this.name,
    required this.isDone,
    required this.index,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name),
        trailing: IconButton(
          icon: Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? Colors.green : Colors.grey,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
