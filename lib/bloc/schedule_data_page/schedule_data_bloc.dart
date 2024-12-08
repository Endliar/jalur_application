import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jalur/adapters/schedule_adapter.dart';
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
    emit(LoadingScheduleDataState());
    try {
      final Box<ScheduleAdapter> scheduleBox =
          Hive.box<ScheduleAdapter>('schedules');
      final List<Schedule> cachedSchedules =
          scheduleBox.values.map((adapter) => adapter.toSchedule()).toList();

      if (cachedSchedules.isNotEmpty) {
        emit(LoadScheduleDataSuccess(cachedSchedules));
        print("Cached schedules loaded");
      }

      final List<Schedule> serverSchedules =
          await getScheduleData.getSchedules();

      if (cachedSchedules.isEmpty ||
          await _isCacheOutdated(cachedSchedules, serverSchedules)) {
        await _updateCache(serverSchedules);
        emit(LoadScheduleDataSuccess(serverSchedules));
      }
    } catch (e) {
      print(e);
      emit(ScheduleErrorState(e.toString()));
    }
  }

  Future<bool> _isCacheOutdated(
      List<Schedule> cachedSchedules, List<Schedule> serverSchedules) async {
    final Map<int, Schedule> cachedScheduleMap = {
      for (var schedule in cachedSchedules) schedule.id: schedule
    };

    for (var serverSchedule in serverSchedules) {
      final cachedSchedule = cachedScheduleMap[serverSchedule.id];
      if (cachedSchedule == null ||
          DateTime.parse(cachedSchedule.updatedAt)
              .isBefore(DateTime.parse(serverSchedule.updatedAt))) {
        return true;
      }
    }
    return false;
  }

  Future<void> _updateCache(List<Schedule> schedules) async {
    for (var schedule in schedules) {
      final workoutDetail =
          await getWorkoutDetail.getWorkoutById(schedule.workoutId);
      schedule.workoutName = workoutDetail.name;
      final typeWorkout =
          await getTypeWorkout.getType(workoutDetail.typeWorkoutId);
      schedule.typeName = typeWorkout.name;
    }

    final Box<ScheduleAdapter> scheduleBox =
        Hive.box<ScheduleAdapter>('schedules');
    await scheduleBox.clear();
    await scheduleBox.addAll(
        schedules.map((schedule) => ScheduleAdapter.fromSchedule(schedule)));
  }
}
