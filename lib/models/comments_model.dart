// flutter
import 'package:flutter/material.dart';
// packages
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
// domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';

final commentsProvider = ChangeNotifierProvider(((ref) => CommentsModel()));

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  String commentString = "";
  String indexPostId = "";
  List<DocumentSnapshot<Map<String, dynamic>>> commentDocs = [];
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) {
    // postにひもづくコメントが欲しい
    return postDoc.reference
        .collection("postComments")
        .orderBy("likeCount", descending: true);
  }

  Future<void> init(
      {required BuildContext context,
      required Post post,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required MainModel mainModel}) async {
    refreshController = RefreshController();
    routes.toCommentsPage(
        context: context, post: post, postDoc: postDoc, mainModel: mainModel);
    if (indexPostId != post.postId) {
      await onReload(postDoc: postDoc);
    }
    indexPostId = postDoc.id;
  }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.refreshCompleted();
    if (commentDocs.isNotEmpty) {
      final qshot = await returnQuery(postDoc: postDoc)
          .endBeforeDocument(commentDocs.first)
          .get();
      final reversed = qshot.docs.reversed.toList();
      for (final postDoc in reversed) {
        commentDocs.insert(0, postDoc);
      }
      commentDocs = qshot.docs;
    }
    notifyListeners();
  }

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    final qshot = await returnQuery(postDoc: postDoc).get();
    commentDocs = qshot.docs;
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.loadComplete();
    if (commentDocs.isNotEmpty) {
      final qshot = await returnQuery(postDoc: postDoc)
          .startAfterDocument(commentDocs.last)
          .get();
      for (final postDoc in qshot.docs) {
        commentDocs.add(postDoc);
      }
    }
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
      likeCount: 0,
      postCommentId: postCommentId,
      postCommentReplyCount: 0,
      userName: firestoreUser.userName,
      uid: activeUid,
      userImageURL: firestoreUser.userImageURL,
    );
    await postDoc.reference
        .collection("postComments")
        .doc(postCommentId)
        .set(comment.toJson());
  }
}
