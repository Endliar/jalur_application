abstract class HomepageState {}

class InitialState extends HomepageState {}

class HomepageChoiceWorkoutSuccess extends HomepageState {}

class HomepageLoadingState extends HomepageState {}

class HomepageErrorState extends HomepageState {
  final String error;
  HomepageErrorState(this.error);
}