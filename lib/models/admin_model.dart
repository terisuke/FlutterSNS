// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/follower/follower.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';

final adminProvider = ChangeNotifierProvider(((ref) => AdminModel()));

class AdminModel extends ChangeNotifier {
  Future<void> admin({required MuteUsersModel muteUsersModel}) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final userDocs =
        await FirebaseFirestore.instance.collection('users').limit(70).get();
    final User currentUser = returnAuthUser()!;
    final currentUid = currentUser.uid;
    for (final userDoc in userDocs.docs) {
      final Timestamp now = Timestamp.now();
      final String tokenId = returnUuidV4();
      // フォローした証
      final FollowingToken followingToken = FollowingToken(
          createdAt: now,
          passiveUid: currentUid,
          tokenId: tokenId,
          tokenType: followingTokenTypeString);
      batch.set(userDocToTokenDocRef(userDoc: userDoc, tokenId: tokenId),
          followingToken.toJson());
      // フォローされた証
      final Follower follower = Follower(
          createdAt: now, followedUid: currentUid, followerUid: userDoc.id);
      batch.set(
          FirebaseFirestore.instance
              .collection('users')
              .doc(currentUid)
              .collection("followers")
              .doc(follower.followerUid),
          follower.toJson());
      await Future.delayed(const Duration(milliseconds: 100));
    }
    await batch.commit();
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
