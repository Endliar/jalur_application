class Record {
  final int id;
  final int userId;
  final int scheduleId;
  final int totalTraining;
  final int remainingTraining;
  final String createdAt;
  final String updatedAt;

  Record(
      {required this.id,
      required this.userId,
      required this.scheduleId,
      required this.totalTraining,
      required this.remainingTraining,
      required this.createdAt,
      required this.updatedAt});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
        id: json['id'],
        userId: json['user_id'],
        scheduleId: json['schedule_id'],
        totalTraining: json['total_training'],
        remainingTraining: json['remaining_training'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
