import 'package:flutter/material.dart';
import 'package:todolist/app/search/widgets/custom_field_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
              CustomTextField()
          ],
        ) ,
        );
  }
}