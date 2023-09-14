// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/post/post.dart';

final adminProvider = ChangeNotifierProvider(((ref) => AdminModel()));

class AdminModel extends ChangeNotifier {
  Future<void> admin() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final String activeUid = returnAuthUser()!.uid;
    for (int i = 0; i < 100; i++) {
      final Timestamp now = Timestamp.now();
      final String postId = returnUuidV4();
      final Post post = Post(
        createdAt: now,
        hashTags: [],
        imageURL: "",
        likeCount: 0,
        text: i.toString(),
        postId: postId,
        uid: activeUid,
        updatedAt: now,
      );
      final DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore
          .instance
          .collection("users")
          .doc(activeUid)
          .collection("posts")
          .doc(postId);
      batch.set(ref, post.toJson());
    }
    await batch.commit();
  }
}
