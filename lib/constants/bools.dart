import 'package:cloud_firestore/cloud_firestore.dart';

bool isValidUser(
        {required List<String> muteUids, required DocumentSnapshot doc, required Map<String, dynamic> map}) =>
    !muteUids.contains(doc["uid"]);
