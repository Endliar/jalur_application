import 'dart:convert';

import 'package:jalur/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  List<ResponseUser> datatosave = [];

  Future<void> _saveToken(String token, int id, String phone) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('auth_token', token);
    await preferences.setInt('user_id', id);
    await preferences.setString('phone', phone);
    print(id);
    print(phone);
  }

  Future<bool> authUser(String phone, String code) async {
    var url = Uri.parse("http://194.58.126.46/api/user/auth");
    final response = await http.post(url,
        headers: {
          "accept": "application/json",
          "Content-type": "application/json"
        },
        body: json.encode({'phone': phone, 'code': code}));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] != null &&
          responseData['data']['user'] != null) {
        await _saveToken(
            responseData['data']['access_key'],
            responseData['data']['user']['id'],
            responseData['data']['user']['phone']);
        return true;
      }
      throw Exception("Не удалось авторизоваться ${response.body}");
    } else {
      throw Exception("Не удалось авториз ${response.body}");
    }
  }

  Future<bool> requestCode(String phoneNumber) async {
    var url = Uri.parse("http://194.58.126.46/api/user/code/$phoneNumber");
    final response = await http.get(url, headers: {
      "accept": "application/json",
      "Content-type": "application/json"
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] != null &&
          responseData['data']['message'] == true) {
        return true;
      }
      throw Exception(
          "API не вернул положительный результат: ${response.body}");
    } else {
      throw Exception("Ошибка запроса: Статус код ${response.statusCode}");
    }
  }
}
