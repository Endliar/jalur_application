abstract class ScheduleDataEvent {}

class LoadScheduleDataEvent extends ScheduleDataEvent {}

class CreateRecordEvent extends ScheduleDataEvent {
  final int scheduleId;
  final int? userId;
  final int? hallId;
  final int totalTraining;
  final String typeRecord;
  final String visitationDate;

  CreateRecordEvent({
    required this.totalTraining,
    required this.scheduleId,
    required this.userId,
    required this.hallId,
    required this.typeRecord,
    required this.visitationDate,
  });
}
