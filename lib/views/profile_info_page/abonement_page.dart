import 'package:flutter/material.dart';

import '../../helpers/colors.dart';

class AbonementPage extends StatelessWidget {
  const AbonementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          'Абонементы',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildAbonementItem('Разовое занятие', '500 руб', false, context),
          _buildAbonementItem(
              '8 занятий',
              '3760 руб (470 руб за занятие), действует 30 дней',
              false,
              context),
          _buildAbonementItem(
              '12 занятий',
              '5400 руб (450 руб за занятие), заморозка 7 дней, действует 40 дней',
              false,
              context),
          _buildAbonementItem(
              '16 занятий',
              '6880 руб (430 руб за занятие), заморозка 14 дней, действует 50 дней',
              false,
              context),
          _buildAbonementItem(
              '24 занятия',
              '9600 руб (400 руб за занятие), заморозка 20 дней, действует 90 дней',
              true,
              context),
        ],
      ),
    );
  }

  Widget _buildAbonementItem(String title, String subtitle, bool isSpecialOffer,
      BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSpecialOffer ? FontWeight.bold : FontWeight.normal,
            color: isSpecialOffer ? Colors.red : kTextColor,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Уважаемый пользователь'),
                  content: const Text(
                      'Функционал оплаты абонемента появится сразу после релиза приложения в Google Play. Приносим извинения за доставленные неудобства'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('ОК'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Приобрести'),
        ),
        contentPadding: const EdgeInsets.all(12.0),
        tileColor: isSpecialOffer ? Colors.yellow[100] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
