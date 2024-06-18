import 'package:flutter/material.dart';

class PopupStyle {
  final Color backgroundColor;
  final String titleText;

  PopupStyle({
    required this.backgroundColor,
    required this.titleText,
  });

  factory PopupStyle.fromBlogType(String blogType) {
    Color backgroundColor = Colors.blue; // Default color
    String titleText = "기타 랜덤 클릭";

    if (blogType == "지정블로그") {
      backgroundColor = const Color.fromARGB(255, 180, 133, 2);
      titleText = "지정블로그 클릭";
    } else if (blogType == "플레이스") {
      backgroundColor = const Color.fromARGB(255, 16, 141, 80);
      titleText = "플레이스 클릭";
    } else if (blogType == "첫페이지") {
      backgroundColor = const Color.fromARGB(255, 161, 8, 221);
      titleText = "첫페이지 클릭";
    } else if (blogType == "지정웹문서") {
      backgroundColor = const Color.fromARGB(255, 221, 207, 8);
      titleText = "지정웹문서 클릭";
    }

    return PopupStyle(
      backgroundColor: backgroundColor,
      titleText: titleText,
    );
  }
}
