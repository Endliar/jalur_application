// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/size_config.dart';

class DefaultNavigatorButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const DefaultNavigatorButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(35),
      width: getProportionateScreenWidth(265),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return kPrimaryColor.withOpacity(0.8);
            }
            return kPrimaryColor;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          mouseCursor: WidgetStateMouseCursor.clickable,
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
