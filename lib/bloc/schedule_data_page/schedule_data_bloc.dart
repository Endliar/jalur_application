import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/response_api/create_record.dart';
import 'package:jalur/response_api/get_type_workout.dart';

import '../../models/schedule.dart';
import '../../response_api/get_schedule.dart';
import '../../response_api/get_workout_detail.dart';
import 'schedule_data_event.dart';
import 'schedule_data_state.dart';

class ScheduleDataBloc extends Bloc<ScheduleDataEvent, ScheduleDataState> {
  final ApiServiceGetSchedule getScheduleData;
  final GetTypeWorkout getTypeWorkout;
  final ApiServiceGetWorkoutDetail getWorkoutDetail;
  final ApiServiceCreateRecord apiServiceCreateRecord;

  final StreamController<RecordCreationState> _streamController =
      StreamController<RecordCreationState>();

  ScheduleDataBloc(this.getScheduleData, this.getWorkoutDetail,
      this.getTypeWorkout, this.apiServiceCreateRecord)
      : super(InitialState()) {
    on<LoadScheduleDataEvent>(_onLoadScheduleDataEvent);
    on<CreateRecordEvent>(_createRecord);
  }

  Stream<RecordCreationState> get recordCreationStream =>
      _streamController.stream;

  Future<void> _createRecord(
      CreateRecordEvent event, Emitter<ScheduleDataState> emit) async {
    try {
      final bool isSuccess = await apiServiceCreateRecord.createRecord(
          scheduleId: event.scheduleId,
          userId: event.userId,
          totalTraining: event.totalTraining,
          hallId: event.hallId,
          typeRecord: event.typeRecord,
          visitionDate: event.visitionDate);

      if (isSuccess) {
        _streamController.add(RecordCreationSuccessState());
      } else {
        _streamController
            .add(RecordCreationFailureState("Не удалось создать запись"));
      }
    } catch (e) {
      _streamController.add(RecordCreationFailureState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }

  Future<void> _onLoadScheduleDataEvent(
      LoadScheduleDataEvent event, Emitter<ScheduleDataState> emit) async {
    try {
      emit(LoadingScheduleDataState());
      List<Schedule> schedules = await getScheduleData.getSchedules();
      for (var schedule in schedules) {
        final workoutDetail =
            await getWorkoutDetail.getWorkoutById(schedule.workoutId);
        schedule.workoutName = workoutDetail.name;
        final typeWorkout =
            await getTypeWorkout.getType(workoutDetail.typeWorkoutId);
        schedule.typeName = typeWorkout.name;
      }
      emit(LoadScheduleDataSuccess(schedules));
    } catch (e) {
      print(e);
      emit(ScheduleErrorState(e.toString()));
    }
  }
}
