import 'package:ojplace/blog/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlogRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final blogTitle = "";

  Future<void> blogWrighting(BlogModel blogWrighting) async {
    await _db.collection("blogWrighting").doc().set(
      {
        blogTitle: blogWrighting.toJson(),
        // "blogWrighting": blogWrighting.targetKeywords
      },
    );
  }
}

final blogWrightingRepo = Provider<BlogRepo>(
  (ref) => BlogRepo(),
);
