import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/record_data_page/record_data_bloc.dart';
import 'package:jalur/response_api/get_record.dart';
import 'package:jalur/response_api/user_logout.dart';
import 'package:jalur/views/profile_info_page/edit_profile_page.dart';
import 'package:jalur/views/profile_info_page/record_data_page.dart';
import 'package:jalur/views/welcome_page/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/colors.dart';
import '../../helpers/routes.dart';

class ProfilePage extends StatefulWidget {
  final int selectedIndex;
  const ProfilePage({super.key, required this.selectedIndex});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  DateTime pickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final args = {
      'selectedIndex': _selectedIndex,
      'selectedDate': pickedDate,
    };

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.homepage, (Route<dynamic> route) => false,
            arguments: _selectedIndex);
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.schedule, (Route<dynamic> route) => false,
            arguments: args);
        break;
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.coach, (Route<dynamic> route) => false,
            arguments: _selectedIndex);
        break;
      case 3:
        break;
      default:
    }
  }

  Future<void> _logout() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final int? userId = preferences.getInt('user_id');
      if (userId == null) {
        throw Exception('User ID not found in SharedPreferences');
      }
      await UserLogout().userLogout(userId);

      await preferences.remove('user_id');
      await preferences.remove('auth_token');
      await preferences.remove('phone');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
          (Route<dynamic> route) => false);

      print("Выход из аккаунта ${userId} произошёл успешно");
    } catch (e) {
      throw Exception("Ошибка выхода из профиля: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Главная",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 265.0,
              height: 35.0,
              decoration: BoxDecoration(
                color:
                    kPrimaryColor, // пример цвета фона для кнопки, замени на нужный
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ));
                },
                child: const Text('Профиль',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 16), // добавим небольшой отступ между кнопками
          Center(
            child: Container(
              width: 265.0,
              height: 35.0,
              decoration: BoxDecoration(
                color:
                    kPrimaryColor, // пример цвета фона для кнопки, замени на нужный
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<RecordDataBloc>(
                      create: (context) =>
                          RecordDataBloc(getRecordApi: GetRecordApi()),
                      child: const RecordDataPage(),
                    ),
                  ));
                },
                child: const Text(
                  'История записей',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // отступ между кнопками
          Center(
            child: Container(
              width: 265.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: kPrimaryColor, // пример цвета фона для кнопки
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextButton(
                onPressed: () {
                  _logout();
                },
                child: const Text(
                  'Выход',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Расписание'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Тренера'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
