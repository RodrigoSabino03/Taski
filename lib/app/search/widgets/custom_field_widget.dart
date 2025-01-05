import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller, 
      decoration: InputDecoration(
        labelText: 'Task',
        labelStyle: TextStyle(color: Colors.blue[800]), 
        prefixIcon: Icon(Icons.search, color: Colors.blue[800]), 
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear, color: Colors.blue[800]), 
                onPressed: () {
                  _controller.clear(); 
                },
              ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[800]!),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[800]!),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[800]!),
          borderRadius: BorderRadius.circular(16), 
        ),
      ),
    );
  }
}
