// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final verifyEmailProvider =
    ChangeNotifierProvider(((ref) => VerifyEmailModel()));

class VerifyEmailModel extends ChangeNotifier {
  VerifyEmailModel() {
    init();
  }

  Future<void> init() async {
    User user = returnAuthUser()!;
    await user.reload(); // FirebaseAuthのユーザーのリロードを行う
    user = returnAuthUser()!; // リロード後、再び取得する
    // ユーザーのメールアドレス宛にメールが送信される
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      await voids.showFluttertoast(msg: "認証が完了していません。メールを送信しました！");
    } else {
      await voids.showFluttertoast(msg: "認証は完了しています");
    }
  }
}
