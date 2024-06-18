import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mvvm/copy_input_data.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/jawan_list/mvvm/util/button_color.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_modify.dart';

class JawanYuji extends ConsumerStatefulWidget {
  const JawanYuji({super.key});

  @override
  ConsumerState<JawanYuji> createState() => _BlogStayState();
}

class _BlogStayState extends ConsumerState<JawanYuji> {
  int browserNumber = 1;
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  void getUserEmail() {
    User? user = auth.currentUser;
    if (user != null) {
      userEmail = user.email ?? ''; // 사용자의 이메일을 userEmail 변수에 저장합니다.
    } else {
      print('현재 로그인된 사용자가 없습니다.');
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
// 팝업창 띄우기
    final blogs = ref.watch(blogStayProvider);
    final TextEditingController textEditingController = TextEditingController();
    final copyAndDel = CopyAndInputdataProvider();
    final popupAndModify = ref.watch(popupAndModifyProvider);

//본문 시작 됨
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1024,
          child: Center(
            child: blogs.when(
              data: (data) {
                int documentNumber = 1;
                final definedData = data.toList();
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: TextField(
                            decoration: const InputDecoration(),
                            controller: textEditingController,
                          ),
                        ),
                        //매크로에서 browserNumber 받아
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
                        Gaps.h20,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 161, 8, 221)),
                          child: const Text(
                            "첫페이지",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 180, 133, 2)),
                          child: const Text(
                            "지정블로그",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 221, 207, 8)),
                          child: const Text(
                            "지정웹문서",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text(
                            "랜덤블로그",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 16, 141, 80)),
                          child: const Text(
                            "플레이스",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        Text(userEmail),
                        Gaps.h10,
                      ],
                    ),
                    //한 행에 3개씩 정렬하기
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < definedData.length; i += 3)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int j = i;
                                    j < i + 3 && j < definedData.length;
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
                                              copyAndDel.copyAndInputData2(
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
