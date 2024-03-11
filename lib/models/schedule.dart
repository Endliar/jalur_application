class Schedule {
  int id;
  int hallId;
  int workoutId;
  int couchId;
  int scheduleTimeId;
  String date;
  int countRecord;
  String workoutName;
  String typeName;
  String createdAt;
  String updatedAt;

  Schedule(
      {required this.id,
      required this.hallId,
      required this.workoutId,
      required this.couchId,
      required this.scheduleTimeId,
      required this.date,
      required this.countRecord,
      this.workoutName = "",
      this.typeName = "",
      required this.createdAt,
      required this.updatedAt});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['id'] as int,
        hallId: json['hall_id'] as int,
        workoutId: json['workout_id'] as int,
        couchId: json['couch_id'] as int,
        scheduleTimeId: json['schedule_time_id'] as int,
        date: json['date'] as String,
        countRecord: json['count_record'] as int,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String);
  }
}
