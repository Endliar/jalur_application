class Coach {
  final int id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final int? age;
  final String description;
  final String role;
  final String gender;
  final String? image;
  final int? sizeCloth;
  final String phone;

  Coach({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.age,
    required this.description,
    required this.role,
    required this.gender,
    required this.image,
    this.sizeCloth,
    required this.phone,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
      age: json['age'] ?? 0,
      description: json['description'],
      role: json['role'],
      gender: json['gender'],
      image: json['image'],
      sizeCloth: json['size_cloth'],
      phone: json['phone'],
    );
  }
}
