import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_event.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_state.dart';
import 'package:jalur/response_api/get_type_workout.dart';

import 'package:jalur/response_api/get_workout_detail.dart';

class DetailWorkoutBloc extends Bloc<DetailWorkoutEvent, DetailWorkoutState> {
  final ApiServiceGetWorkoutDetail apiServiceGetWorkoutDetail;
  final GetTypeWorkout getTypeWorkout;
  DetailWorkoutBloc(this.apiServiceGetWorkoutDetail, this.getTypeWorkout)
      : super(InitialState()) {
    on<LoadWorkoutEvent>(_onLoadCurrentWorkoutEvent);
  }

  Future<void> _onLoadCurrentWorkoutEvent(
      LoadWorkoutEvent event, Emitter<DetailWorkoutState> emit) async {
    try {
      emit(LoadingDetailState());
      final workout = await apiServiceGetWorkoutDetail.getWorkoutById(event.id);
      final workoutType = await getTypeWorkout.getType(workout.typeWorkoutId);
      workout.typeName = workoutType.name;
      emit(LoadWorkoutSuccess(workout));
    } catch (e) {
      emit(WorkoutErrorState(e.toString()));
    }
  }
}
