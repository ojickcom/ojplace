import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/blog_list/mvvm/blog_view_model.dart';

class CopyAndDelProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // Future<int> getUidCount() async {
  //   final docRef = firestore.collection("autoKeyword1").doc("1");
  //   final doc = await docRef.get();
  //   final uidList = doc.get("uid");
  //   return uidList.length;
  // }

  Future<void> copyAndDel(
    int browserNumber,
    BuildContext context,
    String blogtitle,
  ) async {
    await Clipboard.setData(ClipboardData(text: blogtitle));
    final CollectionReference webBrowserCollection =
        _getUserWebBrowserCollection();
    try {
      final docSnapshot =
          await webBrowserCollection.doc(browserNumber.toString()).get();
      int count = 0;

// Check if the document exists and has a "count" field using null-conditional operator
      if (docSnapshot.exists &&
          (docSnapshot.data() as Map?)?.containsKey('count') == true) {
        // Get the existing count value
        count = docSnapshot.get('count') as int;
      } else {
        // Create the "count" field with a value of 1
        count = 1;
      }

      final List<String> uids = docSnapshot.get('uid')?.cast<String>() ?? [];
      final bool uidExists = uids.contains(blogtitle);
      if (!uidExists) {
        await webBrowserCollection.doc(docSnapshot.id).update(
          {
            'uid': FieldValue.arrayUnion([blogtitle]),
            'count': FieldValue.increment(1)
          },
        );
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text("추가 됨", style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red,
            title: const Text("중복 됨"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("$e");
    }
  }

  CollectionReference _getUserWebBrowserCollection() {
    final User? user = auth.currentUser;
    late CollectionReference webBrowserCollection;
    if (user != null) {
      if (user.email == "zegalang@naver.com") {
        webBrowserCollection = firestore.collection("autoKeyword1");
      } else if (user.email == "ojick@ojick.com") {
        webBrowserCollection = firestore.collection("autoKeyword2");
      } else if (user.email == "zegalang@daum.net") {
        webBrowserCollection = firestore.collection("autoKeyword3");
      } else {
        print("사용자 인증 오류");
      }
    }
    return webBrowserCollection;
  }

  Future<void> copyAndDel2(
    int browserNumber,
    BuildContext context,
    String blogtitle,
  ) async {
    await Clipboard.setData(ClipboardData(text: blogtitle));
    final CollectionReference webBrowserCollection =
        _getUserWebBrowserCollection();
    try {
      final docSnapshot =
          await webBrowserCollection.doc(browserNumber.toString()).get();
      int count = 0;

// Check if the document exists and has a "count" field using null-conditional operator
      if (docSnapshot.exists &&
          (docSnapshot.data() as Map?)?.containsKey('count') == true) {
        // Get the existing count value
        count = docSnapshot.get('count') as int;
      } else {
        // Create the "count" field with a value of 1
        count = 1;
      }

      final List<String> uids = docSnapshot.get('uid')?.cast<String>() ?? [];
      final bool uidExists = uids.contains(blogtitle);
      if (!uidExists) {
        await webBrowserCollection.doc(docSnapshot.id).update(
          {
            'uid': FieldValue.arrayUnion([blogtitle]),
            'count': FieldValue.increment(1)
          },
        );
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text("추가 됨", style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red,
            title: const Text("중복 됨"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("확인"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("$e");
    }
  }

  CollectionReference _getUserWebBrowserCollection2() {
    final User? user = auth.currentUser;
    late CollectionReference webBrowserCollection;
    if (user != null) {
      if (user.email == "zegalang@naver.com") {
        webBrowserCollection = firestore.collection("autoKeepKeyword01");
      } else if (user.email == "ojick@ojick.com") {
        webBrowserCollection = firestore.collection("autoKeepKeyword02");
      } else if (user.email == "zegalang@daum.net") {
        webBrowserCollection = firestore.collection("autoKeepKeyword03");
      } else {
        print("사용자 인증 오류");
      }
    }
    return webBrowserCollection;
  }
}

class PopupAndModify extends ChangeNotifier {
  final ModifyTitleNotifier viewModel;
  PopupAndModify(this.viewModel);

  Future<void> modifyTitle(BuildContext context, String blogTitle, String id,
      String blogGroup, String blogType) async {
    await viewModel.modifyBlogTitle(blogTitle, id, blogGroup, blogType);
    notifyListeners();
  }

  Future<void> deleteBlogTitle(String id) async {
    await viewModel.deleteBlogTitle(id); // 블로그 타이틀을 삭제합니다.
  }

  void showEditDialog(context, String blogTitle, String id, String blogType) {
    final titleController = TextEditingController(text: blogTitle);
    String blogTypeController = "자완유지";
    String selectedValue = "자완유지";
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
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: const Text('지정블',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            )),
                        value: "지정블로그",
                        groupValue: blogTypeController,
                        onChanged: (value) {
                          setState(() {
                            blogTypeController = value as String;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        title: const Text('랜덤블',
                            style: TextStyle(
                              color: Colors.orange,
                            )),
                        value: "랜덤블로그",
                        groupValue: blogTypeController,
                        onChanged: (value) {
                          setState(() {
                            blogTypeController = value as String;
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
                              color: Colors.green,
                            )),
                        value: "플레이스",
                        groupValue: blogTypeController,
                        onChanged: (value) {
                          setState(() {
                            blogTypeController = value as String;
                          });
                        },
                      ),
                    ),
                  ]),
                  // 라디오 버튼 추가
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('자완초입'),
                          value: "자완초입",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('자완유지'),
                          value: "자완유지용",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: const Text('플레이스'),
                          value: "플레이스용",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
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
                    final String blogGroup = selectedValue;
                    final String blogType = blogTypeController;
                    await viewModel.modifyBlogTitle(
                        editedTitle, id, blogGroup, blogType);
                    Navigator.pop(context);
                    setState(() {});
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
