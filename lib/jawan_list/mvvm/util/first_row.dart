import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  int browserNumber = 1;
  String userEmail = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  void getUserEmail() {
    User? user = auth.currentUser;
    if (user != null) {
      userEmail = user.email ?? ''; // 사용자의 이메일을 userEmail 변수에 저장합니다.
    } else {
      // print('현재 로그인된 사용자가 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 161, 8, 221)),
          child: const Text(
            "첫줄 무조건",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 180, 133, 2)),
          child: const Text(
            "지정블로그(밀어내기)",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 221, 207, 8)),
          child: const Text(
            "지정웹문서",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text(
            "첫 범위안클릭",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 16, 141, 80)),
          child: const Text(
            "플레이스",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(userEmail),
      ],
    );
  }
}
