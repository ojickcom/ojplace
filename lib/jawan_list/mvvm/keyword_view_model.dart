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

        // 날짜별 클릭 수 가져오기
        final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final clicksCollection = doc.reference.collection('clicks');
        final clickDoc = await clicksCollection.doc(today).get();

        // 필드 존재 여부 확인 후 클릭 수 가져오기
        final int itemCount =
            clickDoc.exists && clickDoc.data()!.containsKey('itemCount')
                ? clickDoc.get('itemCount') as int
                : 0;

        // KeywordModel 초기화 및 itemCount 설정
        KeywordModel keyword =
            KeywordModel.fromJson(doc.data()! as Map<String, dynamic>, id: id)
                .copyWith(itemCount: itemCount);
        blogs.add(keyword);
      }

      return blogs;
    } catch (e) {
      // print("Error: $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> mkJawan1st() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "자완초입");
      QuerySnapshot querySnapshot = await query
          // .orderBy('timestamp', descending: true)
          .where(
            "blogId",
          )
          .get();
      List<KeywordModel> blogStart = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogStart.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogStart;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> jawan2ndProvider() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "자완초입");
      QuerySnapshot querySnapshot = await query.get();

      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        final String? blogTitle = data['blogTitle'] as String?;
        if (blogTitle != null) {
          // Split the blogTitle to remove the last word
          List<String> splitTitle = blogTitle.split(' ');
          if (splitTitle.length > 1) {
            splitTitle.removeLast(); // Remove the last word
          }

          // Join the remaining words back into a string
          String modifiedTitle = splitTitle.join(' ');

          // Update the data locally
          data['blogTitle'] = modifiedTitle;
        }

        blogs.add(KeywordModel.fromJson(data, id: id));
      }
      return blogs;
    } catch (e) {
      // Handle error
      print("Error: $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> jawanYuji1stProvider() async {
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

  Future<List<KeywordModel>> eventProvider() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .where("blogGroup", isEqualTo: "event")
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

  Future<List<KeywordModel>> jawanYuji2ndProvider() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "자완유지용");
      QuerySnapshot querySnapshot = await query.get();

      List<KeywordModel> blogs = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        final String? blogTitle = data['blogTitle'] as String?;
        if (blogTitle != null) {
          // Split the blogTitle to remove the last word
          List<String> splitTitle = blogTitle.split(' ');
          if (splitTitle.length > 1) {
            splitTitle.removeLast(); // Remove the last word
          }

          // Join the remaining words back into a string
          String modifiedTitle = splitTitle.join(' ');

          // Update the data locally
          data['blogTitle'] = modifiedTitle;
        }

        blogs.add(KeywordModel.fromJson(data, id: id));
      }
      return blogs;
    } catch (e) {
      // Handle error
      print("Error: $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> placeProvider1() async {
    try {
      final query =
          firestore.collection("blog").where("blogGroup", isEqualTo: "플레이스용");
      QuerySnapshot querySnapshot = await query
          .where(
            "blogId",
          )
          .get();
      List<KeywordModel> blogStart = [];

      for (var doc in querySnapshot.docs) {
        final String id = doc.id;
        blogStart.add(KeywordModel.fromJson(
            doc.data()! as Map<String, dynamic>? ?? {},
            id: id));
      }
      return blogStart;
    } catch (e) {
      // print(" Erro : $e");
      rethrow;
    }
  }

  Future<List<KeywordModel>> newKeywordProvier() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .where("blogGroup", isEqualTo: "신규")
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

  Future<List<KeywordModel>> standbyProvier() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("blog")
          .where("blogGroup", isEqualTo: "대기")
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

final mkJawan1stProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).mkJawan1st();
});
final jawan2ndProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).jawan2ndProvider();
});
final jawanYuji1stProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).jawanYuji1stProvider();
});
final jawanYuji2ndProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).jawanYuji2ndProvider();
});
final placeProvider1 = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).placeProvider1();
});
final placeProvider2 = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).placeProvider1();
});
final newKeywordProvier = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).newKeywordProvier();
});
final standbyProvier = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).standbyProvier();
});
final eventProvider = FutureProvider<List<KeywordModel>>((ref) async {
  return ref.read(blogViewModelProvider.notifier).eventProvider();
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
