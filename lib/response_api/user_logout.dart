import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserLogout {
  Future<void> userLogout(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? authToken = preferences.getString('auth_token');
    var url = Uri.parse('http://194.58.126.46/api/user/logout/$id');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      print("Выход пользователя произошёл успешно");
    } else {
      throw Exception("Ошибка запроса: Статус код ${response.statusCode}");
    }
  }
}
