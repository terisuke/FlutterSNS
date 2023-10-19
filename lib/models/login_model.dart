// flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final loginProvider = ChangeNotifierProvider(((ref) => LoginModel()));
final Uri _url = Uri.parse('https://fir-flutter-77794.web.app/privacypolicy.html');

class LoginModel extends ChangeNotifier {
  User? currentUser;
  // auth
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> login({required BuildContext context}) async {
    if (email.isEmpty || password.isEmpty) {
        await voids.showFluttertoast(msg: AppLocalizations.of(context)!.emptyform);
        return;
    }
    print("Attempting to sign in with email: $email");  // ログ追加
    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    routes.toMyApp(context: context);
} catch (e) {
    if (e is FirebaseAuthException) {
        print("FirebaseAuthException: ${e.code}");
        String msg = "";
        switch (e.code) {
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
            default:
                msg = "An unknown error occurred.";
                break;
        }
        await voids.showFluttertoast(msg: msg);
    } else {
        await voids.showFluttertoast(msg: "An unexpected error occurred: $e");
    }
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
