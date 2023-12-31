// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/details/report_contents_list_view.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/comment_like/comment_like.dart';
import 'package:udemy_flutter_sns/domain/like_comment_token/like_comment_token.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post_comment_report/post_comment_report.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';

final commentsProvider = ChangeNotifierProvider(((ref) => CommentsModel()));

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  String commentString = "";
  String indexPostId = "";
  List<String> muteUids = [];
  List<DocumentSnapshot<Map<String, dynamic>>> commentDocs = [];
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) {
    // postにひもづくコメントが欲しい
    return postDoc.reference
        .collection("postComments")
        .orderBy("likeCount", descending: true);
  }

  CommentsModel() {
    init();
  }
  Future<void> init() async {
    final muteUidsAndMutePostIds = await returnMuteUidsAndMutePostIds();
    muteUids = muteUidsAndMutePostIds.first;
  }

  Future<void> onCommentButtonPressed(
      {required BuildContext context,
      required Post post,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required MainModel mainModel}) async {
    refreshController = RefreshController();
    final String postId = post.postId;
    routes.toCommentsPage(
        context: context, post: post, postDoc: postDoc, mainModel: mainModel);
    if (indexPostId != postId) {
      await onReload(postDoc: postDoc);
    }
    indexPostId = postId;
  }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids,
        mutePostIds: [],
        docs: commentDocs,
        query: returnQuery(postDoc: postDoc));
    notifyListeners();
  }

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    await voids.processBasicDocs(
        muteUids: muteUids,
        mutePostIds: [],
        docs: commentDocs,
        query: returnQuery(postDoc: postDoc));
    notifyListeners();
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUids: muteUids,
        mutePostIds: [],
        docs: commentDocs,
        query: returnQuery(postDoc: postDoc));
    notifyListeners();
  }

  void showCommentFlashBar(
      {required BuildContext context,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> postDoc}) {
    voids.showFlashBar(
        context: context,
        textEditingController: textEditingController,
        onChanged: (value) => commentString = value,
        titleString: createCommentText,
        primaryActionColor: Colors.orange,
        primaryActionBuilder: (_, controller, __) {
          return InkWell(
            onTap: () async {
              if (textEditingController.text.isNotEmpty) {
                // メインの動作
                await createComment(
                    currentUserDoc: mainModel.currentUserDoc,
                    firestoreUser: mainModel.firestoreUser,
                    postDoc: postDoc);
                await controller.dismiss();
                commentString = "";
                textEditingController.text = "";
              } else {
                // 何もしない
                await controller.dismiss();
              }
            },
            child: const Icon(
              Icons.send,
              color: Colors.orange,
            ),
          );
        });
  }

  Future<void> createComment(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser,
      required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postCommentId = returnUuidV4();
    final Comment comment = Comment(
        createdAt: now,
        comment: commentString,
        commentLanguageCode: "",
        commentNagativeScore: 0,
        commentPositiveScore: 0,
        commentSentiment: "",
        likeCount: 0,
        postCommentId: postCommentId,
        postCommentReplyCount: 0,
        postRef: postDoc.reference,
        muteCount: 0,
        reportCount: 0,
        userName: firestoreUser.userName,
        userNameLanguageCode: firestoreUser.userNameLanguageCode,
        userNameNagativeScore: firestoreUser.userNameNagativeScore,
        userNamePositiveScore: firestoreUser.userNamePositiveScore,
        userNameSentiment: firestoreUser.userNameSentiment,
        uid: activeUid,
        userImageURL: firestoreUser.userImageURL,
        updatedAt: now);
    await postDoc.reference
        .collection("postComments")
        .doc(postCommentId)
        .set(comment.toJson());
  }

  Future<void> like(
      {required Comment comment,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc, required Post post}) async {
    // setting
    final String postCommentId = comment.postCommentId;
    mainModel.likeCommentIds.add(postCommentId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = comment.uid;
    final LikeCommentToken likeCommentToken = LikeCommentToken(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        postCommentRef: commentDoc.reference,
        postCommentId: postCommentId,
        tokenId: tokenId,
        tokenType: likeCommentTokenTypeString);
    mainModel.likeCommentTokens.add(likeCommentToken);
    notifyListeners();
    // 自分がコメントにいいねしたことの印
    await currentUserDoc.reference
        .collection("tokens")
        .doc(tokenId)
        .set(likeCommentToken.toJson());
    // コメントにいいねがついたことの印
    final CommentLike commentLike = CommentLike(
        activeUid: activeUid,
        createdAt: now,
        postCommentCreatorUid: comment.uid,
        postCommentRef: commentDoc.reference,
        postCommentId: postCommentId);
    await commentDoc.reference
        .collection("postCommentLikes")
        .doc(activeUid)
        .set(commentLike.toJson());
  }

  Future<void> unlike(
      {required Comment comment,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc, required Post post}) async {
    final String postCommentId = comment.postCommentId;
    mainModel.likeCommentIds.remove(postCommentId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteLikeCommentToken = mainModel.likeCommentTokens
        .where((element) => element.postCommentId == postCommentId)
        .toList()
        .first;
    mainModel.likeCommentTokens.remove(deleteLikeCommentToken);
    notifyListeners();
    // 自分がいいねしたことの印を削除
    await userDocToTokenDocRef(
            userDoc: currentUserDoc, tokenId: deleteLikeCommentToken.tokenId)
        .delete();
    // コメントにいいねがついたことの印を削除
    final DocumentReference<Map<String, dynamic>> postCommentRef =
        deleteLikeCommentToken.postCommentRef;
    await postCommentRef.collection("postCommentLikes").doc(activeUid).delete();
  }

  void reportComment(
      {required BuildContext context,
      required Comment comment,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc}) {
    final selectedReportContentsNotifier = ValueNotifier<List<String>>([]);
    final String postCommentReportId = returnUuidV4();
    voids.showFlashDialog(
        context: context,
        content: ReportContentsListView(
          selectedReportContentsNotifier: selectedReportContentsNotifier,
        ),
        positiveActionBuilder: (_, controller, __) {
          final commentDocRef = commentDoc.reference;
          return TextButton(
              onPressed: () async {
                final PostCommentReport postCommentReport = PostCommentReport(
                    acitiveUid: returnAuthUser()!.uid,
                    createdAt: Timestamp.now(),
                    others: "",
                    reportContent: returnReportContentString(
                        selectedReportContents:
                            selectedReportContentsNotifier.value),
                    postCommentCreatorUid: comment.uid,
                    passiveUserName: comment.userName,
                    postCommentDocRef: commentDocRef,
                    postCommentId: comment.postCommentId,
                    postCommentReportId: postCommentReportId,
                    comment: comment.comment,
                    commentLanguageCode: comment.commentLanguageCode,
                    commentNagativeScore: comment.commentNagativeScore,
                    commentPositiveScore: comment.commentPositiveScore,
                    commentSentiment: comment.commentSentiment);
                await controller.dismiss();
                await voids.showFluttertoast(msg: "コメントを報告しました");
                await commentDoc.reference
                    .collection("postCommentReports")
                    .doc(postCommentReportId)
                    .set(postCommentReport.toJson());
              },
              child: const Text(
                "送信",
                style: TextStyle(color: Colors.red),
              ));
        });
  }
}
