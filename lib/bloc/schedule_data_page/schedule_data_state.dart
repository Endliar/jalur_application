import '../../models/schedule.dart';

abstract class ScheduleDataState {}

class InitialState extends ScheduleDataState {}

class LoadingScheduleDataState extends ScheduleDataState {}

class LoadScheduleDataSuccess extends ScheduleDataState {
  final List<Schedule> schedules;

  LoadScheduleDataSuccess(this.schedules);
}

class ScheduleErrorState extends ScheduleDataState {
  final String error;
  ScheduleErrorState(this.error);
}

class RecordCreationSuccessState extends ScheduleDataState {}

class RecordCreationFailureState extends ScheduleDataState {
  final String error;

  RecordCreationFailureState(this.error);
}
