import 'dart:convert';

class Workout {
  int id;
  int typeWorkoutId;
  String name;
  String description;
  List<String> images;
  String createdAt;
  String updatedAt;
  Workout(
      {required this.id,
      required this.typeWorkoutId,
      required this.name,
      required this.description,
      required this.images,
      required this.createdAt,
      required this.updatedAt});

  factory Workout.fromJson(Map<String, dynamic> json) {
    var imagesFromJson = jsonDecode(json['images']) as List;
    List<String> imagesList =
        imagesFromJson.map((imageItem) => imageItem['name'] as String).toList();
    return Workout(
      id: json['id'] as int,
      typeWorkoutId: json['type_workout_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      images: imagesList,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}
