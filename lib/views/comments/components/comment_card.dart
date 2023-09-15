// flutter
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
// components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/replies_model.dart';
import 'package:udemy_flutter_sns/views/comments/components/comment_like_button.dart';
// domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(
      {Key? key,
      required this.onTap,
      required this.mainModel,
      required this.post,
      required this.comment,
      required this.commentDoc,
      required this.commentsModel})
      : super(key: key);
  final void Function()? onTap;
  final MainModel mainModel;
  final Post post;
  final Comment comment;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final CommentsModel commentsModel;
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      onTap: onTap,
      borderColor: Colors.green,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserImage(userImageURL: comment.userImageURL, length: 32.0),
              Text(
                comment.userName,
                style: const TextStyle(
                    fontSize: 24.0, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                comment.comment,
                style: const TextStyle(fontSize: 24.0),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  child: const Icon(Icons.comment),
                  onTap: () => routes.toRepliesPage(
                      context: context,
                      comment: comment,
                      commentDoc: commentDoc,
                      mainModel: mainModel)),
              CommentLikeButton(
                  mainModel: mainModel,
                  post: post,
                  comment: comment,
                  commentDoc: commentDoc,
                  commentsModel: commentsModel)
            ],
          )
        ],
      ),
    );
  }
}
