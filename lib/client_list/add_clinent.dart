import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/repository.dart';
import 'package:ojplace/constants/gaps.dart';

class AddClient extends ConsumerWidget {
  AddClient({super.key});
  final TextEditingController clientNameController = TextEditingController();

  final TextEditingController clientMemoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientProvider = FutureProvider<void>((ref) async {
      final clientName = clientNameController.text;
      final clientMemo = clientMemoController.text;
      return addClient(clientName, clientMemo);
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1024,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: clientNameController,
                  decoration: const InputDecoration(
                    labelText: '고객명',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onChanged: (cont) {},
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: clientMemoController,
                  decoration: const InputDecoration(
                    labelText: '메모',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onChanged: (aaa) {},
                ),
                Gaps.v20,
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      ref.read(addClientProvider);
                    } catch (e) {
                      print("failed : $e");
                    }
                  },
                  icon: const Icon(
                    Icons.accessibility_rounded,
                    size: 18,
                  ),
                  label: const Text("입력"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
