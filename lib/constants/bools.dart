import 'package:cloud_firestore/cloud_firestore.dart';

bool isValidUser(
        {required List<String> muteUids,
        required DocumentSnapshot<Map<String, dynamic>> doc}) =>
    !muteUids.contains(doc["uid"]);
