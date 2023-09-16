// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/main/search_model.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
// model
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
    return ListView.builder(
      itemCount: searchModel.userDocs.length,
      itemBuilder: (context, index) {
        final userDoc = searchModel.userDocs[index];
        final firestoreUser = FirestoreUser.fromJson(userDoc.data()!);
        return ListTile(
            title: Text(firestoreUser.uid),
            onTap: () async => await passiveUserProfileModel.onUserIconPressed(
                context: context,
                mainModel: mainModel,
                passiveUserDoc: userDoc));
      },
    );
  }
}
