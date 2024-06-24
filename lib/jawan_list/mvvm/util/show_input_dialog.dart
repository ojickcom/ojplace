import 'package:flutter/material.dart';

Future<void> showInputDialog(
    BuildContext context, Color backgroundColor, String titleText) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(
        titleText,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("확인", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
