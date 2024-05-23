import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_bloc.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_event.dart';
import 'package:jalur/bloc/schedule_data_page/schedule_data_state.dart';
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

  Future<DateTime?> _pickDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = initialDate.subtract(const Duration(days: 365));
    DateTime lastDate = initialDate.add(const Duration(days: 365));

    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);

    return pickedDate;
  }

  // Здесь надо заебашить как в homepage'е

  @override
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
        body: BlocBuilder<ScheduleDataBloc, ScheduleDataState>(
          builder: (context, state) {
            if (state is LoadingScheduleDataState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadScheduleDataSuccess) {
              return ListView.builder(
                itemCount: state.schedules.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                        title: Text(state.schedules[index].workoutName),
                        subtitle: Text(state.schedules[index].typeName),
                        trailing: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final userId = prefs.getInt('user_id');
                              final DateTime? pickedDate =
                                  await _pickDate(context);

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('MM.dd.yyyy').format(pickedDate);
                                List<String> typesList = [
                                  'Тренировка в зале',
                                  'Глемпинг'
                                ];
                                int totalTraining = 0;
                                String typeRecord = typesList.first;
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text("Дополнительная информация"),
                                      content: Column(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              totalTraining = int.parse(value);
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'Количество занятий'),
                                          ),
                                          DropdownButton(
                                              value: typeRecord,
                                              items:
                                                  typesList.map((String type) {
                                                return DropdownMenuItem<String>(
                                                    value: type,
                                                    child: Text(type));
                                              }).toList(),
                                              onChanged: (newValue) {
                                                typeRecord = newValue!;
                                              }),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                              if (totalTraining != null &&
                                                  typeRecord != null) {
                                                BlocProvider.of<
                                                            ScheduleDataBloc>(
                                                        context)
                                                    .add(CreateRecordEvent(
                                                        scheduleId: state
                                                            .schedules[index]
                                                            .id,
                                                        userId: userId,
                                                        totalTraining:
                                                            totalTraining,
                                                        hallId: state
                                                            .schedules[index]
                                                            .hallId,
                                                        typeRecord: typeRecord,
                                                        visitionDate:
                                                            formattedDate));
                                              }
                                            },
                                            child: Text('Ок'))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Записаться"))),
                  );
                },
              );
            } else if (state is ScheduleErrorState) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(
                child: Text('Нет данных о записях'),
              );
            }
          },
        ));
  }
}