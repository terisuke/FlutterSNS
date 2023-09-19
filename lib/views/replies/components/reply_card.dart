// flutter
import 'package:flutter/material.dart';
import 'package:udemy_flutter_sns/constants/bools.dart';
// components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
import 'package:udemy_flutter_sns/domain/reply/reply.dart';
import 'package:udemy_flutter_sns/models/replies_model.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/views/replies/components/reply_like_button.dart';

class ReplyCard extends ConsumerWidget {
  const ReplyCard(
      {Key? key,
      required this.onTap,
      required this.comment,
      required this.reply,
      required this.replyDoc,
      required this.mainModel})
      : super(key: key);
  final void Function()? onTap;
  final Comment comment;
  final Reply reply;
  final DocumentSnapshot replyDoc;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);

    return isValidUser(
                muteUids: mainModel.muteUids,
                map: replyDoc.data() as Map<String, dynamic>) &&
            isValidReply(muteReplyIds: mainModel.muteReplyIds, reply: reply)
        ? CardContainer(
            onTap: onTap,
            borderColor: Colors.green,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserImage(userImageURL: reply.userImageURL, length: 32.0),
                    Text(
                      reply.userName,
                      style: const TextStyle(
                          fontSize: 24.0, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      reply.reply,
                      style: const TextStyle(
                          fontSize: 24.0, overflow: TextOverflow.ellipsis),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    ReplyLikeButton(
                        mainModel: mainModel,
                        comment: comment,
                        reply: reply,
                        replyDoc: replyDoc,
                        repliesModel: repliesModel)
                  ],
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
