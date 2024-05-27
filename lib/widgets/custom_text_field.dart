import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  const CustomTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(hintText: 'Количество занятий'),
    );
  }
}
