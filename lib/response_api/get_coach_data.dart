import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/coach.dart';

class GetCoachData {
  Future<List<Coach>> getCoachesData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    var url = Uri.parse("http://89.104.69.88/api/user/show/role/Тренер");
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body)['data'];
      return responseData
          .map((coachData) => Coach.fromJson(coachData))
          .toList();
    } else {
      throw Exception("Ошибка запроса: Статус код ${response.statusCode}");
    }
  }
}