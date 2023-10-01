// flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final updatePasswordProvider =
    ChangeNotifierProvider(((ref) => UpdatePasswordModel()));

class UpdatePasswordModel extends ChangeNotifier {
  String newPassword = "";
  bool isObscure = true;

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> updatePassword({required BuildContext context}) async {
    final User user = returnAuthUser()!;
    final l10n = returnL10n(context: context);
    try {
      await user.updatePassword(newPassword);
      // ReauthenticationPageへ
      Navigator.pop(context);
      // AccountPageへ
      Navigator.pop(context);
      const String msg = updatedPasswordMsg;
      await voids.showFluttertoast(msg: msg);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        case "requires-recent-login":
          msg = l10n!.requiresRecentLoginMsg;
          break;
        case "weak-password":
          msg = weakPasswordMsg;
          break;
      }
      await voids.showFluttertoast(msg: msg);
    }
  }
}
