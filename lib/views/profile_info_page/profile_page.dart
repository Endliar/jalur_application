import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: const Text("Профиль")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("История записей")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Выход")),
          ],
        ),
      ),
    );
  }
}
