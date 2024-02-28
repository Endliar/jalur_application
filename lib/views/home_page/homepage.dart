import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_bloc.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_event.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_state.dart';
import 'package:jalur/bloc/home_page/homepage_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/helpers/colors.dart';
import 'package:jalur/response_api/get_type_workout.dart';
import 'package:jalur/response_api/get_workout_detail.dart';
import 'package:jalur/views/workout_page/workout_page.dart';

import '../../models/workout.dart';

class Homepage extends StatefulWidget {
  final List<Workout> workouts;
  const Homepage({super.key, required this.workouts});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Главная",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomepageLoadWorkoutSuccess) {
          return ListView.builder(
            itemCount: state.workouts.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        child: Image.network(
                          'http://89.104.69.88/storage/${state.workouts[index].images.first}',
                          width: double.infinity,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.workouts[index].name,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Тип занятия: ${state.workouts[index].typeName}",
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<DetailWorkoutBloc>(
                                    create: (context) => DetailWorkoutBloc(
                                        ApiServiceGetWorkoutDetail(),
                                        GetTypeWorkout())
                                      ..add(LoadWorkoutEvent(
                                          state.workouts[index].id)),
                                    child: BlocBuilder<DetailWorkoutBloc,
                                        DetailWorkoutState>(
                                      builder: (context, state) {
                                        if (state is LoadingDetailState) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is LoadWorkoutSuccess) {
                                          final workout = state.workouts;
                                          return WorkoutPage(data: workout);
                                        } else if (state is WorkoutErrorState) {
                                          return Center(
                                            child:
                                                Text('Ошибка: ${state.error}'),
                                          );
                                        }
                                        return const Center(
                                          child: Text('Данные не загружены'),
                                        );
                                      },
                                    ),
                                  ),
                                ));
                              },
                              child: const Text('Подробнее')),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is HomepageErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(
            child: Text('Нет данных'),
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Расписание'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Тренера'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
