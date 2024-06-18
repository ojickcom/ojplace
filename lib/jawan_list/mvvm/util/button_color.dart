import 'package:flutter/material.dart';

class IconStyle {
  final ButtonStyle buttonStyle;

  IconStyle({required this.buttonStyle});

  static ButtonStyle getButtonStyle(String blogType) {
    Color backgroundColor;

    if (blogType == "지정블로그") {
      backgroundColor = const Color.fromARGB(255, 180, 133, 2);
    } else if (blogType == "플레이스") {
      backgroundColor = const Color.fromARGB(255, 16, 141, 80);
    } else if (blogType == "첫페이지") {
      backgroundColor = const Color.fromARGB(255, 161, 8, 221);
    } else if (blogType == "지정웹문서") {
      backgroundColor = const Color.fromARGB(255, 221, 207, 8);
    } else {
      backgroundColor = Colors.blue;
    }

    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) => backgroundColor,
      ),
    );
  }
}
