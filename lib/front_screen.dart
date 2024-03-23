import 'package:flutter/material.dart';
import 'package:ojplace/client_list/add_clinent.dart';
import 'package:ojplace/blog_list/blog_add.dart';
import 'package:ojplace/test/test.dart';
// import 'package:cloud_firestore_web/cloud_firestore.dart;

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  void _onTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddClient(),
      ),
    );
  }

  void _onKeyword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BlogAdd(),
      ),
    );
  }

  void _onKeyword3() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Test01(),
      ),
    );
  }

  void _onKeyword4() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Test01(),
      ),
    );
  }

  // void _onKeyword5() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => const TestProver01(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("오직닷컴 플레이스 관리툴"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _onTap,
              icon: const Icon(
                Icons.accessibility_rounded,
                size: 18,
              ),
              label: const Text("클라이언트 입력"),
            ),
            ElevatedButton.icon(
              onPressed: _onKeyword,
              icon: const Icon(
                Icons.accessibility_rounded,
                size: 18,
              ),
              label: const Text("키워드 입력창"),
            ),
            ElevatedButton.icon(
              onPressed: _onKeyword3,
              icon: const Icon(
                Icons.accessibility_rounded,
                size: 18,
              ),
              label: const Text("테스트:riverpod0"),
            ),
            ElevatedButton.icon(
              onPressed: _onKeyword4,
              icon: const Icon(
                Icons.accessibility_rounded,
                size: 18,
              ),
              label: const Text("테스트:Riverpod1"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.accessibility_rounded,
                size: 18,
              ),
              label: const Text("테스트:provider01"),
            ),
          ],
        ),
      ),
    );
  }
}
