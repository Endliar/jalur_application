import 'dart:convert';

import 'package:jalur/models/user.dart';
import 'package:http/http.dart' as http;

class Login {
  List<ResponseUser> datatosave = [];

  Future<void> authUser(
      String phone, int code) async {
    var url = Uri.parse("http://89.104.69.88/api/user/auth");
    final response = await http.post(url,
        headers: {
          "accept": "application/json",
          "Content-type": "application/json"
        },
        body: json.encode({
          'phone': phone,
          'code': code
        }));
    if (response.statusCode != 200) {
      throw Exception("Не удалось авторизоваться ${response.body}");
    }
  }

  Future<bool> requestCode(String phoneNumber) async {
    var url = Uri.parse("http://89.104.69.88/api/user/code/$phoneNumber");
    final response = await http.get(url,
    headers: {
      "accept": "application/json",
      "Content-type": "application/json"
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] != null && responseData['data']['message'] == true) {
        return true;
      }
      throw Exception("API не вернул положительный результат: ${response.body}");
    } else {
      throw Exception("Ошибка запроса: Статус код ${response.statusCode}");
    }
  }
}
