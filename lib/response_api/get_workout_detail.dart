import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/workout.dart';

class ApiServiceGetWorkoutDetail {
  Future<Workout> getWorkoutById(int id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    final url = Uri.parse('http://89.104.69.88/api/workout/show/$id');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData['data'] != null) {
        final Map<String, dynamic> data = jsonData['data'];
        return Workout.fromJson(data);
      } else {
        throw Exception('Data not found');
      }
    } else {
      throw Exception('Failed to load workout');
    }
  }
}
