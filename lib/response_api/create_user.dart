import 'dart:convert';

import 'package:jalur/models/user.dart';
import 'package:http/http.dart' as http;

class User {
  List<ResponseUser> datatosave = [];

  Future<void> createUser(String name, String surname, String phone,
      String gender, String role, int age) async {
    var url = Uri.parse("http://194.58.126.46/api/user/create");
    final response = await http.post(url,
        headers: {
          "accept": "application/json",
          "Content-type": "application/json"
        },
        body: json.encode({
          'first_name': name,
          'last_name': surname,
          'phone': phone,
          'gender': gender,
          'role': role,
          'age': age
        }));
    if (response.statusCode != 201) {
      throw Exception("Не удалось зарегистрироваться ${response.body}");
    }
  }
}
