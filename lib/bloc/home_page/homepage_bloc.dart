import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jalur/adapters/workout_adapter.dart';
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

      // Получаем все данные с сервера
      final List<Workout> serverWorkouts =
          await apiServiceGetWorkout.getWorkouts();

      // Проверяем кэш
      final Box<WorkoutAdapter> workoutBox =
          Hive.box<WorkoutAdapter>('workouts');
      final List<Workout> cachedWorkouts =
          workoutBox.values.map((adapter) => adapter.toWorkout()).toList();

      if (cachedWorkouts.isEmpty ||
          await _isCacheOutdated(cachedWorkouts, serverWorkouts)) {
        // Кэш пустой или устарел, обновляем его
        await _updateCache(serverWorkouts);
        emit(HomepageLoadWorkoutSuccess(serverWorkouts));
      } else {
        // Используем кэшированные данные
        emit(HomepageLoadWorkoutSuccess(cachedWorkouts));
      }
    } catch (e) {
      emit(HomepageErrorState(e.toString()));
    }
  }

  Future<bool> _isCacheOutdated(
      List<Workout> cachedWorkouts, List<Workout> serverWorkouts) async {
    // Здесь должна быть логика для сравнения кэшированных данных с данными сервера
    // Возвращает true, если кэш устарел, и false в противном случае
    // Например, можно сравнить даты изменения или хеши данных
    // ...
    return false; // это реальной логикой сравнения
  }

  Future<void> _updateCache(List<Workout> workouts) async {
    for (var workout in workouts) {
      final workoutType = await getTypeWorkout.getType(workout.typeWorkoutId);
      workout.typeName = workoutType.name;
    }

    final Box<WorkoutAdapter> workoutBox = Hive.box<WorkoutAdapter>('workouts');
    workoutBox.clear();
    workoutBox
        .addAll(workouts.map((workout) => WorkoutAdapter.fromWorkout(workout)));
  }
}
