import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/constants/sizes.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';

class PopupAndModify extends ChangeNotifier {
  final ModifyTitleNotifier viewModel;
  PopupAndModify(this.viewModel);

  Future<void> modifyTitle(BuildContext context, String blogTitle, String id,
      String keywordGroupRadio, String blogType, String keywordStatus) async {
    await viewModel.modifyBlogTitle(
        blogTitle, id, keywordGroupRadio, blogType, keywordStatus, context);
    notifyListeners();
  }

  Future<void> deleteBlogTitle(String id) async {
    await viewModel.deleteBlogTitle(id); // 블로그 타이틀을 삭제합니다.
  }

  void showEditDialog(context, String blogTitle, String id, String blogType) {
    final titleController = TextEditingController(text: blogTitle);
    String keywordClickTypeRadio = "지정블로그";
    String keywordGroupRadio = "자완초입";
    String keywordStatusRadio = "신규";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('제목 수정'),
              content: Column(
                mainAxisSize: MainAxisSize.min, // 박스 크기 조절
                children: [
                  TextField(
                    controller: titleController,
                  ),
                  Row(children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        "•클릭위치:",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: Sizes.size18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: const Text('첫페이지',
                            style: TextStyle(
                              color: Color.fromARGB(255, 161, 8, 221),
                            )),
                        value: "첫페이지",
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 175,
                      child: RadioListTile(
                        title: const Text('지정블로그',
                            style: TextStyle(
                              color: Color.fromARGB(255, 2, 98, 177),
                            )),
                        value: "지정블로그",
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: RadioListTile(
                        title: const Text('지정웹문서',
                            style: TextStyle(
                              color: Color.fromARGB(255, 16, 141, 80),
                            )),
                        value: "지정웹문서",
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 175,
                      child: RadioListTile(
                        title: const Text('랜덤블로그',
                            style: TextStyle(
                              color: Color.fromARGB(255, 165, 100, 3),
                            )),
                        value: "랜덤블로그",
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: const Text('플레이스',
                            style: TextStyle(
                              color: Color.fromARGB(255, 16, 141, 80),
                            )),
                        value: "플레이스",
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                        },
                      ),
                    ),
                  ]),
                  // 라디오 버튼 추가
                  Row(
                    children: [
                      const SizedBox(
                        width: 80,
                        child: Text(
                          "•그룹:",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: Sizes.size18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('자완초입'),
                          value: "자완초입",
                          groupValue: keywordGroupRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordGroupRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('자완유지'),
                          value: "자완유지용",
                          groupValue: keywordGroupRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordGroupRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('플레이스'),
                          value: "플레이스용",
                          groupValue: keywordGroupRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordGroupRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('대기'),
                          value: "대기",
                          groupValue: keywordGroupRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordGroupRadio = value as String;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    // final editedTitle = titleController.text;
                    await viewModel.deleteBlogTitle(id);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('삭제'),
                ),
                TextButton(
                  onPressed: () async {
                    final editedTitle = titleController.text;
                    final String blogGroup = keywordGroupRadio;
                    final String blogType = keywordClickTypeRadio;
                    final String keywordStatus = keywordStatusRadio;

                    await viewModel.modifyBlogTitle(editedTitle, id, blogGroup,
                        blogType, keywordStatus, context);
                    Navigator.pop(context);
                  },
                  child: const Text('수정'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

final popupAndModifyProvider = ChangeNotifierProvider<PopupAndModify>(
  (ref) => PopupAndModify(
    ref.read(modifyTitleNotifierProvider),
  ), // ModifyTitleNotifier 주입
);
