// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
// components
import 'package:udemy_flutter_sns/details/user_header.dart';
import 'package:udemy_flutter_sns/details/post_card.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage(
      {Key? key, required this.passiveUserDoc, required this.mainModel})
      : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> passiveUserDoc;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    final FirestoreUser passiveUser =
        FirestoreUser.fromJson(passiveUserDoc.data()!);
    final postDocs = passiveUserProfileModel.postDocs;
    final muteUids = mainModel.muteUids;

    return Scaffold(
        appBar: AppBar(
          title: const Text(profileTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserHeader(
                firestoreUser: passiveUser,
                mainModel: mainModel,
                onTap: () => passiveUserProfileModel.onMenuPressed(
                    context: context,
                    muteUids: muteUids,
                    mutePostIds: mainModel.mutePostIds,
                    passiveUserDoc: passiveUserDoc),
              ),
              postDocs.isEmpty
                  ? ReloadScreen(
                      onReload: () async =>
                          await passiveUserProfileModel.onReload(
                              passiveUserDoc: passiveUserDoc,
                              muteUids: muteUids))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: RefreshScreen(
                        onRefresh: () async =>
                            await passiveUserProfileModel.onRefresh(
                                passiveUserDoc: passiveUserDoc,
                                muteUids: muteUids),
                        onLoading: () async =>
                            await passiveUserProfileModel.onLoading(
                                passiveUserDoc: passiveUserDoc,
                                muteUids: muteUids),
                        refreshController:
                            passiveUserProfileModel.refreshController,
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
