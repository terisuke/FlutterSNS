// flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
// constants
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/constants/ints.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
// domain
import 'package:udemy_flutter_sns/domain/timeline/timeline.dart';

final homeProvider = ChangeNotifierProvider(((ref) => HomeModel()));

class HomeModel extends ChangeNotifier {
  // フォローしているユーザーの投稿の取得に使用する
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  User currentUser = returnAuthUser()!;
  List<String> muteUids = [];
  List<String> mutePostIds = [];
  List<DocumentSnapshot<Map<String, dynamic>>> timelineDocs = [];
  final RefreshController refreshController = RefreshController();
  Query<Map<String, dynamic>> returnQuery(
      {required QuerySnapshot<Map<String, dynamic>> timelinesQshot}) {
    // timelineを取得したい
    final List<String> max10TimelinePostIds = timelinesQshot.docs
        .map((e) => Timeline.fromJson(e.data()).postId)
        .toList();
    if (max10TimelinePostIds.isEmpty) {
      max10TimelinePostIds.add(""); // whereInは中身が空だとerrorを返す
    }
    return FirebaseFirestore.instance
        .collectionGroup("posts")
        .where("postId", whereIn: max10TimelinePostIds)
        .limit(tenCount);
  }

  HomeModel() {
    init();
  }

  Future<void> init() async {
    final muteUidsAndMutePostIds = await returnMuteUidsAndMutePostIds();
    muteUids = muteUidsAndMutePostIds.first;
    mutePostIds = muteUidsAndMutePostIds.last;
    await onReload();
  }

  Future<void> onRefresh() async {
    final timelinesQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("timelines")
        .orderBy("createdAt", descending: true)
        .endAtDocument(timelineDocs.first)
        .limit(tenCount)
        .get();
    for (final doc in timelinesQshot.docs.reversed.toList()) {
      timelineDocs.insert(0, doc);
    }
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(timelinesQshot: timelinesQshot));
    notifyListeners();
  }

  Future<void> onReload() async {
    final timelinesQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("timelines")
        .orderBy("createdAt", descending: true)
        .limit(tenCount)
        .get();
    timelineDocs = timelinesQshot.docs;
    if (timelineDocs.isNotEmpty) {
      await voids.processBasicDocs(
          muteUids: muteUids,
          mutePostIds: mutePostIds,
          docs: postDocs,
          query: returnQuery(timelinesQshot: timelinesQshot));
    }
    notifyListeners();
  }

  Future<void> onLoading() async {
    final timelinesQshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("timelines")
        .orderBy("createdAt", descending: true)
        .startAfterDocument(timelineDocs.last)
        .limit(tenCount)
        .get();
    for (final doc in timelinesQshot.docs) {
      timelineDocs.add(doc);
    }
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery(timelinesQshot: timelinesQshot));
    notifyListeners();
  }
}
