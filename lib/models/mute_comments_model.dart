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
import 'package:udemy_flutter_sns/constants/strings.dart';
// domains
import 'package:udemy_flutter_sns/domain/mute_comment_token/mute_comment_token.dart';
import 'package:udemy_flutter_sns/domain/comment_mute/comment_mute.dart';
// domain
import 'package:udemy_flutter_sns/models/main_model.dart';

final muteCommentsProvider =
    ChangeNotifierProvider(((ref) => MuteCommentsModel()));

class MuteCommentsModel extends ChangeNotifier {
  bool showMuteComments = false;
  List<String> mutePostCommentIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> muteCommentDocs = [];
  final RefreshController refreshController = RefreshController();
  // 新しくミュートするユーザー
  List<MuteCommentToken> newMuteCommentTokens = [];
  // ミュートしているコメントのDocumentを取得する
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MutePostCommentIds}) =>
      FirebaseFirestore.instance
          .collectionGroup("postComments")
          .where("postCommentId", whereIn: max10MutePostCommentIds);

  Future<void> getMuteComments({required MainModel mainModel}) async {
    showMuteComments = true;
    mutePostCommentIds = mainModel.muteCommentIds;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await processNewMuteComments();
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

  Future<void> processNewMuteComments() async {
    // newmuteCommentTokensをfor文で回してpostCommentIdだけをまとめている
    final List<String> newMutePostCommentIds =
        newMuteCommentTokens.map((e) => e.postCommentId).toList();
    // 新しくミュートしたコメントが10個以上の場合
    final List<String> max10MutePostCommentIds =
        newMutePostCommentIds.length > 10
            ? newMutePostCommentIds.sublist(0, tenCount) // 10より大きかったら10個取り出す
            : newMutePostCommentIds; // 10より大きかったらそのまま適応
    if (max10MutePostCommentIds.isNotEmpty) {
      final qshot =
          await returnQuery(max10MutePostCommentIds: max10MutePostCommentIds)
              .get();
      // いつもの新しいdocsに対して行う処理
      final reversed = qshot.docs.reversed.toList();
      for (final mutePostCommentDoc in reversed) {
        muteCommentDocs.insert(0, mutePostCommentDoc);
        // mutemutePostCommentDocsに加えたということは、もう新しくない。
        // 新しいやつから省く
        // tokenに含まれるpostCommentIdがミュートされるべきユーザーと同じpostCommentIdのやつを取得
        final deleteNewMutePostCommentToken = newMuteCommentTokens
            .where((element) => element.postCommentId == mutePostCommentDoc.id)
            .toList()
            .first;
        newMuteCommentTokens.remove(deleteNewMutePostCommentToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (mutePostCommentIds.length > muteCommentDocs.length) {
      // 序盤のmutemutePostCommentDocsの長さを保持
      final int mutePostCommentDocsLength = muteCommentDocs.length;
      // max10MutePostCommentIdsには10個までしかPostCommentIdを入れない。
      // なぜならwhereInで検索にかけるから
      final List<String> max10MutePostCommentIds =
          (mutePostCommentIds.length - muteCommentDocs.length) >= 10
              ? mutePostCommentIds.sublist(mutePostCommentDocsLength,
                  mutePostCommentDocsLength + tenCount)
              : mutePostCommentIds.sublist(
                  mutePostCommentDocsLength, mutePostCommentIds.length);
      if (max10MutePostCommentIds.isNotEmpty) {
        final qshot =
            await returnQuery(max10MutePostCommentIds: max10MutePostCommentIds)
                .get();
        for (final mutePostCommentDoc in qshot.docs) {
          muteCommentDocs.add(mutePostCommentDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> muteComment({
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> commentDocs,
  }) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final Timestamp now = Timestamp.now();
    final postCommentRef = commentDoc.reference;
    final String postCommentId = commentDoc.id;
    final MuteCommentToken muteCommentToken = MuteCommentToken(
        activeUid: activeUid,
        createdAt: now,
        postCommentId: postCommentId,
        postCommentRef: postCommentRef,
        tokenId: tokenId,
        tokenType: muteCommentTokenTypeString);
    // 新しくミュートしたコメント
    newMuteCommentTokens.add(muteCommentToken);
    mainModel.muteCommentTokens.add(muteCommentToken);
    mainModel.muteCommentIds.add(postCommentId);
    // muteしたいコメントを除外する
    commentDocs.remove(commentDoc);
    notifyListeners();
    // currentUserDoc.ref ...
    // 自分がmuteしたことの印
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteCommentToken.toJson());
    // muteされたことの印
    final CommentMute commentMute = CommentMute(
        activeUid: activeUid,
        createdAt: now,
        postCommentId: postCommentId,
        postCommentRef: postCommentRef);
    await commentDoc.reference
        .collection("postCommentMutes")
        .doc(activeUid)
        .set(commentMute.toJson());
  }

  void showMuteCommentDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> commentDocs,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(muteCommentAlertMsg),
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
                      await muteComment(
                          mainModel: mainModel,
                          commentDoc: commentDoc,
                          commentDocs: commentDocs);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }

  Future unMuteComment({
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> commentDocs,
  }) async {
    // muteCommentsModel側の処理
    final String commentId = commentDoc.id;
    muteCommentDocs.remove(commentDoc);
    mainModel.muteCommentIds.remove(commentId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final MuteCommentToken deleteMuteCommentToken = mainModel.muteCommentTokens
        .where((element) => element.postCommentId == commentId)
        .toList()
        .first;
    if (newMuteCommentTokens.contains(deleteMuteCommentToken)) {
      // もし削除するコメントが新しいやつなら
      newMuteCommentTokens.remove(deleteMuteCommentToken);
    }
    mainModel.muteCommentTokens.remove(deleteMuteCommentToken);
    notifyListeners();
    // 自分がミュートしたことの印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMuteCommentToken.tokenId)
        .delete();
    // コメントのミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> muteCommentRef =
        deleteMuteCommentToken.postCommentRef;
    await muteCommentRef.collection("postCommentMutes").doc(activeUid).delete();
  }

  void showUnMuteCommentDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> commentDocs,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(unMuteCommentAlertMsg),
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
                      await unMuteComment(
                          mainModel: mainModel,
                          commentDoc: commentDoc,
                          commentDocs: commentDocs);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }
}
