import 'package:ojplace/jawan_list/mvvm/keyword_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class keywordRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final blogTitle = "";
  Future<void> addBlogPosting(KeywordModel blogPosting) async {
    await _db.collection("blogPosting").doc().set(
      {
        blogTitle: blogPosting.toJson(),
        // "blogPosting": blogPosting.targetKeywords
      },
    );
  }
}

final blogPostingRepo = Provider<keywordRepository>(
  (ref) => keywordRepository(),
);
