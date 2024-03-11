import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/coach.dart';

class GetUserData {
  Future<List<Coach>> getUserData(int id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    var url = Uri.parse('http://89.104.69.88/api/user/show/$id');
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
