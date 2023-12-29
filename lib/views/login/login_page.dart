import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Добро пожаловать"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Зарегистрироваться")),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Войти")),
            ],
          ),
        ));
  }
}
