import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/blog_list/mvvm/blog_view_model.dart';

class WebBrowser {
  int number;
  // String blogUid;

  WebBrowser({
    required this.number,
    // required this.blogUid,
  });
}

class MKWebBrowser extends StateNotifier<WebBrowser> {
  MKWebBrowser()
      : super(WebBrowser(
          number: 1,
        ));
  Future<void> mkBrowser1(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        await firestore.collection("autoKeyword1").doc("$i").set({"uid": []});
      }
    } catch (e) {}
  }

  Future<void> mkBrowser2(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        firestore.collection("autoKeyword2").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser3(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        firestore.collection("autoKeyword3").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser1(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        firestore.collection("autoKeepKeyword01").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser2(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        firestore.collection("autoKeepKeyword02").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser3(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        firestore.collection("autoKeepKeyword03").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkPlaceBrowser1(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        await firestore.collection("place01").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkPlaceBrowser2(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 91; i++) {
        await firestore.collection("place02").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }
}

final mkWebBrowserProvider = StateNotifierProvider<MKWebBrowser, WebBrowser>(
  (ref) => MKWebBrowser(),
);
