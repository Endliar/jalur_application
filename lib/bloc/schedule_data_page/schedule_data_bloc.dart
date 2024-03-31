import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/response_api/crate_record.dart';
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

  ScheduleDataBloc(
      this.getScheduleData, this.getWorkoutDetail, this.getTypeWorkout, this.apiServiceCreateRecord)
      : super(InitialState()) {
    on<LoadScheduleDataEvent>(_onLoadScheduleDataEvent);
    on<CreateRecordEvent>((event, emit) async {
      try {
        final bool isSuccess = await apiServiceCreateRecord.createRecord(
          scheduleId: event.scheduleId, 
          userId: event.userId, 
          hallId: event.hallId, 
          visitationDate: event.visitationDate);
        
        if (isSuccess) {
          emit(RecordCreationSuccessState());
        } else {
          emit(RecordCreationFailureState("Не удалось создать запись"));
        }
      } catch (e) {
        emit(RecordCreationFailureState(e.toString()));
      }
    });
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
      emit(ScheduleErrorState(e.toString()));
    }
  }
}
