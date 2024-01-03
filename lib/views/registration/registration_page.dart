import 'package:flutter/material.dart';
import 'package:jalur/helpers/size_config.dart';

import '../../helpers/colors.dart';
import '../../widgets/default_text_field.dart';
import '../../widgets/default_text_header.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            "Регистрация",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                headerText("Введите имя"),
                defaultTextField("Введите ваше имя"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                headerText("Введите фамилию"),
                defaultTextField("Введите вашу фамилию"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                headerText("Укажите вес"),
                defaultTextField("Укажите ваш вес"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                headerText("Укажите рост"),
                defaultTextField("Укажите ваш рост"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                headerText("Укажите ваш возраст"),
                defaultTextField("Сколько вам лет?"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                headerText("Укажите пол"),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                headerText("Введите номер телефона"),
                defaultTextField("Ваш номер телефона"),
              ],
            ),
          ),
        ));
  }
}
