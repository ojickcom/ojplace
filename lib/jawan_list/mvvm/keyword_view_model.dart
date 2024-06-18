import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_model.dart';
import 'dart:async';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class BlogViewModel extends StateNotifier<List<KeywordModel>> {
  BlogViewModel() : super([]);

  Future<void> addBlog(
    String blogTitle,
    String blogGroup,
    String blogType,
    String keywordStatus,
    context,
  ) async {
    try {
      await firestore.collection("blog").add({
        'blogTitle': blogTitle,
        'blogGroup': blogGroup,
        'blogType': blogType,
        'keywordStatus': keywordStatus,
        "timestamp": FieldValue.serverTimestamp(),
      });
      // refreshCallback();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('추가되었습니다.'),
        ),
      );
    } catch (e) {
      // print(" Erro : $e");
    }
  }

  Future<List<KeywordModel>> keywordListAll() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .orderBy('timestamp', descending: true)
          .get();
      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  // Future<double> getFieldsCountInCollection() async {
  //   try {
  //     QuerySnapshot querySnapshot = await firestore.collection("blog").get();
  //     double totalFieldsCount = 0;

  //     for (var doc in querySnapshot.docs ?? []) {
  //       // Use empty list if null
  //       totalFieldsCount += doc.data().length;
  //     }

  //     return totalFieldsCount;
  //   } catch (e) {
  //     // 예외 처리
  //     rethrow;
  //   }
  // }

  Future<List<KeywordModel>> keywordStart() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "자완초입")
          // .orderBy("date", descending: true)
          ;
      QuerySnapshot querySnapshot = await query.get();
      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> keywordYuji() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .where("blogGroup", isEqualTo: "자완유지용")
          .get();

      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> keywordPlace() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "플레이스용");
      QuerySnapshot querySnapshot = await query
          .where(
            "blogId",
          )
          .get();
      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> keywordDaegi() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "자완초입");
      QuerySnapshot querySnapshot = await query
          .where(
            "blogId",
          )
          .get();

      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<void> deleteBlog(
      String id, context, VoidCallback refreshCallback) async {
    try {
      await firestore.collection("blog").doc(id).delete();
      refreshCallback();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('성공적으로 삭제되었습니다.'),
        ),
      );
    } catch (e) {
      // print("Error: $e");
    }
  }

  Future<void> updateBlog(String id, String title) async {
    try {
      await firestore.collection("blog").doc(id).update({
        "title": title,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // print("Error: $e");
    }
  }

  Future<void> addDate(String id, String startDate) async {
    try {
      await firestore.collection("blog").doc(id).update({
        "startDate": startDate,
      });
    } catch (e) {
      print("Error: $e");
    }
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
}

final blogViewModelProvider =
    StateNotifierProvider<BlogViewModel, List<KeywordModel>>(
        (ref) => BlogViewModel());
final blogListProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).keywordListAll();
});

final blogStayProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).keywordYuji();
});
final blogPlaceProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).keywordPlace();
});

// 타이틀 변경과 삭제 provider
class ModifyTitleNotifier extends ChangeNotifier {
  FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Firestore 인스턴스를 가져옵니다.

  // 제목 클릭시 수정 버튼
  Future<void> modifyBlogTitle(String editedTitle, String id, String blogGroup,
      String blogType, String keywordStatus, context) async {
    try {
      await firestore.collection("blog").doc(id).update({
        "blogTitle": editedTitle,
        "blogGroup": blogGroup,
        "blogType": blogType,
        "keywordStatus": keywordStatus,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('성공적으로 수정되었습니다.'),
        ),
      );
      notifyListeners();
    } catch (e) {
      // print("$e");
    }
  }

  // 블로그 타이틀 삭제
  Future<void> deleteBlogTitle(String id) async {
    try {
      await firestore.collection("blog").doc(id).delete();
      notifyListeners();
    } catch (e) {
      // print("Error: $e");
    }
  }
}

final modifyTitleNotifierProvider =
    ChangeNotifierProvider<ModifyTitleNotifier>((ref) => ModifyTitleNotifier());
