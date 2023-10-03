// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/main/user_search_model.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';
import 'package:udemy_flutter_sns/views/main/components/search_screen.dart';

class UserSearchScreen extends ConsumerWidget {
  const UserSearchScreen({
    Key? key,
    required this.mainModel,
    required this.passiveUserProfileModel,
  }) : super(key: key);
  final MainModel mainModel;
  final PassiveUserProfileModel passiveUserProfileModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserSearchModel userSearchModel = ref.watch(userSearchProvider);
    final userDocs = userSearchModel.userDocs;
    return SearchScreen(
        onQueryChanged: (text) async {
          userSearchModel.searchTerm = text;
          await userSearchModel.opearation(
              muteUids: mainModel.muteUids, mutePostIds: mainModel.mutePostIds);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: ListView.builder(
              itemCount: userDocs.length,
              itemBuilder: ((context, index) {
                // usersの配列から1個1個取得している
                final userDoc = userDocs[index];
                final FirestoreUser firestoreUser =
                    FirestoreUser.fromJson(userDoc.data()!);
                return ListTile(
                    title: Text(firestoreUser.userName),
                    onTap: () async =>
                        await passiveUserProfileModel.onUserIconPressed(
                            context: context,
                            mainModel: mainModel,
                            passiveUserDoc: userDoc));
              })),
        ));
  }
}
