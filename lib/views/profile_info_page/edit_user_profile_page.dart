import 'package:flutter/material.dart';

import '../../helpers/colors.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({super.key});

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
          "Редактирование данных",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
