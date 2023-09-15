// flutter
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
import 'package:udemy_flutter_sns/models/comments_model.dart';
import 'package:udemy_flutter_sns/models/main/home_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
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
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final postDocs = homeModel.postDocs;
    return homeModel.postDocs.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RoundedButton(
                    onPressed: () async => await homeModel.onReload(),
                    widthRate: 0.85,
                    color: Colors.green,
                    text: reloadText),
              )
            ],
          )
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
                              final Post post = Post.fromJson(postDoc.data()!);
                              return PostCard(
                                  onTap: () => muteUsersModel.showPopup(
                                      context: context,
                                      mainModel: mainModel,
                                      passiveUid: post.uid,
                                      docs: postDocs),
                                  post: post,
                                  postDoc: postDoc,
                                  mainModel: mainModel,
                                  postsModel: postsModel,
                                  commentsModel: commentsModel);
                            }),
                      ),
                    )
            ],
          );
  }
}
