// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
// constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

final accountProvider = ChangeNotifierProvider(((ref) => AccountModel()));

class AccountModel extends ChangeNotifier {
  User? currentUser = returnAuthUser();
  String password = "";
  bool isObscure = true;
  ReauthenticationState reauthenticationState =
      ReauthenticationState.initialValue;
  // route処理も同時にこなさなければならない
  Future<void> reauthenticateWithCredential(
      {required BuildContext context,
      required FirestoreUser firestoreUser}) async {
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
          routes.toUpdateEmailPage(context: context);
          break;
        case ReauthenticationState.deleteUser:
          // ユーザーを削除するDialogを表示する
          showDeleteUserDialog(context: context, firestoreUser: firestoreUser);
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
      await voids.showFluttertoast(msg: msg);
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> logout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    final String msg = returnL10n(context: context)!.logoutedMsg;
    routes.toFinishedage(context: context, msg: msg);
  }

  void showDeleteUserDialog(
      {required BuildContext context, required FirestoreUser firestoreUser}) {
    final l10n = returnL10n(context: context);
    showCupertinoModalPopup(
        context: context,
        builder: (innerContext) => CupertinoAlertDialog(
                content: Text(l10n!.deleteUserAlertMsg),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(innerContext),
                    child: const Text(noText),
                  ),
                  CupertinoDialogAction(
                    /// This parameter indicates the action would perform
                    /// a destructive action such as deletion, and turns
                    /// the action's text color to red.
                    isDestructiveAction: true,
                    onPressed: () async {
                      Navigator.pop(innerContext);
                      await deleteUser(
                          context: context, firestoreUser: firestoreUser);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }

  Future<void> deleteUser(
      {required BuildContext context,
      required FirestoreUser firestoreUser}) async {
    final l10n = returnL10n(context: context);
    final String msg = l10n!.userDeletedMsg;
    routes.toFinishedage(context: context, msg: msg);

    // ユーザーの削除にはReauthenticationが必要
    // ユーザーの削除はFirebaseAuthのトークンがないといけない
    // Documentの方を削除 -> FirebaseAuthのユーザーを削除
    final User currentUser = returnAuthUser()!;
    // deleteUserを作成する
    try {
      await FirebaseFirestore.instance
          .collection("deleteUsers")
          .doc(currentUser.uid)
          .set(firestoreUser.toJson())
          .then((_) => currentUser.delete());
    } on FirebaseException catch (e) {
      if (e.code == 'requires-recent-login') {
        voids.showFluttertoast(msg: l10n.requiresRecentLoginMsg);
      }
    }
  }
}
