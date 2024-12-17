import 'package:hive/hive.dart';

import '../models/coach.dart';

part 'coach_adapter.g.dart';

@HiveType(typeId: 3) // Уникальный идентификатор для CoachAdapter
class CoachAdapter {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String? middleName;

  @HiveField(4)
  final int? age;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final String role;

  @HiveField(7)
  final String gender;

  @HiveField(8)
  final String? image;

  @HiveField(9)
  final int? sizeCloth;

  @HiveField(10)
  final String phone;

  @HiveField(11)
  final String updatedAt;

  CoachAdapter({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.age,
    this.description,
    required this.role,
    required this.gender,
    this.image,
    this.sizeCloth,
    required this.phone,
    required this.updatedAt,
  });

  factory CoachAdapter.fromCoach(Coach coach) {
    return CoachAdapter(
        id: coach.id,
        firstName: coach.firstName,
        lastName: coach.lastName,
        middleName: coach.middleName,
        age: coach.age,
        description: coach.description,
        role: coach.role,
        gender: coach.gender,
        image: coach.image,
        sizeCloth: coach.sizeCloth,
        phone: coach.phone,
        updatedAt: coach.updatedAt);
  }

  Coach toCoach() {
    return Coach(
      id: id,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      age: age,
      description: description,
      role: role,
      gender: gender,
      image: image,
      sizeCloth: sizeCloth,
      phone: phone,
      updatedAt: updatedAt,
    );
  }
}
