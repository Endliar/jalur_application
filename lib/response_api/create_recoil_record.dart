import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> createRecoilRecord(
    int id, int userId, int recoilTraining, String scheduleDay) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('auth_token');

  Map<String, dynamic> requestBody = {
    'id': id,
    'user_id': userId,
    'recoil_training': recoilTraining,
    'schedule_day': scheduleDay,
    'payments': ''
  };

  final response = await http.post(
    Uri.parse('http://89.104.69.88/api/record/recoil'),
    headers: {
      'Authorization': 'Bearer $authToken',
      "Content-type": "application/json"
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    print('record created successfully');
  } else {
    print('failed to create record: ${response.statusCode}');
  }
}
