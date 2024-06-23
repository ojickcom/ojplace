import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/client_list/client_model.dart';
import 'package:ojplace/client_list/client_repo.dart';
import 'package:ojplace/client_list/client_vm.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:intl/intl.dart';

class ClientListView extends ConsumerWidget {
  const ClientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clients = ref.watch(clientsProvider);
    // final navigationToEditor = ref.watch(navigationToEditProvider);
    // final deleteClient = ref.watch(deleteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("클라이언트 리스트"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddClientDialog(context, ref);
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 1224,
          child: clients.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final client = data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 1000,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                  "${client.clientsName}, ${client.grade}"),
                            ),
                            Gaps.h20,
                            SizedBox(
                              width: 700,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("자완 가격: ${client.basePrice}"),
                                      Gaps.h10,
                                      Text("자완 수량: ${client.amountKeyword}"),
                                      Gaps.h10,
                                      Text("누락: ${client.amountKeyword}개"),
                                      Gaps.h10,
                                      Text("밀어내기 가격:${client.basePrice}"),
                                      Gaps.h10,
                                      Text("밀어내기 수량:${client.basePrice}"),
                                      Gaps.h10,
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("플레이스 수량:${client.basePrice}"),
                                      Gaps.h10,
                                      Text("총 결재비용: ${client.amountPrice}원"),
                                      Gaps.h10,
                                      Text("결재일: ${client.paymentDate}"),
                                      Gaps.h10,
                                      const Text("결재여부: 완료"),
                                      Gaps.h10,
                                      Text("메모 : ${client.memo}"),
                                      Gaps.h10,
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Gaps.h10,
                            const Text("키워드들"),
                            Gaps.h10,
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showEditClientDialog(context, ref, client);
                        },
                        child: const Text("수정"),
                      ),
                      Gaps.h10,
                      ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(deleteClientProvider(client.id).future);
                          ref
                              .read(clientViewModelProvider.notifier)
                              .fetchClients();
                        },
                        child: const Text("삭제"),
                      ),
                    ],
                  ),
                );
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

void _showAddClientDialog(BuildContext context, WidgetRef ref) {
  final clientsNameController = TextEditingController();
  final memoController = TextEditingController();
  final gradeController = TextEditingController();
  final basePriceController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('고객추가'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: clientsNameController,
              decoration: const InputDecoration(labelText: 'Client Name'),
            ),
            TextField(
              controller: gradeController,
              decoration: const InputDecoration(labelText: 'Grade'),
            ),
            TextField(
              controller: basePriceController,
              decoration: const InputDecoration(labelText: '자완가격'),
            ),
            TextField(
              controller: memoController,
              decoration: const InputDecoration(labelText: 'Memo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final clientsName = clientsNameController.text;
              final basePrice = int.parse(basePriceController.text);
              final grade = gradeController.text;
              final memo = memoController.text;

              if (clientsName.isNotEmpty && memo.isNotEmpty) {
                ref
                    .read(clientViewModelProvider.notifier)
                    .addClient1(clientsName, memo, basePrice, grade);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

void _showEditClientDialog(
    BuildContext context, WidgetRef ref, ClientModel client) {
  final clientsNameController = TextEditingController(text: client.clientsName);
  final clientsGradeController = TextEditingController(text: client.grade);
  final basePriceController =
      TextEditingController(text: client.basePrice.toString());
  final pushPriceController =
      TextEditingController(text: client.pushPrice.toString());
  final paymentDateController = TextEditingController(
    text: client.paymentDate != null
        ? DateFormat('yyyy-MM-dd').format(client.paymentDate!)
        : '',
  );
  final memoController = TextEditingController(text: client.memo);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Client'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: clientsNameController,
              decoration: const InputDecoration(labelText: 'Client Name'),
            ),
            TextField(
              controller: clientsGradeController,
              decoration: const InputDecoration(labelText: '고객등급'),
            ),
            TextField(
              controller: basePriceController,
              decoration: const InputDecoration(labelText: '자완가격'),
            ),
            TextField(
              controller: pushPriceController,
              decoration: const InputDecoration(labelText: '밀어내기 가격'),
            ),
            TextField(
              controller: paymentDateController,
              decoration: const InputDecoration(labelText: 'Payment Date'),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: client.paymentDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  paymentDateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
            TextField(
              controller: memoController,
              decoration: const InputDecoration(labelText: 'Memo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedClient = ClientModel(
                id: client.id,
                clientsName: clientsNameController.text,
                grade: clientsGradeController.text,
                basePrice: int.parse(basePriceController.text),
                pushPrice: int.parse(pushPriceController.text),
                paymentDate:
                    DateFormat('yyyy-MM-dd').parse(paymentDateController.text),
                memo: memoController.text,
              );

              ref
                  .read(clientViewModelProvider.notifier)
                  .updateClient(updatedClient);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
