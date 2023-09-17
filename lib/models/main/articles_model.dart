// dart
import 'dart:convert';
// flutter
import 'package:flutter/material.dart';
// packages
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
import 'package:udemy_flutter_sns/domain/article/article.dart';

final articlesProvider = ChangeNotifierProvider(((ref) => ArticlesModel()));

class ArticlesModel extends ChangeNotifier {
  List<dynamic> jsons = [];
  List<Article> articles = [];

  ArticlesModel() {
    init();
  }

  Future<void> init() async {
    const String uri = "https://qiita.com/api/v2/items";
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      jsons = json.decode(response.body); // response中身をdecode
      articles = jsons.map((e) => Article.fromJson(e)).toList();
      // 成功
    } else {
      // 失敗
      await voids.showFluttertoast(msg: "リクエストが失敗しました");
    }
  }
}
