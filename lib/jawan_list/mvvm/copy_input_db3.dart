import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ojplace/jawan_list/mvvm/util/input_db_vm.dart';
import 'package:ojplace/jawan_list/mvvm/util/popup_color.dart';
import 'package:ojplace/jawan_list/mvvm/util/show_input_dialog.dart';
import 'package:ojplace/jawan_list/mvvm/util/user_select.dart';

class CopyAndInputdataProvider3 {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserClass userClass = UserClass();

  Future<void> copyAndInputData(
      int browserNumber, BuildContext context, String blogTitle) async {
    await Clipboard.setData(ClipboardData(text: blogTitle));
    final CollectionReference? webBrowserCollection =
        userClass.getUserWebBrowserCollection();

    if (webBrowserCollection == null) {
      print("CollectionReference 가져오기 실패");
      return;
    }

    try {
      final docSnapshot =
          await webBrowserCollection.doc(browserNumber.toString()).get();

      final List<String> uids = docSnapshot.get('uid')?.cast<String>() ?? [];
      if (!uids.contains(blogTitle)) {
        await webBrowserCollection.doc(docSnapshot.id).update({
          'uid': FieldValue.arrayUnion([blogTitle]),
        });

        final String? blogType =
            await InputDbProvider.getTargetKeywordType(firestore, blogTitle);
        final PopupStyle popupStyle = PopupStyle.fromBlogType(blogType ?? "");

        await showInputDialog(
            context, popupStyle.backgroundColor, popupStyle.titleText);
      } else {
        await showInputDialog(context, Colors.red, "중복 됨");
      }
    } catch (e) {
      print(e);
    }
  }
}
