import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jalur/helpers/colors.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text("Главная", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
    );
  }
}