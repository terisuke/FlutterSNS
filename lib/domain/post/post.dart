import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required dynamic createdAt,
    required List<String> hashTags,
    required String imageURL,
    required int likeCount,
    required String text,
    required String textLanguageCode,
    required double textNagativeScore,
    required double textPositiveScore,
    required String textSentiment,
    required int postCommentCount,
    required String postId,
    required int reportCount,
    required int muteCount,
    required String uid,
    required String userName,
    required String userNameLanguageCode,
    required double userNameNagativeScore,
    required double userNamePositiveScore,
    required String userNameSentiment,
    required String userImageURL,
    required dynamic updatedAt,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
