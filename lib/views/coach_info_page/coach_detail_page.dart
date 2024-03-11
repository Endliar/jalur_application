import 'package:flutter/material.dart';
import 'package:jalur/models/coach.dart';

import '../../helpers/colors.dart';

class CoachDetailPage extends StatelessWidget {
  final Coach coach;
  const CoachDetailPage({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Тренер",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
