// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter_sns/constants/enums.dart';
import 'package:udemy_flutter_sns/constants/lists.dart';
import 'package:udemy_flutter_sns/constants/maps.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/domain/follower/follower.dart';
import 'package:udemy_flutter_sns/domain/following_token/following_token.dart';

final adminProvider = ChangeNotifierProvider(((ref) => AdminModel()));

class AdminModel extends ChangeNotifier {
  Future<void> admin() async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final userDocs = await FirebaseFirestore.instance.collection('users').get();
    for (final userDoc in userDocs.docs) {
      batch.update(userDoc.reference, {
        "searchToken": returnSearchToken(
            searchWords: returnSearchWords(searchTerm: userDoc["userName"])),
        "postCount": 0,
        "userNameLanguageCode": "",
        "userNameNagativeScore": 0,
        "userNamePositiveScore": 0,
        "userNameSentiment": "POSITIVE",
      });
      await Future.delayed(const Duration(milliseconds: 100));
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
