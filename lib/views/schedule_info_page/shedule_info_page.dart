import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_bloc.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_event.dart';
import 'package:jalur/models/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helpers/colors.dart';
import '../../helpers/routes.dart';

class SheduleInfoPage extends StatefulWidget {
  final DateTime selectedDate;
  final List<Schedule> schedules;
  final int selectedIndex;
  const SheduleInfoPage(
      {super.key,
      required this.schedules,
      required this.selectedIndex,
      required this.selectedDate});

  @override
  State<SheduleInfoPage> createState() => _SheduleInfoPageState();
}

class _SheduleInfoPageState extends State<SheduleInfoPage> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _selectedDate = widget.selectedDate;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.homepage,
            (Route<dynamic> route) => false,
          );
        case 1:
          break;
        case 2:
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.coach, (Route<dynamic> route) => false,
              arguments: _selectedIndex);
          break;
        case 3:
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.profile, (Route<dynamic> route) => false,
              arguments: _selectedIndex);
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
            locale: 'ru_RU',
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            focusedDay: _selectedDate,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: CalendarFormat.month,
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
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
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          final int? userId =
                              sharedPreferences.getInt('user_id');
                          final Map<int, String> halls = {
                            2: 'Зал тренировок',
                            3: 'Зал практик'
                          };
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                int? hallId;
                                String totalTraining = '';
                                return AlertDialog(
                                  title: const Text('Записаться на тренировку'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                            labelText: 'Количество занятий'),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        onChanged: (value) {
                                          totalTraining = value;
                                        },
                                      ),
                                      DropdownButton<int>(
                                        value: hallId,
                                        hint: const Text('Выберите зал'),
                                        items: halls.entries.map((entry) {
                                          return DropdownMenuItem<int>(
                                              value: entry.key,
                                              child: Text(entry.value));
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            hallId = newValue;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Отмена')),
                                    TextButton(
                                        onPressed: () {
                                          if (totalTraining.isNotEmpty &&
                                              hallId != null) {
                                            context
                                                .read()<ScheduleDataBloc>()
                                                .add(CreateRecordEvent(
                                                    totalTraining: int.parse(
                                                        totalTraining),
                                                    scheduleId: schedule.id,
                                                    userId: userId,
                                                    hallId: hallId,
                                                    visitationDate:
                                                        _selectedDate));
                                          }
                                        },
                                        child: const Text('Ок'))
                                  ],
                                );
                              });
                        },
                        child: const Text('Записаться')),
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


// Чтобы 