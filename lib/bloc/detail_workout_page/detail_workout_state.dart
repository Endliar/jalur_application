import 'package:jalur/models/workout.dart';

abstract class DetailWorkoutState {}

class InitialState extends DetailWorkoutState {}

class LoadingDetailState extends DetailWorkoutState {}

class LoadWorkoutSuccess extends DetailWorkoutState {
  final Workout workouts;

  LoadWorkoutSuccess(this.workouts);
}

class WorkoutErrorState extends DetailWorkoutState {
  final String error;
  WorkoutErrorState(this.error);
}
