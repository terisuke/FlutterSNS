import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article(
      {required String id,
      required int comments_count,
      required int likes_count,
      required bool private,
      required int reactions_count,
      @Default('') String title,
      @Default('') String url,
      required dynamic user}) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
