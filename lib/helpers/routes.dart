import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/couch_data_page/coach_workout_bloc.dart';
import 'package:jalur/bloc/couch_data_page/coach_workout_state.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_bloc.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_event.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_state.dart';
import 'package:jalur/bloc/home_page/homepage_event.dart';
import 'package:jalur/bloc/login_page/login_bloc.dart';
import 'package:jalur/bloc/registration_page/registration_bloc.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_bloc.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_event.dart';
import 'package:jalur/response_api/auth_user.dart';
import 'package:jalur/response_api/create_record.dart';
import 'package:jalur/response_api/create_user.dart';
import 'package:jalur/response_api/get_coach_data.dart';
import 'package:jalur/response_api/get_schedule.dart';
import 'package:jalur/response_api/get_type_workout.dart';
import 'package:jalur/response_api/get_workout_detail.dart';
import 'package:jalur/views/coach_info_page/coach_info_page.dart';
import 'package:jalur/views/login/login_page.dart';
import 'package:jalur/views/profile_info_page/profile_page.dart';
import 'package:jalur/views/registration/registration_page.dart';
import 'package:jalur/views/schedule_info_page/shedule_info_page.dart';
import 'package:jalur/views/welcome_page/welcome_page.dart';

import '../bloc/couch_data_page/coach_workout_event.dart';
import '../bloc/home_page/homepage_bloc.dart';
import '../bloc/home_page/homepage_state.dart';
import '../response_api/get_workout.dart';
import '../views/home_page/homepage.dart';
import '../views/workout_page/workout_page.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String regin = '/regin';
  static const String schedule = '/schedule';
  static const String coach = '/coach';
  static const String detailWorkout = '/detailWorkout';
  static const String homepage = '/homepage';
  static const String profile = '/editProfile';

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
      case homepage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomepageBloc>(
              create: (context) =>
                  HomepageBloc(ApiServiceGetWorkout(), GetTypeWorkout())
                    ..add(LoadWorkoutEvent()),
              child: BlocBuilder<HomepageBloc, HomepageState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomepageLoadWorkoutSuccess) {
                    return Homepage(workouts: state.workouts);
                  } else if (state is HomepageErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return const Center(
                    child: Text('Данные не загружены'),
                  );
                },
              )),
        );
      case schedule:
        final args = settings.arguments as Map<String, dynamic>;
        final int pageIndex = args['selectedIndex'] as int;
        final DateTime selectedDate = args['selectedDate'] as DateTime;

        return MaterialPageRoute(
          builder: (context) => BlocProvider<ScheduleDataBloc>(
            create: (context) => ScheduleDataBloc(
                ApiServiceGetSchedule(),
                ApiServiceGetWorkoutDetail(),
                GetTypeWorkout(),
                ApiServiceCreateRecord())
              ..add(LoadScheduleDataEvent()), // загружаем данные здесь
            child: SheduleInfoPage(
              selectedIndex: pageIndex,
              selectedDate: selectedDate,
            ),
          ),
        );
      case coach:
        final int pageIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CoachDataBloc>(
            create: (context) =>
                CoachDataBloc(GetCoachData())..add(LoadCoachDataEvent()),
            child: BlocBuilder<CoachDataBloc, CoachDataState>(
              builder: (context, state) {
                if (state is LoadingCoachDataState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadCoachDataSuccess) {
                  return CoachInfoPage(
                    coaches: state.coaches,
                    selectedIndex: pageIndex,
                  );
                } else if (state is CoachErrorState) {
                  return Center(
                    child: Text('Ошибка: ${state.error}'),
                  );
                }
                return const Center(
                  child: Text('Данные о тренерах не загружены'),
                );
              },
            ),
          ),
        );
      case detailWorkout:
        final int workoutId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DetailWorkoutBloc>(
            create: (context) => DetailWorkoutBloc(
                ApiServiceGetWorkoutDetail(), GetTypeWorkout())
              ..add(LoadDetailWorkoutEvent(workoutId)),
            child: BlocBuilder<DetailWorkoutBloc, DetailWorkoutState>(
              builder: (context, state) {
                if (state is LoadingDetailState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadWorkoutSuccess) {
                  final workout = state.workouts;
                  return WorkoutPage(data: workout);
                } else if (state is WorkoutErrorState) {
                  return Center(
                    child: Text('Ошибка: ${state.error}'),
                  );
                }
                return const Center(
                  child: Text('Данные о конкретной тренировке не загружены'),
                );
              },
            ),
          ),
        );
      case profile:
        final int pageIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ProfilePage(selectedIndex: pageIndex),
        );
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
