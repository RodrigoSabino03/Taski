import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.check_box_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
                Text(
                  'Taski',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Text(
                  'Rodrigo',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ],
            ),
          ],
        );
  }
}