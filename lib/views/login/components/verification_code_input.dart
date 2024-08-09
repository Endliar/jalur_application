import 'package:flutter/material.dart';

class VerificationCodeInput extends StatelessWidget {
  final TextEditingController controller;

  const VerificationCodeInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      decoration: const InputDecoration(hintText: "Введите код"),
    );
  }
}