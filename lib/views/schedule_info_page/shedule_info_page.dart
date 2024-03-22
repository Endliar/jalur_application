import 'package:flutter/material.dart';
import 'package:jalur/models/schedule.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helpers/colors.dart';
import '../../helpers/routes.dart';

class SheduleInfoPage extends StatefulWidget {
  final List<Schedule> schedules;
  final int selectedIndex;
  const SheduleInfoPage(
      {super.key, required this.schedules, required this.selectedIndex});

  @override
  State<SheduleInfoPage> createState() => _SheduleInfoPageState();
}

class _SheduleInfoPageState extends State<SheduleInfoPage> {
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
          Navigator.of(context).pushNamed(Routes.schedule);
          break;
        case 2:
          Navigator.of(context)
              .pushNamed(Routes.coach, arguments: _selectedIndex);
          break;
        case 3:
          break;
        default:
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Расписание",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: CalendarFormat.month,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.schedules.length,
              itemBuilder: (context, index) {
                final schedule = widget.schedules[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(schedule.workoutName),
                    subtitle: Text(schedule.typeName),
                    trailing: ElevatedButton(
                        onPressed: () {}, child: const Text('Записаться')),
                  ),
                );
              },
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
