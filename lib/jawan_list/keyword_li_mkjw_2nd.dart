import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/jawan_list/mvvm/copy_input_db1.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mvvm/util/button_color.dart';
import 'package:ojplace/jawan_list/mvvm/util/first_row.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_modify.dart';

class MkJawan2nd extends ConsumerStatefulWidget {
  const MkJawan2nd({super.key});

  @override
  ConsumerState<MkJawan2nd> createState() => _BlogListPlaceState();
}

class _BlogListPlaceState extends ConsumerState<MkJawan2nd> {
  int browserNumber = 1;

  @override
  Widget build(
    BuildContext context,
  ) {
    final blogs = ref.watch(jawan2ndProvider);

    final copyAndDel = CopyAndInputdataProvider1();
    final popupAndModify = ref.watch(popupAndModifyProvider);

//본문 시작 됨
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1500,
          child: Center(
            child: blogs.when(
              data: (data) {
                int documentNumber = 1;
                final TextEditingController textEditingController =
                    TextEditingController();
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: TextField(
                            decoration: const InputDecoration(),
                            controller: textEditingController,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final String enteredBrowserNumber =
                                textEditingController.text;

                            if (int.tryParse(enteredBrowserNumber) == null) {
                              return;
                            }

                            browserNumber = int.parse(enteredBrowserNumber);
                          },
                          child: const Text("입력"),
                        ),
                        const ActionButtons(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < data.length; i += 5)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int j = i;
                                    j < i + 5 && j < data.length;
                                    j++)
                                  Expanded(
                                    child: Wrap(
                                      // alignment: WrapAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: GestureDetector(
                                            onTap: () {
                                              popupAndModify.showEditDialog(
                                                context,
                                                data[j].blogTitle,
                                                data[j].id,
                                                data[j].blogType ?? "null",
                                              );
                                              setState(() {});
                                            },
                                            child: SizedBox(
                                              width: 200,
                                              child: Text(
                                                "${documentNumber++}.${data[j].blogTitle}",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async =>
                                              copyAndDel.copyAndInputData(
                                            browserNumber,
                                            context,
                                            data[j].blogTitle,
                                          ),
                                          style: IconStyle.getButtonStyle(
                                              data[j].blogType.toString()),
                                          child: const Text("+"),
                                        ),
                                        const SizedBox(width: 16),

                                        // 각 아이템 사이의 간격을 조절합니다.
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    )
                  ],
                );
              },
              error: (error, stackTrace) => Text("Error: $error"),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
