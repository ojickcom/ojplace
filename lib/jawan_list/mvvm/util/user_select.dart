import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserClass {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Map<String, String> userCollectionMap = {
    "zegalang@naver.com": "autoKeyword1",
    "ojick@ojick.com": "autoKeyword2",
    "zegalang@daum.net": "autoKeyword3",
    "yulpung@naver.com": "autoKeyword4",
    "ojick01@ojick.com": "autoKeyword5",
    "dream01@dream.com": "autoKeyword6",
    "dream02@dream.com": "autoKeyword7",
    "dream03@dream.com": "autoKeyword8",
    "dream04@dream.com": "autoKeyword9",
    "dream05@dream.com": "autoKeyword10",
  };
  final Map<String, String> userCollectionMap2 = {
    "zegalang@naver.com": "autoKeepKeyword01",
    "ojick@ojick.com": "autoKeepKeyword02",
    "zegalang@daum.net": "autoKeepKeyword03",
    "yulpung@naver.com": "autoKeepKeyword04",
    "ojick01@ojick.com": "autoKeepKeyword05",
    "dream01@dream.com": "autoKeepKeyword06",
    "dream02@dream.com": "autoKeepKeyword07",
    "dream03@dream.com": "autoKeepKeyword08",
    "dream04@dream.com": "autoKeepKeyword09",
    "dream05@dream.com": "autoKeepKeyword10",
  };
  final Map<String, String> userCollectionMap3 = {
    "zegalang@naver.com": "place01",
    "ojick@ojick.com": "place02",
    "zegalang@daum.net": "place03",
    "yulpung@naver.com": "place04",
    "ojick01@ojick.com": "place05",
    "dream01@dream.com": "place06",
    "dream02@dream.com": "place07",
    "dream03@dream.com": "place08",
    "dream04@dream.com": "place09",
    "dream05@dream.com": "place010",
  };
  CollectionReference? getUserWebBrowserCollection() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String? collectionName = userCollectionMap[user.email];
      if (collectionName != null) {
        return _firestore.collection(collectionName);
      } else {
        print("사용자 인증 오류: 해당하는 컬렉션을 찾을 수 없습니다.");
        return null;
      }
    } else {
      print("사용자 인증 오류: 사용자가 로그인되어 있지 않습니다.");
      return null;
    }
  }

  CollectionReference? getUserWebBrowserCollection2() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String? collectionName = userCollectionMap2[user.email];
      if (collectionName != null) {
        return _firestore.collection(collectionName);
      } else {
        print("사용자 인증 오류: 해당하는 컬렉션을 찾을 수 없습니다.");
        return null;
      }
    } else {
      print("사용자 인증 오류: 사용자가 로그인되어 있지 않습니다.");
      return null;
    }
  }

  CollectionReference? getUserWebBrowserCollection3() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String? collectionName = userCollectionMap3[user.email];
      if (collectionName != null) {
        return _firestore.collection(collectionName);
      } else {
        print("사용자 인증 오류: 해당하는 컬렉션을 찾을 수 없습니다.");
        return null;
      }
    } else {
      print("사용자 인증 오류: 사용자가 로그인되어 있지 않습니다.");
      return null;
    }
  }
}
