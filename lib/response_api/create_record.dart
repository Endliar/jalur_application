import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServiceCreateRecord {
  Future<bool> createRecord({
    required int scheduleId,
    required int? userId,
    required int totalTraining,
    required int hallId,
    required String typeRecord,
    required String visitionDate,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? authToken = sharedPreferences.getString('auth_token');
    final url = Uri.parse('http://89.104.69.88/api/record/create');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        "Content-type": "application/json"
      },
      body: jsonEncode({
        'schedule_id': scheduleId,
        'user_id': userId,
        'total_training': totalTraining,
        'hall_id': hallId,
        'type_record': typeRecord,
        'visition_date': visitionDate,
      }),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      print('Ошибка создания записи: ${response.body}');
      return false;
    }
  }
}
