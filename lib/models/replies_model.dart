// flutter
import 'package:flutter/material.dart';
// packages
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
// constants
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/domain/like_reply_token/like_reply_token.dart';
import 'package:udemy_flutter_sns/details/report_contents_list_view.dart';
// domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post_comment_reply_report/post_comment_reply_report.dart';
import 'package:udemy_flutter_sns/domain/reply/reply.dart';
import 'package:udemy_flutter_sns/domain/reply_like/reply_like.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';

final repliesProvider = ChangeNotifierProvider(((ref) => RepliesModel()));

class RepliesModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  String replyString = "";

  void showReplyFlashBar(
      {required BuildContext context,
      required MainModel mainModel,
      required Comment comment,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc}) {
    voids.showFlashBar(
        context: context,
        textEditingController: textEditingController,
        onChanged: (value) => replyString = value,
        titleString: createReplyText,
        primaryActionColor: Colors.purple,
        primaryActionBuilder: (_, controller, __) {
          return InkWell(
            onTap: () async {
              if (textEditingController.text.isNotEmpty) {
                // メインの動作
                await createReply(
                    currentUserDoc: mainModel.currentUserDoc,
                    firestoreUser: mainModel.firestoreUser,
                    comment: comment,
                    commentDoc: commentDoc);
                await controller.dismiss();
                replyString = "";
                textEditingController.text = "";
              } else {
                // 何もしない
                await controller.dismiss();
              }
            },
            child: const Icon(
              Icons.send,
              color: Colors.purple,
            ),
          );
        });
  }

  Future<void> createReply(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser,
      required Comment comment,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postCommentReplyId = returnUuidV4();
    final Reply reply = Reply(
        createdAt: now,
        reply: replyString,
        replyLanguageCode: "",
        replyNagativeScore: 0,
        replyPositiveScore: 0,
        replySentiment: "",
        likeCount: 0,
        muteCount: 0,
        postRef: comment.postRef,
        postCommentRef: commentDoc.reference,
        postCommentReplyId: postCommentReplyId,
        reportCount: 0,
        userName: firestoreUser.userName,
        userNameLanguageCode: firestoreUser.userNameLanguageCode,
        userNameNagativeScore: firestoreUser.userNameNagativeScore,
        userNamePositiveScore: firestoreUser.userNamePositiveScore,
        userNameSentiment: firestoreUser.userNameSentiment,
        uid: activeUid,
        userImageURL: firestoreUser.userImageURL,
        updatedAt: now);
    await commentDoc.reference
        .collection("postCommentReplies")
        .doc(postCommentReplyId)
        .set(reply.toJson());
  }

  Future<void> like(
      {required Reply reply,
      required MainModel mainModel,
      required Comment comment,
      required DocumentSnapshot replyDoc}) async {
    // setting
    final String postCommentReplyId = reply.postCommentReplyId;
    mainModel.likeReplyIds.add(postCommentReplyId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = reply.uid;
    final DocumentReference postCommentReplyRef = replyDoc.reference;
    final LikeReplyToken likeReplyToken = LikeReplyToken(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        postCommentReplyRef: postCommentReplyRef,
        postCommentReplyId: postCommentReplyId,
        tokenId: tokenId,
        tokenType: likeReplyTokenTypeString);
    mainModel.likeReplyTokens.add(likeReplyToken);
    notifyListeners();
    // 自分がリプライにいいねしたことの印
    await currentUserDoc.reference
        .collection("tokens")
        .doc(tokenId)
        .set(likeReplyToken.toJson());
    // リプライにいいねがついたことの印
    final ReplyLike replyLike = ReplyLike(
        activeUid: activeUid,
        createdAt: now,
        postCommentReplyCreatorUid: reply.uid,
        postCommentReplyRef: postCommentReplyRef,
        postCommentReplyId: postCommentReplyId);
    await postCommentReplyRef
        .collection("postCommentReplyLikes")
        .doc(activeUid)
        .set(replyLike.toJson());
  }

  Future<void> unlike(
      {required Reply reply,
      required MainModel mainModel,
      required Comment comment,
      required DocumentSnapshot replyDoc}) async {
    final String postCommentReplyId = reply.postCommentReplyId;
    mainModel.likeReplyIds.remove(postCommentReplyId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    // whereは複数取得
    final LikeReplyToken deleteLikeReplyToken = mainModel.likeReplyTokens
        .where((element) => element.postCommentReplyId == postCommentReplyId)
        .toList()
        .first;
    mainModel.likeReplyTokens.remove(deleteLikeReplyToken);
    notifyListeners();
    // 自分がいいねしたことの印を削除
    await currentUserDoc.reference
        .collection("tokens")
        .doc(deleteLikeReplyToken.tokenId)
        .delete();
    // リプライにいいねがついたことの印を削除
    final DocumentReference<Map<String, dynamic>> postCommentReplyRef =
        deleteLikeReplyToken.postCommentReplyRef;
    await postCommentReplyRef
        .collection("postCommentReplyLikes")
        .doc(activeUid)
        .delete();
  }

  void reportReply(
      {required BuildContext context,
      required Reply reply,
      required DocumentSnapshot replyDoc}) {
    final selectedReportContentsNotifier = ValueNotifier<List<String>>([]);
    final String reportId = returnUuidV4();
    voids.showFlashDialog(
        context: context,
        content: ReportContentsListView(
          selectedReportContentsNotifier: selectedReportContentsNotifier,
        ),
        positiveActionBuilder: (_, controller, __) {
          final replyDocRef = replyDoc.reference;
          return TextButton(
              onPressed: () async {
                final PostCommentReplyReport postCommentReplyReport =
                    PostCommentReplyReport(
                        acitiveUid: returnAuthUser()!.uid,
                        createdAt: Timestamp.now(),
                        others: "",
                        reportContent: returnReportContentString(
                            selectedReportContents:
                                selectedReportContentsNotifier.value),
                        postCommentReplyCreatorUid: reply.uid,
                        passiveUserName: reply.userName,
                        postCommentReplyDocRef: replyDocRef,
                        postCommentReplyId: replyDoc.id,
                        postCommentReplyReportId: reportId,
                        reply: reply.reply,
                        replyLanguageCode: reply.replyLanguageCode,
                        replyNagativeScore: reply.replyNagativeScore,
                        replyPositiveScore: reply.replyPositiveScore,
                        replySentiment: reply.replySentiment);
                await controller.dismiss();
                await voids.showFluttertoast(msg: "リプライを報告しました");
                await replyDocRef
                    .collection("postCommentReplyReports")
                    .doc(reportId)
                    .set(postCommentReplyReport.toJson());
              },
              child: const Text(
                "送信",
                style: TextStyle(color: Colors.red),
              ));
        });
  }
}
