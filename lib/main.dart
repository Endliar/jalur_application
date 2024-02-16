import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/login_page/login_bloc.dart';
import 'package:jalur/helpers/colors.dart';
import 'package:jalur/helpers/routes.dart';
import 'package:jalur/response_api/auth_user.dart';
import 'package:jalur/views/welcome_page/welcome_page.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => Login(),
      child: BlocProvider(
        create: (context) => LoginBloc(loginRepo: RepositoryProvider.of<Login>(context)),
        child: MyApp(),
        ),
      ),
  );
}

class MyApp extends StatelessWidget {
  final loginRepo = Login();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: kTextColor)),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(loginRepo: loginRepo),
        child: const WelcomePage(),
      ),
    );
  }
}
