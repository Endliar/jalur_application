class VisitionDate {
  final int id;
  final String visitionDate;
  final String status;

  VisitionDate(
      {required this.id, required this.visitionDate, required this.status});

  factory VisitionDate.fromJson(Map<String, dynamic> json) {
    return VisitionDate(
        id: json['id'],
        visitionDate: json['visition_date'],
        status: json['status']);
  }
}
