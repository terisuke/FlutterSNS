// flutter
import 'package:flutter/cupertino.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;

final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  SortState sortState = SortState.byNewestFirst;
  final RefreshController refreshController = RefreshController();
  List<String> muteUids = [];
  List<String> mutePostIds = [];
  Query<Map<String, dynamic>> returnQuery() {
    final User? currentUser = returnAuthUser();
    final Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('posts');
    switch (sortState) {
      case SortState.byLikeUidCount:
        return query.orderBy("likeCount", descending: true);
      case SortState.byNewestFirst:
        return query.orderBy("createdAt", descending: true);
      case SortState.byOldestFirst:
        return query.orderBy("createdAt", descending: false);
    }
  }

  ProfileModel() {
    init();
  }

  Future<void> init() async {
    final muteUidsAndMutePostIds = await returnMuteUidsAndMutePostIds();
    muteUids = muteUidsAndMutePostIds.first;
    mutePostIds = muteUidsAndMutePostIds.last;
    await onReload();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery());
    notifyListeners();
  }

  Future<void> onReload() async {
    await voids.processBasicDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery());
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUids: muteUids,
        mutePostIds: mutePostIds,
        docs: postDocs,
        query: returnQuery());
    notifyListeners();
  }

  void onMenuPressed({required BuildContext context}) {
    voids.showPopup(
        context: context,
        builder: (innerContext) {
          return CupertinoActionSheet(
            message: const Text("操作を選択"),
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    if (sortState != SortState.byLikeUidCount) {
                      sortState = SortState.byLikeUidCount;
                      await onReload();
                    }
                    Navigator.pop(innerContext);
                  },
                  isDestructiveAction: true,
                  child: const Text("いいね順に並び替え")),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    if (sortState != SortState.byNewestFirst) {
                      sortState = SortState.byNewestFirst;
                      await onReload();
                    }
                    Navigator.pop(innerContext);
                  },
                  isDestructiveAction: true,
                  child: const Text("新しい順に並び替え")),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    if (sortState != SortState.byOldestFirst) {
                      sortState = SortState.byOldestFirst;
                      await onReload();
                    }
                    Navigator.pop(innerContext);
                  },
                  isDestructiveAction: true,
                  child: const Text("古い順に並び替え")),
              CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(innerContext),
                  child: const Text(backText)),
            ],
          );
        });
  }
}
