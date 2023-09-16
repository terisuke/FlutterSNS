// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';

final searchProvider = ChangeNotifierProvider(((ref) => SearchModel()));

class SearchModel extends ChangeNotifier {
  List<DocumentSnapshot<Map<String, dynamic>>> userDocs = [];
  SearchModel() {
    init();
  }

  Future<void> init() async {
    final qshot = await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .limit(30)
        .get();
    userDocs = qshot.docs;
  }
}
