import 'package:flutter/material.dart';

class navigationBar extends StatefulWidget {
  const navigationBar({
    super.key,
  });

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NavigationBar(
        onDestinationSelected: (int index) {
          // setState();
          currentPageIndex = index;
        },
        backgroundColor: Colors.orange,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.info),
            label: '소개',
          ),
        ],
      ),
    );

    [currentPageIndex];
  }
}
