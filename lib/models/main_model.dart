// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';
import 'package:udemy_flutter_sns/domain/like_post_token/like_post_token.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;
  late User? currentUser;
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;
  late FirestoreUser firestoreUser;
  // tokens
  List<FollowingToken> followingTokens = [];
  List<String> followingUids = [];
  List<LikePostToken> likePostTokens = [];
  List<String> likePostIds = [];
  //以下がMainModelが起動した時の処理
  // ユーザーの動作を必要としないモデルの関数
  MainModel() {
    init();
  }
  // initの中でcurrentUserを更新すれば良い
  Future<void> init() async {
    startLoading();
    // modelを跨がないでcurrentUserの更新
    currentUser = FirebaseAuth.instance.currentUser;
    // hcbXO8Rs4PPGua2vlPL92XTmpJj1
    currentUserDoc = await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .doc(currentUser!.uid)
        .get();
    await distributeTokens();
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    // currentUserのuidの取得が可能になりました
    endLoading();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> logout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    routes.toLoginPage(context: context);
  }

  Future<void> distributeTokens() async {
    final tokensQshot =
        await currentUserDoc.reference.collection("tokens").get();
    final tokenDocs = tokensQshot.docs;
    // 新しい順に並べる
    // 古い順に並べるなら、aとbを逆にする
    tokenDocs.sort(
        (a, b) => (b["createdAt"] as Timestamp).compareTo(a["createdAt"]));
    for (final token in tokenDocs) {
      final Map<String, dynamic> tokenMap = token.data();
      // Stringからenumに変換してミスのないようにしたい
      final TokenType tokenType = mapToTokenType(tokenMap: tokenMap);
      switch (tokenType) {
        case TokenType.following:
          final FollowingToken followingToken =
              FollowingToken.fromJson(tokenMap);
          followingTokens.add(followingToken);
          followingUids.add(followingToken.passiveUid);
          break;
        case TokenType.likePost:
          final LikePostToken likePostToken = LikePostToken.fromJson(tokenMap);
          likePostTokens.add(likePostToken);
          likePostIds.add(likePostToken.postId);
          break;
      }
    }
  }
}
