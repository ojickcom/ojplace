import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/test/test_cotrl.dart';

class Test01 extends ConsumerWidget {
  const Test01({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = ref.watch(controllerProvider); //컨트롤러 변수에 컨트롤러에 요청한다.

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Example')),
        body: Center(
          child: FutureBuilder(
            future: ref.watch(controllerProvider).fetchData2(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Data: ${ref.watch(controllerProvider).data}');
              }
            },
          ),
        ),
      ),
    );
  }
}
