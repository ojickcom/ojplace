import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/jawan_list/mvvm/keyword_view_model.dart';

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
      for (int i = 1; i < 101; i++) {
        await firestore.collection("autoKeyword1").doc("$i").set({"uid": []});
      }
    } catch (e) {}
  }

  Future<void> mkBrowser2(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
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
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword3").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser4(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword4").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser5(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword5").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser6(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword6").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser7(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword7").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser8(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword8").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser9(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword9").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkBrowser10(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeyword10").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser1(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
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
      for (int i = 1; i < 101; i++) {
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
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword03").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser4(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword04").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser5(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword05").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser6(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword06").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser7(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword07").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser8(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword08").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser9(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword09").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkStayBrowser10(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
        firestore.collection("autoKeepKeyword10").doc("$i").set({"uid": []});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> mkPlaceBrowser1(
    List webBrowser,
  ) async {
    try {
      for (int i = 1; i < 101; i++) {
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
      for (int i = 1; i < 101; i++) {
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
