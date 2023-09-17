// flutter
import 'package:flutter/material.dart';
import 'package:udemy_flutter_sns/details/user_button.dart';
// components
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class UserHeader extends StatelessWidget {
  const UserHeader(
      {Key? key,
      required this.mainModel,
      required this.firestoreUser,
      required this.onTap})
      : super(key: key);
  final MainModel mainModel;
  final FirestoreUser firestoreUser;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(children: [
        Row(
          children: [
            UserImage(userImageURL: firestoreUser.userImageURL, length: 30.0),
            Text(
              firestoreUser.userName,
              style: const TextStyle(fontSize: 32.0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "フォロー中${firestoreUser.followingCount.toString()}",
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              "フォロワー${firestoreUser.followerCount.toString()}",
              style: const TextStyle(fontSize: 16.0),
            ),
            InkWell(
              onTap: onTap,
              child: const Icon(Icons.menu),
            )
          ],
        ),
        UserButton(mainModel: mainModel, passiveUser: firestoreUser)
      ]),
    );
  }
}
