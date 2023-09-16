// flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
// components
import 'package:udemy_flutter_sns/details/card_container.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/details/post_like_button.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
// model
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_posts_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    Key? key,
    required this.post,
    required this.index,
    required this.postDocs,
    required this.mainModel,
  }) : super(key: key);
  final Post post;
  final List<DocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int index;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final bool isMyPost = post.uid == firestoreUser.uid;
    final PostsModel postsModel = ref.watch(postsProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final MutePostsModel mutePostsModel = ref.watch(mutePostsProvider);
    final postDoc = postDocs[index];
    return CardContainer(
      onTap: () => voids.showPopup(
          context: context,
          builder: (BuildContext innerContext) =>
              CupertinoActionSheet(actions: [
                CupertinoActionSheetAction(
                  /// This parameter indicates the action would perform
                  /// a destructive action such as delete or exit and turns
                  /// the action's text color to red.
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(innerContext);
                    muteUsersModel.showMuteUserDialog(
                        context: context,
                        mainModel: mainModel,
                        passiveUid: post.uid,
                        docs: commentsModel.commentDocs);
                  },
                  child: const Text(muteUserText),
                ),
                CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(innerContext);
                    mutePostsModel.showMutePostDialog(
                        context: context,
                        mainModel: mainModel,
                        postDoc: postDoc,
                        postDocs: postDocs);
                  },
                  child: const Text(mutePostText),
                ),
                CupertinoActionSheetAction(
                  /// This parameter indicates the action would be a default
                  /// defualt behavior, turns the action's text to bold text.
                  onPressed: () => Navigator.pop(innerContext),
                  child: const Text(backText),
                ),
              ])),
      borderColor: Colors.green,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserImage(
                  length: 32.0,
                  userImageURL:
                      isMyPost ? firestoreUser.userImageURL : post.imageURL),
              Text(isMyPost ? firestoreUser.userName : post.userName)
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
