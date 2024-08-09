import 'package:jalur/models/visition_date.dart';

abstract class RecordDataEvent {}

class LoadRecordDataEvent extends RecordDataEvent {}

class GetRecordEvent extends RecordDataEvent {
  final int recordId;
  final int userId;
  final int scheduleId;
  final int totalTraining;
  final int remainingTraining;
  final List<VisitionDate> visitionDates;
  final String createdAt;
  final String updatedAt;

  GetRecordEvent({
    required this.recordId,
    required this.userId,
    required this.scheduleId,
    required this.totalTraining,
    required this.remainingTraining,
    required this.visitionDates,
    required this.createdAt,
    required this.updatedAt,
  });
}
