// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;

final signupProvider = ChangeNotifierProvider((ref) => SignupModel());

class SignupModel extends ChangeNotifier {
  int counter = 0;
  User? currentUser;
  // auth
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      followerCount: 0,
      followingCount: 0,
      isAdmin: false,
      uid: uid,
      updatedAt: now,
      userName: "Alice",
      userImageURL: "",
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();
    await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .doc(uid)
        .set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(userCreatedMsg)));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context, uid: uid);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
