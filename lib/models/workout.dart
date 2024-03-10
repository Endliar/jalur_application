import 'dart:convert';

class Workout {
  int id;
  int typeWorkoutId;
  String name;
  String typeName;
  String description;
  String images;
  String createdAt;
  String updatedAt;
  Workout(
      {required this.id,
      required this.typeWorkoutId,
      required this.name,
      this.typeName = '',
      required this.description,
      required this.images,
      required this.createdAt,
      required this.updatedAt});

  factory Workout.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] as String;
    imageUrl = imageUrl.replaceAll('"', '');
    return Workout(
      id: json['id'] as int,
      typeWorkoutId: json['type_workout_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      images: imageUrl,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}
