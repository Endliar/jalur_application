import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServiceCreateRecord {
  Future<bool> createRecord({
    required int scheduleId,
    required int? userId,
    required int? hallId,
    required int totalTraining,
    required DateTime visitationDate,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? authToken = sharedPreferences.getString('auth_token');
    const String payments =
        '[{"id": "22e12f66-000f-5000-8000-18db351245c7", "paid": true, "test": false, "amount": {"value": "1000.00", "currency": "RUB"}, "status": "waiting_for_capture", "metadata": {}, "recipient": {"account_id": "100500", "gateway_id": "100700"}, "created_at": "2018-07-18T10:51:18.139Z", "expires_at": "2018-07-25T10:52:00.233Z", "refundable": false, "description": "Заказ №1", "income_amount": {"value": "1.97", "currency": "RUB"}, "payment_method": {"id": "22e12f66-000f-5000-8000-18db351245c7", "card": {"last4": "4444", "first6": "555555", "card_type": "MasterCard", "expiry_year": "2022", "issuer_name": "Sberbank", "expiry_month": "07", "issuer_country": "RU"}, "type": "bank_card", "saved": false, "title": "Bank card *4444"}, "authorization_details": {"rrn": "10000000000", "auth_code": "000000", "three_d_secure": {"applied": true}}}]';
    final url = Uri.parse('http://89.104.69.88/api/record/create');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'schedule_id': scheduleId,
        'user_id': userId,
        'total_training': totalTraining,
        'hall_id': hallId,
        'payments': payments,
        'visitation_date': visitationDate,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Ошибка создания записи: ${response.body}');
      return false;
    }
  }
}
