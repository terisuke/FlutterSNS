// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udemy_flutter_sns/constants/routes.dart';
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/post_like_button.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main/home_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    Key? key,
    required this.post,
    required this.postDoc,
    required this.mainModel,
    required this.postsModel,
    required this.commentsModel,
  }) : super(key: key);
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;
  final PostsModel postsModel;
  final CommentsModel commentsModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardContainer(
      borderColor: Colors.green,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserImage(
                  length: 32.0,
                  userImageURL: post.uid == mainModel.firestoreUser.uid
                      ? mainModel.firestoreUser.userImageURL
                      : post.imageURL),
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
            PostLikeButton(
                mainModel: mainModel,
                post: post,
                postsModel: postsModel,
                postDoc: postDoc),
            InkWell(
                child: const Icon(Icons.comment),
                onTap: () async => await commentsModel.init(
                    context: context,
                    post: post,
                    postDoc: postDoc,
                    mainModel: mainModel))
          ])
        ],
      ),
    );
  }
}
