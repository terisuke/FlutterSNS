// flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final verifyPasswordRestProvider =
    ChangeNotifierProvider(((ref) => VerifyPasswordResetModel()));

class VerifyPasswordResetModel extends ChangeNotifier {
  String email = "";

  Future<void> sendPasswordResetEmail({required BuildContext context}) async {
    try {
      // passwordをresetするためのメールを送る
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      await voids.showFluttertoast(msg: emailSendedMsg);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      switch (e.code) {
        case "auth/invalid-email":
          msg = invalidEmailMsg;
          break;
        case "auth/missing-android-pkg-name":
          msg = missingAndroidPkgNameMsg;
          break;
        case "auth/missing-ios-bundle-id":
          msg = missingIosBundleIdMsg;
          break;
        case "auth/user-not-found":
          msg = userNotFoundMsg;
          break;
      }
      await voids.showFluttertoast(msg: msg);
    }
  }
}
