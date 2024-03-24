import 'package:flutter/material.dart';

Widget genderTextField({required BuildContext context, required TextEditingController controller}) {
  return InkWell(
    onTap: () {
      showDialog(context: context, builder: (BuildContext context) {
        return SimpleDialog(
          title: const Center(child: Text("Выберите ваш пол")),
          children: <Widget> [
            Center(
              child: SimpleDialogOption(
                onPressed: () {
                  controller.text = 'Мужчина';
                  Navigator.pop(context);
                },
                child: const Text('Мужчина'),
              ),
            ),
            Center(
              child: SimpleDialogOption(
                onPressed: () {
                  controller.text = 'Женщина';
                  Navigator.pop(context);
                },
                child: const Text('Женщина'),
              ),
            )
          ],
        );
      });
    },
    child: AbsorbPointer(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Ваш гендер?',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
        readOnly: true,
      ),
    ),
  );
}