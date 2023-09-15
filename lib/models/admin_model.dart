// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';

final adminProvider = ChangeNotifierProvider(((ref) => AdminModel()));

class AdminModel extends ChangeNotifier {
  Future<void> admin({required MuteUsersModel muteUsersModel}) async {
    final WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    // 投稿が数個残るはず
    final Timestamp now = Timestamp.now();
    for (int i = 0; i < 35; i++) {
      final passiveUid = "newMuteUser${i.toString()}";
      final FirestoreUser firestoreUser = FirestoreUser(
        createdAt: now,
        followerCount: 0,
        followingCount: 0,
        isAdmin: false,
        muteCount: 0,
        uid: passiveUid,
        updatedAt: now,
        userName: passiveUid,
        userImageURL: "",
      );
      final ref =
          FirebaseFirestore.instance.collection("users").doc(passiveUid);
      final String tokenId = returnUuidV4();
      final String activeUid = returnAuthUser()!.uid;
      writeBatch.set(ref, firestoreUser.toJson());
      final MuteUserToken muteUserToken = MuteUserToken(
          activeUid: activeUid,
          createdAt: now,
          passiveUid: passiveUid,
          tokenId: tokenId,
          tokenType: muteUserTokenTypeString);
      muteUsersModel.newMuteUserTokens.add(muteUserToken);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    await writeBatch.commit();
    Fluttertoast.showToast(
        msg: "動作が完了しました",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
