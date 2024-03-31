import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServiceCreateRecord {
  Future<bool> createRecord({
    required int scheduleId,
    required int userId,
    required int hallId,
    required String visitationDate,
    required String payments,
  }) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? authToken = sharedPreferences.getString('auth_token');
    final url = Uri.parse('http://89.104.69.88/api/record/create');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'schedule_id': scheduleId,
        'user_id': userId,
        'total_training': 2,
        'hall_id': hallId,
        'type_record': "Тренировка в зале",
        'payments': payments,
        'visitation_date': visitationDate,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      // логируем ошибку, потому как на практике нам важно знать детали
      print('Ошибка создания записи: ${response.body}');
      return false;
    }
  }
}