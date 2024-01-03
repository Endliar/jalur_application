import 'package:flutter/material.dart';

TextField defaultTextField(String text) {
  return TextField(
    decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
  );
}
