import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.emailController,
    required this.text,
  });

  final TextEditingController emailController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
