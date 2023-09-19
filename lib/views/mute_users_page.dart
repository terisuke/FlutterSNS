// flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class MuteUsersPage extends ConsumerWidget {
  const MuteUsersPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MuteUsersModel muteUsersModel = ref.watch(muteUsersProvider);
    final muteUserDocs = muteUsersModel.muteUserDocs;
    return Scaffold(
      appBar: AppBar(
        title: const Text(muteUsersPageTitle),
      ),
      body: muteUsersModel.showMuteUsers
          ? RefreshScreen(
              onRefresh: () async => await muteUsersModel.onRefresh(),
              onLoading: () async => await muteUsersModel.onLoading(),
              refreshController: muteUsersModel.refreshController,
              child: ListView.builder(
                  itemCount: muteUserDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final muteUserDoc = muteUserDocs[index];
                    final FirestoreUser muteFirestoreUser =
                        FirestoreUser.fromJson(muteUserDoc.data()!);
                    return ListTile(
                      title: Text(muteFirestoreUser.userName),
                      onTap: () => voids.showPopup(
                          context: context,
                          builder: (BuildContext innerContext) =>
                              CupertinoActionSheet(actions: [
                                CupertinoActionSheetAction(
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(innerContext);
                                    muteUsersModel.showMuteUserDialog(
                                        context: context,
                                        mainModel: mainModel,
                                        passiveUid: muteUserDoc.id,
                                        docs: muteUserDocs);
                                  },
                                  child: const Text(muteUserText),
                                ),
                              ])),
                    );
                  }))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                    onPressed: () async =>
                        await muteUsersModel.getMuteUsers(mainModel: mainModel),
                    widthRate: 0.85,
                    color: Colors.blue,
                    text: showMuteUsersText)
              ],
            ),
    );
  }
}
