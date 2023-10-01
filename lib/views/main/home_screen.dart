// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
// components
import 'package:udemy_flutter_sns/details/sns_drawer.dart';
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
// model
import 'package:udemy_flutter_sns/models/main/home_model.dart';
import 'package:udemy_flutter_sns/models/create_post_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/themes_model.dart';
// domain
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(
      {Key? key,
      required this.mainModel,
      required this.muteUsersModel,
      required this.themeModel})
      : super(key: key);
  final MainModel mainModel;
  final MuteUsersModel muteUsersModel;
  final ThemeModel themeModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final CreatePostModel createPostModel = ref.watch(createPostProvider);
    final postDocs = homeModel.postDocs;
    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        drawer: SNSDrawer(
          mainModel: mainModel,
          themeModel: themeModel,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.new_label),
            onPressed: () => createPostModel.showPostFlashBar(
                context: context, mainModel: mainModel)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              postDocs.isEmpty
                  ? ReloadScreen(onReload: () async => homeModel.onReload())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: RefreshScreen(
                        onRefresh: () async => homeModel.onRefresh(),
                        onLoading: () async => homeModel.onLoading(),
                        refreshController: homeModel.refreshController,
                        child: ListView.builder(
                            itemCount: postDocs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final postDoc = postDocs[index];
                              final Post post = Post.fromJson(postDoc.data()!);
                              return PostCard(
                                  post: post,
                                  index: index,
                                  postDocs: postDocs,
                                  mainModel: mainModel);
                            }),
                      ),
                    )
            ],
          ),
        ));
  }
}
