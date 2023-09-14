// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/models/main/home_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/posts_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  onRefresh: () async => await homeModel.onRefresh(),
                  onLoading: () async => await homeModel.onLoading(),
                  controller: homeModel.refreshController,
                  child: ListView.builder(
                      itemCount: postDocs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final postDoc = postDocs[index];
                        final Post post = Post.fromJson(postDoc.data()!);
                        return ListTile(
                          leading: UserImage(
                              length: 32,
                              userImageURL:
                                  post.uid == mainModel.firestoreUser.uid
                                      ? mainModel.firestoreUser.userImageURL
                                      : post.imageURL),
                          trailing: mainModel.likePostIds.contains(post.postId)
                              ? InkWell(
                                  child: const Icon(Icons.favorite,
                                      color: Colors.red),
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
                          title: Text(post.text),
                        );
                      }),
                ),
              )
            ],
          );
  }
}
