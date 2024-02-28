class WorkoutType {
  final int id;
  final String name;

  WorkoutType({required this.id, required this.name});

  factory WorkoutType.fromJson(Map<String, dynamic> json) {
    return WorkoutType(id: json['id'] as int, name: json['name'] as String);
  }
}
