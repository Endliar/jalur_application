import 'package:flutter/material.dart';

import '../../helpers/colors.dart';
import '../../models/coach.dart';

class EditUserProfilePage extends StatefulWidget {
  final Coach coach;
  const EditUserProfilePage({
    super.key,
    required this.coach,
  });

  @override
  State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Данные пользователя",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: widget.coach.phone ?? 'Номер не указан'),
            ),
          ],
        ),
      ),
    );
  }
}
