import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/jawan_list/mvvm/copy_input_db1.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/jawan_list/mvvm/util/button_color.dart';
import 'package:ojplace/jawan_list/mvvm/util/first_row.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_modify.dart';

class MkJawan1st extends ConsumerStatefulWidget {
  const MkJawan1st({super.key});

  @override
  ConsumerState<MkJawan1st> createState() => _BlogListPlaceState();
}

class _BlogListPlaceState extends ConsumerState<MkJawan1st> {
  int browserNumber = 1;

  @override
  Widget build(
    BuildContext context,
  ) {
    final blogs = ref.watch(mkJawan1stProvider);
    final copyAndDel = CopyAndInputdataProvider1();
    final popupAndModify = ref.watch(popupAndModifyProvider);
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1500,
          child: Center(
            child: blogs.when(
              data: (data) {
                int documentNumber = 1;

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
                    //한 행에 3개씩 정렬하기
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
                                          onPressed: () async {
                                            // print(
                                            //     "browserNumber: $browserNumber"); // 디버깅 로그 추가
                                            await copyAndDel.copyAndInputData(
                                              browserNumber,
                                              context,
                                              data[j].blogTitle,
                                            );
                                          },
                                          style: IconStyle.getButtonStyle(
                                              data[j].blogType.toString()),
                                          child: const Text("+"),
                                        ),
                                        const SizedBox(width: 16),
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
