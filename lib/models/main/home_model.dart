// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:udemy_flutter_sns/constants/others.dart';

final homeProvider = ChangeNotifierProvider(((ref) => HomeModel()));

class HomeModel extends ChangeNotifier {
  // フォローしているユーザーの投稿の取得に使用する
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  final RefreshController refreshController = RefreshController();
  Query<Map<String, dynamic>> returnQuery() {
    final User? currentUser = returnAuthUser();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('posts')
        .orderBy("createdAt", descending: true)
        .limit(30);
  }

  HomeModel() {
    init();
  }

  Future<void> init() async {
    final query = returnQuery();
    final qshot = await query.get();
    postDocs = qshot.docs;
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    if (postDocs.isNotEmpty) {
      final qshot = await returnQuery().endBeforeDocument(postDocs.first).get();
      final reversed = qshot.docs.reversed.toList();
      for (final postDoc in reversed) {
        postDocs.insert(0, postDoc);
      }
      postDocs = qshot.docs;
    }
    notifyListeners();
  }

  Future<void> onReload() async {
    final qshot = await returnQuery().get();
    postDocs = qshot.docs;
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    if (postDocs.isNotEmpty) {
      final qshot = await returnQuery().startAfterDocument(postDocs.last).get();
      for (final postDoc in qshot.docs) {
        postDocs.add(postDoc);
      }
    }
    notifyListeners();
  }
}
