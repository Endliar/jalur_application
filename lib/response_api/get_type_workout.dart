import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jalur/models/type_workout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTypeWorkout {
  Future<WorkoutType> getType(int typeId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    var url =
        Uri.parse("http://89.104.69.88/api/hall/workout/type/show/$typeId");
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'];
      return WorkoutType.fromJson(responseData);
    } else {
      throw Exception("Ошибка запроса: Статус код ${response.statusCode}");
    }
  }
}
