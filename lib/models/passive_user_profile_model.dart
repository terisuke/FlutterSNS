// flutter
import 'package:flutter/cupertino.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
// constants
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
// domain
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/follower/follower.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';

final passiveUserProfileProvider =
    ChangeNotifierProvider(((ref) => PassiveUserProfileModel()));

class PassiveUserProfileModel extends ChangeNotifier {
  // 相手の投稿を取得する
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  RefreshController refreshController = RefreshController();
  String indexUid = "";

  Future<void> onUserIconPressed(
      {required BuildContext context,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    refreshController = RefreshController();
    routes.toPassiveUserProfilePagePage(
        context: context, passiveUserDoc: passiveUserDoc, mainModel: mainModel);
    final String passiveUid = passiveUserDoc.id;
    if (indexUid != passiveUid) {
      await onReload(
          muteUids: mainModel.muteUids, passiveUserDoc: passiveUserDoc);
    }
    indexUid = passiveUid;
  }

  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) {
    return passiveUserDoc.reference.collection('posts');
  }

  Future<void> onRefresh(
      {required List<String> muteUids,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids,
        docs: postDocs,
        query: returnQuery(passiveUserDoc: passiveUserDoc), mutePostIds: []);
    notifyListeners();
  }

  Future<void> onReload(
      {required List<String> muteUids,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    await voids.processBasicDocs(
        muteUids: muteUids,
        docs: postDocs,
        query: returnQuery(passiveUserDoc: passiveUserDoc), mutePostIds: []);
    notifyListeners();
  }

  Future<void> onLoading(
      {required List<String> muteUids,
      required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc}) async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUids: muteUids,
        docs: postDocs,
        query: returnQuery(passiveUserDoc: passiveUserDoc), mutePostIds: []);
    notifyListeners();
  }

  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    // settings
    mainModel.followingUids.add(passiveUser.uid);
    notifyListeners();
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final FollowingToken followingToken = FollowingToken(
        createdAt: now,
        passiveUid: passiveUser.uid,
        tokenId: tokenId,
        tokenType: followingTokenTypeString);
    final FirestoreUser activeUser = mainModel.firestoreUser;
    // 自分がフォローした印
    await FirebaseFirestore.instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .doc(tokenId)
        .set(followingToken.toJson());
    // 受動的なユーザーがフォローされたdataを生成する
    final Follower follower = Follower(
        createdAt: now,
        followedUid: passiveUser.uid,
        followerUid: activeUser.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .set(follower.toJson());
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.remove(passiveUser.uid);
    notifyListeners();
    // followしているTokenを取得する
    final FirestoreUser activeUser = mainModel.firestoreUser;
    // qshotというdataの塊の存在を存在を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .where("passiveUid", isEqualTo: passiveUser.uid)
        .get();
    // 1個しか取得してないけど複数している扱い
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    await token.reference.delete();
    // 受動的なユーザーがフォローされたdataを削除する
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .delete();
  }
}
