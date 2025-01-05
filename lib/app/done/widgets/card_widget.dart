import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final int index;
  final VoidCallback onDelete;

  const CardWidget({
    Key? key,
    required this.name,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
