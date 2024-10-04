import 'package:flutter/material.dart';
import 'package:jalur/helpers/routes.dart';
import 'package:jalur/views/welcome_page/components/default_navigator_button.dart';
import 'package:jalur/views/welcome_page/components/login_button.dart';
import 'package:jalur/views/welcome_page/components/sign_up_button.dart';

import '../../helpers/colors.dart';
import '../../helpers/size_config.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            "Добро пожаловать",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignUpButton(),
              SizedBox(height: 16),
              LoginButton(),
            ],
          ),
        ));
  }
}
