import 'package:flutter/material.dart';
import 'package:jalur/models/workout.dart';

import '../../../helpers/routes.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                'http://193.104.57.92/storage/${workout.images}',
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      workout.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Тип занятия: ${workout.typeName}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Routes.detailWorkout,
                      arguments: workout.id,
                    );
                  },
                  child: const Text('Подробнее'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
