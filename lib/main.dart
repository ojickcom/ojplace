import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_list.dart';
import 'package:ojplace/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ojplace/home.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(child: OjPlace()),
  );
}

class OjPlace extends StatelessWidget {
  const OjPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // colorScheme: myColorScheme,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
