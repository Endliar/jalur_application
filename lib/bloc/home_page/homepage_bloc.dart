import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_event.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/response_api/get_workout.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final ApiServiceGetWorkout apiServiceGetWorkout;
  HomepageBloc(this.apiServiceGetWorkout) : super(InitialState()) {
    on<LoadWorkoutEvent>(_onLoadWorkoutEvent);
  }

  Future<void> _onLoadWorkoutEvent(
      LoadWorkoutEvent event, Emitter<HomepageState> emit) async {
    try {
      emit(LoadingState());
      final workouts = await apiServiceGetWorkout.getWorkouts();
      emit(HomepageLoadWorkoutSuccess(workouts));
    } catch (e) {
      emit(HomepageErrorState(e.toString()));
    }
  }
}
