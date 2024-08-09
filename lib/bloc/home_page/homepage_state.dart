import 'package:jalur/models/workout.dart';

abstract class HomepageState {}

class InitialState extends HomepageState {}

class LoadingState extends HomepageState {}

class HomepageLoadWorkoutSuccess extends HomepageState {
  final List<Workout> workouts;

  HomepageLoadWorkoutSuccess(this.workouts);
}

class HomepageErrorState extends HomepageState {
  final String error;
  HomepageErrorState(this.error);
}
