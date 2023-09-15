// dart
import 'dart:io';
// flutter
import 'package:flutter/material.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
// domain
import 'package:udemy_flutter_sns/domain/user_update_log/user_update_log.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// constants
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
// model
import 'package:udemy_flutter_sns/models/main_model.dart';

final editProfileProvider =
    ChangeNotifierProvider(((ref) => EditProfileModel()));

class EditProfileModel extends ChangeNotifier {
  File? croppedFile;
  String userName = "";

  Future<void> updateUserInfo(
      {required BuildContext context, required MainModel mainModel}) async {
    String userImageURL = "";
    // userNameとcroppedがどっちもnullだったらやる必要ない
    if (!(userName.isEmpty && croppedFile == null)) {
      // userNameとcroppedFileどっちかの情報がある状態
      final currentUserDoc = mainModel.currentUserDoc;
      final firestoreUser = mainModel.firestoreUser;
      if (croppedFile != null) {
        userImageURL = await uploadImageAndGetURL(
            uid: currentUserDoc.id, file: croppedFile!);
      } else {
        // croppedFileがnullなら
        userImageURL = firestoreUser.userImageURL;
      }
      if (userName.isEmpty) {
        userName = firestoreUser.userName;
      }
      mainModel.updateFrontUserInfo(
          newUserName: userName, newUserImageURL: userImageURL);
      // 一つ前のページに戻る
      Navigator.pop(context);
      // idを指定する必要がない。なぜならアプリから呼び出すことが泣く、消すこともないから
      final UserUpdateLog updateLog = UserUpdateLog(
          logCreatedAt: Timestamp.now(),
          userName: userName,
          userImageURL: userImageURL,
          userRef: currentUserDoc.reference);
      // .doc()とidを指定しないと、勝手に生成してくれる
      await currentUserDoc.reference
          .collection("userUpdateLogs")
          .doc()
          .set(updateLog.toJson());
    }
  }

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String fileName = returnJpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putFile(file);
    // users/uid/ファイル名 のURLを取得している
    return await storageRef.getDownloadURL();
  }

  Future<void> onImageTapped() async {
    final XFile xFile = await returnXFile();
    croppedFile = await returnCroppedFile(xFile: xFile);
    notifyListeners();
  }
}
