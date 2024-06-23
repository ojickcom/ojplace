import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_color.dart';
import 'package:ojplace/jawan_list/mvvm/util/user_select.dart';

class CopyAndInputdataProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserClass userClass = UserClass();

  Future<String?> targetKeywordType(String blogTitle) async {
    final query = FirebaseFirestore.instance
        .collection("blog")
        .where("blogTitle", isEqualTo: blogTitle)
        .limit(1);
    final querySnapshot = await query.get();
    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    final docSnapshot = querySnapshot.docs[0];
    return docSnapshot.get("blogType") as String?;
  }

  Future<void> copyAndInputData1(
    int browserNumber,
    BuildContext context,
    String blogTitle,
  ) async {
    await Clipboard.setData(ClipboardData(text: blogTitle));
    final CollectionReference? webBrowserCollection =
        userClass.getUserWebBrowserCollection();
    if (webBrowserCollection != null) {
      try {
        final docSnapshot =
            await webBrowserCollection.doc(browserNumber.toString()).get();
        int count = 0;

// Check if the document exists and has a "count" field using null-conditional operator
        if (docSnapshot.exists &&
            (docSnapshot.data() as Map?)?.containsKey('count') == true) {
          // Get the existing count value
          count = docSnapshot.get('count') as int;
        } else {
          // Create the "count" field with a value of 1
          count = 1;
        }

        final List<String> uids = docSnapshot.get('uid')?.cast<String>() ?? [];
        final bool uidExists = uids.contains(blogTitle);

        if (!uidExists) {
          await webBrowserCollection.doc(docSnapshot.id).update(
            {
              'uid': FieldValue.arrayUnion([blogTitle]),
              'count': FieldValue.increment(1)
            },
          );
          final String? blogType = await targetKeywordType(blogTitle);
          final PopupStyle popupStyle = PopupStyle.fromBlogType(blogType ?? "");
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: popupStyle.backgroundColor,
              title: Text(
                popupStyle.titleText,
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      const Text("확인", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red,
              title: const Text("중복 됨"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("확인"),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print("$e");
      }
    } else {
      print("CollectionReference 가져오기 실패");
    }
  }

  Future<void> copyAndInputData2(
    int browserNumber,
    BuildContext context,
    String blogTitle,
  ) async {
    await Clipboard.setData(ClipboardData(text: blogTitle));
    final CollectionReference? webBrowserCollection =
        userClass.getUserWebBrowserCollection2();
    if (webBrowserCollection != null) {
      try {
        final docSnapshot =
            await webBrowserCollection.doc(browserNumber.toString()).get();
        int count = 0;

// Check if the document exists and has a "count" field using null-conditional operator
        if (docSnapshot.exists &&
            (docSnapshot.data() as Map?)?.containsKey('count') == true) {
          // Get the existing count value
          count = docSnapshot.get('count') as int;
        } else {
          // Create the "count" field with a value of 1
          count = 1;
        }

        final List<String> uids = docSnapshot.get('uid')?.cast<String>() ?? [];
        final bool uidExists = uids.contains(blogTitle);

        if (!uidExists) {
          await webBrowserCollection.doc(docSnapshot.id).update(
            {
              'uid': FieldValue.arrayUnion([blogTitle]),
              'count': FieldValue.increment(1)
            },
          );
          final String? blogType = await targetKeywordType(blogTitle);
          final PopupStyle popupStyle = PopupStyle.fromBlogType(blogType ?? "");
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: popupStyle.backgroundColor,
              title: Text(
                popupStyle.titleText,
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      const Text("확인", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red,
              title: const Text("중복 됨"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("확인"),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print("$e");
      }
    } else {
      print("CollectionReference 가져오기 실패");
    }
  }

  Future<void> copyAndInputData3(
    int browserNumber,
    BuildContext context,
    String blogTitle,
  ) async {
    await Clipboard.setData(ClipboardData(text: blogTitle));
    final CollectionReference? webBrowserCollection =
        userClass.getUserWebBrowserCollection3();
    if (webBrowserCollection != null) {
      try {
        final docSnapshot =
            await webBrowserCollection.doc(browserNumber.toString()).get();
        int count = 0;

// Check if the document exists and has a "count" field using null-conditional operator
        if (docSnapshot.exists &&
            (docSnapshot.data() as Map?)?.containsKey('count') == true) {
          // Get the existing count value
          count = docSnapshot.get('count') as int;
        } else {
          // Create the "count" field with a value of 1
          count = 1;
        }

        final List<String> uids = docSnapshot.get('uid')?.cast<String>() ?? [];
        final bool uidExists = uids.contains(blogTitle);

        if (!uidExists) {
          await webBrowserCollection.doc(docSnapshot.id).update(
            {
              'uid': FieldValue.arrayUnion([blogTitle]),
              'count': FieldValue.increment(1)
            },
          );
          final String? blogType = await targetKeywordType(blogTitle);
          final PopupStyle popupStyle = PopupStyle.fromBlogType(blogType ?? "");
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: popupStyle.backgroundColor,
              title: Text(
                popupStyle.titleText,
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      const Text("확인", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red,
              title: const Text("중복 됨"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("확인"),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print("$e");
      }
    } else {
      print("CollectionReference 가져오기 실패");
    }
  }
}
