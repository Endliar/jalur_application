import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class ApiServiceGetWorkout {
  Future<List<Workout>> getWorkouts() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    final Uri url = Uri.parse('http://193.104.57.92/api/workout/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
      "Content-type": "application/json"
    });

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      final List<Workout> workouts =
          dataList.map((data) => Workout.fromJson(data)).toList();

      return workouts;
    } else {
      throw Exception('Failed to load workouts');
    }
  }
}
