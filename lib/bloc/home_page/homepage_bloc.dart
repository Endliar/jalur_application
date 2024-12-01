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
    on<ResetStateEvent>(_onResetStateEvent);
  }

  Future<void> _onLoadWorkoutEvent(
      LoadWorkoutEvent event, Emitter<HomepageState> emit) async {
    emit(LoadingState());
    try {
      final Box<WorkoutAdapter> workoutBox =
          Hive.box<WorkoutAdapter>('workouts');
      final List<Workout> cachedWorkouts =
          workoutBox.values.map((adapter) => adapter.toWorkout()).toList();

      if (cachedWorkouts.isNotEmpty) {
        emit(HomepageLoadWorkoutSuccess(cachedWorkouts));
        print("Cached workouts loaded");
      }

      final List<Workout> serverWorkouts =
          await apiServiceGetWorkout.getWorkouts();

      if (cachedWorkouts.isEmpty ||
          await _isCacheOutdated(cachedWorkouts, serverWorkouts)) {
        await _updateCache(serverWorkouts);
        emit(HomepageLoadWorkoutSuccess(serverWorkouts));
      }
    } catch (e) {
      emit(HomepageErrorState(e.toString()));
    }
  }

  Future<void> _onResetStateEvent(
      ResetStateEvent event, Emitter<HomepageState> emit) async {
    emit(InitialState());
    add(LoadWorkoutEvent());
  }

  Future<bool> _isCacheOutdated(
      List<Workout> cachedWorkouts, List<Workout> serverWorkouts) async {
    final Map<int, Workout> cachedWorkoutMap = {
      for (var workout in cachedWorkouts) workout.id: workout
    };

    for (var serverWorkout in serverWorkouts) {
      final cachedWorkout = cachedWorkoutMap[serverWorkout.id];
      if (cachedWorkout == null ||
          DateTime.parse(cachedWorkout.updatedAt)
              .isBefore(DateTime.parse(serverWorkout.updatedAt))) {
        // тренировки устарели
        return true;
      }
    }
    // все тренировки актуальны
    return false;
  }

  Future<void> _updateCache(List<Workout> workouts) async {
    for (var workout in workouts) {
      final workoutType = await getTypeWorkout.getType(workout.typeWorkoutId);
      workout.typeName = workoutType.name;
    }

    final Box<WorkoutAdapter> workoutBox = Hive.box<WorkoutAdapter>('workouts');
    await workoutBox.clear();
    await workoutBox
        .addAll(workouts.map((workout) => WorkoutAdapter.fromWorkout(workout)));
  }
}
