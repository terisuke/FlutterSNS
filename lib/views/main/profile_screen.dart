// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/main/profile_model.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final int followerCount = firestoreUser.followerCount;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserImage(
          length: 160.0,
          userImageURL: mainModel.firestoreUser.userImageURL,
        ),
        Text(
          firestoreUser.userName,
          style: const TextStyle(fontSize: 32.0),
        ),
        Text(
          "フォロー中${firestoreUser.followingCount.toString()}",
          style: const TextStyle(fontSize: 32.0),
        ),
        Text(
          "フォロワー${followerCount.toString()}",
          style: const TextStyle(fontSize: 32.0),
        ),
        RoundedButton(
            onPressed: () => routes.toEditProfilePage(
                context: context, mainModel: mainModel),
            widthRate: 0.85,
            color: Colors.purple,
            text: editProfileText)
      ],
    );
  }
}
