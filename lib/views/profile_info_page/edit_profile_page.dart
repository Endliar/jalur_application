import 'package:flutter/material.dart';
import 'package:jalur/response_api/user_data_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/colors.dart';
import '../welcome_page/welcome_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _phoneController = TextEditingController();
  UserDataUpdate _userDataUpdate = UserDataUpdate();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _loadPhone();
  }

  Future<void> _loadPhone() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? phone = preferences.getString('phone');
    setState(() {
      _phoneController.text = phone ?? '';
    });
  }

  void _updateUserData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int? userID = preferences.getInt('user_id');
    try {
      await _userDataUpdate.userDataUpdate(
          id: userID, phone: _phoneController.text);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
          (Route<dynamic> route) => false);
    } catch (e) {
      throw Exception(
          "Не удалось обновить данные пользователя: ${e.toString()}");
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          'Данные',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Здесь вы можете изменить некоторые свои данные.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
                onPressed: () {
                  _updateUserData();
                },
                child: const Text("Обновить"))
          ],
        ),
      ),
    );
  }
}
