import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_event.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/response_api/get_type_workout.dart';
import 'package:jalur/response_api/get_workout.dart';

import '../../models/workout.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final ApiServiceGetWorkout apiServiceGetWorkout;
  final GetTypeWorkout getTypeWorkout;
  HomepageBloc(this.apiServiceGetWorkout, this.getTypeWorkout)
      : super(InitialState()) {
    on<LoadWorkoutEvent>(_onLoadWorkoutEvent);
  }

  Future<void> _onLoadWorkoutEvent(
      LoadWorkoutEvent event, Emitter<HomepageState> emit) async {
    try {
      emit(LoadingState());
      final List<Workout> workouts = await apiServiceGetWorkout.getWorkouts();
      for (var workout in workouts) {
        final workoutType = await getTypeWorkout.getType(workout.typeWorkoutId);
        workout.typeName = workoutType.name;
      }
      emit(HomepageLoadWorkoutSuccess(workouts));
    } catch (e) {
      emit(HomepageErrorState(e.toString()));
    }
  }
}
