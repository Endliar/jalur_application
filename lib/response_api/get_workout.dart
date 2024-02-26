import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class ApiServiceGetWorkout {
  List<Workout> datatosave = [];

  Future<List<Workout>> getWorkouts() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    final url = Uri.parse('http://89.104.69.88/api/hall/workout/2');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      datatosave = dataList.map((data) => Workout.fromJson(data)).toList();
      return datatosave;
    } else {
      throw Exception('Failed to load workouts');
    }
  }
}
