import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:jalur/adapters/workout_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class ApiServiceGetWorkout {
  Future<List<Workout>> getWorkouts() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    final Uri url = Uri.parse('http://194.58.126.46/api/workout/');

    final Box<WorkoutAdapter> workoutBox = Hive.box<WorkoutAdapter>('workouts');
    if (workoutBox.isNotEmpty) {
      return workoutBox.values.map((adapter) => adapter.toWorkout()).toList();
    }

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      final List<Workout> workouts =
          dataList.map((data) => Workout.fromJson(data)).toList();

      for (var workout in workouts) {
        workoutBox.add(WorkoutAdapter.fromWorkout(workout));
      }

      return workouts;
    } else {
      throw Exception('Failed to load workouts');
    }
  }
}
