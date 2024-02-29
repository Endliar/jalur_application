import 'package:jalur/models/coach.dart';

abstract class CoachDataState {}

class InitialState extends CoachDataState {}

class LoadingCoachDataState extends CoachDataState {}

class LoadCoachDataSuccess extends CoachDataState {
  final List<Coach> coaches;

  LoadCoachDataSuccess(this.coaches);
}

class CoachErrorState extends CoachDataState {
  final String error;
  CoachErrorState(this.error);
}
