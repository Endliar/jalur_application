import 'package:flutter/material.dart';
import 'package:jalur/models/schedule.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helpers/colors.dart';

class SheduleInfoPage extends StatefulWidget {
  final List<Schedule> schedules;
  const SheduleInfoPage({super.key, required this.schedules});

  @override
  State<SheduleInfoPage> createState() => _SheduleInfoPageState();
}

class _SheduleInfoPageState extends State<SheduleInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
