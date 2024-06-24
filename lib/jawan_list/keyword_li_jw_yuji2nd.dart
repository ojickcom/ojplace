import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/jawan_list/mvvm/copy_input_db2.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/jawan_list/mvvm/util/button_color.dart';
import 'package:ojplace/jawan_list/mvvm/util/first_row.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_modify.dart';

class JawanYuji2nd extends ConsumerStatefulWidget {
  const JawanYuji2nd({super.key});

  @override
  ConsumerState<JawanYuji2nd> createState() => _BlogStayState();
}

class _BlogStayState extends ConsumerState<JawanYuji2nd> {
  int browserNumber = 1;

  @override
  Widget build(
    BuildContext context,
  ) {
// 팝업창 띄우기
    final blogs = ref.watch(jawanYuji2ndProvider);
    final copyAndDel = CopyAndInputdataProvider2();
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
                final definedData = data.toList();
                return Column(
                  children: [
                    const Row(
                      children: [
                        ActionButtons(),
                      ],
                    ),
                    //한 행에 3개씩 정렬하기
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < definedData.length; i += 5)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int j = i;
                                    j < i + 5 && j < definedData.length;
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
                                                definedData[j].blogTitle,
                                                definedData[j].id,
                                                data[j].blogType ?? "null",
                                              );
                                            },
                                            child: SizedBox(
                                              width: 200,
                                              child: Text(
                                                "${documentNumber++}.${definedData[j].blogTitle}",
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
                                            definedData[j].blogTitle,
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
