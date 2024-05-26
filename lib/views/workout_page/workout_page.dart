import 'package:flutter/material.dart';
import 'package:jalur/helpers/routes.dart';
import 'package:jalur/models/workout.dart';

import '../../helpers/colors.dart';

class WorkoutPage extends StatelessWidget {
  final Workout data;
  const WorkoutPage({super.key, required this.data});

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2101));
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          "Тренировка",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'http://89.104.69.88/storage/${data.images}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  data.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  data.typeName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Описание',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(data.description, // Описание тренировки
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 16)),
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
                  onPressed: () async {
                    int _selectedIndex = 1;
                    final DateTime? pickedDate = await _selectDate(context);
                    final args = {
                      'selectedIndex': _selectedIndex,
                      'selectedDate': pickedDate,
                    };
                    if (pickedDate != null) {
                      Navigator.of(context)
                          .pushNamed(Routes.schedule, arguments: args);
                    }
                  },
                  child: const Text(
                    'Записаться',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
