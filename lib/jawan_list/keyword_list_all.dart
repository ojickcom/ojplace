import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';
import 'package:ojplace/constants/gaps.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_modify.dart';

class KeywordAll extends ConsumerStatefulWidget {
  const KeywordAll({Key? key}) : super(key: key);

  @override
  ConsumerState<KeywordAll> createState() => _BlogPostingListState();
}

class _BlogPostingListState extends ConsumerState<KeywordAll> {
  @override
  void initState() {
    super.initState();
    // Fetch data on initial load (optional, depending on your needs)
    ref.read(blogViewModelProvider.notifier).keywordListAll();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int? countValue;
  int? priceValue;

  Future<void> count(BuildContext context, int countValue, String id) async {
    try {
      await firestore.collection("blog").doc(id).update({
        "count": countValue,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('누락일이 입력되었습니다.'),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> price(BuildContext context, int priceValue, String id) async {
    try {
      await firestore.collection("blog").doc(id).update({
        "price": priceValue,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('비용이 입력되었습니다.'),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  void showNurakInputDialog(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('누락일 입력'),
          content: TextField(
            keyboardType: TextInputType.number, // 숫자만 입력할 수 있도록 설정
            onChanged: (value) {
              countValue = int.tryParse(value); // 입력된 값이 숫자인지 확인하고 변수에 저장
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 취소 버튼
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 확인 버튼
                if (countValue != null) {
                  count(context, countValue!, id); // count 함수 호출
                  Navigator.of(context).pop(); // 팝업 닫기
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void showPriceInputDialog(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('비용 입력'),
          content: TextField(
            keyboardType: TextInputType.number, // 숫자만 입력할 수 있도록 설정
            onChanged: (value) {
              priceValue = int.tryParse(value); // 입력된 값이 숫자인지 확인하고 변수에 저장
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 취소 버튼
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 확인 버튼
                if (priceValue != null) {
                  price(context, priceValue!, id); // count 함수 호출
                  Navigator.of(context).pop(); // 팝업 닫기
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future<void> editStartDate(BuildContext context, String id) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      try {
        await firestore.collection("blog").doc(id).update({
          "startDate": formattedDate,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('시작일이 수정되었습니다.'),
          ),
        );
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final blogs = ref.watch(blogListProvider);
    final popupAndModify = ref.watch(popupAndModifyProvider);
    int? total; // Declare total as nullable int
    int? startKeyTotal;
    int? yujiKeyTotal;
    int? totalPrice;
    if (blogs.value != null) {
      total = blogs.value!.length;
    }
    if (blogs.value != null) {
      final filteredBlogs =
          blogs.value!.where((blog) => blog.blogGroup == "자완초입").toList();
      startKeyTotal = filteredBlogs.length;
    }
    if (blogs.value != null) {
      final filteredBlogs =
          blogs.value!.where((blog) => blog.blogGroup == "자완유지").toList();
      yujiKeyTotal = filteredBlogs.length;
    }
    if (blogs.value != null) {
      totalPrice = blogs.value!.fold<int>(0, (sum, blog) => sum + (blog.price));
    }

    String formatNumberWithCommas(int number) {
      return number.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
          );
    }

    String formattedDate = DateFormat('yyyy년MM월dd일').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "블로그 포스팅 현황",
          style: TextStyle(color: Colors.deepOrange),
        ),
        centerTitle: true,
        backgroundColor: Colors.black12,
        actions: [
          Column(
            children: [
              Row(
                children: [
                  Text("총키워드: $total",
                      style: const TextStyle(color: Colors.blue)),
                  Gaps.h10,
                  Text("유지 키워드: $yujiKeyTotal",
                      style: const TextStyle(color: Colors.blue)),
                  Gaps.h10,
                  Text("작업중인 키워드: $startKeyTotal",
                      style: const TextStyle(color: Colors.blue)),
                ],
              ),
              Row(
                children: [
                  Text(
                      "매출액: ${totalPrice != null ? formatNumberWithCommas(totalPrice) : "0"}",
                      style: const TextStyle(color: Colors.blue)),
                  Gaps.h10,
                  const Text("미완성 수익: 100,000원",
                      style: TextStyle(color: Colors.blue)),
                  Gaps.h10,
                  Text("날짜: $formattedDate",
                      style: const TextStyle(color: Colors.blue)),
                ],
              ),
            ],
          ),
          Gaps.h96, // Add some spacing between Column and appBar edge
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 1300,
          child: blogs.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final filteredData = data.toList();
                    final blog = filteredData[index];
                    const int daycount = 3;
                    final startDate = DateFormat('yy년MM월dd일')
                        .format(blog.startDate ?? DateTime.now());
                    final oneMonthLater = DateFormat('yy년MM월dd일').format(
                        (blog.startDate ?? DateTime.now())
                            .add(const Duration(days: 30 + daycount)));
                    return Column(children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              popupAndModify.showEditDialog(
                                context,
                                blog.blogTitle,
                                blog.id,
                                blog.blogType ?? "null",
                                // blog.keywordStatus,
                              );
                            },
                            child: SizedBox(
                                width: 300,
                                child: Text(
                                  "<${blog.blogTitle}>",
                                  overflow: TextOverflow.ellipsis,
                                  // style: const TextStyle(),
                                )),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: blog.blogTitle),
                              );
                            },
                            child: const Text("복사"),
                          ),
                          Gaps.h14,
                          SizedBox(
                            width: 260,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "주문: $startDate",
                                    ),
                                    Gaps.h10,
                                    GestureDetector(
                                      onTap: () {
                                        showNurakInputDialog(context, blog.id);
                                      },
                                      child: Text(
                                        "누락일: ${blog.itemCount}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        editStartDate(context, blog.id);
                                      },
                                      child: Text(
                                        "시작: $startDate",
                                        style: const TextStyle(
                                            color: Colors.orange),
                                      ),
                                    ),
                                    Gaps.h10,
                                    Text(
                                      "결재: $oneMonthLater",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gaps.h36,
                          SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "거래처:메이저 플레이",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showPriceInputDialog(context, blog.id);
                                    },
                                    child: Text(
                                        "비용:${NumberFormat("#,##0").format(blog.price)}")),
                              ],
                            ),
                          ),
                          Gaps.h14,
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "그룹:${blog.blogGroup}",
                                  style: const TextStyle(color: Colors.amber),
                                ),
                                Text("타겟:${blog.blogType} "),
                              ],
                            ),
                          ),
                          Gaps.h14,
                          SizedBox(
                            width: 130,
                            child: Text(
                              "타겟:${blog.blogType}  ",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          Gaps.h14,
                          SizedBox(
                            width: 50,
                            child: Text("칸트:${blog.itemCount} "),
                          ),
                          Gaps.h14,
                          ElevatedButton(
                              onPressed: () async {
                                String id = blog.id;
                                await ref
                                    .read(blogViewModelProvider.notifier)
                                    .deleteBlog(
                                  id,
                                  context,
                                  () {
                                    ref.refresh(blogListProvider); // 새로 고침 콜백
                                  },
                                );
                              },
                              child: const Text("삭제")),
                        ],
                      ),
                      Gaps.v8,
                    ]);
                  });
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text("Error: $error"),
          ),
        ),
      ),
    );
  }
}
