import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_bloc.dart';
import 'package:jalur/bloc/login_page/login_bloc.dart';
import 'package:jalur/helpers/colors.dart';
import 'package:jalur/helpers/routes.dart';
import 'package:jalur/response_api/auth_user.dart';
import 'package:jalur/response_api/get_workout.dart';
import 'package:jalur/views/home_page/homepage.dart';
import 'package:jalur/views/welcome_page/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? authToken = preferences.getString('auth_token');
  runApp(
    RepositoryProvider(
      create: (context) => Login(),
      child: BlocProvider(
        create: (context) =>
            LoginBloc(loginRepo: RepositoryProvider.of<Login>(context)),
        child: MyApp(isUserLoggedIn: authToken != null),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  final loginRepo = Login();
  MyApp({super.key, required this.isUserLoggedIn});

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
        child: isUserLoggedIn
            ? BlocProvider<HomepageBloc>(
                create: (context) =>
                    HomepageBloc(apiServiceGetWorkout: ApiServiceGetWorkout()),
                child: const Homepage())
            : const WelcomePage(),
      ),
    );
  }
}
