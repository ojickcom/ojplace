import 'package:cloud_firestore/cloud_firestore.dart';

class InputDbProvider {
  static Future<String?> getTargetKeywordType(
      FirebaseFirestore firestore, String blogTitle) async {
    final querySnapshot = await firestore
        .collection("blog")
        .where("blogTitle", isEqualTo: blogTitle)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    return querySnapshot.docs[0].get("blogType") as String?;
  }
}
