import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/home_page/homepage_event.dart';
import 'package:jalur/bloc/home_page/homepage_state.dart';
import 'package:jalur/response_api/get_workout.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final ApiServiceGetWorkout apiServiceGetWorkout;

  HomepageBloc({required this.apiServiceGetWorkout}) : super(InitialState()) {
    on<LoadUserEvent>(((event, emit) async {
      emit(HomepageLoadingState());
      try {
        final workouts = await apiServiceGetWorkout.getWorkouts();
        if (workouts.isNotEmpty) {
          emit(HomepageChoiceWorkoutSuccess(workouts));
        } else {
          emit(HomepageErrorState("Не удалось загрузить список тренировок"));
        }
      } catch (e) {
        emit(HomepageErrorState("Ошибка загрузки данных: ${e.toString()}"));
      }
    }));
  }
}
