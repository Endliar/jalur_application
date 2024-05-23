import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/record.dart';
import 'package:http/http.dart' as http;

class GetRecordApi {
  Future<List<Record>> getUserRecords(int userId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    final url = Uri.parse('http://89.104.69.88/api/record/$userId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final List<dynamic> recordsJson = json.decode(response.body)['data'];
      return recordsJson.map((json) => Record.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load records');
    }
  }
}
