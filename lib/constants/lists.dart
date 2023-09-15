import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/domain/mute_user_token/mute_user_token.dart';

Future<List<String>> returnMuteUids() async {
  //　リストの1つにmuteUids、二つ目にmutePostIdsを含める
  // firebase authのユーザーをreturnしている
  final User? user = returnAuthUser();
  final tokensQshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("tokens")
      .get();
  final tokenDocs = tokensQshot.docs;
  final List<String> muteUids = tokenDocs
      .where((element) => element["tokenType"] == muteUserTokenTypeString)
      .map((e) => MuteUserToken.fromJson(e.data()).passiveUid)
      .toList();
  return muteUids;
}
