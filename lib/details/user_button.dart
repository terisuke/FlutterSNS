// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/passive_user_profile_model.dart';

class UserButton extends ConsumerWidget {
  const UserButton(
      {Key? key, required this.mainModel, required this.passiveUser})
      : super(key: key);
  final MainModel mainModel;
  final FirestoreUser passiveUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String passiveUid = passiveUser.uid;
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    return mainModel.currentUserDoc.id == passiveUid
        ? // 自分か本人か。自分なら編集するためのボタンをリターン。違うならフォロー、アンフォローボタンをリターン
        RoundedButton(
            onPressed: () => routes.toEditProfilePage(
                context: context, mainModel: mainModel),
            widthRate: 0.85,
            color: Colors.purple,
            text: editProfileText)
        : mainModel.followingUids.contains(passiveUid)
            ? RoundedButton(
                onPressed: () async => await passiveUserProfileModel.unfollow(
                    mainModel: mainModel, passiveUser: passiveUser),
                widthRate: 0.85,
                color: Colors.red,
                text: "アンフォローする")
            : RoundedButton(
                onPressed: () async => await passiveUserProfileModel.follow(
                    mainModel: mainModel, passiveUser: passiveUser),
                widthRate: 0.85,
                color: Colors.green,
                text: "フォローする",
              );
  }
}
