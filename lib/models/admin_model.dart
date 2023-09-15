// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';

final adminProvider = ChangeNotifierProvider(((ref) => AdminModel()));

class AdminModel extends ChangeNotifier {
  Future<void> admin(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser}) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final postsQshot = await currentUserDoc.reference.collection("posts").get();
    for (final post in postsQshot.docs) {
      batch.update(post.reference, {
        "postCommentCount": 0,
      });
    }
    await batch.commit();
  }
}
