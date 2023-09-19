// flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final loginProvider = ChangeNotifierProvider(((ref) => LoginModel()));

class LoginModel extends ChangeNotifier {
  User? currentUser;
  // auth
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> login({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        // caseのe.codeは視認性を高めるために変数には格納しない
        // 国際化に対応する必要がないString
        case "wrong-password":
          msg = wrongPasswordMsg;
          break;
        case "user-not-found":
          msg = userNotFoundMsg;
          break;
        case "user-disabled":
          msg = userDisabledMsg;
          break;
        case "invalid-email":
          msg = invalidEmailMsg;
          break;
      }
      await voids.showFluttertoast(msg: msg);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
