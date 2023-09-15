// flutter
// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/create_post_model.dart';
import 'package:udemy_flutter_sns/models/main/home_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_posts_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
    required this.mainModel,
  }) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final CreatePostModel createPostModel = ref.watch(createPostProvider);
    final MutePostsModel mutePostsModel = ref.watch(mutePostsProvider);
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final postDocs = homeModel.postDocs;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.new_label),
          onPressed: () => createPostModel.showPostFlashBar(
              context: context, mainModel: mainModel)),
      body: homeModel.postDocs.isEmpty
          ? ReloadScreen(onReload: (() async => await homeModel.onReload()))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                postDocs.isEmpty
                    ? ReloadScreen(
                        onReload: () async => await homeModel.onReload())
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: RefreshScreen(
                          onRefresh: () async => await homeModel.onRefresh(),
                          onLoading: () async => await homeModel.onLoading(),
                          refreshController: homeModel.refreshController,
                          child: ListView.builder(
                              itemCount: postDocs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final postDoc = postDocs[index];
                                final Post post =
                                    Post.fromJson(postDoc.data()!);
                                return PostCard(
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
                                                  muteUsersModel
                                                      .showMuteUserDialog(
                                                          context: context,
                                                          mainModel: mainModel,
                                                          passiveUid: post.uid,
                                                          docs: commentsModel
                                                              .commentDocs);
                                                },
                                                child: const Text(muteUserText),
                                              ),
                                              CupertinoActionSheetAction(
                                                isDestructiveAction: true,
                                                onPressed: () {
                                                  Navigator.pop(innerContext);
                                                  mutePostsModel
                                                      .showMutePostDialog(
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
                                                onPressed: () =>
                                                    Navigator.pop(innerContext),
                                                child: const Text(backText),
                                              ),
                                            ])),
                                    post: post,
                                    postDoc: postDoc,
                                    mainModel: mainModel,
                                    postsModel: postsModel,
                                    commentsModel: commentsModel);
                              }),
                        ),
                      )
              ],
            ),
    );
  }
}
