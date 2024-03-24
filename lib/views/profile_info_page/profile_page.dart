import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/views/welcome_page/components/default_navigator_button.dart';

import '../../bloc/profile_data_page/profile_data_bloc.dart';
import '../../bloc/profile_data_page/profile_data_event.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.of(context).pushNamed(Routes.homepage);
        case 1:
          Navigator.of(context)
              .pushNamed(Routes.schedule, arguments: _selectedIndex);
          break;
        case 2:
          Navigator.of(context).pushNamed(Routes.coach);
          break;
        case 3:
          break;
        default:
      }
    }
  }

  Future<void> _logout() async {
    BlocProvider.of<ProfileDataBloc>(context).add(UserLogoutEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Профиль",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefualtNavigatorButton(onPressed: () {}, text: "Профиль"),
            const SizedBox(
              height: 10,
            ),
            DefualtNavigatorButton(onPressed: () {}, text: "История записей"),
            const SizedBox(
              height: 10,
            ),
            DefualtNavigatorButton(onPressed: _logout, text: "Выход"),
          ],
        ),
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
