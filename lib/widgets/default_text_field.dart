import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

TextField defaultTextField(String text, TextEditingController controller,
    {MaskTextInputFormatter? maskFormatter}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    inputFormatters: maskFormatter != null ? [maskFormatter] : [],
    keyboardType:
        maskFormatter != null ? TextInputType.phone : TextInputType.text,
  );
}
