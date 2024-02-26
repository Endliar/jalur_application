import 'package:jalur/models/workout.dart';

abstract class HomepageState {}

class InitialState extends HomepageState {}

class HomepageChoiceWorkoutSuccess extends HomepageState {
  final List<Workout> workouts;

  HomepageChoiceWorkoutSuccess(this.workouts);
}

class HomepageLoadingState extends HomepageState {}

class HomepageErrorState extends HomepageState {
  final String error;
  HomepageErrorState(this.error);
}
