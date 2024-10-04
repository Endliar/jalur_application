import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class ApiServiceGetWorkout {
  Future<List<Workout>> getWorkouts() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    final Uri url = Uri.parse('http://194.58.126.46/api/workout/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      return dataList.map((data) => Workout.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }
}
