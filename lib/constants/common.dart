import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ojplace/jawan_list/mvvm/util/user_select.dart';

class FirebaseConnect {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserClass userClass = UserClass();
}
