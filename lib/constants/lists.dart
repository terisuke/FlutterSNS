// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';
import 'package:udemy_flutter_sns/domain/mute_post_token/mute_post_token.dart';

Future<List<List<String>>> returnMuteUidsAndMutePostIds() async {
  //　リストの1つにmuteUids、二つ目にmutePostIdsを含める
  // firebase authのユーザーをreturnしている
  final User? user = returnAuthUser();
  final tokensQshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("tokens")
      .get();
  final tokenDocs = tokensQshot.docs;
  // 端的な正解
  final List<String> muteUids = tokenDocs
      .where((element) => element["tokenType"] == muteUserTokenTypeString)
      .map((e) => MuteUserToken.fromJson(e.data()).passiveUid)
      .toList();
  final List<String> mutePostIds = tokenDocs
      .where((element) => element["tokenType"] == mutePostTokenTypeString)
      .map((e) => MutePostToken.fromJson(e.data()).postId)
      .toList();
  return [muteUids, mutePostIds];
}

List<String> returnSearchWords({required String searchTerm}) {
  // 1文字づつに分割
  // ["私","は",........]
  List<String> afterSplit = searchTerm.split("");
  // firebaseで検索に使用できないフィールドを削除
  // {
  //   "私は": true,
  //   "はプ": true,
  // }
  const List<String> notUseOnField = [".", "[", "]", "*", "`"];
  afterSplit.removeWhere((element) => notUseOnField.contains(element));
  String result = "";
  for (final String element in afterSplit) {
    // 小文字にする
    final x = element.toLowerCase();
    result += x;
  }
  // bi-gram
  final int lenght = result.length;
  List<String> searchWords = [];
  const nGramIndex = 2;
  if (lenght < nGramIndex) {
    searchWords.add(result);
  } else {
    int termIndex = 0;
    for (int i = 0; i < lenght - nGramIndex + 1; i++) {
      final String word = result.substring(termIndex, termIndex + nGramIndex);
      searchWords.add(word);
      termIndex++;
    }
  }
  return searchWords;
}
