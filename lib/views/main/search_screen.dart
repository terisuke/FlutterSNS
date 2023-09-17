// flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/main/search_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchModel searchModel = ref.watch(searchProvider);
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    final userDocs = searchModel.userDocs;
    return FloatingSearchBar(
      onQueryChanged: (text) async {
        searchModel.searchTerm = text;
        await searchModel.operation(muteUids: mainModel.muteUids);
      },
      clearQueryOnClose: true,
      body: IndexedStack(children: [
        FloatingSearchBarScrollNotifier(
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
                })))
      ]),
      builder: (context, transition) {
        return Container();
      },
    );
  }
}
