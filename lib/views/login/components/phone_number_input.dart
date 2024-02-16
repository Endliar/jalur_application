import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final MaskTextInputFormatter formatter;

  const PhoneNumberInput({super.key, required this.controller, required this.formatter});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: [formatter],
      decoration: const InputDecoration(hintText: "Введите номер телефона"),
      keyboardType: TextInputType.phone,
    );
  }
}