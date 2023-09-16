// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/domain/reply/reply.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
// domains
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/models/mute_replies_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/replies_model.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
import 'package:udemy_flutter_sns/views/replies/components/reply_card.dart';

class RepliesPage extends ConsumerWidget {
  const RepliesPage(
      {Key? key,
      required this.comment,
      required this.commentDoc,
      required this.mainModel})
      : super(key: key);
  final Comment comment;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MuteRepliesModel muteRepliesModel = ref.watch(muteRepliesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(replyTitle)),
      body: StreamBuilder<QuerySnapshot>(
          // streamにqueryのようなものを入れる
          stream: commentDoc.reference
              .collection("postCommentReplies")
              .orderBy("likeCount", descending: true)
              .limit(30)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            } else if (!snapshot.hasData) {
              return const Text("データがありません");
            } else {
              final replyDocs = snapshot.data!.docs;
              return ListView(
                // DocumentSnapshot<Map<String,dynamic>>は不可
                children: replyDocs.map((DocumentSnapshot replyDoc) {
                  final Map<String, dynamic> data =
                      replyDoc.data()! as Map<String, dynamic>;
                  final Reply reply = Reply.fromJson(data);
                  return ReplyCard(
                      onTap: () => voids.showPopup(
                          context: context,
                          builder: (BuildContext innerContext) =>
                              CupertinoActionSheet(actions: [
                                CupertinoActionSheetAction(
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(innerContext);
                                    muteUsersModel.showMuteUserDialog(
                                        context: context,
                                        mainModel: mainModel,
                                        passiveUid: reply.uid,
                                        docs: []);
                                  },
                                  child: const Text(muteUserText),
                                ),
                                CupertinoActionSheetAction(
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(innerContext);
                                    // リアルタイム取得なので表示しなければ良い
                                    muteRepliesModel.showMuteReplyDialog(
                                        context: context,
                                        mainModel: mainModel,
                                        replyDoc: replyDoc);
                                  },
                                  child: const Text(muteReplyText),
                                ),
                              ])),
                      comment: comment,
                      reply: reply,
                      replyDoc: replyDoc,
                      mainModel: mainModel);
                }).toList(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(
            Icons.new_label,
            color: Colors.white,
          ),
          onPressed: () => repliesModel.showReplyFlashBar(
              context: context,
              mainModel: mainModel,
              comment: comment,
              commentDoc: commentDoc)),
    );
  }
}
