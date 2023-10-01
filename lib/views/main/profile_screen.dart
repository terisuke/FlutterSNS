// flutter
import 'package:flutter/cupertino.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/details/user_header.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/main/profile_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final postDocs = profileModel.postDocs;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserHeader(
            firestoreUser: firestoreUser,
            mainModel: mainModel,
            onTap: () => profileModel.onMenuPressed(context: context),
          ),
          profileModel.postDocs.isEmpty
              ? ReloadScreen(
                  onReload: (() async => await profileModel.onReload()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    postDocs.isEmpty
                        ? ReloadScreen(
                            onReload: () async => profileModel.onReload())
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: RefreshScreen(
                                  onRefresh: () async =>
                                      profileModel.onRefresh(),
                                  onLoading: () async =>
                                      profileModel.onLoading(),
                                  refreshController:
                                      profileModel.refreshController,
                                  child: ListView.builder(
                                      itemCount: postDocs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final postDoc = postDocs[index];
                                        final Post post =
                                            Post.fromJson(postDoc.data()!);
                                        return PostCard(
                                            post: post,
                                            index: index,
                                            postDocs: postDocs,
                                            mainModel: mainModel);
                                      }),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
        ],
      ),
    );
  }
}
