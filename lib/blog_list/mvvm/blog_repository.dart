import 'package:ojplace/blog_list/mvvm/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlogRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final blogTitle = "";
  Future<void> addBlogPosting(BlogModel blogPosting) async {
    await _db.collection("blogPosting").doc().set(
      {
        blogTitle: blogPosting.toJson(),
        // "blogPosting": blogPosting.targetKeywords
      },
    );
  }
}

final blogPostingRepo = Provider<BlogRepository>(
  (ref) => BlogRepository(),
);
