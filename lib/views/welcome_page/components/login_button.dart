import 'package:flutter/material.dart';
import 'package:jalur/helpers/routes.dart';
import 'package:jalur/views/welcome_page/components/default_navigator_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultNavigatorButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.login);
        },
        text: 'Авторизация');
  }
}
