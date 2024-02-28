import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/login_page/login_bloc.dart';
import 'package:jalur/bloc/registration_page/registration_bloc.dart';
import 'package:jalur/response_api/auth_user.dart';
import 'package:jalur/response_api/create_user.dart';
import 'package:jalur/views/login/login_page.dart';
import 'package:jalur/views/registration/registration_page.dart';
import 'package:jalur/views/welcome_page/welcome_page.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String regin = '/regin';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case login:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => LoginBloc(loginRepo: Login()),
                child: const LoginPage()));
      case regin:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => RegistrationBloc(user: User()),
                  child: const RegistrationPage(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("Ошибка, маршрут не найден"),
                  ),
                ));
    }
  }
}
