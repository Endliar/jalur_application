import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserDataUpdate {
  Future<void> userDataUpdate(
      {required int id, required String phone, required String weight}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    var url = Uri.parse('http://89.104.69.88/api/user/update');

    final body = jsonEncode({'id': id, 'phone': phone, 'weight': weight});

    final response = await http.post(url,
        headers: {
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
