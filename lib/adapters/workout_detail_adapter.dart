import 'package:hive/hive.dart';
import '../models/workout.dart';

part 'workout_detail_adapter.g.dart';

@HiveType(typeId: 2)
class WorkoutDetailAdapter {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int typeWorkoutId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String typeName;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String images;

  @HiveField(6)
  final String createdAt;

  @HiveField(7)
  final String updatedAt;

  WorkoutDetailAdapter({
    required this.id,
    required this.typeWorkoutId,
    required this.name,
    this.typeName = '',
    required this.description,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkoutDetailAdapter.fromWorkout(Workout workout) {
    return WorkoutDetailAdapter(
      id: workout.id,
      typeWorkoutId: workout.typeWorkoutId,
      name: workout.name,
      typeName: workout.typeName,
      description: workout.description,
      images: workout.images,
      createdAt: workout.createdAt,
      updatedAt: workout.updatedAt,
    );
  }

  Workout toWorkout() {
    return Workout(
      id: id,
      typeWorkoutId: typeWorkoutId,
      name: name,
      typeName: typeName,
      description: description,
      images: images,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
