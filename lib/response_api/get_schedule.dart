import 'dart:convert';

import 'package:jalur/models/schedule.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceGetSchedule {
  List<Schedule> datatosave = [];

  Future<List<Schedule>> getSchedules() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? authToken = sharedPreferences.getString('auth_token');
    final url = Uri.parse('http://194.58.126.46/api/schedule/');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $authToken'});
    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];
      datatosave = dataList.map((data) => Schedule.fromJson(data)).toList();
      return datatosave;
    } else {
      throw Exception('Failed to load schedules');
    }
  }
}
