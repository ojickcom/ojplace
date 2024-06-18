import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_model.dart';
import 'package:ojplace/client_list/client_viewmodel.dart';
import 'package:ojplace/client_list/repository.dart';
import 'package:ojplace/constants/gaps.dart';

class ClientListView extends ConsumerWidget {
  const ClientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ClientModel>> clientView = ref.watch(repoProvider);
    final navigationToEditor = ref.watch(navigationToEditProvider);
    final deleteClient = ref.watch(deleteProvider);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1224,
          child: clientView.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final client = data[index];
                return Row(children: [
                  Text("거래처명: ${client.clientsName}"),
                  Gaps.h10,
                  Text("키워드 : ${client.clientsMemo}"),
                  Gaps.h10,
                  const Text("월간 비용: 00"),
                  Gaps.h10,
                  const Text("자완: 부산 강아지"),
                  Gaps.h10,
                  const Text("결재일"),
                  Gaps.h10,
                  const Text("결재여부"),
                  Gaps.h10,
                  const Text("상품링크"),
                  Gaps.h10,
                  const Text("키워드수정"),
                  Gaps.h10,
                  ElevatedButton(
                    onPressed: () => navigationToEditor.navigateToEditScreen(
                        context, client),
                    child: const Text("수정"),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        deleteClient.deleteClient(client.id, context, ref),
                    child: const Text("삭제"),
                  ),
                ]);
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}

void _deleteClient(var clientId, BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseFirestore.instance
        .collection("clients")
        .doc(clientId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('클라이언트가 성공적으로 삭제되었습니다.'),
      ),
    );
    ref.refresh(repoProvider);
  } catch (e) {
    print("Error deleting client: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('클라이언트 삭제에 실패했습니다.'),
      ),
    );
  }
}
