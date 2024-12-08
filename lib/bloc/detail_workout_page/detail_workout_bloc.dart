import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_event.dart';
import 'package:jalur/bloc/detail_workout_page/detail_workout_state.dart';
import 'package:jalur/response_api/get_type_workout.dart';

import 'package:jalur/response_api/get_workout_detail.dart';

import '../../adapters/workout_detail_adapter.dart';
import '../../models/workout.dart';

class DetailWorkoutBloc extends Bloc<DetailWorkoutEvent, DetailWorkoutState> {
  final ApiServiceGetWorkoutDetail apiServiceGetWorkoutDetail;
  final GetTypeWorkout getTypeWorkout;
  DetailWorkoutBloc(this.apiServiceGetWorkoutDetail, this.getTypeWorkout)
      : super(InitialState()) {
    on<LoadDetailWorkoutEvent>(_onLoadCurrentWorkoutEvent);
  }

  Future<void> _onLoadCurrentWorkoutEvent(
      LoadDetailWorkoutEvent event, Emitter<DetailWorkoutState> emit) async {
    emit(LoadingDetailState());
    try {
      final Box<WorkoutDetailAdapter> workoutBox =
          Hive.box<WorkoutDetailAdapter>('workout_details');
      final WorkoutDetailAdapter? cachedWorkoutAdapter =
          workoutBox.get(event.id);

      if (cachedWorkoutAdapter != null) {
        final Workout cachedWorkout = cachedWorkoutAdapter.toWorkout();
        final Workout serverWorkout =
            await apiServiceGetWorkoutDetail.getWorkoutById(event.id);

        if (DateTime.parse(cachedWorkout.updatedAt)
            .isBefore(DateTime.parse(serverWorkout.updatedAt))) {
          await _updateCache(serverWorkout);
          emit(LoadWorkoutSuccess(serverWorkout));
        } else {
          emit(LoadWorkoutSuccess(cachedWorkout));
        }
      } else {
        final Workout workout =
            await apiServiceGetWorkoutDetail.getWorkoutById(event.id);
        await _updateCache(workout);
        emit(LoadWorkoutSuccess(workout));
      }
    } catch (e) {
      emit(WorkoutErrorState(e.toString()));
    }
  }

  Future<void> _updateCache(Workout workout) async {
    final workoutType = await getTypeWorkout.getType(workout.typeWorkoutId);
    workout.typeName = workoutType.name;

    final Box<WorkoutDetailAdapter> workoutBox =
        Hive.box<WorkoutDetailAdapter>('workout_details');
    await workoutBox.put(workout.id, WorkoutDetailAdapter.fromWorkout(workout));
  }
}
