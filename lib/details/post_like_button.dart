// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class PostLikeButton extends StatelessWidget {
  const PostLikeButton(
      {Key? key,
      required this.mainModel,
      required this.post,
      required this.postsModel,
      required this.postDoc})
      : super(key: key);
  final MainModel mainModel;
  final Post post;
  final PostsModel postsModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  @override
  Widget build(BuildContext context) {
    final int plusOneCount = post.likeCount + 1;
    final bool isLike = mainModel.likePostIds.contains(post.postId);
    return Row(
      children: [
        Container(
          child: isLike
              ? InkWell(
                  child: const Icon(Icons.favorite, color: Colors.red),
                  onTap: () async => await postsModel.unlike(
                      post: post,
                      postDoc: postDoc,
                      postRef: postDoc.reference,
                      mainModel: mainModel),
                )
              : InkWell(
                  child: const Icon(
                    Icons.favorite,
                  ),
                  onTap: () async => await postsModel.like(
                      post: post,
                      postDoc: postDoc,
                      postRef: postDoc.reference,
                      mainModel: mainModel),
                ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                isLike ? plusOneCount.toString() : post.likeCount.toString()))
      ],
    );
  }
}
