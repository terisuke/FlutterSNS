// flutter
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flash/flash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/chat_api.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

final createPostProvider = ChangeNotifierProvider(((ref) => CreatePostModel()));

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  final ChatAPI chatAPI = ChatAPI(); // Assuming ChatAPI is your API client
  @override
  void dispose() {
    textEditingController.dispose(); // これを忘れるとメモリリークする
    super.dispose();
  }
  Future<void> getSuggestion() async {
    try {
      final suggestion =
          await chatAPI.requestChatAPI(textEditingController.text);
      textEditingController.text = suggestion; // Or handle as you wish
      notifyListeners(); // If you wish to reflect changes on UI.
    } catch (e) {
      // Handle error accordingly
      print('Error getting suggestion: $e');
    }
  }
  Future<void> reviseText() async {
    try {
      final revisedText =
          await chatAPI.requestRevisionAPI(textEditingController.text);
      textEditingController.text = revisedText; // Or handle as you wish
      notifyListeners(); // If you wish to reflect changes on UI.
    } catch (e) {
      // Handle error accordingly
      print('Error revising text: $e');
    }
  }


  void showPostFlashBar(
      {required BuildContext context, required MainModel mainModel}) {
    context.showFlash(
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          content: Form(
            child: TextFormField(
              controller: textEditingController,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLength: 280,
            ),
          ),
          actions: [
            InkWell(
              onTap: getSuggestion,
              child:
                  const Icon(Icons.lightbulb_outline), // Or any suitable icon
            ),
            InkWell(
              onTap: reviseText,
              child: const Icon(Icons.edit), // Or any suitable icon
            ),
            InkWell(
              onTap: () {
                if (textEditingController.text.isNotEmpty) {
                  createPost(
                      currentUserDoc: mainModel.currentUserDoc,
                      mainModel: mainModel);
                  controller.dismiss();
                  textEditingController.clear();
                } else {
                  controller.dismiss();
                }
              },
              child: const Icon(Icons.send),
            ),
            InkWell(
              child: const Icon(Icons.close),
              onTap: () => controller.dismiss(),
            ),
          ],
        );
      },
      persistent: true,
    );
  }

  Future<void> createPost(
      {required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    final String text = textEditingController.text;
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Post post = Post(
        createdAt: now,
        hashTags: [],
        imageURL: "",
        likeCount: 0,
        text: text,
        textLanguageCode: "",
        textNagativeScore: 0,
        textPositiveScore: 0,
        textSentiment: "",
        postCommentCount: 0,
        postId: postId,
        reportCount: 0,
        muteCount: 0,
        uid: activeUid,
        userImageURL: firestoreUser.userImageURL,
        userName: firestoreUser.userName,
        userNameLanguageCode: firestoreUser.userNameLanguageCode,
        userNameNagativeScore: firestoreUser.userNameNagativeScore,
        userNamePositiveScore: firestoreUser.userNamePositiveScore,
        userNameSentiment: firestoreUser.userNameSentiment,
        updatedAt: now);
    await currentUserDoc.reference
        .collection("posts")
        .doc(postId)
        .set(post.toJson());
    await voids.showFluttertoast(msg: createdPostMsg);
  }
}
