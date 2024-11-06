import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jalur/adapters/workout_adapter.dart';
import 'package:jalur/bloc/home_page/homepage_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/helpers/colors.dart';
import 'package:jalur/helpers/routes.dart';
import 'package:jalur/views/home_page/components/workout_card.dart';

import '../../models/workout.dart';

class Homepage extends StatefulWidget {
  final List<Workout> workouts;
  const Homepage({super.key, required this.workouts});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  DateTime pickedDate = DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final args = {
      'selectedIndex': _selectedIndex,
      'selectedDate': pickedDate,
    };

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.schedule, (Route<dynamic> route) => false,
            arguments: args);
        break;
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.coach, (Route<dynamic> route) => false,
            arguments: _selectedIndex);
        break;
      case 3:
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.profile, (Route<dynamic> route) => false,
            arguments: _selectedIndex);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Главная",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomepageLoadWorkoutSuccess) {
            if (state.workouts.isNotEmpty) {
              return ListView.builder(
                itemCount: state.workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutCard(workout: state.workouts[index]);
                },
              );
            } else {
              final List<Workout> cachedWorkouts = _getCachedWorkouts();

              if (cachedWorkouts.isNotEmpty) {
                return ListView.builder(
                  itemCount: cachedWorkouts.length,
                  itemBuilder: (context, index) {
                    return WorkoutCard(workout: cachedWorkouts[index]);
                  },
                );
              }
            }
          } else if (state is HomepageErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(
            child: Text('Нет данных о тренировках'),
          );
        },
      ),
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

List<Workout> _getCachedWorkouts() {
  final Box<WorkoutAdapter> workoutBox = Hive.box<WorkoutAdapter>('workouts');
  return workoutBox.values.map((adapter) => adapter.toWorkout()).toList();
}
