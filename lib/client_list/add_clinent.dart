import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/repository.dart';

class AddClient extends ConsumerWidget {
  AddClient({super.key});
  final TextEditingController clientNameController = TextEditingController();

  final TextEditingController targetKeywordsController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientProvider = FutureProvider<void>((ref) async {
      final clientName = clientNameController.text;
      final targetKeywords = targetKeywordsController.text;
      return addClient(clientName, targetKeywords);
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
                  controller: targetKeywordsController,
                  decoration: const InputDecoration(
                    labelText: '키워드',
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
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  // initialValue: keyword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35.0),
                      ),
                    ),
                    hintText: 'User name',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      ref.read(addClientProvider);
                      print("Succeed : 진짜 되냐? 되면 알려다오 제발~!");
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
