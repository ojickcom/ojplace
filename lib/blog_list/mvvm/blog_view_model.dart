import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/blog_list/mvvm/blog_model.dart';
import 'dart:async';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class BlogViewModel extends StateNotifier<List<BlogModel>> {
  BlogViewModel() : super([]);

  Future<void> addBlog(
    String blogTitle,
    String blogContent,
    String blogGroup,
    blogOrder,
    blogId,
    String blogType,
  ) async {
    try {
      await firestore.collection("blog").add({
        'blogTitle': blogTitle,
        'blogContent': blogContent,
        'blogGroup': blogGroup,
        'blogOrder': blogOrder,
        'blogId': blogId,
        'blogType': blogType,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // print(" Erro : $e");
    }
  }

  Future<List<BlogModel>> blogList() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .orderBy('timestamp', descending: true)
          .get();
      List<BlogModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(BlogModel.fromJson(doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<BlogModel>> blogList1() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "자완초입");
      QuerySnapshot querySnapshot = await query.get();
      List<BlogModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(BlogModel.fromJson(doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<BlogModel>> blogList2() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .where("blogGroup", isEqualTo: "자완유지용")
          .get();

      List<BlogModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(BlogModel.fromJson(doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogs;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<BlogModel>> blogList3() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "플레이스용");
      QuerySnapshot querySnapshot = await query
          .where(
            "blogId",
          )
          .get();
      List<BlogModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogs.add(BlogModel.fromJson(doc.data()! as Map<String, dynamic>? ?? {},
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
}

final blogViewModelProvider =
    StateNotifierProvider<BlogViewModel, List<BlogModel>>(
        (ref) => BlogViewModel());
final blogListProvider = FutureProvider<List<BlogModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).blogList1();
});
final blogStayProvider = FutureProvider<List<BlogModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).blogList2();
});
final blogPlaceProvider = FutureProvider<List<BlogModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).blogList3();
});

// 타이틀 변경과 삭제 provider
class ModifyTitleNotifier extends ChangeNotifier {
  FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Firestore 인스턴스를 가져옵니다.

  // 제목 클릭시 수정 버튼
  Future<void> modifyBlogTitle(
      String editedTitle, String id, String blogGroup, String blogType) async {
    try {
      await firestore.collection("blog").doc(id).update({
        "blogTitle": editedTitle,
        "blogGroup": blogGroup,
        "blogType": blogType,
      });
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
