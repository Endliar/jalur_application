import 'package:hive/hive.dart';
import '../models/schedule.dart';

part 'schedule_adapter.g.dart';

@HiveType(typeId: 1)
class ScheduleAdapter {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int hallId;

  @HiveField(2)
  final int workoutId;

  @HiveField(3)
  final int couchId;

  @HiveField(4)
  final int scheduleTimeId;

  @HiveField(5)
  final String date;

  @HiveField(6)
  final int countRecord;

  @HiveField(7)
  final String workoutName;

  @HiveField(8)
  final String typeName;

  @HiveField(9)
  final String createdAt;

  @HiveField(10)
  final String updatedAt;

  ScheduleAdapter({
    required this.id,
    required this.hallId,
    required this.workoutId,
    required this.couchId,
    required this.scheduleTimeId,
    required this.date,
    required this.countRecord,
    this.workoutName = '',
    this.typeName = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleAdapter.fromSchedule(Schedule schedule) {
    return ScheduleAdapter(
      id: schedule.id,
      hallId: schedule.hallId,
      workoutId: schedule.workoutId,
      couchId: schedule.couchId,
      scheduleTimeId: schedule.scheduleTimeId,
      date: schedule.date,
      countRecord: schedule.countRecord,
      workoutName: schedule.workoutName,
      typeName: schedule.typeName,
      createdAt: schedule.createdAt,
      updatedAt: schedule.updatedAt,
    );
  }

  Schedule toSchedule() {
    return Schedule(
      id: id,
      hallId: hallId,
      workoutId: workoutId,
      couchId: couchId,
      scheduleTimeId: scheduleTimeId,
      date: date,
      countRecord: countRecord,
      workoutName: workoutName,
      typeName: typeName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
