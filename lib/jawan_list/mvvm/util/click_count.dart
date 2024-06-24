// click_counter.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ClickCounter {
  final FirebaseFirestore firestore;

  ClickCounter(this.firestore);

  Future<void> incrementClickCount(String blogTitle) async {
    final querySnapshot = await firestore
        .collection('blog')
        .where('blogTitle', isEqualTo: blogTitle)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print('블로그 문서를 찾을 수 없습니다.');
      return;
    }

    final blogDoc = querySnapshot.docs[0];
    final blogDocRef = firestore.collection('blog').doc(blogDoc.id);
    final clicksCollection = blogDocRef.collection('clicks');

    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final clickDocRef = clicksCollection.doc(today);

    await firestore.runTransaction((transaction) async {
      final clickDoc = await transaction.get(clickDocRef);

      if (clickDoc.exists) {
        final newCount = (clickDoc.data()!['itemCount'] as int) + 1;
        transaction.update(clickDocRef, {'itemCount': newCount});
      } else {
        transaction.set(clickDocRef, {'itemCount': 1});
      }
    });

    print('클릭 수가 성공적으로 업데이트되었습니다.');
  }
}
