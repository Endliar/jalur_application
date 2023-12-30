import 'package:flutter/material.dart';
import 'package:jalur/helpers/colors.dart';
import 'package:jalur/helpers/size_config.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(35),
                width: getProportionateScreenWidth(265),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)))),
                  child: const Text(
                    "Зарегистрироваться",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              SizedBox(
                  height: getProportionateScreenHeight(35),
                  width: getProportionateScreenWidth(265),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                    child: const Text(
                      "Войти",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }
}
