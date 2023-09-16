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
import 'package:udemy_flutter_sns/domain/mute_reply_token/mute_reply_token.dart';
import 'package:udemy_flutter_sns/domain/reply_mute/reply_mute.dart';
// domain
import 'package:udemy_flutter_sns/models/main_model.dart';

final muteRepliesProvider =
    ChangeNotifierProvider(((ref) => MuteRepliesModel()));

class MuteRepliesModel extends ChangeNotifier {
  bool showMuteReplies = false;
  List<String> mutePostCommentReplyIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> muteReplyDocs = [];
  final RefreshController refreshController = RefreshController();
  // 新しくミュートするユーザー
  List<MuteReplyToken> newMuteReplyTokens = [];
  // ミュートしているコメントのDocumentを取得する
  Query<Map<String, dynamic>> returnQuery(
          {required List<String> max10MutePostCommentReplyIds}) =>
      FirebaseFirestore.instance
          .collectionGroup("postCommentReplies")
          .where("postCommentReplyId", whereIn: max10MutePostCommentReplyIds);

  Future<void> getMuteReplies({required MainModel mainModel}) async {
    showMuteReplies = true;
    mutePostCommentReplyIds = mainModel.muteReplyIds;
    await process();
    notifyListeners();
  }

  Future<void> onRefresh({required MainModel mainModel}) async {
    refreshController.refreshCompleted();
    await processNewPostCommentReplies();
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

  Future<void> processNewPostCommentReplies() async {
    // newmuteReplyTokensをfor文で回してpostCommentReplyIdだけをまとめている
    final List<String> newMutePostCommentReplyIds =
        newMuteReplyTokens.map((e) => e.postCommentReplyId).toList();
    // 新しくミュートしたコメントが10個以上の場合
    final List<String> max10MutePostCommentReplyIds = newMutePostCommentReplyIds
                .length >
            10
        ? newMutePostCommentReplyIds.sublist(0, tenCount) // 10より大きかったら10個取り出す
        : newMutePostCommentReplyIds; // 10より大きかったらそのまま適応
    if (max10MutePostCommentReplyIds.isNotEmpty) {
      final qshot = await returnQuery(
              max10MutePostCommentReplyIds: max10MutePostCommentReplyIds)
          .get();
      // いつもの新しいdocsに対して行う処理
      final reversed = qshot.docs.reversed.toList();
      for (final mutePostCommentReplyDoc in reversed) {
        muteReplyDocs.insert(0, mutePostCommentReplyDoc);
        // mutemutePostCommentReplyDocsに加えたということは、もう新しくない。
        // 新しいやつから省く
        // tokenに含まれるpostCommentReplyIdがミュートされるべきユーザーと同じpostCommentReplyIdのやつを取得
        final deleteNewMutePostCommentReplyToken = newMuteReplyTokens
            .where((element) =>
                element.postCommentReplyId == mutePostCommentReplyDoc.id)
            .toList()
            .first;
        newMuteReplyTokens.remove(deleteNewMutePostCommentReplyToken);
      }
    }
    notifyListeners();
  }

  Future<void> process() async {
    if (mutePostCommentReplyIds.length > muteReplyDocs.length) {
      // 序盤のmutemutePostCommentReplyDocsの長さを保持
      final int mutePostCommentReplyDocsLength = muteReplyDocs.length;
      // max10MutePostCommentReplyIdsには10個までしかPostCommentReplyIdを入れない。
      // なぜならwhereInで検索にかけるから
      final List<String> max10MutePostCommentReplyIds =
          (mutePostCommentReplyIds.length - muteReplyDocs.length) >= 10
              ? mutePostCommentReplyIds.sublist(mutePostCommentReplyDocsLength,
                  mutePostCommentReplyDocsLength + tenCount)
              : mutePostCommentReplyIds.sublist(mutePostCommentReplyDocsLength,
                  mutePostCommentReplyIds.length);
      if (max10MutePostCommentReplyIds.isNotEmpty) {
        final qshot = await returnQuery(
                max10MutePostCommentReplyIds: max10MutePostCommentReplyIds)
            .get();
        for (final mutePostCommentReplyDoc in qshot.docs) {
          muteReplyDocs.add(mutePostCommentReplyDoc);
        }
      }
    }
    notifyListeners();
  }

  Future<void> muteReply({
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) async {
    final String tokenId = returnUuidV4();
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final Timestamp now = Timestamp.now();
    final postCommentReplyRef = replyDoc.reference;
    final String postCommentReplyId = replyDoc.id;
    final MuteReplyToken muteReplyToken = MuteReplyToken(
        activeUid: activeUid,
        createdAt: now,
        postCommentReplyId: postCommentReplyId,
        postCommentReplyRef: postCommentReplyRef,
        tokenId: tokenId,
        tokenType: muteReplyTokenTypeString);
    // 新しくミュートしたコメント
    newMuteReplyTokens.add(muteReplyToken);
    mainModel.muteReplyTokens.add(muteReplyToken);
    mainModel.muteReplyIds.add(postCommentReplyId);
    // フロントエンドで非表示にしているので除外する必要はない
    notifyListeners();
    // currentUserDoc.ref ...
    // 自分がmuteしたことの印
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteReplyToken.toJson());
    // muteされたことの印
    final ReplyMute replyMute = ReplyMute(
        activeUid: activeUid,
        createdAt: now,
        postCommentReplyId: postCommentReplyId,
        postCommentReplyRef: postCommentReplyRef);
    await replyDoc.reference
        .collection("postCommentReplyMutes")
        .doc(activeUid)
        .set(replyMute.toJson());
  }

  void showMuteReplyDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(muteReplyAlertMsg),
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
                      await muteReply(mainModel: mainModel, replyDoc: replyDoc);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }

  Future unMuteReply({
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) async {
    // muteRepliesModel側の処理
    final String replyId = replyDoc.id;
    muteReplyDocs.remove(replyDoc);
    mainModel.muteReplyIds.remove(replyId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final MuteReplyToken deleteMuteReplyToken = mainModel.muteReplyTokens
        .where((element) => element.postCommentReplyId == replyId)
        .toList()
        .first;
    if (newMuteReplyTokens.contains(deleteMuteReplyToken)) {
      // もし削除するコメントが新しいやつなら
      newMuteReplyTokens.remove(deleteMuteReplyToken);
    }
    mainModel.muteReplyTokens.remove(deleteMuteReplyToken);
    notifyListeners();
    // 自分がミュートしたことの印を削除
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc,
            tokenId: deleteMuteReplyToken.tokenId)
        .delete();
    // コメントのミュートされた印を削除
    final DocumentReference<Map<String, dynamic>> muteReplyRef =
        deleteMuteReplyToken.postCommentReplyRef;
    await muteReplyRef
        .collection("postCommentReplyMutes")
        .doc(activeUid)
        .delete();
  }

  void showUnMuteReplyDialog({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot replyDoc,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext innerContext) => CupertinoAlertDialog(
                content: const Text(unMuteReplyAlertMsg),
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
                      await unMuteReply(
                          mainModel: mainModel, replyDoc: replyDoc);
                    },
                    child: const Text(yesText),
                  )
                ]));
  }
}
