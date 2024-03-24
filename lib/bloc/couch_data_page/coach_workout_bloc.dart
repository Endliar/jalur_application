import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/models/coach.dart';
import 'package:jalur/response_api/get_coach_data.dart';

import 'coach_workout_event.dart';
import 'coach_workout_state.dart';

class CoachDataBloc extends Bloc<CoachDataEvent, CoachDataState> {
  final GetCoachData getCoachData;
  CoachDataBloc(this.getCoachData) : super(InitialState()) {
    on<LoadCoachDataEvent>(_onLoadCoachDataEvent);
    on<CoachDetailButtonPressed>(_onCoachDetailButtonPressed);
  }

  Future<void> _onLoadCoachDataEvent(
      LoadCoachDataEvent event, Emitter<CoachDataState> emit) async {
    try {
      emit(LoadingCoachDataState());
      List<Coach> coaches = await getCoachData.getCoachesData();
      emit(LoadCoachDataSuccess(coaches));
    } catch (e) {
      emit(CoachErrorState(e.toString()));
    }
  }

  Future<void> _onCoachDetailButtonPressed(
      CoachDetailButtonPressed event, Emitter<CoachDataState> emit) async {
    try {
      emit(LoadingCoachDataState());
      final Coach coach = await getCoachData.getUserData(event.coachId);
      emit(LoadCoachDataSuccess([coach]));
    } catch (e) {
      emit(CoachErrorState(e.toString()));
    }
  }
}