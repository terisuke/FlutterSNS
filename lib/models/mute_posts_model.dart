// flutter
import 'package:flutter/cupertino.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/ints.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/domain/mute_post_token/mute_post_token.dart';
import 'package:udemy_flutter_sns/domain/post_mute/post_mute.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
// domains

// domain
import 'package:udemy_flutter_sns/models/main_model.dart';

final mutePostsProvider = ChangeNotifierProvider(((ref) => MutePostsModel()));

class MutePostsModel extends ChangeNotifier {
  bool showMutePosts = false;
  List<String> mutePostIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> mutePostDocs = [];
  final RefreshController refreshController = RefreshController();
  // 新しくミュートするユーザー
  List<MutePostToken> newMutePostTokens = [];
  // ミュートしているコメントのDocumentを取得する
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MutePostIds}) =>
      FirebaseFirestore.instance
          .collectionGroup("posts")
          .where("postId", whereIn: max10MutePostIds);

  Future<void> getMutePosts({required MainModel mainModel}) async {
    showMutePosts = true;
    mutePostIds = mainModel.mutePostIds;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await processNewPosts();
    notifyListeners();
  }

  Future<void> onReload() async {
    await process();
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    await process();
    notifyListeners();
  }

  Future<void> processNewPosts() async {
    // newmutePostTokensをfor文で回してPostIdだけをまとめている
    final List<String> newMutePostIds =
        newMutePostTokens.map((e) => e.postId).toList();
    // 新しくミュートしたコメントが10個以上の場合
    final List<String> max10MutePostIds = newMutePostIds.length > 10
        ? newMutePostIds.sublist(0, tenCount) // 10より大きかったら10個取り出す
        : newMutePostIds; // 10より大きかったらそのまま適応
    if (max10MutePostIds.isNotEmpty) {
      final qshot = await returnQuery(max10MutePostIds: max10MutePostIds).get();
      // いつもの新しいdocsに対して行う処理
      final reversed = qshot.docs.reversed.toList();
      for (final mutePostDoc in reversed) {
        mutePostDocs.insert(0, mutePostDoc);
        // mutemutePostDocsに加えたということは、もう新しくない。
        // 新しいやつから省く
        // tokenに含まれるPostIdがミュートされるべきユーザーと同じPostIdのやつを取得
        final deleteNewMutePostToken = newMutePostTokens
            .where((element) => element.postId == mutePostDoc.id)
            .toList()
            .first;
        newMutePostTokens.remove(deleteNewMutePostToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (mutePostIds.length > mutePostDocs.length) {
      // 序盤のmutemutePostDocsの長さを保持
      final int mutePostDocsLength = mutePostDocs.length;
      // max10MutePostIdsには10個までしかPostIdを入れない。
      // なぜならwhereInで検索にかけるから
      final List<String> max10MutePostIds =
          (mutePostIds.length - mutePostDocs.length) >= 10
              ? mutePostIds.sublist(
                  mutePostDocsLength, mutePostDocsLength + tenCount)
              : mutePostIds.sublist(mutePostDocsLength, mutePostIds.length);
      if (max10MutePostIds.isNotEmpty) {
        final qshot =
            await returnQuery(max10MutePostIds: max10MutePostIds).get();
        for (final mutePostDoc in qshot.docs) {
          mutePostDocs.add(mutePostDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> mutePost({
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> postDocs,
  }) async {
    // postMapとpostDocってほぼ同じ
    // postMap["postId"]とpostDoc["postId"]
    // 同じ値が返ってくる
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final Timestamp now = Timestamp.now();
    final postRef = postDoc.reference;
    final String postId = postDoc.id;
    final MutePostToken mutePostToken = MutePostToken(
        activeUid: activeUid,
        createdAt: now,
        postId: postId,
        postRef: postRef,
        tokenId: tokenId,
        tokenType: mutePostTokenTypeString);
    // 新しくミュートしたコメント
    newMutePostTokens.add(mutePostToken);
    mainModel.mutePostTokens.add(mutePostToken);
    mainModel.mutePostIds.add(postId);
    // muteしたいコメントを除外する
    postDocs.remove(postDoc);
    notifyListeners();
    // currentUserDoc.ref ...
    // 自分がmuteしたことの印
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(mutePostToken.toJson());
    // muteされたことの印
    final PostMute postMute = PostMute(
        activeUid: activeUid, createdAt: now, postId: postId, postRef: postRef);
    await postDoc.reference
        .collection("postMutes")
        .doc(activeUid)
        .set(postMute.toJson());
  }

  void showMutePostDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> postDocs,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(mutePostAlertMsg),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
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
                      await mutePost(
                          mainModel: mainModel,
                          postDoc: postDoc,
                          postDocs: postDocs);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }

  Future unMutePost({
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> postDocs,
  }) async {
    // mutePostsModel側の処理
    final String postId = postDoc.id;
    mutePostDocs.remove(postDoc);
    mainModel.mutePostIds.remove(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final MutePostToken deleteMutePostToken = mainModel.mutePostTokens
        .where((element) => element.postId == postId)
        .toList()
        .first;
    if (newMutePostTokens.contains(deleteMutePostToken)) {
      // もし削除するコメントが新しいやつなら
      newMutePostTokens.remove(deleteMutePostToken);
    }
    mainModel.mutePostTokens.remove(deleteMutePostToken);
    notifyListeners();
    // 自分がミュートしたことの印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMutePostToken.tokenId)
        .delete();
    // コメントのミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> mutePostRef =
        deleteMutePostToken.postRef;
    await mutePostRef.collection("postMutes").doc(activeUid).delete();
  }

  void showUnMutePostDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> postDocs,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(unMutePostAlertMsg),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    /// This parameter indicates this action is the default,
                    /// and turns the action's text to bold text.
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
                      await unMutePost(
                          mainModel: mainModel,
                          postDoc: postDoc,
                          postDocs: postDocs);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }
}
