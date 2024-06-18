import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/constants/sizes.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/constants/color_scheme.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mvvm/util/web_db.dart';

class BlogAdd extends ConsumerStatefulWidget {
  const BlogAdd({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogAdd> createState() => _BlogAddState();
}

class _BlogAddState extends ConsumerState<BlogAdd> {
  String keywordGroupRadio = "자완초입";
  String keywordClickTypeRadio = "지정블로그";
  String keywordStatusRadio = "신규";
  final TextEditingController keywordInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final blogViewModel = ref.watch(blogViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("블로그 글쓰기"),
      ),
      body: Center(
        child: SizedBox(
          width: 1024,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Gaps.v28,
                Center(
                  child: Row(children: [
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
                      width: 170,
                      child: RadioListTile(
                        title: const Text('지정블로그',
                            style: TextStyle(
                              color: Colors.blue,
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
                      width: 170,
                      child: RadioListTile(
                        title: const Text('랜덤블로그',
                            style: TextStyle(
                              color: Colors.orange,
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
                      width: 190,
                      child: RadioListTile(
                        title: const Text('플레이스_클릭',
                            style: TextStyle(
                              color: Colors.green,
                            )),
                        value: "플레이스_클릭",
                        groupValue: keywordClickTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            keywordClickTypeRadio = value as String;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 170,
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
                        width: 170,
                        child: RadioListTile(
                          title: const Text('자완유지용'),
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
                        width: 200,
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
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: myColorScheme.primary),
                        onPressed: () async {
                          final String blogTitle = keywordInputController.text;
                          final String keywordClickType = keywordClickTypeRadio;
                          final String keywordGroup = keywordGroupRadio;
                          final String keywordStatus = keywordStatusRadio;
                          if (keywordInputController.text.isEmpty) {
                            return;
                          }
                          try {
                            await ref
                                .read(blogViewModelProvider.notifier)
                                .addBlog(
                                  blogTitle,
                                  keywordGroup,
                                  keywordClickType,
                                  keywordStatus,
                                  context,
                                );
                          } catch (e) {
                            print("Erro $e");
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
                Center(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: RadioListTile(
                          title: const Text('신규'),
                          value: "신규",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: RadioListTile(
                          title: const Text('누락'),
                          value: "누락",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: RadioListTile(
                          title: const Text('완성'),
                          value: "완성",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('완성초기'),
                          value: "완성초기",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: RadioListTile(
                          title: const Text('유지중'),
                          value: "유지중",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: RadioListTile(
                          title: const Text('작업중'),
                          value: "작업중",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: RadioListTile(
                          title: const Text('자완이력있음'),
                          value: "자완이력있음",
                          groupValue: keywordStatusRadio,
                          onChanged: (value) {
                            setState(() {
                              keywordStatusRadio = value as String;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: keywordInputController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: '자동완성 키워드',
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
                  onChanged: (blogTitle) {},
                ),
                Gaps.v20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
