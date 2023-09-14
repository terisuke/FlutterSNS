// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flash/flash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

final createPostProvider = ChangeNotifierProvider(((ref) => CreatePostModel()));

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String text = "";
  void showPostFlashBar(
      {required BuildContext context, required MainModel mainModel}) {
    context.showFlashBar(
      persistent: true,
      content: Form(
          child: TextFormField(
        controller: textEditingController,
        style: const TextStyle(fontWeight: FontWeight.bold),
        onChanged: (value) => text = value,
        maxLength: 10,
      )),
      title: const Text(createPostTitle),
      primaryActionBuilder: (context, controller, _) {
        return InkWell(
          onTap: () async {
            if (textEditingController.text.isNotEmpty) {
              // メインの動作
              await createPost(mainModel: mainModel);
              await controller.dismiss();
              text = "";
            } else {
              // 何もしない
              await controller.dismiss();
            }
          },
          child: const Icon(Icons.send),
        );
      },
      // 閉じる時の動作
      negativeActionBuilder: (context, controller, _) {
        return InkWell(
          child: const Icon(Icons.close),
          onTap: () async => await controller.dismiss(),
        );
      },
    );
  }

  Future<void> createPost({required MainModel mainModel}) async {
    final Timestamp now = Timestamp.now();
    final DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
        mainModel.currentUserDoc;
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Post post = Post(
        createdAt: now,
        hashTags: [],
        imageURL: "",
        likeCount: 0,
        text: text,
        postId: postId,
        userImageURL: firestoreUser.userImageURL,
        userName: firestoreUser.userName,
        uid: activeUid,
        updatedAt: now);
    await currentUserDoc.reference
        .collection("posts")
        .doc(postId)
        .set(post.toJson());
  }
}
