// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/post_like_button.dart';
// constants
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/models/comments_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    Key? key,
    required this.onTap,
    required this.post,
    required this.postDoc,
    required this.mainModel,
    required this.postsModel,
    required this.commentsModel,
  }) : super(key: key);
  final void Function()? onTap;
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;
  final PostsModel postsModel;
  final CommentsModel commentsModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardContainer(
      onTap: onTap,
      borderColor: Colors.green,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserImage(length: 32.0, userImageURL: post.imageURL),
            ],
          ),
          Row(
            children: [
              Text(
                post.text,
                style: const TextStyle(fontSize: 24.0),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
                child: const Icon(Icons.comment),
                onTap: () async => await commentsModel.onCommentButtonPressed(
                    context: context,
                    post: post,
                    postDoc: postDoc,
                    mainModel: mainModel)),
            PostLikeButton(
                mainModel: mainModel,
                post: post,
                postsModel: postsModel,
                postDoc: postDoc),
          ])
        ],
      ),
    );
  }
}
