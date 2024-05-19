abstract class ScheduleDataEvent {}

class LoadScheduleDataEvent extends ScheduleDataEvent {}

class CreateRecordEvent extends ScheduleDataEvent {
  final int scheduleId;
  final int userId;
  final int totalTraining;
  final int hallId;
  final String typeRecord;
  final String visitionDate;

  CreateRecordEvent({
    required this.totalTraining,
    required this.scheduleId,
    required this.userId,
    required this.totalTraining,
    required this.hallId,
    required this.typeRecord,
    required this.visitionDate,
  });
}
