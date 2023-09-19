// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final adminProvider = ChangeNotifierProvider(((ref) => AdminModel()));

class AdminModel extends ChangeNotifier {
  Future<void> admin() async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    // posts
    final postsQshot =
        await FirebaseFirestore.instance.collectionGroup("posts").get();
    for (final post in postsQshot.docs) {
      batch.update(post.reference, {
        "reportCount": 0,
      });
    }
    // comments
    final commentsQshot =
        await FirebaseFirestore.instance.collectionGroup("postComments").get();
    for (final comment in commentsQshot.docs) {
      batch.delete(comment.reference);
    }
    // replies
    final repliesQshot = await FirebaseFirestore.instance
        .collectionGroup("postCommentReplies")
        .get();
    for (final reply in repliesQshot.docs) {
      batch.delete(reply.reference);
    }
    await batch.commit();
    Fluttertoast.showToast(
        msg: "動作が完了しました",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
