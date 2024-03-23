import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_viewmodel.dart';

class ClientEditScreen extends ConsumerWidget {
  final dynamic client;
  const ClientEditScreen({super.key, this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateClient = ref.watch(updateClientProvider);
    final nameController =
        TextEditingController(text: client.clientsName ?? '');
    final keywordController =
        TextEditingController(text: client.targetKeywords ?? '');

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
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
                controller: nameController,
                onChanged: (cont) {},
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
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
                controller: keywordController,
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
                onPressed: () {
                  String updatedName = nameController.text;
                  String updatedKeyword = keywordController.text;
                  updateClient.updateClient(
                      client.id, updatedName, updatedKeyword, ref, context);
                },
                icon: const Icon(
                  Icons.accessibility_rounded,
                  size: 18,
                ),
                label: const Text("수정 완료"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void _updateClient(String clientId, String updatedClientName,
//     String updatedKeywords, WidgetRef ref, BuildContext context) async {
//   // Firestore에서 데이터 업데이트
//   try {
//     await FirebaseFirestore.instance
//         .collection("clients")
//         .doc(clientId)
//         .update({
//       "clients_name": updatedClientName,
//       "keyword": updatedKeywords,
//     });
//     print("업데이트 성공");
//     // 성공 메시지 표시
//     Navigator.pop(context);
//     ref.refresh(repoProvider);
//   } catch (e) {
//     print("Error updating client: $e");
//     // 에러 메시지 처리
//   }
// }
