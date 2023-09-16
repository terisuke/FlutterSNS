// flutter
import 'package:flutter/cupertino.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
// constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final accountProvider = ChangeNotifierProvider(((ref) => AccountModel()));

class AccountModel extends ChangeNotifier {
  User? currentUser = returnAuthUser();
  String password = "";
  bool isObscure = true;
  ReauthenticationState reauthenticationState =
      ReauthenticationState.initialValue;
  // route処理も同時にこなさなければならない
  Future<void> reauthenticateWithCredential(
      {required BuildContext context}) async {
    // まず再認証をする
    currentUser = returnAuthUser();
    final String email = currentUser!.email!;
    // 認証情報
    // FirebaseAuthの大事な作業に必要
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      // エラーをcatchしたらその瞬間、tryの中の処理は中断される
      await currentUser!.reauthenticateWithCredential(credential);
      // 認証が完了したらメッセージを表示してあげる
      await voids.showFluttertoast(msg: reauthenticatedMsg);
      switch (reauthenticationState) {
        case ReauthenticationState.initialValue:
          break;
        case ReauthenticationState.updatePassword:
          // updatePasswordPageに飛ばす
          routes.toUpdatePasswordPage(context: context);
          break;
        case ReauthenticationState.updateEmail:
          // updateEmailPageに飛ばす
          break;
      }
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        case "wrong-password":
          msg = wrongPasswordMsg;
          break;
        case "invalid-email":
          msg = invalidEmailMsg;
          break;
        case "invalid-credential":
          msg = invalidCredentialMsg;
          break;
        case "user-not-found":
          msg = userNotFoundMsg;
          break;
        case "user-mismatch":
          msg = userMismatchMsg;
          break;
      }
      voids.showFluttertoast(msg: msg);
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
