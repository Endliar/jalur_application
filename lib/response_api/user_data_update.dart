import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserDataUpdate {
  Future<void> userDataUpdate(
      {required int? id, String? phone, String? weight}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    var url = Uri.parse('http://89.104.69.88/api/user/update');

    final body = jsonEncode({'id': id, 'phone': phone});

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body);

    if (response.statusCode == 200) {
      print("Данные пользователя успешно обновлены");
    } else {
      throw Exception("Ошибка запроса: Статус код ${response.statusCode}");
    }
  }
}
